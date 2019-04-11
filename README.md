# Dito Chat App

## CircleCI
This app have CircleCI integrated for automated building, testing and deploying, using docker as a support tool.

**On branch devel:**

Considering this as a feature branch workflow i have set automated tests for each commit on devel branch. The test job will copy the latest version of the code, install the dependencies from packge.json and run `yarn test` command. If tests fail the job will exit with an error otherwise the commit will display a success sign



![CircleCI commits marker](/home/frattezi/github/go-project/images/check-test.png)



**On branch master:**

On master branch each commit will trigger a more complex CI, containing multiple workflows running at the same time:
   - **deploy_backend_artifact:**
        This job will run a docker image with golang installed, the image will then run the `go get -d .` downloading all dependencies for the backend application, then will create a build in /build folder, this build can be downloaded as a CircleCI artifact containing the go binaries.

   - **deploy_backend_image:**

        Another form of deploying the application, this job will use the dockerfile within the backend application to create a new image, then the job will login into dockerhub and push the image to a url, publishing it.

- **test_frontend_image:**

     Tests react app running yarn test command on each commit at master or devel branches, it is also set as a `deploy_frontend_image` dependency.

- **deploy_frontend_image:**

     This will create a new docker image of our application, this job will only trigger if the commit passed the test

After the workflow above finishes the circleci dashboard will display the following structure representing the jobs executed:

![master workflow](/home/frattezi/github/go-project/images/test-deploy-app-circle.png)

---

## Docker

All applications are containerized, this helps simulating the same environment for every dev on the team

**Backend:**

Using a golang alpine image the Dockerfile inside backend directory copies the content from backend dir to the container. Then it creates a build which is used by the container when the `docker run` command is called to run the backend. To use the container you have to [install docker ce](https://docs.docker.com/install/linux/docker-ce/ubuntu/) a run the following commands on a terminal:

```bash
# Creates a new image containing backend application
docker build -t app-backend .

# Run the container
docker run app-backend 

```

**Frontend:**

The frontend contains two dockerfiles in it, dev.dockerfile will create a dev image, only setting up applications variables and starting it locally. The prod.dockerfile contains also nginx installed considering it as an web app. This differentiation is created basically for the CI and the compose files, so we can separate environments well and make it  easy to simulate every env.

---

### Docker-compose

The docker-compose is the right way to use this application, with it you can easily run  a local dev build, just use the following command:

```bash
# -f flag indicates which file to use
docker-compose -f dev-docker-compose.yml up --build
```

After the installation the application will be ready to be used in development mode. You can access it by opening your browser and accessing the url: localhost:3000.

You should be redirected to the app, here the compose takes care of environment and connection between all services and uses the docker images inside backend and frontend folders to build the latest version inside your current branch. 

I also created a prod compose which will use the last images deployed into our dockerhub so its always using the latest build passed on CircleCI. Thinking in the deploy environment being a server capable of docker this methods described above would create an easy deploy.

---

## Motivations

I choose CircleCI because of some features it have:

- Proximity with gitlab-CI features

- YAML files for configurations
- Github integration

As I only have worked with GitlabCI it looked as the best option with a low learning curve.

Docker is a great helper in this case, as I'am a python developer, setting up environments locally or on CI could be hard.

In my development history you will see me trying to use Heroku and Now as deploying tools, unfortunately I had no success with it (it was my first try), but it represents what I have thought for the task, creating small and unattached apps, with separated deploys using CI to control versions with Docker.