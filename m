From: Tony Lindgren <tony@atomide.com>
Subject: Help needed with remaining plat headers
Date: Thu, 20 Sep 2012 16:29:08 -0700
Message-ID: <20120920232907.GN28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43443 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932517Ab2ITX3K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 19:29:10 -0400
Received: from c-98-234-237-12.hsd1.ca.comcast.net ([98.234.237.12] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)
	(envelope-from <tony@atomide.com>)
	id 1TEqBB-0000Ft-If
	for linux-omap@vger.kernel.org; Thu, 20 Sep 2012 23:29:09 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

With the recent pull request I sent for v3.7, we now have pretty
much all the mach includes fixed up for omap2+ for single zImage
support.

We still have quite a few plat headers that we need to sort
out manually.

Please take a look at the following list, and reply to this
thread if you are working on patches moving one of the headers
in the list so we can coordinate things. The rules are simple
for most of them:

1. For driver related data, the header should now be in
   include/linux/platform_data/*.h

2. For mach-omap2 specific things, the headers should be
   in arch/arm/mach-omap2.

3. Drivers should not include anything from plat or mach.

I'll be looking into getting rid of cpu.h etc for v3.8 merge
window, but won't be looking much at the driver related
headers. So some help would be appreciated here :)

Regards,

Tony


$ ls arch/arm/plat-omap/include/plat/
clkdev_omap.h
clock.h
common.h
cpu.h
dma-44xx.h
dma.h
dmtimer.h
fpga.h
gpmc.h
i2c.h
iommu2.h
iommu.h
iopgtable.h
iovmm.h
led.h
mailbox.h
menelaus.h
mmc.h
multi.h
omap_device.h
omap_hwmod.h
omap-pm.h
omap-secure.h
omap-serial.h
prcm.h
sdrc.h
serial.h
sram.h
tc.h
timex.h
uncompress.h
usb.h
vram.h
vrfb.h

