Drop the final MP4/H.264 files directly into this directory.
Do not create empty placeholder MP4 files; this README keeps the directory in Git.

Required filenames:

01_mortise_tenon.mp4
02_water_hose.mp4
03_three_hole_plug.mp4
04_lego.mp4
05_two_hole_plug.mp4
06_board_wipe.mp4
07_water_hose_90min.mp4        9-minute time-compressed version of the full 90-minute / 450-trial session
08_mortise_tenon_60min.mp4     60-minute / 80-trial continuous stability test
09_cable_lego_sorting.mp4
10_long_horizon_servo_packing.mp4
11_three_hole_plug_pi05.mp4    matched π0.5 rollout with lateral drift
12_three_hole_plug_spa_vla.mp4 matched PSR-VLA rollout with vertical insertion

Encoding: MP4 container, H.264 video, yuv420p.
Use square 1:1 video (1080x1080 or 720x720) for files 01-06 and 11-12.
Use 16:9 video (1920x1080 or 1280x720) for files 07-10.
Audio is optional because the webpage plays videos muted.

Use matched framing, playback speed, and duration for files 11-12. Their initial
plug-to-socket alignment should be closely comparable. After the files are added,
reload the webpage; no HTML filename changes are needed.

The MP4 files are ignored by Git by default because the source videos are
currently internal. Do not force-add or upload them until public release is
approved. Use external object storage/CDN URLs for large release videos.
