echo "Sending stop signal..."
pkill -F fswebcam.pid

# Wait for process to exit
while kill -0 `cat fswebcam.pid` 2>/dev/null; do
    sleep 1
done

# Print success
echo "Stopped fswebcam"
