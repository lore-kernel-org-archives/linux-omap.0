From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH] omap3: various code improvements for IGEP v2 board.
Date: Tue, 12 Oct 2010 12:16:10 +0200
Message-ID: <1286878570-1973-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57259 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131Ab0JLKQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Oct 2010 06:16:29 -0400
Received: by wwj40 with SMTP id 40so4826116wwj.1
        for <linux-omap@vger.kernel.org>; Tue, 12 Oct 2010 03:16:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

The comments of this post also apply to IGEP v2 board (thanks Laurent)

  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36402.html

Changes are:

  - Set onenand_setup to NULL instead of adding a no-op function.
  - On igep2_flash_init() function:
    - Use 'for' loop instead 'while' loop.
    - No need to initialize ret to 0, we're assigning it right after.
    - No need to check for onenandcs < GPMC_CS_NUM here, it will always be true.
  - omap_board_config_size is implicitly initialized to 0 in
    plat-omap/common.c, get_config() won't dereference omap_board_config,
    so we can remove the empty igep2_config array.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   39 ++++++++++++---------------------
 1 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 152f757..ddcfd06 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -136,16 +136,10 @@ static struct mtd_partition igep2_onenand_partitions[] = {
 	},
 };
 
-static int igep2_onenand_setup(void __iomem *onenand_base, int freq)
-{
-       /* nothing is required to be setup for onenand as of now */
-       return 0;
-}
-
 static struct omap_onenand_platform_data igep2_onenand_data = {
 	.parts = igep2_onenand_partitions,
 	.nr_parts = ARRAY_SIZE(igep2_onenand_partitions),
-	.onenand_setup = igep2_onenand_setup,
+	.onenand_setup = NULL,
 	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
 };
 
@@ -159,35 +153,35 @@ static struct platform_device igep2_onenand_device = {
 
 static void __init igep2_flash_init(void)
 {
-	u8		cs = 0;
-	u8		onenandcs = GPMC_CS_NUM + 1;
+	u8 cs = 0;
+	u8 onenandcs = GPMC_CS_NUM + 1;
 
-	while (cs < GPMC_CS_NUM) {
-		u32 ret = 0;
+	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
+		u32 ret;
 		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
 
 		/* Check if NAND/oneNAND is configured */
 		if ((ret & 0xC00) == 0x800)
 			/* NAND found */
-			pr_err("IGEP v2: Unsupported NAND found\n");
+			pr_err("IGEP2: Unsupported NAND found\n");
 		else {
 			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
+
 			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
-				/* ONENAND found */
+				/* OneNAND found */
 				onenandcs = cs;
 		}
-		cs++;
 	}
+
 	if (onenandcs > GPMC_CS_NUM) {
-		pr_err("IGEP v2: Unable to find configuration in GPMC\n");
+		pr_err("IGEP2: Unable to find configuration in GPMC\n");
 		return;
 	}
 
-	if (onenandcs < GPMC_CS_NUM) {
-		igep2_onenand_data.cs = onenandcs;
-		if (platform_device_register(&igep2_onenand_device) < 0)
-			pr_err("IGEP v2: Unable to register OneNAND device\n");
-	}
+	igep2_onenand_data.cs = onenandcs;
+
+	if (platform_device_register(&igep2_onenand_device) < 0)
+		pr_err("IGEP2: Unable to register OneNAND device\n");
 }
 
 #else
@@ -254,9 +248,6 @@ static inline void __init igep2_init_smsc911x(void)
 static inline void __init igep2_init_smsc911x(void) { }
 #endif
 
-static struct omap_board_config_kernel igep2_config[] __initdata = {
-};
-
 static struct regulator_consumer_supply igep2_vmmc1_supply = {
 	.supply		= "vmmc",
 };
@@ -493,8 +484,6 @@ static struct platform_device *igep2_devices[] __initdata = {
 
 static void __init igep2_init_irq(void)
 {
-	omap_board_config = igep2_config;
-	omap_board_config_size = ARRAY_SIZE(igep2_config);
 	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
-- 
1.7.1

