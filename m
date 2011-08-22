From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/7] OMAP: omap_device cleanup before device-tree integration
Date: Mon, 22 Aug 2011 17:19:00 +0200
Message-ID: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37480 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab1HVPTg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 11:19:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>

Hi Kevin,

Here are a couple of cleanups on top of your for_3.2/omap_device series
rebased on top of 3.1-rc2 to get your pm-fixes.
The goal is to help building core devices using device-tree by removing
direct reference to the device inside PM.
For that, I took and rebased the two patches done by Nishanth to use hwmod
to identify the device from the generic IP name.
The currently "unused" omap_device_pm_latency is moved inside the
omap_device core code to avoid the duplication.

patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.2/omap_device_cleanup

It is tested on OMAP4 SDP and Panda only. I don't even have the Beagle
to test the beagle patch :-(

Regards,
Benoit


Benoit Cousson (5):
  OMAP3: beagle-board: Use the omap_hwmod_name_get_dev API
  OMAP2+: pm: Use hwmod name instead of dev pointer
  OMAP2+: pm: Remove static devices variable for mpu, dsp, iva and l3 PM
  OMAP: omap_device: Create a default omap_device_pm_latency
  OMAP2+: devices: Remove all omap_device_pm_latency structures

Nishanth Menon (2):
  OMAP: PM: omap_device: add omap_hwmod_name_get_odev
  OMAP: PM: omap_device: add few quick access functions

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
 arch/arm/plat-omap/include/plat/omap_device.h |   16 ++++++
 arch/arm/plat-omap/omap_device.c              |   49 +++++++++++++++++-
 15 files changed, 101 insertions(+), 215 deletions(-)

