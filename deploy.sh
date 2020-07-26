docker build -t lauro2/multi-client:latest -t lauro2/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lauro2/multi-server:latest -t lauro2/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lauro2/multi-worker:latest -t lauro2/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lauro2/multi-client:latest
docker push lauro2/multi-server:latest
docker push lauro2/multi-worker:latest

docker push lauro2/multi-client:$SHA
docker push lauro2/multi-server:$SHA
docker push lauro2/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lauro2/multi-server:$SHA
kubectl set image deployments/client-deployment client=lauro2/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lauro2/multi-worker:$SHA