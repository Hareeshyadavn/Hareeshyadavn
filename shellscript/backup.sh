#!/bin/bash

# Set the source directory to be backed up
SOURCE_DIR="/home/ubuntu/file1"

# Set the destination directory for the backup
BACKUP_DIR="/home/ubuntu/folder"

# Set the backup filename (you can add a timestamp to make it unique)
BACKUP_FILE="backup_$(date +"%Y%m%d_%H%M%S").tar.gz"

# Create the backup using tar
tar -czf "${BACKUP_DIR}/${BACKUP_FILE}" -C "${SOURCE_DIR}" .

echo "Backup completed successfully. Backup file: ${BACKUP_DIR}/${BACKUP_FILE}"
