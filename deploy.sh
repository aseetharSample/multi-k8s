docker build -t aswanth06/multi-client:latest -t aswanth06/multi-client:$BUILD_NUM -f ./client/Dockerfile ./client
docker build -t aswanth06/multi-server:latest -t aswanth06/multi-server:$BUILD_NUM -f ./server/Dockerfile ./server
docker build -t aswanth06/multi-worker:latest -t aswanth06/multi-worker:$BUILD_NUM -f ./worker/Dockerfile ./worker

docker push aswanth06/multi-client:latest
docker push aswanth06/multi-server:latest
docker push aswanth06/multi-worker:latest

docker push aswanth06/multi-client:$BUILD_NUM
docker push aswanth06/multi-server:$BUILD_NUM
docker push aswanth06/multi-worker:$BUILD_NUM


kubectl apply -f k8s

kubectl set image deployments/server-deployment server=aswanth06/multi-server:$BUILD_NUM
kubectl set image deployments/client-deployment server=aswanth06/multi-client:$BUILD_NUM
kubectl set image deployments/worker-deployment server=aswanth06/multi-worker:$BUILD_NUM
