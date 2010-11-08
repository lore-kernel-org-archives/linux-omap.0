From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v4 00/13] OMAP: DMA: hwmod and DMA as platform device
Date: Mon,  8 Nov 2010 19:37:39 +0530
Message-ID: <1289225272-9767-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48190 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654Ab0KHOHS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 09:07:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Changes incorporated from v3 version:
1. http://www.spinics.net/lists/arm-kernel/msg102937.html
2. http://www.spinics.net/lists/arm-kernel/msg103156.html

All the information such as build, testing etc from 'v3' is valid for 
v4 also(except this series is rebased to latest linux omap master branch). 
V3 Report can be accessed at:
http://www.spinics.net/lists/arm-kernel/msg102688.html 

Applies cleanly on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
commit 9988a6be118d1150ffc8d1dda1f136d30bbc3936
Merge: 18e1fab 2d37882
Author: Tony Lindgren <tony@atomide.com>
Date:   Fri Nov 5 15:06:08 2010 -0700

    Linux-omap rebuilt: Merged in some fixes and new boards
   
Benoit Cousson (1):
  OMAP4: DMA: hwmod: add system DMA

G, Manjunath Kondaiah (11):
  OMAP: DMA: Replace read/write macros with functions
  OMAP: DMA: Introduce errata handling feature
  OMAP: DMA: Introduce DMA device attributes
  OMAP2420: DMA: hwmod: add system DMA
  OMAP2430: DMA: hwmod: add system DMA
  OMAP3: DMA: hwmod: add system DMA
  OMAP1: DMA: Introduce DMA driver as platform device
  OMAP2+: DMA: hwmod: Device registration
  OMAP: DMA: Convert DMA library into DMA platform Driver
  OMAP: DMA: Use DMA device attributes
  OMAP: PM: DMA: Enable runtime pm

Venkatraman S (1):
  OMAP2+: DMA: descriptor autoloading feature

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/dma.c                  |  667 ++++++++++
 arch/arm/mach-omap1/include/mach/dma.h     |   51 +
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/dma.c                  | 1583 ++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/dma.h     |  173 +++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   85 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   85 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   94 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   99 ++
 arch/arm/plat-omap/dma.c                   | 1829 ++++------------------------
 arch/arm/plat-omap/include/plat/dma.h      |  386 ++++---
 12 files changed, 3271 insertions(+), 1785 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.c
 create mode 100644 arch/arm/mach-omap1/include/mach/dma.h
 create mode 100644 arch/arm/mach-omap2/dma.c
 create mode 100644 arch/arm/mach-omap2/include/mach/dma.h

