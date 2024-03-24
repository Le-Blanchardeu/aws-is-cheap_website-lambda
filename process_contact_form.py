import base64
import json

def lambda_handler(event, context):
    
    print("Event received")
    print(event)
    
    post_data = ''
    
    if 'body' in event:
        if 'isBase64Encoded' in event and event['isBase64Encoded']:
            post_data = base64.b64decode(event['body']).decode('utf-8')
        else:
            post_data = event['body']
    
    print(f'We received the following post data: {post_data}')
    
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(f'We received the following post data: {post_data}')
    }
    

