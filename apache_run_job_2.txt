# Inter-job2
# cat /ans/start_apache.sh
#!/bin/bash
#
# Start apache if down.

touch /ans/remediation_status
chmod 777 /ans/remediation_status

#	servers with apache down

appdown=$(cat /ans/apachestatus | grep down |awk '{print $1}')

#	restart app and check the latest status for app servers

for server in $appdown ;do
	sudo su -c ' ssh -q root@appserver1 "systemctl start httpd.service"'
	if curl -s --head http://$server | grep "200 OK" > /dev/null; then
	echo "$server application restarted" >> /ans/remediation_status
	else
	echo "$server application still have problems" >> /ans/remediation_status
	fi
done
