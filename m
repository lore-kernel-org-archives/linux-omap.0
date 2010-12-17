From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 0/9] OMAP: DMA: hwmod and DMA as platform device
Date: Fri, 17 Dec 2010 21:09:39 +0530
Message-ID: <1292600388-13094-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53004 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755276Ab0LQPii (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 10:38:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, santosh.shilimkar@ti.com, b-cousson@ti.com, paul@pwsan.com

Detailed description and history of this patch series can be found at:
http://thread.gmane.org/gmane.linux.ports.arm.omap/47600

Changes from v1 to v2:
1. The OMAP1 irq fixes patchby kevin:
https://patchwork.kernel.org/patch/412021/
is folded into this series and added kevin s.o.b

2. The 2420 and 2430 clock clock entries are corrected as per paul's
suggestion at:
http://article.gmane.org/gmane.linux.ports.arm.omap/48441
http://article.gmane.org/gmane.linux.ports.arm.omap/48442

3. Added Tested-by and Acked-by to all the applicable patches
(except 3/9 and 4/9 due to paul's comments)

The diff between v1 and v2 series is posted for reference at:
http://pastebin.com/EG46DeK6

Testing:
Build: 
omap1_defconfig : Success
omap2plus_defconfig: Success

Boot:
OMAP4430SDP    : Success
OMAP2430SDP    : Success
N800(OMAP2420) : Success 
Note: Image for N800 is created from n8x0_defconfig derived from the commit: 
d31f59f31d602e8c3a34ce1f20d1e8fcfe50dd59
and it is customized to reduce the image size. Thanks to Tony and paul
for providing the commit and other info related to N800 boot.
boot log at: http://pastebin.com/0y91Vvkf

Unit testing:
All the memory to memory test cases are passing on SDP2430 and complete
test log can be accessed at:
http://pastebin.com/1ALGuE8z

Note: The remaining omap2+ boards are not tested with this series since
changes done in this series are no way related to other omap2+ boards. 
The OMAP1(OSK5912) boot and other relevant tests are executed by kevin 
with the fixes https://patchwork.kernel.org/patch/412021/
The above patch is folded into 7/9 in this patch series which needs review.

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

