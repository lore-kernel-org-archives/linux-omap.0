From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH] ARM: omap2: Fix redefinition of board_onenand_init
Date: Tue, 26 Jun 2012 15:16:01 +0200
Message-ID: <1340716561-27750-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ebb06.tieto.com ([131.207.168.38]:42816 "EHLO ebb06.tieto.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756554Ab2FZNQ3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 09:16:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>, Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>

Initialy defined in arch/arm/mach-omap2/board-flash.h and redefined in
arch/arm/mach-omap2/board-flash.c when CONFIG_MTD_ONENAND_OMAP2 were not set.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
---
 arch/arm/mach-omap2/board-flash.c |    5 -----
 1 file changed, 5 deletions(-)

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
1.7.10

