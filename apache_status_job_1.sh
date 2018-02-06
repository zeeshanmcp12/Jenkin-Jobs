# Inter-job1
# cat /ans/check_apache.sh
#!/bin/bash
#
# check if the apache is running or not.
# delete old status file.
if [ -f /ans/appstatus ] ;then
	rm /ans/appstatus
fi

# Check the latest status for apache servers

for server in appserver1 ;do
	if curl -s --head http://$server | grep "200 OK" > /dev/null;
then
	echo "$server application up" >> /ans/appstatus
 else
	echo "$server application down" >> /ans/appstatus
	fi
done

chmod 777 /ans/apachestatus
