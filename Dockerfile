#Make sure you point the ECR Image correctly
FROM python:3.9-slim

RUN apt-get update \
    && apt-get install curl -y \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

# # We copy just the requirements.txt first to leverage Docker cache
COPY requirements.txt /app
RUN pip install -r requirements.txt

COPY . /app
# ENV AGG_APP_URL='http://prodinfo.octank-mesh-ns.svc.cluster.local:3000/productAgreement'

#WORKDIR /docker_app
EXPOSE 8080
ENTRYPOINT ["/app/bootstrap.sh"]
