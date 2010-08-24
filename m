From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH v2 00/11] OMAP: DMA: HWMOD and DMA as platform driver
Date: Tue, 24 Aug 2010 16:34:15 +0530
Message-ID: <1282647866-6918-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56325 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab0HXLF0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Aug 2010 07:05:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch series has review comments incorporated which are received
for v1 version.
The review comments can be found at:
http://www.spinics.net/lists/linux-omap/msg34291.html
http://www.spinics.net/lists/linux-omap/msg34292.html
http://www.spinics.net/lists/linux-omap/msg34078.html
http://www.spinics.net/lists/linux-omap/msg34083.html

These changes are tested on following boards:
- Zoom3     (OMAP3630)
- Beagle    (OMAP3530)
- OMAP4 SDP (OMAP4430)
I don't have omap1 and omap2 boards and appreciate if 
some one can test these boards and provides feedback.

Build tested for both omap1 and omap2 plus boards.

This patch series applies on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
Branch: pm-wip/hwmods-omap4
commit f6f7f1103b80b4dc0ace8a0314d95d1b1ebca726
Merge: 79d0b02 597e89c
Author: Kevin Hilman <khilman@ti.com>

    Merge branch 'pm-wip/hwmods' into pm-wip/hwmods-omap4-base

The earlier version of the patches can be found at:
RFC patches:
http://www.spinics.net/lists/linux-omap/index.html#33393

v1 patches:
http://www.spinics.net/lists/linux-omap/msg34066.html

Patch series summary:
=====================
Manjunatha GK (10):
  OMAP: DMA: Introduce DMA device attributes
  OMAP2420: DMA: HWMOD: Add hwmod data structures
  OMAP2430: DMA: HWMOD: Add hwmod data structures
  OMAP3: DMA: HWMOD: Add hwmod data structures
  OMAP4: DMA: HWMOD: Add hwmod data structures
  OMAP1: DMA: Introduce DMA driver as platform driver
  OMAP2/3/4: DMA: HWMOD: Device registration
  OMAP: DMA: Convert DMA library into DMA platform Driver
  OMAP: DMA: Implement generic errata handling
  OMAP: DMA: Use DMA device attributes

Venkatraman S (1):
  sDMA: descriptor autoloading feature

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/dma.c                  |  451 ++++++++
 arch/arm/mach-omap1/include/mach/dma.h     |  148 +++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/dma.c                  | 1380 +++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/dma.h     |  378 +++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   85 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   85 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   85 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   99 ++
 arch/arm/plat-omap/dma.c                   | 1539 ++++------------------------
 arch/arm/plat-omap/include/plat/dma.h      |  222 +---
 12 files changed, 2945 insertions(+), 1531 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.c
 create mode 100644 arch/arm/mach-omap1/include/mach/dma.h
 create mode 100644 arch/arm/mach-omap2/dma.c
 create mode 100644 arch/arm/mach-omap2/include/mach/dma.h

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
