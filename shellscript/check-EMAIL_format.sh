#!/bin/bash

# Function to validate email format
validate_email() {
    # Regular expression for email validation
    regex='^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    
    # Check if the email matches the regex
    if [[ $1 =~ $regex ]]; then
        echo "Valid email address"
    else
        echo "Invalid email address"
    fi
}

# Usage
if [ $# -ne 1 ]; then
    echo "Usage: $0 <email>"
    exit 1
fi

# Call the function with the provided email address
validate_email $1
