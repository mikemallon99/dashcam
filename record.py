import subprocess
import datetime

# Send to laptops ip, get ip with "ip a"
laptop_ip = "192.168.0.128" # Sweetgreen WiFi ip
# Make sure this is mounted
output_dir = "/mnt/usbdrive/dashcam_recs"

# Check output directory to see if were overflowing, then delete old files

RES="1280x720"
FPS=30
BITRATE="2000k"   # ~2 Mbps; adjust as needed
ts  = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")

cmd = [
    "ffmpeg",
    "-f", "v4l2",
    "-input_format", "mjpeg",
    "-video_size", RES,
    "-framerate", str(FPS),
    "-i", "/dev/video0",
    "-an", "-map", "0:v:0",
    "-vf", "format=yuv420p",
    "-c:v", "h264_v4l2m2m", 
    "-b:v", "2000k", 
    "-g", "60", 
    "-pix_fmt", "yuv420p",
    "-f", "tee", f"[f=mpegts]udp://{laptop_ip}:1234|[f=mp4:movflags=+faststart]{output_dir}/{ts}.mp4",
]

subprocess.run(cmd, check=True)

