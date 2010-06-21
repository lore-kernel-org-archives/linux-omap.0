From: Peter Tseng <tsenpet09@gmail.com>
Subject: Overo serial problems after resume, vs. Beagleboard
Date: Mon, 21 Jun 2010 13:04:00 -0400
Message-ID: <4C1F9B80.9010708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55245 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355Ab0FUREH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 13:04:07 -0400
Received: by vws3 with SMTP id 3so1261425vws.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 10:04:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Han Wang <hw342@cornell.edu>

Hey there,

I am seeing some discrepancies between the Overo (I believe I have a
Water) and the Beagleboard (I have a Rev. B5) when resuming after a
suspend to RAM.

The setup: My kernel is built from the latest commit (commit ID
305f453e897e4673dd4c2b52ec7e2c4be2e2b035 [1]) of the branch named pm of
Kevin Hilman's linux-omap-pm [2].

I take the omap3_pm_defconfig, and change the below options to Y as they
seem to be needed to boot from SD card (Names given are names in
menuconfig under Device Drivers-->MMC/SD/SDIO card support. Config
symbols given in parentheses)
- MMC block device driver (MMC_BLOCK)
- TI OMAP High Speed Multimedia Card Interface support (MMC_OMAP_HS)
- Secure Digital Host Controller Interface support (MMC_SDHC)

My filesystem is omap3-console-image dated May 23 from Steve Sakoman's
binaries [3]. I do need to note that I made a few changes: symlinked
/sbin/init to /bin/busybox instead of /sbin/init.sysvinit and changed
/etc/init.d/rcS and /etc/inittab to suit Busybox.

My uBoot is also taken from Steve Sakoman, and also dated May 23.

I use the same card for both the Beagle and the Overo. This reduces
sources of confounding variables, as now the only difference is the
hardware (and that I need a micro-SD adapter for the Beagle).

For Beagle:
Kernel command line: console=ttyS2,115200n8 mpurate=500 vram=12M
omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y omapdss.def_disp=dvi
root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait

For Overo:
Kernel command line: console=ttyS2,115200n8 vram=12M
omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y omapdss.def_disp=dvi
root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait

The Overo connects to my computer through USB, on the port on the Summit
board labeled CONSOLE. The Beagle connects to my computer through RS232,
a null modem cable, and a USB to serial adapter. I use screen.

The problem comes when I use echo mem > /sys/power/state to suspend to
ram, and then press some key to wake up the system. The Beagleboard
comes up just fine. On the other hand, the Overo initially looks like it
comes up fine, but I can no longer type anything into the prompt that
appears. This looks suspiciously similar to Han Wang's problem, but I
did a little more exploring via a quick test script to see how far the
system gets.

root@overo:~# cat test.sh
echo "I went to sleep" > log
echo mem > /sys/power/state
echo "HEY I WOKE UP"
echo "HEY I WOKE UP" >> log
sync
root@overo:~#

Interestingly enough, when I run this script and resume on the Overo, I
can see HEY I WOKE UP both in the console and the file (after a restart
so I can type something to read the file)! So the problem is simply that
I cannot type anything, not that the system isn't waking up, otherwise
it wouldn't even get to the echoes. (Blindly typing in things afterward,
including echoing to a file, does not seem to have an effect, unfortunately)

Any ideas on what might be causing this discrepancy and whether there's
anything I can do to fix? I appreciate your time.

Peter Tseng

[1]
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=305f453e897e4673dd4c2b52ec7e2c4be2e2b035
[2]
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
[3] http://www.sakoman.com/feeds/omap3/glibc/images/overo/
