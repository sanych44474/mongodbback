export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%d%b%Y"`
DB_BACK_TMP='/backup/mongo/TMP'
MONGO_HOST='127.0.0.1'
MONGO_PORT='27017'
MONGO_USER='user'
MONGO_PASSWD='pass'
TAR_BACK='/backup/mongo'
DATABASE_NAMES='DB_NAME' ##'DB1 DB2 DB3'
#DATABASE_NAMES='ALL' for all dbs
DAYS=7 ## Delete backup if older

mkdir -p ${DB_BACK_TMP}/${TODAY}
AUTH_PARAM=" --username ${MONGO_USER} --password ${MONGO_PASSWD}  --authenticationDatabase "admin" "

if [ ${DATABASE_NAMES} = "ALL" ]; then
        mongodump --host ${MONGO_HOST} --port ${MONGO_PORT} ${AUTH_PARAM} --out ${DB_BACK_TMP}/${TODAY}
                cd  ${DB_BACK_TMP}
                tar -zcvf ${TAR_BACK}/${TODAY}.tgz ${TODAY}
                rm -rf ${DB_BACK_TMP}

else
        for DB_NAME in ${DATABASE_NAMES}
        do
                mongodump --host ${MONGO_HOST} --port ${MONGO_PORT} --db ${DB_NAME} ${AUTH_PARAM} --out ${DB_BACK_TMP}/${TODAY}
                if [$? -ne 0]; then
                        echo 'Mongodump finished'| mail -s 'Failed' <examle@domain.com>
                        exit 1
                else
                         cd  ${DB_BACK_TMP}
                         tar -zcvf ${TAR_BACK}/${TODAY}.tgz ${TODAY}
                         rm -rf ${DB_BACK_TMP}
                         echo 'Mongodump successfuly finished'| mail -s 'Success' <examle@domain.com>

                fi
        done
fi

# Remove oldest back

find ${TAR_BACK}/ -mtime +${DAYS} -delete
exit
