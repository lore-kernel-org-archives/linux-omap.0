From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v3 0/4] nand prefetch-irq support and ecc layout chanage
Date: Tue, 13 Jul 2010 10:15:33 +0530
Message-ID: <1278996337-25172-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52470 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747Ab0GMEpr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jul 2010 00:45:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

   The following set of patches applies on top of for-next branch. And
   is dependent on the following patches 
	1. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30305.html
   
   v3: Rebase on latest codebase and previous patch(posted).	
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31963.html

   v2: Rebase on latest codebase and previous patch(posted).	
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31471.html

   v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26666.html

Sukumar Ghorai (4):
	omap3: nand: prefetch in irq mode support
	omap: nand: configurable fifo threshold to gain the throughput
	omap: nand: ecc layout select from board file
	omap: nand: making ecc layout as compatible with romcode ecc

 arch/arm/mach-omap2/board-flash.c              |    4 +-
 arch/arm/mach-omap2/gpmc.c                     |   15 +-
 arch/arm/mach-omap2/include/mach/board-flash.h |    3 +
 arch/arm/plat-omap/include/plat/gpmc.h         |    9 +-
 arch/arm/plat-omap/include/plat/nand.h         |    7 +
 drivers/mtd/nand/Kconfig                       |   14 ++-
 drivers/mtd/nand/omap2.c                       |  277 +++++++++++++++++++++---
 7 files changed, 295 insertions(+), 34 deletions(-)

