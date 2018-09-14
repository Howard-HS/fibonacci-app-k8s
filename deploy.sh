docker build -t howardhs/fibonacci-client:latest -t howardhs/fibonacci-client:$SHA -f ./client/Dockerfile ./client
docker build -t howardhs/fibonacci-server:latest -t howardhs/fibonacci-server:$SHA -f ./server/Dockerfile ./server
docker build -t howardhs/fibonacci-worker:latest -t howardhs/fibonacci-worker:$SHA -f ./worker/Dockerfile ./worker

docker push howardhs/fibonacci-client:latest
docker push howardhs/fibonacci-server:latest
docker push howardhs/fibonacci-worker:latest
docker push howardhs/fibonacci-client:$SHA
docker push howardhs/fibonacci-server:$SHA
docker push howardhs/fibonacci-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=howardhs/fibonacci-client:$SHA
kubectl set image deployments/server-deployment server=howardhs/fibonacci-server:$SHA
kubectl set image deployments/worker-deployment worker=howardhs/fibonacci-worker:$SHA