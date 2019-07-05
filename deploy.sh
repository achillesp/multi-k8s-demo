docker build -t achillesp/multi-client:latest -t achillesp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t achillesp/multi-server:latest -t achillesp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t achillesp/multi-worker:latest -t achillesp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push achillesp/multi-client:latest
docker push achillesp/multi-server:latest
docker push achillesp/multi-worker:latest

docker push achillesp/multi-client:$SHA
docker push achillesp/multi-server:$SHA
docker push achillesp/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=achillesp/multi-client:$SHA
kubectl set image deployments/server-deployment server=achillesp/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=achillesp/multi-worker:$SHA
