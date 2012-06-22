From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: omap4: Fix standalone OMAP4 build break
Date: Fri, 22 Jun 2012 17:14:21 +0530
Message-ID: <1340365461-25385-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56151 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760431Ab2FVLoe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 07:44:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Fix the below build error while building OMAP4 standalone

  CC      arch/arm/mach-omap2/board-flash.o
arch/arm/mach-omap2/board-flash.c:102: error: redefinition of 'board_onenand_init'
arch/arm/mach-omap2/board-flash.h:56: note: previous definition of 'board_onenand_init' was here
make[1]: *** [arch/arm/mach-omap2/board-flash.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-flash.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 70a81f9..53c39d2 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -97,11 +97,6 @@ __init board_onenand_init(struct mtd_partition *onenand_parts,
 
 	gpmc_onenand_init(&board_onenand_data);
 }
-#else
-void
-__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
-{
-}
 #endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
 
 #if defined(CONFIG_MTD_NAND_OMAP2) || \
-- 
1.7.1

