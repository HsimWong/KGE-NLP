#!/bin/bash
function downloadFile () {
    local download_dir=$1
    local download_url=$2
    local md5sum=$3
    let fileName=${download_url##*/}
    if [ -f ${download_dir}/${fileName} ];
    then
        if [ "$md5sum  $fileName" = `md5sum ${download_dir}/${fileName}` ];
        then 
            return
        else
            rm ${download_dir}/${fileName}
        fi 
    fi 
    wget $download_url -O ${download_dir}/${fileName}
}

WORKING_DIR=$PWD 
SUB_DIR="${PWD}/Entity-Relation-Extraction"


echo "Provision: The working path is ${WORKING_DIR}"

echo "Provision: git submodule update"
git submodule update
cd ${SUB_DIR}/pretrained_model
downloadFile ${SUB_DIR}/raw_data http://207.246.95.200/files/train_data.json 24c39dceacaad412d857e0e002355c40
downloadFile ${SUB_DIR}/raw_data http://207.246.95.200/files/dev_data.json b4616969bc28a6cf8b54b76a4bbc0bd1
downloadFile ${SUB_DIR}/raw_data http://207.246.95.200/files/all_50_schemas 557f9fcd31ca7b9735bfdcde28008db9
downloadFile ${SUB_DIR}/pretrained_model https://storage.googleapis.com/bert_models/2018_11_03/chinese_L-12_H-768_A-12.zip 8e8de0450e7d973ab7295594bd7196bb
% cd ../raw_data
wget https://dataset-bj.cdn.bcebos.com/sked/train_data.json
wget https://dataset-bj.cdn.bcebos.com/sked/dev_data.json
wget https://dataset-bj.cdn.bcebos.com/sked/all_50_schemas
cd ..
echo "entered: "
pwd
