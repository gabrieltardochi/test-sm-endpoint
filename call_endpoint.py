import argparse
import boto3
import json


if __name__ == "__main__":    # Parse arguments
    parser = argparse.ArgumentParser(description="Hit a SageMaker endpoint with dummy JSON data.")
    parser.add_argument('--endpoint-name', required=True, help="The name of the SageMaker endpoint.")
    args = parser.parse_args()

    # Dummy JSON data
    dummy_data = {
        "key1": "value1",
        "key2": "value2"
    }

    # Initialize SageMaker runtime client
    sagemaker_runtime = boto3.client('sagemaker-runtime', region_name='us-east-1')

    # Invoke the endpoint
    response = sagemaker_runtime.invoke_endpoint(
        EndpointName=args.endpoint_name,
        Body=json.dumps(dummy_data),
        ContentType='application/json'
    )

    # Print the response
    print("Response from SageMaker endpoint:")
    print(response['Body'].read().decode('utf-8'))
