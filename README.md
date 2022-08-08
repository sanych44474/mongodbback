# mongodbback
Mongodb instalation https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/
apt-get update && apt-get install -y ssmtp
apt install mailutils   
nano /etc/ssmtp/ssmtp.conf
      mailhub=smtp.office365.com:587
      AuthUser=<$OFFICE365_EMAIL>
      AuthPass=<$OFFICE365_PASSWORD>
      UseTLS=YES
      UseSTARTTLS=YES
nano back.sh 
chmod +x back.sh
nano / etc / crontab
      00 10   * * *   root    <your_path>/back.sh ## every day at 10 AM
