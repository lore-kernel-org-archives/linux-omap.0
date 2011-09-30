From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP: more omap_device preparations for DT
Date: Fri, 30 Sep 2011 13:55:00 -0700
Message-ID: <87y5x5hhsr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:49635 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754816Ab1I3UzE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 16:55:04 -0400
Received: by mail-gy0-f172.google.com with SMTP id 12so2269265gyd.31
        for <linux-omap@vger.kernel.org>; Fri, 30 Sep 2011 13:55:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Please pull the following omap_device series that finishes up the
preparation the rest of the device tree work from Benoit.

Kevin


The following changes since commit 0f9b8dd0120cca55b73620c2a6e0dd8c1575f677:

  Merge branches 'cleanup', 'voltage' and 'dmtimer' into dt-base (2011-09-30 11:13:29 -0700)

are available in the git repository at:

  git://github.com/khilman/linux-omap-pm.git for_3.2/omap_device-2

Benoit Cousson (8):
      ARM: OMAP3: beagle-board: Use the omap_hwmod_name_get_dev API
      ARM: OMAP2+: pm: Use hwmod name instead of dev pointer
      ARM: OMAP2+: pm: Remove static devices variable for mpu, dsp, iva and l3 PM
      ARM: OMAP: omap_device: Create a default omap_device_pm_latency
      ARM: OMAP2+: devices: Remove all omap_device_pm_latency structures
      of: Add helpers to get one string in multiple strings property
      ARM: OMAP: omap_device: Add omap_device_[alloc|delete] for DT integration
      ARM: OMAP: omap_device: Add a method to build an omap_device from a DT node

Nishanth Menon (1):
      ARM: OMAP: omap_device: Add omap_device_get_by_hwmod_name

 .../devicetree/bindings/arm/omap/omap.txt          |   43 +++
 arch/arm/mach-omap2/board-omap3beagle.c            |    4 +-
 arch/arm/mach-omap2/devices.c                      |   46 +---
 arch/arm/mach-omap2/display.c                      |   11 +-
 arch/arm/mach-omap2/dma.c                          |   11 +-
 arch/arm/mach-omap2/gpio.c                         |   12 +-
 arch/arm/mach-omap2/hsmmc.c                        |   18 +-
 arch/arm/mach-omap2/hwspinlock.c                   |   12 +-
 arch/arm/mach-omap2/mcbsp.c                        |   11 +-
 arch/arm/mach-omap2/pm.c                           |   69 ++---
 arch/arm/mach-omap2/serial.c                       |   25 +--
 arch/arm/mach-omap2/sr_device.c                    |   11 +-
 arch/arm/mach-omap2/usb-musb.c                     |   11 +-
 arch/arm/plat-omap/i2c.c                           |   10 +-
 arch/arm/plat-omap/include/plat/omap_device.h      |    1 +
 arch/arm/plat-omap/omap_device.c                   |  313 +++++++++++++++++---
 drivers/of/base.c                                  |   84 ++++++
 include/linux/of.h                                 |   18 ++
 18 files changed, 448 insertions(+), 262 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/omap.txt
