comand=$1
project_name=$2

function make_docker_file() {
    echo "[INFO] - Making dockerfile"
    touch ./Dockerfile
    
    echo -e 'FROM amazoncorretto:17-al2-full
    ADD target/'$project_name.jar' '$project_name.jar'
    ENTRYPOINT ["java", "-jar", "'$project_name'.jar"]' | awk '{gsub(/^[ \t]+/,""); print$0, ""}' > ./Dockerfile
}

function compile_and_make_docker_image() {
    echo "[INFO] - Generating JAR file"
    
    sudo mvn package
    sudo docker build -f Dockerfile -t $project_name '.'
}

function run_container() {
    echo "[WARN] - runing container"
    sudo docker run -p 8080:8080 $project_name
}

function push(){
    echo "[INFO] - repository uri"
    read -e -p "> " erc_uri

    sudo docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) $erc_uri
    sudo docker tag $project_name:latest $erc_uri:latest
    sudo docker push $erc_uri:latest
}

echo "[INFO] - build application and push - BAAP"
echo "Dont forgive star the repository: https://github.com/JBunCE/baap-CLI :)"
sudo service docker start

case $comand in

    -b)
        make_docker_file
        compile_and_make_docker_image

        echo "[INFO] - push container?"
        select YoN in yes no
        do
            if [ $YoN == "yes" ]; then
                push
            fi 
        done
    ;;

    -p)
        echo "[INFO] - deploying container"
        push
    ;;

    -run)
        run_container
    ;;

    -bp)
        make_docker_file
        compile_and_make_docker_image
        push 
    ;;

    -help)
        echo " 
        baap comands: 

        -b <project_name>   Build project
        -p <project_name>   push docker image to ECR
        -run <project_name>   runs the docker container
        "
    ;;

    **)
        echo "Invalid command see: baap -help"
    ;;

esac
