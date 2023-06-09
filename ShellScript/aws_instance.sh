#!/bin/bash

#SHELL SCRIPT TO START/STOP AWS EC2 INSTANCE BASED ON THEIR CURRENT STATE

region=ap-south-1

read -p "Enter region name [ default: $region ]: " region
if [[ -z "$region" ]]; then
    region=ap-south-1
fi

echo "Getting AWS EC2 Instance details from $region region"
echo "----------------------------------------------------"
aws ec2 --region $region describe-instances | jq -r '.Reservations[].Instances[].Tags[] | select(.Key == "Name").Value'
echo "----------------------------------------------------"

read -p "Enter Instance Name from above list: " instance_name

if [[ -z "$instance_name" ]]; then
   echo "No Instance name entered"
   exit 1
fi

instance_id=$(aws ec2 describe-instances --region $region --filters "Name=tag:Name,Values='$instance_name'" | jq -r '.Reservations[].Instances[0].InstanceId')

#echo "Instance Id of $instance_name is $instance_id"

instance_state=$(aws ec2 describe-instances --region $region --instance-id $instance_id | jq -r '.Reservations[].Instances[0].State.Name')


if [[ "$instance_state" == 'stopped' ]]; then
    read -p "Instance $instance_name ( $instance_id ) is in $instance_state state. Do you want to start the $instance_name ( $instance_id ) instance. Press y to start: " trigger

    if [ $trigger == 'y' ] || [ $trigger == 'Y' ]; then
        echo "Starting $instance_name ( $instance_id ) Instance"
        aws ec2 start-instances --region $region --instance-ids $instance_id > /dev/null
        if [ $? -ne 0 ]; then
            echo "Starting $instance_name ( $instance_id ) Instance results in some issue. Please try again"
        else
            echo "Please wait a few seconds, $instance_name ( $instance_id ) Instance is starting"
        fi
    else
        echo "Invalid Instruction provided. Please Continue again"
        exit 1
    fi
fi

if [[ "$instance_state" == 'running' ]]; then
    read -p "Instance $instance_name ( $instance_id ) is in $instance_state state. Do you want to stop the $instance_name ( $instance_id ) instance. Press y/Y to stop: " trigger

    if [ $trigger == 'y' ] || [ $trigger == 'Y' ]; then
        echo "Stopping $instance_name ( $instance_id ) Instance"
        aws ec2 stop-instances --region $region --instance-ids $instance_id
        if [ $? -ne 0 ]; then
            echo "Stopping $instance_name ( $instance_id ) Instance results in some issue. Please try again"
        else
            echo "Please wait a few seconds, $instance_name ( $instance_id ) Instance is stopping"
        fi    
    else
        echo "Invalid Instruction provided. Please Continue again"
        exit 1
    fi
fi

