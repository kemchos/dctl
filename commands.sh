dctl() {
  if [[ $1 == "swp" ]]; then
    command docker rm $(docker ps -aq -f status=exited)
  elif [[ $1 == "swpi" ]]; then
    command docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
  elif [[ $1 == "ip" ]]; then
    if [[ $2 == "-l" ]]; then
      command docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(docker ps -l -q)
    else
      command docker inspect --format '{{ .NetworkSettings.IPAddress }}' $2
    fi
  else
    command echo -e "Commands:\
                      \n    swp\t\t\tremove exited processes \
                      \n    swpi\t\tremove not tagged images \
                      \n    ip <id> or -l\tshow ip"
  fi
}