#TechCorp Troubleshooting Runbook

#Issue: NFS Mount Not Working
#Symptoms: Cannot access /mnt/nfs/shared
#Steps:
1. Check NFS server: sudo systemctl status nfs-kernel-server
2. Check exports: sudo exportfs -v
3. Check connectivity: ping <storage-vm-ip>
4. Check port: nc -zv <storage-vm-ip> 2049
5. Check firewall: sudo ufw status
6. Check NFS client: showmount -e <storage-vm-ip>
7. Try manual mount: sudo mount -t nfs <ip>:/nfs/share /mnt/test
8. Check logs: sudo journalctl -u nfs-kernel-server
9. Capture traffic: sudo tcpdump -i eth0 port 2049

#Issue: Apache Not Responding
#Symptoms: HTTP 502/503 or connection refused
#Steps:
1. Check service: sudo systemctl status apache2
2. Check port: ss -tulnp | grep :80
3. Check logs: sudo tail -f /var/log/apache2/error.log
4. Check config: sudo apache2ctl configtest
5. Check disk space: df -h
6. Check memory: free -h
7. Restart service: sudo systemctl restart apache2
8. Trace process: sudo strace -p $(pgrep apache2)

#Issue: High CPU Usage
#Symptoms: System slow, CPU > 90%
#Steps:
1. Identify process: top / htop
2. Check process: ps aux --sort=-%cpu | head -10
3. Trace process: sudo strace -p <pid> -c
4. Check cron jobs: crontab -l
5. Check system calls: sudo perf top

#Issue: SMB Connection Failed
#Symptoms: Cannot connect to Samba share
#Steps:
1. Check service: sudo systemctl status smbd
2. Test config: sudo testparm
3. Check user: sudo smbpasswd -e username
4. Check port: ss -tulnp | grep 445
5. Test connection: smbclient -L <server-ip> -U username
6. Check logs: sudo tail -f /var/log/samba/log.smbd
7. Capture: sudo tcpdump -i eth0 port 445
