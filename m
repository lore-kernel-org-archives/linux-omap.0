From: Steve Sakoman <steve@sakoman.com>
Subject: ARM: OMAP: Overo: use new gpmc nand infrastructure
Date: Wed, 7 Apr 2010 10:35:48 -0700
Message-ID: <h2p5e088bd91004071035pdae7ad0fk4add0731455d921c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:37472 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab0DGRft (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 13:35:49 -0400
Received: by qw-out-2122.google.com with SMTP id 8so460371qwh.37
        for <linux-omap@vger.kernel.org>; Wed, 07 Apr 2010 10:35:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Steve Sakoman <steve@sakoman.com>

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index 8848c7c..ae23633 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -184,6 +184,11 @@ static inline void __init overo_init_smsc911x(void)
 static inline void __init overo_init_smsc911x(void) { return; }
 #endif

+struct flash_partitions {
+	struct mtd_partition *parts;
+	int nr_parts;
+};
+
 static struct mtd_partition overo_nand_partitions[] = {
 	{
 		.name           = "xloader",
@@ -213,34 +218,80 @@ static struct mtd_partition overo_nand_partitions[] = {
 	},
 };

-static struct omap_nand_platform_data overo_nand_data = {
-	.parts = overo_nand_partitions,
-	.nr_parts = ARRAY_SIZE(overo_nand_partitions),
-	.dma_channel = -1,	/* disable DMA in OMAP NAND driver */
+static struct flash_partitions overo_flash_partitions[] = {
+	{
+		/* NOR flash */
+	},
+	{
+		/* OneNAND */
+	},
+	{
+		/* NAND */
+		.parts = overo_nand_partitions,
+		.nr_parts = ARRAY_SIZE(overo_nand_partitions),
+	},
 };

-static struct resource overo_nand_resource = {
-	.flags		= IORESOURCE_MEM,
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
 };

-static struct platform_device overo_nand_device = {
-	.name		= "omap2-nand",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &overo_nand_data,
-	},
-	.num_resources	= 1,
-	.resource	= &overo_nand_resource,
+static struct omap_nand_platform_data overo_nand_data = {
+	.nand_setup	= NULL,
+	.gpmc_t		= &nand_timings,
+	.dma_channel	= -1,	/* disable DMA in OMAP NAND driver */
+	.dev_ready	= NULL,
+	.devsize	= 1,	/* '0' for 8-bit, '1' for 16-bit device */
 };

+static void
+__init board_nand_init(struct flash_partitions overo_nand_parts, u8 cs)
+{
+	overo_nand_data.cs		= cs;
+	overo_nand_data.parts		= overo_nand_parts.parts;
+	overo_nand_data.nr_parts	= overo_nand_parts.nr_parts;
+	overo_nand_data.gpmc_baseaddr	= (void *) (OMAP34XX_GPMC_VIRT);
+
+	overo_nand_data.gpmc_cs_baseaddr = (void *)(OMAP34XX_GPMC_VIRT +
+				GPMC_CS0_BASE + cs * GPMC_CS_SIZE);

-static void __init overo_flash_init(void)
+	gpmc_nand_init(&overo_nand_data);
+}
+#else
+static void
+__init board_nand_init(struct flash_partitions overo_nand_parts, u8 cs)
 {
+}
+#endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
+
+static void
+__init overo_flash_init(struct flash_partitions partition_info[]) {
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;

-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
 	/* find out the chip-select on which NAND exists */
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
@@ -260,16 +311,8 @@ static void __init overo_flash_init(void)
 		return;
 	}

-	if (nandcs < GPMC_CS_NUM) {
-		overo_nand_data.cs = nandcs;
-		overo_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		overo_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
-
-		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (platform_device_register(&overo_nand_device) < 0)
-			printk(KERN_ERR "Unable to register NAND device\n");
-	}
+	if (nandcs < GPMC_CS_NUM)
+		board_nand_init(partition_info[2], nandcs);
 }

 static struct omap2_hsmmc_info mmc[] = {
@@ -425,7 +468,7 @@ static void __init overo_init(void)
 	overo_i2c_init();
 	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
 	omap_serial_init();
-	overo_flash_init();
+	overo_flash_init(overo_flash_partitions);
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	overo_ads7846_init();
