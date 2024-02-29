#!/bin/bash
if [ $# -ne 1 ]; then
       echo "Usage $0 <folder_path>"
       exit 1
fi

folder_path="$1"
folder_name=$(basename "$folder_path")
snapshot_dir="/run/media/sarvesh/1/snapshot/$folder_name"
if [ ! -d "$folder_path" ]; then
    echo "Error: Folder '$folder_path' doesn't exist."
    exit 1
fi
if [ ! -d "snapshot_dir" ];then
        mkdir -p $snapshot_dir;
        echo "Created snapshot directory: $snapshot_dir"
fi
timestamp=$(date +"%d%m%Y_%H%M%S")
snapshot_path="$snapshot_dir/snapshot_$timestamp"
if [ $(ls -A "$snapshot_dir" | wc -l) -eq 0 ];then
        mkdir -p "$snapshot_dir/snapshot_$timestamp"
        echo "Created snapshot: $snapshot_dir/snapshot_$timestamp"
else
    echo "Using existing snapshot directory: $snapshot_dir"
fi
passwd='qwerty'

# echo $passwd | sudo -S rsync -a --progress "$folder_path/" "$snapshot_path/"
#sudo rsync -a --perms "$folder_path/" "$snapshot_path"
eval "sudo rsync -a --perms \"$folder_path/\" \"$snapshot_path\""


echo "Snapshot created successfully: $snapshot_path"
