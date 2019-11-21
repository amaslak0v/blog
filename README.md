# My flask blog

Installation
------------
If ./venv dir not exist:
`make install-venv`

# TODO: 

EKS
CI
pre-commit
https
nginx proxy
healthcheck
show app-version
RSS
Spotify


    Use CodeBuild to push the new image. Make sure the task definition is using the "latest" tag. You'll need to force the deployment of the task definition to pick the new image.
    Use CodePipeline to update ECS. It will automatically generate a new task definition revision with the new image and deploy it.




