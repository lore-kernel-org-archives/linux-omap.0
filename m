From: Paolo Pisati <p.pisati-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: omap_wdt: node present in device-tree but kmod is not autoloaded
Date: Tue, 25 Aug 2015 16:06:07 +0200
Message-ID: <20150825140607.GA23311@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-dt <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The question is two-folded, hence the crossposting.

I have a kernel that runs perfectly on my beaglebone black, except for one thing
- the kmod for the watchdog is not autoloaded upon boot albeit the device-tree
node is present:

ubuntu@beaglebone:~$ dmesg | grep wdt
ubuntu@beaglebone:~$ ll /dev/watch* 
ls: cannot access /dev/watch*: No such file or directory
ubuntu@beaglebone:~$ ls -la /proc/device-tree/ocp/wdt\@44e35000/
total 0
drwxr-xr-x  2 root root  0 Aug 25 13:43 .
drwxr-xr-x 54 root root  0 Aug 25 13:43 ..
-r--r--r--  1 root root 13 Aug 25 13:43 compatible
-r--r--r--  1 root root  4 Aug 25 13:43 interrupts
-r--r--r--  1 root root  4 Aug 25 13:43 name
-r--r--r--  1 root root  8 Aug 25 13:43 reg
-r--r--r--  1 root root 10 Aug 25 13:43 ti,hwmods
ubuntu@beaglebone:~$ cat /proc/device-tree/ocp/wdt\@44e35000/compatible 
ti,omap3-wdt
ubuntu@beaglebone:~$ ls -la /sys/bus/platform/devices/ocp/*wdt*
total 0
drwxr-xr-x  3 root root    0 Aug 25 13:49 ./
drwxr-xr-x 33 root root    0 Aug 25 13:49 ../
-rw-r--r--  1 root root 4096 Aug 25 13:49 driver_override
-r--r--r--  1 root root 4096 Aug 25 13:49 modalias
lrwxrwxrwx  1 root root    0 Aug 25 13:49 of_node ->
../../../../firmware/devicetree/base/ocp/wdt@44e35000/
drwxr-xr-x  2 root root    0 Aug 25 13:49 power/
lrwxrwxrwx  1 root root    0 Aug 25 13:49 subsystem -> ../../../../bus/platform/
-rw-r--r--  1 root root 4096 Aug 25 13:49 uevent

and if i manually load the module:

ubuntu@beaglebone:~$ sudo modprobe omap_wdt
ubuntu@beaglebone:~$ dmesg | grep wdt
[  388.104283] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
ubuntu@beaglebone:~$ ls -la /dev/watchdog*
crw------- 1 root root  10, 130 Aug 25 13:46 /dev/watchdog
crw------- 1 root root 251,   0 Aug 25 13:46 /dev/watchdog0
ubuntu@beaglebone:~$ ls -la /sys/bus/platform/devices/ocp/*wdt*                                                             
total 0
drwxr-xr-x  3 root root    0 Aug 25 13:53 .
drwxr-xr-x 33 root root    0 Aug 25 13:49 ..
lrwxrwxrwx  1 root root    0 Aug 25 13:53 driver ->
../../../../bus/platform/drivers/omap_wdt
-rw-r--r--  1 root root 4096 Aug 25 13:49 driver_override
-r--r--r--  1 root root 4096 Aug 25 13:49 modalias
lrwxrwxrwx  1 root root    0 Aug 25 13:49 of_node ->
../../../../firmware/devicetree/base/ocp/wdt@44e35000
drwxr-xr-x  2 root root    0 Aug 25 13:49 power
lrwxrwxrwx  1 root root    0 Aug 25 13:49 subsystem -> ../../../../bus/platform
-rw-r--r--  1 root root 4096 Aug 25 13:49 uevent

and then the device works as expected.

So here are my questions:

1) My understanding was that, once a device node was present in the device-tree
and there was a compatible driver available, it would have been autoloaded, so why it's
not happening here?

2) And more importantly, how do i debug these situations?
Building a kernel with the driver built-in, and comparing the two dmesgs, didn't
show any noticeable difference either.

Any idea?
-- 
bye,
p.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
