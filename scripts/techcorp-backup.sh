#!/bin/bash
#TechCorp Automated Backup Script
#Backs up /techcorp directory to Azure Blob Storage

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/techcorp"
BACKUP_FILE="/tmp/techcorp-backup-$DATE.tar.gz"
STORAGE_ACCOUNT="techcorpstorage2024"
CONTAINER="techcorp-backups"
LOG_FILE="/techcorp/logs/backup.log"

echo "[$DATE] Starting TechCorp backup..." | tee -a $LOG_FILE

#Create compressed backup
tar -czf $BACKUP_FILE $BACKUP_DIR 2>/dev/null
echo "[$DATE] Backup file created: $BACKUP_FILE" | tee -a $LOG_FILE


#Upload to Azure Blob
az storage blob upload \
--account-name $STORAGE_ACCOUNT \
--container-name $CONTAINER \
--name "backup-$DATE.tar.gz" \
--file $BACKUP_FILE \
--auth-mode login

if [ $? -eq 0 ]; then
echo "[$DATE] Backup uploaded successfully to Azure Blob!" | tee -a $LOG_FILE
rm -f $BACKUP_FILE
else
echo "[$DATE] ERROR: Backup upload failed!" | tee -a $LOG_FILE
exit 1
fi

echo "[$DATE] Backup completed successfully!" | tee -a $LOG_FILE
