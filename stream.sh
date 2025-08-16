# Run this on the laptop youre streaming from
ffplay -fflags nobuffer -flags low_delay -framedrop -i udp://@:1234
