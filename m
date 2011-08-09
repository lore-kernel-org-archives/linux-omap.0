From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH 00/14] dt: omap hwmod-dt binding and omap3 i2c1 dt support
Date: Tue, 09 Aug 2011 19:10:18 +0500
Message-ID: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.76.145] ([117.192.76.145]:55758 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750695Ab1HINwn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Aug 2011 09:52:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca


This is in continuation of patch series posted at:
http://lwn.net/Articles/451917/

Patches from Kevin Hilman and others are consolidated along with this
series since it will be part of ongoing work of decoupling pdev from
omap_device.
[There is latest version posted which will be rebased later]

Apart from the above, the major feature included in this series is
dt-hwmod binding and preparing omap hwmod framework for adapting omap
drivers to support omap dt after aligning with Grant Likely 
<grant.likely@secretlab.ca>

However, current hwmod-dt binding will be replaced with notifiers in
generic board file and hwmod device pointer will be scanned and attached
in notifier call.

Used 3.0 stable kernel version for this patch series since latest mainline
was broken for beagle boot last week.

git://git.secretlab.ca/git/linux-2.6.git
Branch: devicetree/test-3.0

G, Manjunath Kondaiah (6):
  dt: omap: prepare hwmod to support dt
  dt: Add pd_size to AUXDATA structure
  dt: omap3: add soc file for handling i2c controllers
  dt: omap3: beagle board: set clock freq for i2c devices
  dt: omap3: add generic board file for dt support
  dt: omap3: enable dt support for i2c1 controller

Kevin Hilman (7):
  OMAP: omap_device: replace _find_by_pdev() with to_omap_device()
  OMAP: omap_device: replace debug/warning/error prints with dev_*
    macros
  OMAP3: beagle: don't touch omap_device internals
  OMAP: McBSP: use existing macros for converting between devices
  OMAP: omap_device: remove internal functions from omap_device.h
  OMAP: omap_device: when building return platform_device instead of
    omap_device
  ARM: platform_device: pdev_archdata: add omap_device pointer

Tony Lindgren (1):
  omap2+: Use Kconfig symbol in Makefile instead of obj-y

 arch/arm/boot/dts/omap3-beagle-nunchuck.dts   |   11 +--
 arch/arm/boot/dts/omap3-beagle.dts            |   18 +++-
 arch/arm/boot/dts/omap3-soc.dtsi              |   62 ++++++++++
 arch/arm/include/asm/device.h                 |    5 +
 arch/arm/mach-omap2/Kconfig                   |   11 ++
 arch/arm/mach-omap2/Makefile                  |   77 ++++++-------
 arch/arm/mach-omap2/board-omap3-dt.c          |   93 +++++++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c       |   40 ++-----
 arch/arm/mach-omap2/devices.c                 |   44 ++++----
 arch/arm/mach-omap2/display.c                 |    6 +-
 arch/arm/mach-omap2/dma.c                     |   16 ++--
 arch/arm/mach-omap2/gpio.c                    |    8 +-
 arch/arm/mach-omap2/hsmmc.c                   |    8 +-
 arch/arm/mach-omap2/hwspinlock.c              |    8 +-
 arch/arm/mach-omap2/mcbsp.c                   |    8 +-
 arch/arm/mach-omap2/pm.c                      |    8 +-
 arch/arm/mach-omap2/serial.c                  |   12 +-
 arch/arm/plat-omap/i2c.c                      |    8 +-
 arch/arm/plat-omap/include/plat/omap_device.h |   17 ++-
 arch/arm/plat-omap/mcbsp.c                    |    6 +-
 arch/arm/plat-omap/omap_device.c              |  150 ++++++++++++++++---------
 drivers/i2c/busses/i2c-omap.c                 |   23 ++++-
 drivers/of/platform.c                         |   41 +++++++
 include/linux/of_platform.h                   |    5 +
 24 files changed, 469 insertions(+), 216 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-soc.dtsi
 create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c

