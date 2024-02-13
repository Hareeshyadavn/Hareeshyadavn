#!/bin/bash
# List of users
user="java"

# New password
new_password="12345"

# Change password for each user
    echo "Changing password for $user..."
    echo "$user:$new_password" | chpasswd
    if [ $? -eq 0 ]; then
        echo "Password changed successfully for $user."
    else
        echo "Failed to change password for $user."
    fi
~
