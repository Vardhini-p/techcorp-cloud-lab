!/bin/bash
echo "=== TechCorp System Health Report ==="
echo "Date: $(date)"
echo ""
echo "--- CPU Usage ---"
top -bn1 | grep "Cpu(s)"
echo ""
echo "--- Memory Usage ---"
free -h
echo ""
echo "--- Disk Usage ---"
df -h
echo ""
echo "--- Top 5 CPU Processes ---"
ps aux --sort=-%cpu | head -6
echo ""
echo "--- Recent Errors in Syslog ---"
sudo grep -i error /var/log/syslog | tail -5
echo ""
echo "--- Apache Status ---"
sudo systemctl is-active apache2
echo ""
echo "--- NFS Status ---"
sudo systemctl is-active nfs-kernel-server
echo ""
echo "--- SMB Status ---"
sudo systemctl is-active smbd
