From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH 00/11] OMAP: DMA: HWMOD and DMA as platform driver
Date: Thu, 29 Jul 2010 15:28:54 +0530
Message-ID: <1280397545-27323-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59288 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756098Ab0G2KBB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jul 2010 06:01:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Anand Sawant <sawant@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Basak Partha <p-basak2@ti.com>, Charulatha V <charu@ti.com>

This patch series is refined version of earlier patches posted at:
http://www.spinics.net/lists/linux-omap/index.html#33393

These changes are based on comments received during internal discussions which 
has changes(compared to previous version) such as:
 - Code optimization
 - Patches are rearranged in more meaningful way so that git bisect works at any
   intermediate patch in the series.
 - Build tested for all omap's(OMAP1 and OMAP2PLUS)
 - Boot tested for OMAP3 and OMAP4(appreciate if some one tests on OMAP1/2)
 - Applicalbe tests are executed on OMAP3 and OMAP4 boards
 - Rebased and added descriptor autoloading feature(only for omap3630 and omap4)

This patch series applies on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
Branch: pm-wip/hwmods-omap4
commit f1c79ab452ed9cf7b5ff6488335c1ddf15d5c92a
Author: Benoit Cousson <b-cousson@ti.com>
Date:   Wed May 12 17:54:37 2010 +0200

    OMAP4: hwmod: Enable omap_hwmod build for OMAP4

Patch series summary:
=====================
Manjunatha GK (10):
  OMAP: DMA: Introduce DMA device attributes
  OMAP2420: DMA: HWMOD: Add hwmod data structures
  OMAP2430: DMA: HWMOD: Add hwmod data structures
  OMAP3: DMA: HWMOD: Add hwmod data structures
  OMAP4: DMA: HWMOD: update OMAP4 data base
  OMAP1: DMA: Introduce DMA driver as platform driver
  OMAP2/3/4: DMA: HWMOD: Device registration
  OMAP: DMA: Convert DMA library into DMA platform Driver
  OMAP: DMA: Implement generic errata handling
  OMAP: DMA: Use DMA device attributes

Venkatraman S (1):
  sDMA: descriptor autoloading feature

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/dma.c                  |  446 ++++++++
 arch/arm/mach-omap1/include/mach/dma.h     |  148 +++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/dma.c                  | 1380 +++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/dma.h     |  378 +++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   89 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   89 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   89 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   19 +-
 arch/arm/plat-omap/dma.c                   | 1515 +++-------------------------
 arch/arm/plat-omap/include/plat/dma.h      |  222 +----
 12 files changed, 2850 insertions(+), 1529 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.c
 create mode 100644 arch/arm/mach-omap1/include/mach/dma.h
 create mode 100644 arch/arm/mach-omap2/dma.c
 create mode 100644 arch/arm/mach-omap2/include/mach/dma.h

