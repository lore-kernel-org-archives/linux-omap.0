From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4 06/39] ARM: OMAP2+: onenand: return value in init function
Date: Tue, 1 May 2012 17:50:20 +0530
Message-ID: <91c09cb6a6cb5e87acdcc3f6100a87b4c2a3dd41.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37929 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab2EAMh3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 08:37:29 -0400
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Modify board_onenand_init to return platform data. This
would be required for boards to be able to pass it to
gpmc driver so that it finally reaches onenand driver.

Also un-static the function so that boards can use it.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-flash.c |   14 ++++----------
 arch/arm/mach-omap2/board-flash.h |   12 ++++++++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 091aaf6..8727c05 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -87,22 +87,16 @@ static struct omap_onenand_platform_data board_onenand_data = {
 	.dma_channel	= -1,   /* disable DMA in OMAP OneNAND driver */
 };
 
-static void
-__init board_onenand_init(struct mtd_partition *onenand_parts,
-				u8 nr_parts, u8 cs)
+struct omap_onenand_platform_data * __init
+board_onenand_init(struct mtd_partition *onenand_parts, u8 nr_parts, u8 cs)
 {
 	board_onenand_data.cs		= cs;
 	board_onenand_data.parts	= onenand_parts;
 	board_onenand_data.nr_parts	= nr_parts;
 
-	gpmc_onenand_init(&board_onenand_data);
-}
-#else
-static void
-__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
-{
+	return &board_onenand_data;
 }
-#endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
+#endif
 
 #if defined(CONFIG_MTD_NAND_OMAP2) || \
 		defined(CONFIG_MTD_NAND_OMAP2_MODULE)
diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/board-flash.h
index 052964c..75ba49f 100644
--- a/arch/arm/mach-omap2/board-flash.h
+++ b/arch/arm/mach-omap2/board-flash.h
@@ -52,3 +52,15 @@ board_nand_init(struct mtd_partition *nand_parts,
 	return NULL;
 }
 #endif
+
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+extern struct omap_onenand_platform_data * __init
+board_onenand_init(struct mtd_partition *onenand_parts, u8 nr_parts, u8 cs);
+#else
+static inline struct omap_onenand_platform_data *
+__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
+{
+	return NULL;
+}
+#endif
-- 
1.7.10

