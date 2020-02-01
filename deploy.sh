docker build -t sha01/multi-client:latest -t sha01/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sha01/multi-server:latest -t sha01/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sha01/multi-worker:latest -t sha01/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sha01/multi-client:latest
docker push sha01/multi-server:latest
docker push sha01/multi-worker:latest
docker push sha01/multi-client:$SHA
docker push sha01/multi-server:$SHA
docker push sha01/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sha01/multi-server:$SHA
kubectl set image deployments/client-deployment client=sha01/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sha01/multi-worker:$SHA