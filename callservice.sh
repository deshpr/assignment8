# JSON object to pass to Lambda Function
json={"\"msg\"":"\"ServerlessComputingWithFaaS\",\"shift\"":22}
smarn="<replace with state machine arn>"
exearn=$(aws   stepfunctions   start­execution   ­­state­machine­arn   $smarn
­­input $json | jq ­r ".executionArn")
# poll output
output="RUNNING"
while [ "$output" == "RUNNING" ]
do
  echo "Status check call..."
    alloutput=$(aws   stepfunctions   describe­execution   ­­execution­arn
$exearn)
  output=$(echo $alloutput | jq ­r ".status")
  echo "Status check=$output"
done
echo ""
aws   stepfunctions   describe­execution   ­­execution­arn   $exearn   |   jq   ­r
".output" | jq