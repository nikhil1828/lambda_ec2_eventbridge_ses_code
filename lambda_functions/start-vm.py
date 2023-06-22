import boto3
import json
from collections import defaultdict

region = 'ap-south-1'

def lambda_handler(event, context):
    client = boto3.client('ec2')
    running_instances = client.describe_instances(
      Filters=[
        {
            'Name': 'tag:Layer',
            'Values': ['three']
        },
    ],
    )
    instance_ids = []

    for reservation in running_instances['Reservations']:
        for instance in reservation['Instances']:
            instance_ids.append(instance['InstanceId'])

    client.start_instances(InstanceIds=instance_ids)
    print('Started your instance: ' + str(instance_ids))

    ses = boto3.client('ses', region_name='ap-south-1')
    sender = "dobriyaln17@gmail.com"
    recipient = "nikd9917@gmail.com"
    subject = "Compute VM status"
    message = "Compute Instance started successfully "

    response = ses.send_email(
        Source=sender,
        Destination={
            'ToAddresses': [recipient]
        },
        Message={
            'Subject': {
                'Data': subject
            },
            'Body': {
                'Text': {
                    'Data': message
                }
            }
        }
    )
    print(response)
    
    return {
        'statusCode': 200,
        'body': 'Email sent successfully'
    }
