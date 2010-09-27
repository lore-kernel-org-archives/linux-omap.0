From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v5 0/5] nand prefetch-irq support and ecc layout chanage
Date: Mon, 27 Sep 2010 19:07:09 +0530
Message-ID: <1285594634-19277-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36674 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635Ab0I0NhX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Sep 2010 09:37:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

  The following set of patches applies on linux-2.6.
     
    The main motivations behind this patch series are -
        1. support NAND I/O in irq mode.
        2. support of different ECC schema. 
        3. also to make ecc layout as like in romcode ecc layout

   v5: This address the input as to support the irq_chained in GPMC 
	
   v4: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34882.html
       and resend of 
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32689.html
   
   v3: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32071.html
   	Rebase on latest codebase and previous patch(posted).	
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31963.html
	
   v2: Rebase on latest codebase and previous patch(posted).	
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31471.html

   v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26666.html



Sukumar Ghorai (5):
  omap gpmc: enable irq mode in gpmc
  omap3: nand: prefetch in irq mode support
  omap3: nand: configurable fifo threshold to gain the throughput
  omap: nand: ecc layout select from board file
  omap: nand: making ecc layout as compatible with romcode ecc

 arch/arm/mach-omap2/board-2430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3630sdp.c        |    1 +
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +
 arch/arm/mach-omap2/board-apollon.c        |    1 +
 arch/arm/mach-omap2/board-cm-t35.c         |    1 +
 arch/arm/mach-omap2/board-devkit8000.c     |    1 +
 arch/arm/mach-omap2/board-flash.c          |    5 +-
 arch/arm/mach-omap2/board-generic.c        |    2 +
 arch/arm/mach-omap2/board-h4.c             |    1 +
 arch/arm/mach-omap2/board-igep0020.c       |    1 +
 arch/arm/mach-omap2/board-ldp.c            |    1 +
 arch/arm/mach-omap2/board-n8x0.c           |    2 +
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
 arch/arm/mach-omap2/board-omap3evm.c       |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +
 arch/arm/mach-omap2/board-omap3stalker.c   |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c |    1 +
 arch/arm/mach-omap2/board-omap4panda.c     |    2 +
 arch/arm/mach-omap2/board-overo.c          |    1 +
 arch/arm/mach-omap2/board-rx51.c           |    1 +
 arch/arm/mach-omap2/board-zoom2.c          |    2 +
 arch/arm/mach-omap2/board-zoom3.c          |    2 +
 arch/arm/mach-omap2/gpmc.c                 |   48 +++++-
 arch/arm/mach-omap2/io.c                   |    2 -
 arch/arm/plat-omap/include/plat/gpmc.h     |   16 ++-
 arch/arm/plat-omap/include/plat/irqs.h     |    9 +-
 arch/arm/plat-omap/include/plat/nand.h     |    3 +
 drivers/mtd/nand/Kconfig                   |   14 ++-
 drivers/mtd/nand/omap2.c                   |  277 +++++++++++++++++++++++++---
 31 files changed, 367 insertions(+), 39 deletions(-)

