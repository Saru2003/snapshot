#!/bin/bash
usage() {
    echo "Usage: $0 [-s <snapshot_path>] | [-u <snapshot_dir> <destination_path>]"
    exit 1
}

while getopts ":s:u" opt; do
	case $opt in 
		s)
			
			if [ $# -ne 3 ]; then
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
			
			sudo rsync -a --perms "$folder_path/" "$snapshot_path"
			echo "Snapshot created successfully: $snapshot_path"
			;;
		u)	
			if [ $# -ne 4 ]; then
				echo "Error: Incorrect number of arguments for option -u."
				usage
	                fi
			snapshot_dir="run/media/sarvesh/1/snapshot/$OPTARG"
			destination_sir="$2"
			if [ ! -d "$snapshot_dir" ]; then
				echo "Error: Snapshot directory '$snapshot_dir' doesn't exist."
		                exit 1
		        fi

			if [ ! -d "$destination_path" ]; then
		                echo "Error: Destination directory '$destination_path' doesn't exist."
                	exit 1
		        fi
		        sudo rsync -a --delete "$snapshot_dir/" "$destination_path/"
		        echo "Snapshot files updated successfully in: $destination_path"
		        ;;
		\?)
			echo "Invalid option: -$OPTARG"
			usage
			;;
		:)
			echo "Option -$OPTARG requires an argument."
			usage
			;;
	esac
done
if [ $# -eq 0 ]; then
    usage
fi

