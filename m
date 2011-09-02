From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 0/6] OMAP: omap_device cleanup before device-tree integration
Date: Fri, 2 Sep 2011 16:25:14 +0200
Message-ID: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36603 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab1IBOZe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 10:25:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Kevin,

Here are a couple of cleanups on top of your (old) for_3.2/omap_device branch
rebased on top of -rc4 + Tony's cleanup patches.

Since I cannot pull your latest version, I repost the whole series.

patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.2/1_omap_device_cleanup

It is tested on OMAP4 SDP, Panda and Beagle-xM (Yeah, I found one...).

Regards,
Benoit


Changes since v1: http://www.spinics.net/lists/linux-omap/msg55801.html
 - Update the 2 patches from Nishanth based on Kevin's comment and merge
   them into one patch.


Benoit Cousson (5):
  OMAP3: beagle-board: Use the omap_hwmod_name_get_dev API
  OMAP2+: pm: Use hwmod name instead of dev pointer
  OMAP2+: pm: Remove static devices variable for mpu, dsp, iva and l3 PM
  OMAP: omap_device: Create a default omap_device_pm_latency
  OMAP2+: devices: Remove all omap_device_pm_latency structures

Nishanth Menon (1):
  OMAP: omap_device: Add omap_hwmod_name_get_dev

 arch/arm/mach-omap2/board-omap3beagle.c       |    4 +-
 arch/arm/mach-omap2/devices.c                 |   46 ++---------------
 arch/arm/mach-omap2/display.c                 |   11 +----
 arch/arm/mach-omap2/dma.c                     |   11 +----
 arch/arm/mach-omap2/gpio.c                    |   12 +----
 arch/arm/mach-omap2/hsmmc.c                   |   18 +------
 arch/arm/mach-omap2/hwspinlock.c              |   12 +----
 arch/arm/mach-omap2/mcbsp.c                   |   11 +----
 arch/arm/mach-omap2/pm.c                      |   69 ++++++++-----------------
 arch/arm/mach-omap2/serial.c                  |   25 +---------
 arch/arm/mach-omap2/sr_device.c               |   11 +----
 arch/arm/mach-omap2/usb-musb.c                |   11 +----
 arch/arm/plat-omap/i2c.c                      |   10 +---
 arch/arm/plat-omap/include/plat/omap_device.h |   10 ++++
 arch/arm/plat-omap/omap_device.c              |   49 +++++++++++++++++-
 15 files changed, 95 insertions(+), 215 deletions(-)

