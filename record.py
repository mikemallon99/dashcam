import subprocess
import datetime
import os

MAX_VIDEOS = 4

# Send to laptops ip, get ip with "ip a"
laptop_ip = "192.168.0.128" # Sweetgreen WiFi ip
# Make sure this is mounted
output_dir = "/mnt/usbdrive/dashcam_recs"

# Check output directory to see if were overflowing, then delete old files
video_names = [filename.split(".")[0] for filename in os.listdir(output_dir)]
if len(video_names) >= MAX_VIDEOS:
    print(f"Number of vids in {output_dir} exceeds max of {MAX_VIDEOS}")
    oldest_video_name = video_names[0]
    oldest_video_ts = datetime.datetime.strptime(video_names[0], "%Y%m%d-%H%M%S")
    for cur_video_name in video_names:
        cur_video_ts = datetime.datetime.strptime(cur_video_name, "%Y%m%d-%H%M%S")
        if cur_video_ts < oldest_video_ts:
            oldest_video_name = cur_video_name
            oldest_video_ts = cur_video_ts

    # Remove oldest file
    oldest_filepath = os.path.join(output_dir, f"{oldest_video_name}.mp4")
    os.remove(oldest_filepath)
    print(f"Removed video at path: {oldest_filepath}")


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

