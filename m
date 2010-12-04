From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v1 0/9] OMAP: DMA: hwmod and DMA as platform device
Date: Sat,  4 Dec 2010 09:13:57 +0530
Message-ID: <1291434246-30716-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59628 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753896Ab0LDDnn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 22:43:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, "G, Manjunath Kondaiah" <manjugk@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Patch series to convert DMA library into platform driver using platform
device model and adapting hwmod for omap2+.

The original patch series :
http://comments.gmane.org/gmane.linux.ports.arm.omap/46953
has been split into two patch series based on suggestion from Tony.
(https://patchwork.kernel.org/patch/375831/)

The first series will prepare existing DMA library for DMA hwmod and 
converting the same into platform driver.

The second series will have:
arch/arm/mach-omap1/dma.c       omap1 specific platform init
arch/arm/mach-omap2/dma.c       omap2+ specific platform init
drivers/dma/omap-dma.c          driver using dmaengine.c

Patch series1 Design:
1. The low level read/write macros are converted into static inline functions
so that, these functions can be moved to respective mach-omap driver
files later.
(Thanks to Tony and Kevin for their suggestions on handling all omap register
offset without adding extra enums)
2. Implements generic errata handling for all OMAP DMA errata.
3. DMA hwmod data is updated for respective hwmod db files.
4. The DMA library is split into two layers.
   a. The generic code is retained in plat-omap/dma.c
   b. The machine specific init code is moved to
      respective mach-omap dma files.

Minimal machine specific code is moved to respective mach-omap dma files with 
this series. Rest of code movement and API cleanup's are handled in second
series.

Patch series applies on top of latest linux omap master branch:
*************************************************************************
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
Branch: master
commit a04fd22204b13ce34a3f8a8157f83c44d64f8da9
Merge: e941bb0 afd2d11
Author: Tony Lindgren <tony@atomide.com>

    Linux-omap rebuilt: Merged in usb patches for testing
*************************************************************************

Test Report:
************
Build:
omap2plus_defconfig    : Success
omap_osk_5912_defconfig: Success

Boot:
OMAP3530Beagle         : Success
OMAP4430Blaze(ES2.1)   : Success
OMAP1(OSK5912)         : Success

Test cases executed:
1. All applicable TI DMA tests which are located at:
git://dev.omapzoom.org/pub/scm/richo/device_driver_test.git
Branch: master

Report can be accessed at: 
Beagle board: http://pastebin.com/sDUChNLr

The original patch series and change history can be found at:
http://permalink.gmane.org/gmane.linux.ports.arm.omap/46953#

Benoit Cousson (1):
  OMAP4: hwmod data: add system DMA

G, Manjunath Kondaiah (8):
  OMAP: DMA: Replace read/write macros with functions
  OMAP: DMA: Introduce errata handling feature
  OMAP2420: hwmod data: add system DMA
  OMAP2430: hwmod data: add system DMA
  OMAP3: hwmod data: add system DMA
  OMAP1: DMA: Implement in platform device model
  OMAP2+: DMA: hwmod: Device registration
  OMAP: DMA: Convert DMA library into platform driver

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/dma.c                  |  390 ++++++++++++++++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/dma.c                  |  297 ++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   87 ++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   87 ++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   97 ++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  101 ++++
 arch/arm/plat-omap/dma.c                   |  697 ++++++++++++----------------
 arch/arm/plat-omap/include/plat/dma.h      |  232 ++++------
 10 files changed, 1452 insertions(+), 540 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.c
 create mode 100644 arch/arm/mach-omap2/dma.c

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
