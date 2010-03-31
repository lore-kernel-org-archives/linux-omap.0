From: swirl@gmx.li
Subject: [PATCH] OMAP3: Devkit8000: Add support for flash
Date: Wed, 31 Mar 2010 09:03:37 +0200
Message-ID: <1270019017-28871-1-git-send-email-swirl@gmx.li>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45228 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756781Ab0CaICR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 04:02:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Tony Lindgren <tony@atomide.com>

From: Thomas Weber <weber@corscience.de>

This patch adds support for flash on devkit8000 after changes
in commit 2f70a1e93657bea0baa7d449aa49e44a08582dc8

The functions are similar to the example for sdp-boards like shown in
commit 88c8460ac32283e2a25e36e4670ff5ab02f3b521

The only available type of flash on devkit8000 is nand flash so the other
types are empty.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   98 +++++++++++++++++++++++---------
 1 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 5bfc13b..b548913 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -67,6 +67,11 @@
 #define OMAP_DM9000_GPIO_IRQ	25
 #define OMAP3_DEVKIT_TS_GPIO	27
 
+struct flash_partitions {
+       struct mtd_partition *parts;
+       int nr_parts;
+};
+
 static struct mtd_partition devkit8000_nand_partitions[] = {
 	/* All the partition sizes are listed in terms of NAND block size */
 	{
@@ -98,27 +103,74 @@ static struct mtd_partition devkit8000_nand_partitions[] = {
 	},
 };
 
-static struct omap_nand_platform_data devkit8000_nand_data = {
-	.options	= NAND_BUSWIDTH_16,
-	.parts		= devkit8000_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(devkit8000_nand_partitions),
-	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+static struct flash_partitions devkit8000_flash_partitions[] = {
+	{
+		/* NOR flash */
+	},
+	{
+		/* OneNAND */
+	},
+	{
+		.parts = devkit8000_nand_partitions,
+		.nr_parts = ARRAY_SIZE(devkit8000_nand_partitions),
+	},
 };
 
-static struct resource devkit8000_nand_resource = {
-	.flags		= IORESOURCE_MEM,
+#if defined(CONFIG_MTD_NAND_OMAP2) || \
+	defined(CONFIG_MTD_NAND_OMAP2_MODULE)
+
+/* Note that all values in this struct are in nanoseconds */
+static struct gpmc_timings nand_timings = {
+
+       .sync_clk = 0,
+
+       .cs_on = 0,
+       .cs_rd_off = 36,
+       .cs_wr_off = 36,
+
+       .adv_on = 6,
+       .adv_rd_off = 24,
+       .adv_wr_off = 36,
+
+       .we_off = 30,
+       .oe_off = 48,
+
+       .access = 54,
+       .rd_cycle = 72,
+       .wr_cycle = 72,
+
+       .wr_access = 30,
+       .wr_data_mux_bus = 0,
 };
 
-static struct platform_device devkit8000_nand_device = {
-	.name		= "omap2-nand",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &devkit8000_nand_data,
-	},
-	.num_resources	= 1,
-	.resource	= &devkit8000_nand_resource,
+static struct omap_nand_platform_data devkit8000_nand_data = {
+       .nand_setup     = NULL,
+       .gpmc_t         = &nand_timings,
+       .dma_channel    = -1,           /* disable DMA in OMAP NAND driver */
+       .dev_ready      = NULL,
+       .devsize        = 1,    /* '0' for 8-bit, '1' for 16-bit device */
 };
 
+static void
+__init board_nand_init(struct flash_partitions devkit8000_nand_parts, u8 cs)
+{
+	devkit8000_nand_data.cs		= cs;
+	devkit8000_nand_data.parts	= devkit8000_nand_parts.parts;
+	devkit8000_nand_data.nr_parts	= devkit8000_nand_parts.nr_parts;
+
+	devkit8000_nand_data.gpmc_cs_baseaddr = (void *)(OMAP34XX_GPMC_VIRT +
+							GPMC_CS0_BASE +
+							cs * GPMC_CS_SIZE);
+	devkit8000_nand_data.gpmc_baseaddr = (void *) (OMAP34XX_GPMC_VIRT);
+	gpmc_nand_init(&devkit8000_nand_data);
+}
+#else
+static void
+__init board_nand_init(struct flash_partitions devkit8000_nand_parts, u8 cs)
+{
+}
+#endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
+
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -591,13 +643,12 @@ static struct platform_device *devkit8000_devices[] __initdata = {
 	&omap_dm9000_dev,
 };
 
-static void __init devkit8000_flash_init(void)
+static void
+__init devkit8000_flash_init(struct flash_partitions partition_info[])
 {
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
 
-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
 	/* find out the chip-select on which NAND exists */
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
@@ -618,15 +669,8 @@ static void __init devkit8000_flash_init(void)
 	}
 
 	if (nandcs < GPMC_CS_NUM) {
-		devkit8000_nand_data.cs = nandcs;
-		devkit8000_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		devkit8000_nand_data.gpmc_baseaddr = (void *)
-			(gpmc_base_add);
-
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (platform_device_register(&devkit8000_nand_device) < 0)
-			printk(KERN_ERR "Unable to register NAND device\n");
+		board_nand_init(partition_info[2], nandcs);
 	}
 }
 
@@ -673,7 +717,7 @@ static void __init devkit8000_init(void)
 
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
-	devkit8000_flash_init();
+	devkit8000_flash_init(devkit8000_flash_partitions);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdr_cke0", OMAP_PIN_OUTPUT);
-- 
1.6.4.4

