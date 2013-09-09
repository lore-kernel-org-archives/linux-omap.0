From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Vanilla kernel 3.11.0 boot problem on Pandaboard.
Date: Mon, 09 Sep 2013 21:17:28 +0100
Message-ID: <522E2CD8.4050704@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from know-smtprelay-omc-6.server.virginmedia.net ([80.0.253.70]:45039
	"EHLO know-smtprelay-omc-6.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755472Ab3IIURb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Sep 2013 16:17:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I built the kernel-headers and kernel-image .deb packages using 
make-kpkg native on the 3.18.3.6 kernel.

The package installs created new uEnv.txt, uImage an uInitrd.

Do I need an updated uboot for 3.11?

[125588.918060] Restarting system.

Serial console log
===========
U-Boot SPL 2011.12-00002-g1bdc71d (Feb 13 2012 - 18:52:25)
Texas Instruments OMAP4430 ES2.3
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2011.12-00002-g1bdc71d (Feb 13 2012 - 18:52:25)

CPU  : OMAP4430 ES2.3
Board: OMAP4 Panda
I2C:   ready
DRAM:  1 GiB
MMC:   OMAP SD/MMC: 0
Using default environment

In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
SD/MMC found on device 0
reading uEnv.txt

119 bytes read
Loaded environment from uEnv.txt
Importing environment from mmc ...
Running uenvcmd ...
reading uImage

4039336 bytes read
reading uInitrd

2187985 bytes read
## Booting kernel from Legacy Image at 80000000 ...
    Image Name:   kernel 3.11.0-07887-gb409624-dir
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    4039272 Bytes = 3.9 MiB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 81600000 ...
    Image Name:   ramdisk 3.11.0-07887-gb409624-di
    Image Type:   ARM Linux RAMDisk Image (gzip compressed)
    Data Size:    2187921 Bytes = 2.1 MiB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Regards
Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Senior Staff Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

