From: "Boswell, Patrick" <Patrick.Boswell@Sypris.com>
Subject: RE: Kernel panic on "run_init_process(execute command)"
Date: Mon, 11 Apr 2011 16:28:54 -0400
Message-ID: <0E62BBF85AF134469094EB502CE90A321EAEE2@TAMPA202EM.se.sypris.com>
References: <0E62BBF85AF134469094EB502CE90A321EAEB7@TAMPA202EM.se.sypris.com> <6A68247F-1EC3-4CF4-9FAB-E67B4C84E72D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og111.obsmtp.com ([64.18.2.175]:48213 "HELO
	exprod7og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754611Ab1DKU3w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Apr 2011 16:29:52 -0400
Content-class: urn:content-classes:message
In-Reply-To: <6A68247F-1EC3-4CF4-9FAB-E67B4C84E72D@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap@vger.kernel.org

Elvis,

Thanks for the all the info below, see my interleaved comments.

-----Original Message-----
From: Elvis Dowson [mailto:elvis.dowson@mac.com] 
Sent: Friday, April 08, 2011 4:21 PM
To: Boswell, Patrick
Cc: linux-omap@vger.kernel.org
Subject: Re: Kernel panic on "run_init_process(execute command)"

Hi,
        

On Apr 8, 2011, at 11:22 PM, Boswell, Patrick wrote:

> I am working with a custom OMAP3530 board. I am using rowboat 2.6.32,
> codesourcery 2010q1, X-loader and U-boot, all uniquely customized for
> this board.
> 
> I am using the 3 partition microSD card for this board, modeled after
> the TI-DevKit version 2.2, with rootfs as a partition at
/dev/mmcblk0p2.

Try to use just 2 partitions first, a 40MB FAT32 partition, and a 512MB 
ext3 partition.

On the FAT boot partition, you should first copy MLO, u-boot.bin and
uImage.

While creating the bootable rootfs partition (disk-1), you can merge the
outputs of the 
android root and system folders as follows:

# su
# cd /media/disk-1
# rm -Rf *
# cp -a /tool/android-rowboat-2.2/out/target/product/beagleboard/root/*
.
# cp -a
/tool/android-rowboat-2.2/out/target/product/beagleboard/system/*
system/

# chown -R root.root *
# chmod -R 777 data system


You should also check your init.rc file, to ensure that you comment out
the
sections relating to mounting the nand partitions.

##    mount rootfs rootfs / ro remount

# mount mtd partitions
    # Mount /system rw first to give the filesystem a chance to save a
checkpoint
##    mount yaffs2 mtd@system /system
##    mount yaffs2 mtd@system /system ro remount

    # We chown/chmod /data again so because mount is run as root +
defaults
##    mount yaffs2 mtd@userdata /data nosuid nodev
    chown system system /data
    chmod 0771 /data


Also check your bootargs. The ones that I use are as follows:

# printenv
# setenv defaultdisplay lcd43
# setenv dvimode 480x272MR-16@60
# setenv vram 12M

# setenv mmcargs setenv bootargs console=${console} vram=${vram}
omapfb.vram=0:4M omapfb.mode=dvi:${dvimode} omapfb.debug=y
omapdss.def_disp=${defaultdisplay} root=/dev/mmcblk0p2 rw
rootfstype=ext3 rootwait

# saveenv
# boot

> On kernel boot, after mounting the root filesystem (/dev/mmcblk0p2)
when
> attempting to start init (bootargs are init=/init), in main.c,
> run_init_process(execute_command) with execute_command set to /init, I
> get a kernel panic:
> 
> 
> [  103.806274] Kernel panic - not syncing: Attempted to kill init!

Are you able to boot a standard linux omap console image, with the TI
DevKit 2.2 kernel
without specifying the init=/init boot args?

This is to try to narrow the issue to being either with the x-load,
u-boot, kernel combination
with standard rootfs (which should boot properly first), versus trying
to load the android
root file system.

Specifically, I believe the issue is most likely to do with the android
fs 
versus a vanilla fs.

I have not really dealt with init and rootfs before, but the logic makes
sense
to try something non-android and then try android for the rootfs. 

I did some simple debugging like removing init from the partition, and
the kernel
was unable to find init -- which means that the kernel is reading init. 

Also, when I pause the kernel boot in the debugger for a long time, I
get
the lockup stack dump, which is good, and it identifies the running
process
as init, PID 1, which is good, which means that init is being read and
run
from the rootfs on the SD card.

How would I go about generating a basic, stock root filesystem to try
instead of the one that was provided by the TI-DevKit?


Which version of android are you using?

I am building for 2.2, Froyo, linux 2.6.32.

> The backtrace identifies: 
> 
> 
> [  103.812377] [<c0048320>] (unwind_backtrace+0x0/0x17c) from
> [<c0489d34>] (dump_stack+0x20/0x24)
> [  103.821105] [<c0489d34>] (dump_stack+0x20/0x24) from [<c0489d94>]
> (panic+0x5c/0x130)
> [  103.828918] [<c0489d94>] (panic+0x5c/0x130) from [<c007cc18>]
> (do_exit+0x5d4/0x6a4)
> [  103.836669] [<c007cc18>] (do_exit+0x5d4/0x6a4) from [<c007cd34>]
> (do_group_exit+0x4c/0xbc)
> [  103.845062] [<c007cd34>] (do_group_exit+0x4c/0xbc) from
[<c008dee8>]
> (get_signal_to_deliver+0x208/0x3e8)
> [  103.854644] [<c008dee8>] (get_signal_to_deliver+0x208/0x3e8) from
> [<c0042de0>] (do_signal+0x74/0x698)
> [  103.863983] [<c0042de0>] (do_signal+0x74/0x698) from [<c0043470>]
> (do_notify_resume+0x6c/0x78)
> [  103.872680] [<c0043470>] (do_notify_resume+0x6c/0x78) from
> [<c003fb4c>] (work_pending+0x1c/0x20)

Could you paste the output of the entire boot process, leading upto the
panic?



Elvis Dowson

