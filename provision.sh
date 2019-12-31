#!/bin/bash
downloadFile(){
    local download_dir=$1
    local download_url=$2
    local md5sum=$3
    fileName=${download_url##*/}
    echo `ls ${download_dir}/${fileName}`
    echo "Provision: File to be downloaded $download_dir/$fileName"
    if [ `ls ${download_dir}/${fileName}` = $download_dir/$fileName ];
    then
	echo "Provision: File exist: $download_dir/$fileName"
	curmd5sum=`md5sum ${download_dir}/${fileName}`
        if [ "$md5sum  $fileName" = $curmd5sum ];
        then
            return
        else
	    echo "Expect md5sum: $md5sum"
	    echo "Current md5sum: $curmd5sum"
	    echo "Provision: existed file broken, removing..."
            rm ${download_dir}/${fileName}
	    echo "Provision: removal finished, start downloading"
        fi 
    fi 
    echo "Provision: wget $download_url -O ${download_dir}/${fileName}"
    wget $download_url -O ${download_dir}/${fileName} 
    
}

WORKING_DIR=$PWD 
SUB_DIR="${PWD}/Entity-Relation-Extraction"


echo "Provision: The working path is ${WORKING_DIR}"
echo "Provision: git submodule init"
git submodule init
echo "Provision: git submodule update"
git submodule update
echo ${SUB_DIR}/raw_data 
downloadFile ${SUB_DIR}/raw_data http://[2001:19f0:5:3c2c:5400:2ff:fe69:905b]/files/train_data.json 24c39dceacaad412d857e0e002355c40
downloadFile ${SUB_DIR}/raw_data http://[2001:19f0:5:3c2c:5400:2ff:fe69:905b]/files/dev_data.json b4616969bc28a6cf8b54b76a4bbc0bd1
downloadFile ${SUB_DIR}/raw_data http://[2001:19f0:5:3c2c:5400:2ff:fe69:905b]/files/all_50_schemas 557f9fcd31ca7b9735bfdcde28008db9
downloadFile ${SUB_DIR}/pretrained_model https://storage.googleapis.com/bert_models/2018_11_03/chinese_L-12_H-768_A-12.zip 8e8de0450e7d973ab7295594bd7196bb
