docker build -t avinash68/multi-client:latest -t avinash68/multi-client:$SHA-f ./client/Dockerfile ./client
docker build -t avinash68/multi-server:latest -t avinash68/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t avinash68/multi-worker:latest -t avinash68/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push aviansh68/multi-client:latest
docker push aviansh68/multi-server:latest
docker push aviansh68/multi-worker:latest

docker push aviansh68/multi-client:$SHA
docker push aviansh68/multi-server:$SHA
docker push aviansh68/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=avinash68/multi-server:$SHA
kubectl set image deployments/client-deployment client=avinash68/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=avinash68/multi-worker:$SHA