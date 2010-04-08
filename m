From: Steve Sakoman <sakoman@gmail.com>
Subject: [PATCHv2] ARM: OMAP: Beagle: use new gpmc nand infrastructure
Date: Thu, 8 Apr 2010 06:46:21 -0700
Message-ID: <k2j5e088bd91004080646vd0c023dco2ed7513a5ab067ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:43055 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758597Ab0DHNqW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 09:46:22 -0400
Received: by qyk9 with SMTP id 9so109750qyk.1
        for <linux-omap@vger.kernel.org>; Thu, 08 Apr 2010 06:46:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Steve Sakoman <steve@sakoman.com>

A new GPMC NAND infrastructure was added by commit
2f70a1e93657bea0baa7d449aa49e44a08582dc8.  This patch updates Beagle
NAND functionally to work with those changes.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
b/arch/arm/mach-omap2/board-omap3beagle.c
index 962d377..3ba0603 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -52,6 +52,11 @@

 #define NAND_BLOCK_SIZE		SZ_128K

+struct flash_partitions {
+	struct mtd_partition *parts;
+	int nr_parts;
+};
+
 static struct mtd_partition omap3beagle_nand_partitions[] = {
 	/* All the partition sizes are listed in terms of NAND block size */
 	{
@@ -83,28 +88,102 @@ static struct mtd_partition
omap3beagle_nand_partitions[] = {
 	},
 };

+static struct flash_partitions omap3beagle_flash_partitions[] = {
+	{
+		/* NOR flash */
+	},
+	{
+		/* OneNAND */
+	},
+	{
+		/* NAND */
+		.parts = omap3beagle_nand_partitions,
+		.nr_parts = ARRAY_SIZE(omap3beagle_nand_partitions),
+	},
+};
+
+#if defined(CONFIG_MTD_NAND_OMAP2) || \
+       defined(CONFIG_MTD_NAND_OMAP2_MODULE)
+
+/* Note that all values in this struct are in nanoseconds */
+static struct gpmc_timings nand_timings = {
+
+	.sync_clk		= 0,
+
+	.cs_on			= 0,
+	.cs_rd_off		= 36,
+	.cs_wr_off		= 36,
+
+	.adv_on			= 6,
+	.adv_rd_off		= 24,
+	.adv_wr_off		= 36,
+
+	.we_off			= 30,
+	.oe_off			= 48,
+
+	.access			= 54,
+	.rd_cycle		= 72,
+	.wr_cycle		= 72,
+
+	.wr_access		= 30,
+	.wr_data_mux_bus	= 0,
+};
+
 static struct omap_nand_platform_data omap3beagle_nand_data = {
-	.options	= NAND_BUSWIDTH_16,
-	.parts		= omap3beagle_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(omap3beagle_nand_partitions),
-	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
 	.nand_setup	= NULL,
+	.gpmc_t		= &nand_timings,
+	.dma_channel	= -1,	/* disable DMA in OMAP NAND driver */
 	.dev_ready	= NULL,
+	.devsize	= 1,	/* '0' for 8-bit, '1' for 16-bit device */
 };

-static struct resource omap3beagle_nand_resource = {
-	.flags		= IORESOURCE_MEM,
-};
+static void
+__init board_nand_init(struct flash_partitions omap3beagle_nand_parts, u8 cs)
+{
+	omap3beagle_nand_data.cs	= cs;
+	omap3beagle_nand_data.parts	= omap3beagle_nand_parts.parts;
+	omap3beagle_nand_data.nr_parts	= omap3beagle_nand_parts.nr_parts;
+	omap3beagle_nand_data.gpmc_baseaddr = (void *) (OMAP34XX_GPMC_VIRT);

-static struct platform_device omap3beagle_nand_device = {
-	.name		= "omap2-nand",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &omap3beagle_nand_data,
-	},
-	.num_resources	= 1,
-	.resource	= &omap3beagle_nand_resource,
-};
+	omap3beagle_nand_data.gpmc_cs_baseaddr = (void *)(OMAP34XX_GPMC_VIRT +
+					GPMC_CS0_BASE + cs * GPMC_CS_SIZE);
+
+	gpmc_nand_init(&omap3beagle_nand_data);
+}
+#else
+static void
+__init board_nand_init(struct flash_partitions omap3beagle_nand_parts, u8 cs)
+{
+}
+#endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
+
+static void
+__init omap3beagle_flash_init(struct flash_partitions partition_info[]) {
+	u8 cs = 0;
+	u8 nandcs = GPMC_CS_NUM + 1;
+
+	/* find out the chip-select on which NAND exists */
+	while (cs < GPMC_CS_NUM) {
+		u32 ret = 0;
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+		if ((ret & 0xC00) == 0x800) {
+			printk(KERN_INFO "Found NAND on CS%d\n", cs);
+			if (nandcs > GPMC_CS_NUM)
+				nandcs = cs;
+		}
+		cs++;
+	}
+
+	if (nandcs > GPMC_CS_NUM) {
+		printk(KERN_INFO "NAND: Unable to find configuration "
+				 "in GPMC\n ");
+		return;
+	}
+
+	if (nandcs < GPMC_CS_NUM)
+		board_nand_init(partition_info[2], nandcs);
+}

 #include "sdram-micron-mt46h32m32lf-6.h"

@@ -372,44 +451,6 @@ static struct platform_device
*omap3_beagle_devices[] __initdata = {
 	&keys_gpio,
 };

-static void __init omap3beagle_flash_init(void)
-{
-	u8 cs = 0;
-	u8 nandcs = GPMC_CS_NUM + 1;
-
-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
-	/* find out the chip-select on which NAND exists */
-	while (cs < GPMC_CS_NUM) {
-		u32 ret = 0;
-		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
-
-		if ((ret & 0xC00) == 0x800) {
-			printk(KERN_INFO "Found NAND on CS%d\n", cs);
-			if (nandcs > GPMC_CS_NUM)
-				nandcs = cs;
-		}
-		cs++;
-	}
-
-	if (nandcs > GPMC_CS_NUM) {
-		printk(KERN_INFO "NAND: Unable to find configuration "
-				 "in GPMC\n ");
-		return;
-	}
-
-	if (nandcs < GPMC_CS_NUM) {
-		omap3beagle_nand_data.cs = nandcs;
-		omap3beagle_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		omap3beagle_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
-
-		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (platform_device_register(&omap3beagle_nand_device) < 0)
-			printk(KERN_ERR "Unable to register NAND device\n");
-	}
-}
-
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {

 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
@@ -451,7 +492,7 @@ static void __init omap3_beagle_init(void)

 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
-	omap3beagle_flash_init();
+	omap3beagle_flash_init(omap3beagle_flash_partitions);

 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
