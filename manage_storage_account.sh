#!/bin/bash
set -e
set -x

action=$1
file_name=$2

storage_account_name=$3
container_name=$4


case $action in upload)
    echo "Uploading $file_name to $container_name..."
    az storage blob upload \
      --account-name $storage_account_name \
      --container-name $container_name \
      --name "$file_name" \
      --file "$file_name" \
      --auth-mode key
      echo "Upload of $file_name was successful"
      echo "$(date): Uploaded $file_name" >> activity_log.txt
    ;;

  download)
    echo ">>>>>>>>>> Downloading $file_name from $container_name..."
    az storage blob download \
      --account-name $storage_account_name \
      --container-name $container_name \
      --name "$file_name" \
      --file "downloaded_$file_name" \
      --auth-mode key
      echo "$(date): Downloaded $file_name" >> activity_log.txt
    ;;

  list)
    echo "Listing contents of $container_name:"
    az storage blob list \
      --account-name $storage_account_name \
      --container-name $container_name \
      --output table \
      --auth-mode key
      echo "$(date): Listed contnets of container $file_name" >> activity_log.txt
    ;;

  *)
    echo "Usage: $0 {upload|download|list} [filename]"
    exit 1
    ;;

esac