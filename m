From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: 4430SDP boot failure
Date: Thu, 6 Jan 2011 17:08:05 +0000
Message-ID: <20110106170805.GE1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34192 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab1AFRIL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 12:08:11 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PatJn-0000uF-9H
	for linux-omap@vger.kernel.org; Thu, 06 Jan 2011 17:08:07 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PatJm-0001zl-1D
	for linux-omap@vger.kernel.org; Thu, 06 Jan 2011 17:08:06 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This looks like something's rather broken on OMAP4 too - even with the
DEBUG_LL stuff enabled and my printk hack, I get nothing more, same with
vanilla 2.6.37.  So, no OMAP platform I have seems to be usable with
2.6.37...

It's worth noting that the kernel which was originally supplied with the
board works fine (2.6.31-00682-g49ab82a-dirty) with this uboot, as have
previous kernels I've built.

Is there yet an updated uboot for this platform which works with ethernet,
and which has the uboot environment saving implemented?  Or are we stuck
with having to catch uboot before it runs the default settings and paste
the commands in each time?  Also, if possible please extend the default
timeout - I can only just get from the board to the terminal to stop it
booting the default environment.

For TI folk: it may be an idea to make X-loader say why it's hanging so
that we know what is going on.

Texas Instruments X-Loader 1.41 (Apr 19 2010 - 13:31:11)
mmc read: Invalid size
Starting OS Bootloader from MMC/SD1 ...


U-Boot 1.1.4-g9e955085-dirty (Nov 19 2009 - 13:01:21)

Load address: 0x80e80000
DRAM:  512 MB
Flash:  0 kB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
OMAP44XX SDP # setenv bootargs 'root=/dev/mmcblk1p2 rw mem=512M console=ttyO2,115200n8 rootdelay=2'
OMAP44XX SDP # mmcinit 0
OMAP44XX SDP # fatload mmc 0 0x80300000 uImage-test
mmc read: Invalid size

1843088 bytes read
OMAP44XX SDP # bootm 80300000
## Booting image at 80300000 ...
   Image Name:   Linux-2.6.37+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1843024 Bytes =  1.8 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
X-Loader hangs

