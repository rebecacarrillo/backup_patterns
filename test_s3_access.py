import boto3

def test_s3_access():
    s3 = boto3.client('s3')
    response = s3.list_buckets()
    print("Available buckets:")
    for bucket in response['Buckets']:
        print(f"  {bucket['Name']}")

if __name__ == "__main__":
    test_s3_access()
