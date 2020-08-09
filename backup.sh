#!/bin/sh

set -e

if [ -z "${S3_ACCESS_KEY}" ]; then
  echo "You need to set the S3_ACCESS_KEY environment variable."
  exit 1
fi
if [ -z "${S3_SECRET_KEY}" ]; then
  echo "You need to set the S3_SECRET_KEY environment variable."
  exit 1
fi

if [ -z "${DUMP_URL_PREFIX}" ]; then
  echo "You need to set the DUMP_URL_PREFIX environment variable."
  echo "like: https://BUCKET.s3.amazonaws.com/PATH/dbbackup"
  exit 1
fi

if [ -z "${DATABASE_URL}" ]; then
  echo "You need to set the DATABASE_URL environment variable."
  exit 1
fi

echo "Starting dump of database(s)..."

S3_URL=$DUMP_URL_PREFIX`date +%Y%m%d_%H%M%S`
pg_dump -F c $DATABASE_URL | s3cp /dev/stdin $S3_URL

echo "Done!"

exit 0
