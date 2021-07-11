docker build -t anushakv71/multi-client:latest -t anushakv71/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anushakv71/multi-server:latest -t anushakv71/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anushakv71/multi-worker:latest -t anushakv71/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push anushakv71/multi-client:latest
docker push anushakv71/multi-server:latest
docker push anushakv71/multi-worker:latest
docker push anushakv71/multi-client:$SHA
docker push anushakv71/multi-server:$SHA
docker push anushakv71/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anushakv71/multi-server:$SHA
kubectl set image deployments/client-deployment client=anushakv71/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anushakv71/multi-worker:$SHA

