#!/bin/bash

#This script installs nginx web server on the EC2 instance 

usage() {
    #Display the usage and exit.
    available_instances=$(aws ec2 describe-instances --query "Reservations[*].Instances[*].InstanceId" --output text)
}