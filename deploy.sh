docker build -t djcaldas/multi-client:latest -t djcaldas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t djcaldas/multi-server:latest -t djcaldas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t djcaldas/multi-worker:latest -t djcaldas/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push djcaldas/multi-client:latest
docker push djcaldas/multi-server:latest
docker push djcaldas/multi-worker:latest

docker push djcaldas/multi-client:$SHA
docker push djcaldas/multi-server:$SHA
docker push djcaldas/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=djcaldas/multi-server:$SHA
kubectl set image deployments/client-deployment client=djcaldas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=djcaldas/multi-worker:$SHA