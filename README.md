# sync_bag_player
To run D2SLAM single PC for multi-robot datasets from [D2SLAM](https://github.com/HKUST-Aerial-Robotics/D2SLAM).

# Running in docker container
Included a simple setup to run this package in docker containers

## Build
```
cd ~/sync_bag_player
docker build -t sync-bag-player .
```

## Launch
```
xhost +local:docker

cd ~/sync_bag_player
docker compose up -d
docker attach container_id
```

## Running (assuming [D2SLAM](https://github.com/HKUST-Aerial-Robotics/D2SLAM) installed)
```
# Within sync_bag_player container
rosrun sync_bag_player environment_setup.sh
rosrun sync_bag_player did_swarm_test.py configs/d2slam.yaml

```