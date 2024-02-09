#!/bin/bash

# Jenkins home directory
JENKINS_HOME="/var/lib/jenkins"

# Backup directory
BACKUP_DIR="/path/to/backup/directory"

# Create timestamp for the backup
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Create backup archive
tar -czf "${BACKUP_DIR}/jenkins_backup_${TIMESTAMP}.tar.gz" -C "${JENKINS_HOME}" .

echo "Jenkins backup completed: ${BACKUP_DIR}/jenkins_backup_${TIMESTAMP}.tar.gz"
