docker build -t dimaka77/multi-client:latest -t dimaka77/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dimaka77/multi-server:latest -t dimaka77/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dimaka77/multi-worker:latest -t dimaka77/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dimaka77/multi-client:latest
docker push dimaka77/multi-server:latest
docker push dimaka77/multi-worker:latest

docker push dimaka77/multi-client:$SHA
docker push dimaka77/multi-server:$SHA
docker push dimaka77/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dimaka77/multi-server:$SHA
kubectl set image deployments/client-deployment client=dimaka77/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dimaka77/multi-worker:$SHA
