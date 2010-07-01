From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v2 0/4] nand prefetch-irq support and ecc layout chanage
Date: Thu,  1 Jul 2010 16:12:11 +0530
Message-ID: <1277980935-24070-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44721 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754517Ab0GAKmW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Jul 2010 06:42:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

   The following set of patches applies on top of for-next branch. And
   is dependent on the following patches not yet applied onto this branch.
	1. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30305.html
	2. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30735.html
   
   v2: Rebase on latest codebase and previous patch(posted).	
   v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26666.html

Sukumar Ghorai (4):
	omap3: nand: prefetch in irq mode support
	omap: nand: configurable fifo threshold to gain the throughput
	omap: nand: ecc layout select from board file
	omap: nand: making ecc layout as compatible with romcode ecc

 arch/arm/mach-omap2/board-flash.c              |    4 +-
 arch/arm/mach-omap2/gpmc.c                     |   18 ++-
 arch/arm/mach-omap2/include/mach/board-flash.h |    3 +
 arch/arm/plat-omap/include/plat/gpmc.h         |    8 +-
 arch/arm/plat-omap/include/plat/nand.h         |    7 +
 drivers/mtd/nand/Kconfig                       |   14 +-
 drivers/mtd/nand/omap2.c                       |  280 +++++++++++++++++++++---
 7 files changed, 300 insertions(+), 34 deletions(-)



