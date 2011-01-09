From: Steve Sakoman <sakoman@gmail.com>
Subject: Issues with ADATA SD cards on OMAP?
Date: Sat, 8 Jan 2011 22:04:05 -0800
Message-ID: <AANLkTinw=ZjiOr1KHNxu1Npq5iLucOPyw0Gumdyq1jjS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44219 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1AIGEH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Jan 2011 01:04:07 -0500
Received: by vws16 with SMTP id 16so7736366vws.19
        for <linux-omap@vger.kernel.org>; Sat, 08 Jan 2011 22:04:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I've recently been testing memory card performance to identify the
best performing brands/models.

As expected, I found a huge difference in performance between brands.
What I didn't expect to find, however, was a brand (ADATA) that
doesn't seem to play well with the 2.6.36 kernel on OMAP3 hardware.
I'm wondering if this failure might be exposing an issue in the OMAP
mmc driver/hw setup.

I tested both 4GB and 8GB versions of the ADATA Class 6 cards.  I was
not able to boot successfully from either card on both Overo and
Beagle hardware (both 35xx and 37xx versions were tested).

The error was the same in all cases: x-load, u-boot, and the kernel
were all loaded successfully from SD, but the kernel was not able to
mount the rootfs:

Waiting for root device /dev/mmcblk0p2...
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new high speed SDHC card at address 0260
mmcblk0: mmc0:0260 SD    3.75 GiB
 mmcblk0: p1 p2
EXT3-fs: barriers not enabled
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) on device 179:2.
devtmpfs: mounted
Freeing init memory: 168K
INIT: version 2.86 booting
Please wait: booting...
Starting udev
Remounting root file system...
mmcblk0: error -110 sending read/write command, response 0x900, card
status 0xe00
mmcblk0: error -110 transferring data, sector 3556505, nr 8, card status 0xc00
end_request: I/O error, dev mmcblk0, sector 3556512
Buffer I/O error on device mmcblk0p2, logical block 426490
lost page write due to I/O error on mmcblk0p2
mmcblk0: error -110 sending read/write command, response 0x900, card
status 0xe00
mmcblk0: error -110 transferring data, sector 4076825, nr 8, card status 0xc00
end_request: I/O error, dev mmcblk0, sector 4076832
Buffer I/O error on device mmcblk0p2, logical block 491530
lost page write due to I/O error on mmcblk0p2
mmcblk0: error -110 sending read/write command, response 0x900, card
status 0xe00
mmcblk0: error -110 transferring data, sector 4126233, nr 8, card status 0xc00
end_request: I/O error, dev mmcblk0, sector 4126234
Buffer I/O error on device mmcblk0p2, logical block 497706
lost page write due to I/O error on mmcblk0p2

And so on, with many more mmc errors.

If I reset and try again, things go wrong even sooner:

Waiting for root device /dev/mmcblk0p2...
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new high speed SDHC card at address 0260
mmcblk0: mmc0:0260 SD    3.75 GiB
 mmcblk0: p1 p2
EXT3-fs: barriers not enabled
mmcblk0: error -110 sending read/write command, response 0x900, card
status 0xe00
mmcblk0: error -110 transferring data, sector 147545, nr 8, card status 0xc00
end_request: I/O error, dev mmcblk0, sector 147552
Buffer I/O error on device mmcblk0p2, logical block 370
lost page write due to I/O error on mmcblk0p2

The ADATA cards seem to work with no issues on my desktop system.

Has anyone else run into this issue?  Any theories on where to start looking?

FWIW, there is this thread on the beagleboard list discussing issues
with mmc writes:

http://groups.google.com/group/beagleboard/browse_thread/thread/0083724ff7e54c58/f55578bb1c1379db#f55578bb1c1379db

In this thread Gerald Coley speculates that the driver may be setting
the mmc1 voltage to 3.0V rather than 3.15V.

Regards,

Steve

PS: For those who might be interested in the microSD card performance tests:

http://www.sakoman.com/OMAP/microsd-card-perfomance-test-results.html
