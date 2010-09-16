From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH RESEND v4 0/4] nand prefetch-irq support and ecc layout chanage
Date: Thu, 16 Sep 2010 13:30:55 +0530
Message-ID: <1284624059-1741-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57901 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab0IPIBL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 04:01:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

  The following set of patches applies on linux-2.6.
   
   v4: resend of 
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32689.html
   
   v3: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32071.html
   	Rebase on latest codebase and previous patch(posted).	
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31963.html
	
   v2: Rebase on latest codebase and previous patch(posted).	
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31471.html

   v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26666.html



Sukumar Ghorai (5):
  Merge branches 'master' and 'master' of
    git://git.kernel.org/.../torvalds/linux-2.6
  omap3: nand: prefetch in irq mode support
  omap3: nand: configurable fifo threshold to gain the throughput
  omap: nand: ecc layout select from board file
  omap: nand: making ecc layout as compatible with romcode ecc

 arch/arm/mach-omap2/board-flash.c      |    5 +-
 arch/arm/mach-omap2/gpmc.c             |   15 ++-
 arch/arm/plat-omap/include/plat/gpmc.h |    9 +-
 arch/arm/plat-omap/include/plat/irqs.h |    1 +
 arch/arm/plat-omap/include/plat/nand.h |    7 +
 drivers/mtd/nand/Kconfig               |   14 ++-
 drivers/mtd/nand/omap2.c               |  277 ++++++++++++++++++++++++++++---
 7 files changed, 294 insertions(+), 34 deletions(-)

