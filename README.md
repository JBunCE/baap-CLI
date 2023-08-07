# baap - a CLI for push to ECR
Build Applicatin And Push

Hello everyone this is a bash script that i make for push my spring projects to ECR and probably someone needs this or maybe this can help anyone idk :)

for install you can use this commands bellow

```bash
sudo mv ./baap.bash ~/
sudo echo 'alias baap="~/baap.bash"' >> ~/.bashrc
sudo source ~/.bashrc
```

> [!WARNING]\
> This script only works on WSL with Docker.io installed or linux systems obviusly and only works with maven archetype.


### How to use
Please read this if you want to use the CLI, take this like an advice

- <b> For build your maven project, make a Dockerfile and finally create the project docker image use: </b>

  ```bash
  baap -b <project name>
  ``` 

- <b> For push your docker image to RCR </b>

  ```bash
  baap -p <project name>
  ```
  
- <b> And finally you can use this command for use the two operations </b>

  ```bash
  baap -bp <project name>
  ```
