#!/bin/bash

echo ${SFTP_HOST} $SFTP_HOST
sshpass -p "${SFTP_PASSWORD}" sftp -o StrictHostKeyChecking=no -P ${SFTP_PORT} "${SFTP_USER}@${SFTP_HOST}" <<EOL
cd ${REPO_PATH}
put ${PACKAGE_NAME}
EOL

exit $?