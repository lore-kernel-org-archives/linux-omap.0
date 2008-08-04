From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH 2/3 v2] OMAP3 Beagle: add nand support
Date: Mon, 04 Aug 2008 17:58:22 +0200
Message-ID: <4897271E.6000408@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030806030601010501010906"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:19323 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263AbYHDP60 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 11:58:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1022490fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 04 Aug 2008 08:58:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Steve Sakoman <steve@sakoman.com>

This is a multi-part message in MIME format.
--------------030806030601010501010906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Steve Sakoman <steve@sakoman.com>, Dirk Behme <dirk.behme@gmail.com>

Add nand support to omap3beagle

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------030806030601010501010906
Content-Type: text/plain;
 name="2_nand.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2_nand.txt"

Index: linux-beagle/arch/arm/mach-omap2/board-omap3beagle.c
===================================================================
--- linux-beagle.orig/arch/arm/mach-omap2/board-omap3beagle.c
+++ linux-beagle/arch/arm/mach-omap2/board-omap3beagle.c
@@ -20,11 +20,15 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/leds.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/flash.h>
 
 #include <asm/arch/gpio.h>
 #include <asm/arch/board.h>
@@ -32,6 +36,64 @@
 #include <asm/arch/usb-ehci.h>
 #include <asm/arch/hsmmc.h>
 #include <asm/arch/common.h>
+#include <asm/arch/gpmc.h>
+#include <asm/arch/nand.h>
+
+#define GPMC_CS0_BASE  0x60
+#define GPMC_CS_SIZE   0x30
+
+static struct mtd_partition omap3beagle_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "X-Loader",
+		.offset		= 0,
+		.size		= 4*(64 * 2048),
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size		= 15*(64 * 2048),
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot Env",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x260000 */
+		.size		= 1*(64 * 2048),
+	},
+	{
+		.name		= "Kernel",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
+		.size		= 32*(64 * 2048),
+	},
+	{
+		.name		= "File System",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x680000 */
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_nand_platform_data omap3beagle_nand_data = {
+	.parts		= omap3beagle_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(omap3beagle_nand_partitions),
+	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.nand_setup	= NULL,
+	.dev_ready	= NULL,
+};
+
+static struct resource omap3beagle_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device omap3beagle_nand_device = {
+	.name		= "omap2-nand",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &omap3beagle_nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &omap3beagle_nand_resource,
+};
 
 static struct omap_uart_config omap3_beagle_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
@@ -113,6 +175,44 @@ static struct platform_device *omap3_bea
 	&leds_gpio,
 };
 
+void __init omap3beagle_flash_init(void)
+{
+	u8 cs = 0;
+	u8 nandcs = GPMC_CS_NUM + 1;
+
+	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
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
+	if (nandcs < GPMC_CS_NUM) {
+		omap3beagle_nand_data.cs = nandcs;
+		omap3beagle_nand_data.gpmc_cs_baseaddr = (void *)
+			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
+		omap3beagle_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
+
+		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
+		if (platform_device_register(&omap3beagle_nand_device) < 0)
+			printk(KERN_ERR "Unable to register NAND device\n");
+	}
+}
+
 static void __init omap3_beagle_init(void)
 {
 	platform_add_devices(omap3_beagle_devices, ARRAY_SIZE(omap3_beagle_devices));
@@ -122,6 +222,7 @@ static void __init omap3_beagle_init(voi
 	hsmmc_init();
 	usb_musb_init();
 	usb_ehci_init();
+	omap3beagle_flash_init();
 }
 
 arch_initcall(omap3_beagle_i2c_init);

--------------030806030601010501010906--
