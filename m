From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/17] ARM: OMAP2+: Remove unused nand_irq for GPMC
Date: Mon, 10 Sep 2012 22:30:49 -0700
Message-ID: <20120911053049.29637.89271.stgit@muffinssi.local>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:13617 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751668Ab2IKFaw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 01:30:52 -0400
In-Reply-To: <20120911052934.29637.9190.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org

This is no longer needed and assumes a fixed IRQ number
that won't work with SPARSE_IRQ.

Acked-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-flash.c      |    1 -
 arch/arm/plat-omap/include/plat/nand.h |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 53c39d2..9ceec38 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -140,7 +140,6 @@ __init board_nand_init(struct mtd_partition *nand_parts,
 	board_nand_data.devsize		= nand_type;
 
 	board_nand_data.ecc_opt = OMAP_ECC_HAMMING_CODE_DEFAULT;
-	board_nand_data.gpmc_irq = OMAP_GPMC_IRQ_BASE + cs;
 	gpmc_nand_init(&board_nand_data);
 }
 #endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index 290cef5..1a68c1e 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -24,7 +24,6 @@ struct omap_nand_platform_data {
 	struct gpmc_timings	*gpmc_t;
 	int			nr_parts;
 	bool			dev_ready;
-	int			gpmc_irq;
 	enum nand_io		xfer_type;
 	int			devsize;
 	enum omap_ecc           ecc_opt;

