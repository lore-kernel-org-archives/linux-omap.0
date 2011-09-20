From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix missing inline functions for Makefile
 cleanup (Re: [GIT PULL] omap cleanup part1 for v3.2 merge window)
Date: Tue, 20 Sep 2011 16:25:51 -0700
Message-ID: <20110920232551.GL2937@atomide.com>
References: <20110917014623.GC2937@atomide.com>
 <201109202334.43213.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:32774 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752107Ab1ITXZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 19:25:56 -0400
Content-Disposition: inline
In-Reply-To: <201109202334.43213.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Commit f41caddbe73f52a42f529d668ce47b4d693fd2c0 (omap2+: Use
Kconfig symbol in Makefile instead of obj-y) cleaned up the
omap2+ Makefile. However this did not account for the inline
functions that are now needed for board_flash_init and
board_nand_init.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Will have this in the next pull request for cleanup

--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -148,11 +148,6 @@ __init board_nand_init(struct mtd_partition *nand_parts,
 	board_nand_data.gpmc_irq = OMAP_GPMC_IRQ_BASE + cs;
 	gpmc_nand_init(&board_nand_data);
 }
-#else
-void
-__init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs, int nand_type)
-{
-}
 #endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
 
 /**
--- a/arch/arm/mach-omap2/board-flash.h
+++ b/arch/arm/mach-omap2/board-flash.h
@@ -24,7 +24,26 @@ struct flash_partitions {
 	int nr_parts;
 };
 
+#if defined(CONFIG_MTD_NAND_OMAP2) || \
+		defined(CONFIG_MTD_NAND_OMAP2_MODULE) || \
+		defined(CONFIG_MTD_ONENAND_OMAP2) || \
+		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
 extern void board_flash_init(struct flash_partitions [],
 				char chip_sel[][GPMC_CS_NUM], int nand_type);
+#else
+static inline void board_flash_init(struct flash_partitions part[],
+				char chip_sel[][GPMC_CS_NUM], int nand_type)
+{
+}
+#endif
+
+#if defined(CONFIG_MTD_NAND_OMAP2) || \
+		defined(CONFIG_MTD_NAND_OMAP2_MODULE)
 extern void board_nand_init(struct mtd_partition *nand_parts,
 					u8 nr_parts, u8 cs, int nand_type);
+#else
+static inline void board_nand_init(struct mtd_partition *nand_parts,
+					u8 nr_parts, u8 cs, int nand_type)
+{
+}
+#endif
