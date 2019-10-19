usage() {
  echo "$0 {start|stop|restart}"
}

check_process() {
  if [ -f "$pidfile" ]; then
    output=$(ps -p $(cat "`pwd`/$pidfile") --no-headers -o cmd)
    if [ "$output" != "$cmd" ]; then
      rm "$pidfile"
    fi
  fi
}

start() {
  if [ ! -f "$pidfile" ]; then
    setsid -f $cmd & echo $! > "$pidfile"
  fi
}

stop() {
  if [ -f "$pidfile" ]; then
    kill -9 $(cat "$pidfile")
    rm "$pidfile"
  fi
}

status() {
  if [ -f "$pidfile" ]; then
    echo "The daemon is running"
  else
    echo "The daemon is stopped."
  fi
}

check_process
case $1 in
  "status")
    status
    ;;
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "restart")
    stop
    start
    ;;
  *)
    usage
    ;;
esac

exit 0
