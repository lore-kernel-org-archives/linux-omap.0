From: "Anil Sasidharan" <anils@mistralsolutions.com>
Subject: Android porting onto OMAP2430
Date: Wed, 27 Feb 2008 15:16:54 +0530
Message-ID: <f6c5b8d90802270146q69c0e698j52f9f231adcc64bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

        I've applied the android m5-r14 kernel patch (received from
 Raymond) to my 2.6.22 based kernel source and built a new kernel image.
 The system, dev, data directories are pulled out from the emulator
 (m5-r14 SDK release) and added into my current rootFS. The results of
 my experiments are given below:

 1. rootFS on NFS mount
 --------------------------------
 1. Once the device boots up completely and shows the console prompt,
 the following commands are issued.

 date -s 022711302008 (to set the system date) umask 000

 mount -t tmpfs tmpfs /tmp
 mount -t proc proc /proc
 mount -t sysfs sysfs /sys

 rm -rf /tmp/*
 chmod -R a+rw /data /tmp

 export ANDROID_ASSETS=/system/app
 export ANDROID_BOOTLOGO=1
 export ANDROID_DATA=/data
 export ANDROID_ROOT=/system
 export BOOTCLASSPATH=/system/framework/core.jar:/system/framework/ext.jar:/system/framework/framework.jar:/system/framework/framework-tests.jar
 export DRM_CONTENT=/data/drm/content
 export EXTERNAL_STORAGE=/sdcard
 export IFS='
 '
 export LD_LIBRARY_PATH=/system/lib
 export OPTIND=1
 export PATH=/sbin:/system/sbin:/system/bin
 /system/bin/app_process -Xzygote /system/bin --zygote &
 /system/bin/dbus-daemon --system & /strace_android -f -ff -tt -s 200
 /system/bin/runtime

 Now I'll have to wait for approximately 10minutes to view  the android
 home screen. I'm really happy about android being functional on our
 platform. However I still have some issues to be resolved.

 1. If I do not launch /system/bin/runtime without the strace command,
 the process hangs and even the console is not responding. I would like
 to get some tips regardding the schedule_timeout that was introduced
 in your pan_display routine of the framebuffer driver.
 2. I can see key events from the H/W keyboard being recognized by
 Android. However touch is still not functional.
 3. Right now the rootFS is residing on an NFS mount point. I have
 tried flashing the filesystem to a yaffs2 partition (of size 93MB) on
 the NAND flash. But the /system/bin/app_process itself is segfaulting
 with java Classpath exceptions as shown here:

 /system/bin/app_process -Xzygote /system/bin --zygote & # binder_open: 268:268
 PathClassLoader: can't find '.'
 PathClassLoader: can't find '.'
 PathClassLoader: can't find '.'
 PathClassLoader: can't find '.'
 PathClassLoader: can't find '.'
 PathClassLoader: can't find '.'
 PathClassLoader: can't find '.'
 PathClassLoader: can't find '.'
 PathClassLoader: can't find '.'
 PathClassLoader: can't find '.'
 PathClassLoader: can't find '.'
 PathClassLoader: can't find '.'
 java.lang.NullPointerException
        at java.io.BufferedInputStream.fillbuf(BufferedInputStream.java:150)
        at java.io.BufferedInputStream.read(BufferedInputStream.java:306)
        at java.io.FilterInputStream.read(FilterInputStream.java:137)
        at java.util.Properties.load(Properties.java:269)
        at java.util.logging.LogManager.readConfigurationImpl(LogManager.java:532)
        at java.util.logging.LogManager.readConfiguration(LogManager.java:455)
        at java.util.logging.LogManager$1.run(LogManager.java:247)
        at java.security.AccessController.doPrivilegedImpl(AccessController.java:173)
        at java.security.AccessController.doPrivileged(AccessController.java:53)
        at java.util.logging.LogManager.<clinit>(LogManager.java:233)
        at java.util.logging.Logger.initHandler(Logger.java:435)
        at java.util.logging.Logger.log(Logger.java:1099)
        at java.util.logging.Logger.warning(Logger.java:918)
        at java.util.ZoneInfoDB.<clinit>(ZoneInfoDB.java:113)
        at java.util.TimeZone.getDefault(TimeZone.java:176)
        at java.util.GregorianCalendar.<init>(GregorianCalendar.java:192)
        at java.util.GregorianCalendar.<init>(GregorianCalendar.java:151)
        at java.util.Date.getYear(Date.java:333)
        at java.util.Date.<clinit>(Date.java:44)
        at android.dalvik.Zygote.initClass(Native Method)
        at android.os.ZygoteInit.preloadClasses(ZygoteInit.java:1371)
        at android.os.ZygoteInit.main(ZygoteInit.java:1406)
        at android.dalvik.NativeStart.main(Native Method)
 binder_flush: 268 woke 0 threads
 binder_release: 268 threads 0, nodes 0 (ref 0), refs 0, active
 transactions 0, buffers 0, pages  0


 It would be extremely helpful if you could throw
 some light on the above mentioned issues.

 Warm Regards,
 Anil
