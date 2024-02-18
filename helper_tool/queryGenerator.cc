#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>

std::string generateInsertQuery(const std::vector<std::string>& columnNames, const std::vector<std::string>& values, const std::string& tableName) {
    std::string query = "INSERT INTO " + tableName + " (";
    for (size_t i = 0; i < columnNames.size(); ++i) {
        query += columnNames[i];
        if (i < columnNames.size() - 1) query += ", ";
    }
    query += ") VALUES (";
    for (size_t i = 0; i < values.size(); ++i) {
        
        // if handling with a data value:
        if (values[i][0] == '@'){
            query += "TO_DATE('"; 
            query += values[i].substr(1);   
            query += "','YYYY-MM-DD')" ;
        }
        
        else
            query += "'" + values[i] + "'";

        // if not last attribute, add comma
        if (i < values.size() - 1) 
            query += ", ";
    }
    query += ");";
    return query;
}

int main(int argc, char** argv) {
    std::string tableName;
    std::string fileName;
    std::vector<std::string> columnNames;
    std::string line;
    
    tableName = std::string(argv[1]);
    std::ifstream file(argv[2]);

    // Check if file opened successfully
    if (!file.is_open()) {
        std::cerr << "Error opening file" << std::endl;
        return 1;
    }

    // Read the first line to get column names
    if (getline(file, line)) {
        std::istringstream ss(line);
        std::string columnName;
        while (getline(ss, columnName, ',')) {
            columnNames.push_back(columnName);
        }
    }

    // Process the rest of the lines to generate SQL queries
    while (getline(file, line)) {
        std::istringstream ss(line);
        std::string value;
        std::vector<std::string> values;
        while (getline(ss, value, ',')) {
            values.push_back(value);
        }
        std::string query = generateInsertQuery(columnNames, values, tableName);
        std::cout << query << std::endl;
    }

    file.close();
    return 0;
}
