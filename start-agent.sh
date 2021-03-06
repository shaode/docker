#!/usr/bin/env bash
# example ./start-agent.sh 127.0.0.1 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe
# example USER_DOCKER=true ./start-agent.sh 127.0.0.1 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe

if [[ ! -n $USE_DOCKER ]]; then
	echo "###################Start Agent Using jar#######################"
	nohup java -jar ./agent/flow-agent.jar http://${1}:8080/flow-api $2 &
else
	if [[ ! -n $DOCKER_IMAGE_AGENT ]]; then
		export DOCKER_IMAGE_AGENT=flowci/flow.ci.agent
	fi
	echo "环境变量 DOCKER_IMAGE_AGENT: Agent 的 docker 镜像地址, 默认是官方镜像 flowci/flow.ci.agent, 当前参数值是 $DOCKER_IMAGE_AGENT"

	docker run --network=host -v ~/.ssh:/root/.ssh -e FLOW_BASE_URL=$1/flow-api -e FLOW_TOKEN=$2 -d $DOCKER_IMAGE_AGENT
fi


echo "=============================start agent success============================="