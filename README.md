# jenkins-pipeline-deploy-to-eks

## Steps for the project

    1. Create a Keypair that matches your keypair
    2. Create a Jenkins Server with all the dependencies, libraries and packagies needed.
    2. Once completed, access the Jenkins server and Set it up
    4. Run the jenkins-pipeline-deploy-to-eks to create Kubernetes Cluster, create deployments and Services
    5. Test that the application is running 
    6. Destroy infrastructure
    #

## To use this variable file you can use following command
- terraform plan -var-file="./dev.tfvars" -var-file="./common.tfvars" 
    ## Limitations

    1. You can not call any function
    2. Operations are not allowed
    3. You can not use any logic in here.