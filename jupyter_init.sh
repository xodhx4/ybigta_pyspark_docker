jupyter notebook --generate-config
# Change 'admin' to 'YOUTPASSWORD'
jupyter notebook password << END
admin
admin
END
rm /root/.jupyter/jupyter_notebook_config.py
mkdir /certs && cd /certs
yes NO | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mycert.pem
