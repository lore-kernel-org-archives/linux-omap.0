From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 0/3] Handle GPMC-NAND registers by NAND driver
Date: Fri, 11 May 2012 20:56:32 +0530
Message-ID: <cover.1336748974.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57064 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423Ab2EKPnJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 11:43:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dedekind1@gmail.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Hi,

This series provides the ability for OMAP NAND driver to configure
GPMC_NAND registers by NAND driver itself instead of using GPMC
exported symbols.

Regards
Afzal

Afzal Mohammed (3):
  ARM: OMAP2+: gpmc: update nand register helper
  ARM: OMAP2+: gpmc-nand: update gpmc-nand regs
  mtd: nand: omap2: handle nand on gpmc

 arch/arm/mach-omap2/gpmc-nand.c        |    2 +
 arch/arm/mach-omap2/gpmc.c             |   21 ++++
 arch/arm/plat-omap/include/plat/gpmc.h |   18 +++
 arch/arm/plat-omap/include/plat/nand.h |    1 +
 drivers/mtd/nand/omap2.c               |  207 +++++++++++++++++++++++++-------
 5 files changed, 205 insertions(+), 44 deletions(-)

-- 
1.7.10

