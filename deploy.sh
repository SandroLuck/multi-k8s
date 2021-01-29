docker build -t sluck/multi-client:latest -t sluck/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t sluck/multi-server:latest -t sluck/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t sluck/multi-worker:latest -t sluck/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push sluck/multi-client:latest
docker push sluck/multi-worker:latest
docker push sluck/multi-server:latest

docker push sluck/multi-client:$GIT_SHA
docker push sluck/multi-worker:$GIT_SHA
docker push sluck/multi-server:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sluck/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment server=sluck/client-server:$GIT_SHA
kubectl set image deployments/worker-deployment server=sluck/worker-server:$GIT_SHA



