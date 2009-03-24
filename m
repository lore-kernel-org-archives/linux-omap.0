From: Paul Walmsley <paul@pwsan.com>
Subject: Beagle can't mount rootfs from MMC after regulator updates
Date: Tue, 24 Mar 2009 16:56:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903241651080.9924@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59804 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZCXW4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 18:56:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: david-b@pacbell.net


Hi,

The BeagleBoard rev B4 here can't mount its root filesystem from MMC after 
3fe326511c66ab842ef0a09a1f4c564b1a8beecf, "mmc-twl4030 uses regulator 
framework".  This is with omap3_beagle_defconfig and rootwait in the 
kernel command line.  Kernel hangs after:

Waiting for root device /dev/mmcblk0p2...

Will look at this in a few hours unless Dave beats me to it ;-)


- Paul
