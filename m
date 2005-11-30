From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 0/5] Updated driver model and various fixes
Date: Wed, 30 Nov 2005 17:22:09 +0100
Message-ID: <20051130162209.GA3381@orphique>
References: <20051129030028.GJ8319@atomide.com>
	<20051129082222.71196.qmail@web32914.mail.mud.yahoo.com>
	<20051130015722.GC7212@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20051130015722.GC7212@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 29, 2005 at 05:57:23PM -0800, Tony Lindgren wrote:
[snip]
> Yes that thread, but a later post in August:
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004847.html
> 
> That patch needs to be modified to use struct flash_platform_data in
> include/asm-arm/mach/flash.h, and the smc91x.[ch] patches should not
> be included...


Hmm, flash_platform_data is not suitable for that purpose since it lacks
requested fields (dev_ready and options). I agree that it could be
modified, because it seems there already is OneNAND support. What do you
think? (patch bellow was generated against current git)

	ladis

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index a07e2c9..0fc2e0f 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
 #include <asm/hardware.h>
@@ -40,7 +41,7 @@
 
 extern int omap_gpio_init(void);
 
-static struct mtd_partition h2_partitions[] = {
+static struct mtd_partition h2_nor_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
 	      .name		= "bootloader",
@@ -71,26 +72,83 @@ static struct mtd_partition h2_partition
 	}
 };
 
-static struct flash_platform_data h2_flash_data = {
+static struct flash_platform_data h2_nor_data = {
 	.map_name	= "cfi_probe",
 	.width		= 2,
-	.parts		= h2_partitions,
-	.nr_parts	= ARRAY_SIZE(h2_partitions),
+	.parts		= h2_nor_partitions,
+	.nr_parts	= ARRAY_SIZE(h2_nor_partitions),
 };
 
-static struct resource h2_flash_resource = {
+static struct resource h2_nor_resource = {
 	/* This is on CS3, wherever it's mapped */
 	.flags		= IORESOURCE_MEM,
 };
 
-static struct platform_device h2_flash_device = {
+static struct platform_device h2_nor_device = {
 	.name		= "omapflash",
 	.id		= 0,
 	.dev		= {
-		.platform_data	= &h2_flash_data,
+		.platform_data	= &h2_nor_data,
 	},
 	.num_resources	= 1,
-	.resource	= &h2_flash_resource,
+	.resource	= &h2_nor_resource,
+};
+
+static struct mtd_partition h2_nand_partitions[] = {
+#if 0
+	/* REVISIT:  enable these partitions if you make NAND BOOT
+	 * work on your H2 (rev C or newer); published versions of
+	 * x-load only support P2 and H3.
+	 */
+	{
+		.name		= "xloader",
+		.offset		= 0,
+		.size		= 64 * 1024,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "bootloader",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 256 * 1024,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "params",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 192 * 1024,
+	},
+	{
+		.name		= "kernel",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 2 * SZ_1M,
+	},
+#endif
+	{
+		.name		= "filesystem",
+		.size		= MTDPART_SIZ_FULL,
+		.offset		= MTDPART_OFS_APPEND,
+	},
+};
+
+/* dip switches control NAND chip access:  8 bit, 16 bit, or neither */
+static struct nand_platform_data h2_nand_data = {
+	.options	= NAND_SAMSUNG_LP_OPTIONS,
+	.parts		= h2_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(h2_nand_partitions),
+};
+
+static struct resource h2_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device h2_nand_device = {
+	.name		= "omapnand",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &h2_nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &h2_nand_resource,
 };
 
 static struct resource h2_smc91x_resources[] = {
@@ -114,7 +172,8 @@ static struct platform_device h2_smc91x_
 };
 
 static struct platform_device *h2_devices[] __initdata = {
-	&h2_flash_device,
+	&h2_nor_device,
+	&h2_nand_device,
 	&h2_smc91x_device,
 };
 
@@ -174,13 +233,34 @@ static struct omap_board_config_kernel h
 	{ OMAP_TAG_LCD,		&h2_lcd_config },
 };
 
+#define H2_NAND_RB_GPIO_PIN	62
+
+static int h2_nand_dev_ready(struct nand_platform_data *data)
+{
+	return omap_get_gpio_datain(H2_NAND_RB_GPIO_PIN);
+}
+
 static void __init h2_init(void)
 {
-	/* NOTE: revC boards support NAND-boot, which can put NOR on CS2B
-	 * and NAND (either 16bit or 8bit) on CS3.
+	/* Here we assume the NOR boot config:  NOR on CS3 (possibly swapped
+	 * to address 0 by a dip switch), NAND on CS2B.  The NAND driver will
+	 * notice whether a NAND chip is enabled at probe time.
+	 *
+	 * FIXME revC boards (and H3) support NAND-boot, with a dip switch to
+	 * put NOR on CS2B and NAND (which on H2 may be 16bit) on CS3.  Try
+	 * detecting that in code here, to avoid probing every possible flash
+	 * configuration...
 	 */
-	h2_flash_resource.end = h2_flash_resource.start = omap_cs3_phys();
-	h2_flash_resource.end += SZ_32M - 1;
+	h2_nor_resource.end = h2_nor_resource.start = omap_cs3_phys();
+	h2_nor_resource.end += SZ_32M - 1;
+
+	h2_nand_resource.end = h2_nand_resource.start = OMAP_CS2B_PHYS;
+	h2_nand_resource.end += SZ_4K - 1;
+	if (!(omap_request_gpio(H2_NAND_RB_GPIO_PIN)))
+		h2_nand_data.dev_ready = h2_nand_dev_ready;
+
+	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
+	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
 
 	/* MMC:  card detect and WP */
 	// omap_cfg_reg(U19_ARMIO1);		/* CD */
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 668e278..2953d38 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/errno.h>
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
 #include <asm/setup.h>
@@ -41,7 +42,7 @@
 
 extern int omap_gpio_init(void);
 
-static struct mtd_partition h3_partitions[] = {
+static struct mtd_partition nor_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
 	      .name		= "bootloader",
@@ -72,26 +73,80 @@ static struct mtd_partition h3_partition
 	}
 };
 
-static struct flash_platform_data h3_flash_data = {
+static struct flash_platform_data nor_data = {
 	.map_name	= "cfi_probe",
 	.width		= 2,
-	.parts		= h3_partitions,
-	.nr_parts	= ARRAY_SIZE(h3_partitions),
+	.parts		= nor_partitions,
+	.nr_parts	= ARRAY_SIZE(nor_partitions),
 };
 
-static struct resource h3_flash_resource = {
+static struct resource nor_resource = {
 	/* This is on CS3, wherever it's mapped */
 	.flags		= IORESOURCE_MEM,
 };
 
-static struct platform_device flash_device = {
+static struct platform_device nor_device = {
 	.name		= "omapflash",
 	.id		= 0,
 	.dev		= {
-		.platform_data	= &h3_flash_data,
+		.platform_data	= &nor_data,
 	},
 	.num_resources	= 1,
-	.resource	= &h3_flash_resource,
+	.resource	= &nor_resource,
+};
+
+static struct mtd_partition nand_partitions[] = {
+#if 0
+	/* REVISIT: enable these partitions if you make NAND BOOT work */
+	{
+		.name		= "xloader",
+		.offset		= 0,
+		.size		= 64 * 1024,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "bootloader",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 256 * 1024,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "params",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 192 * 1024,
+	},
+	{
+		.name		= "kernel",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 2 * SZ_1M,
+	},
+#endif
+	{
+		.name		= "filesystem",
+		.size		= MTDPART_SIZ_FULL,
+		.offset		= MTDPART_OFS_APPEND,
+	},
+};
+
+/* dip switches control NAND chip access:  8 bit, 16 bit, or neither */
+static struct nand_platform_data nand_data = {
+	.options	= NAND_SAMSUNG_LP_OPTIONS,
+	.parts		= nand_partitions,
+	.nr_parts	= ARRAY_SIZE(nand_partitions),
+};
+
+static struct resource nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device nand_device = {
+	.name		= "omapnand",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &nand_resource,
 };
 
 static struct resource smc91x_resources[] = {
@@ -139,7 +194,8 @@ static struct platform_device intlat_dev
 };
 
 static struct platform_device *devices[] __initdata = {
-	&flash_device,
+	&nor_device,
+	&nand_device,
         &smc91x_device,
 	&intlat_device,
 };
@@ -182,11 +238,36 @@ static struct omap_board_config_kernel h
 	{ OMAP_TAG_LCD,		&h3_lcd_config },
 };
 
+#define H3_NAND_RB_GPIO_PIN	10
+
+static int nand_dev_ready(struct nand_platform_data *data)
+{
+	return omap_get_gpio_datain(H3_NAND_RB_GPIO_PIN);
+}
+
 static void __init h3_init(void)
 {
-	h3_flash_resource.end = h3_flash_resource.start = omap_cs3_phys();
-	h3_flash_resource.end += OMAP_CS3_SIZE - 1;
-	(void) platform_add_devices(devices, ARRAY_SIZE(devices));
+	/* Here we assume the NOR boot config:  NOR on CS3 (possibly swapped
+	 * to address 0 by a dip switch), NAND on CS2B.  The NAND driver will
+	 * notice whether a NAND chip is enabled at probe time.
+	 *
+	 * H3 support NAND-boot, with a dip switch to put NOR on CS2B and NAND
+	 * (which on H2 may be 16bit) on CS3.  Try detecting that in code here,
+	 * to avoid probing every possible flash configuration...
+	 */
+	nor_resource.end = nor_resource.start = omap_cs3_phys();
+	nor_resource.end += SZ_32M - 1;
+
+	nand_resource.end = nand_resource.start = OMAP_CS2B_PHYS;
+	nand_resource.end += SZ_4K - 1;
+	if (!(omap_request_gpio(H3_NAND_RB_GPIO_PIN)))
+		nand_data.dev_ready = nand_dev_ready;
+
+	/* GPIO10 Func_MUX_CTRL reg bit 29:27, Configure V2 to mode1 as GPIO */
+	/* GPIO10 pullup/down register, Enable pullup on GPIO10 */
+	omap_cfg_reg(V2_1710_GPIO10);
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
 	omap_board_config = h3_config;
 	omap_board_config_size = ARRAY_SIZE(h3_config);
 	omap_serial_init();
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index bd900b7..dd8069a 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
 #include <asm/hardware.h>
@@ -44,7 +45,7 @@ static struct resource smc91x_resources[
 	},
 };
 
-static struct mtd_partition p2_partitions[] = {
+static struct mtd_partition nor_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
 	      .name		= "bootloader",
@@ -75,27 +76,47 @@ static struct mtd_partition p2_partition
 	},
 };
 
-static struct flash_platform_data p2_flash_data = {
+static struct flash_platform_data nor_data = {
 	.map_name	= "cfi_probe",
 	.width		= 2,
-	.parts		= p2_partitions,
-	.nr_parts	= ARRAY_SIZE(p2_partitions),
+	.parts		= nor_partitions,
+	.nr_parts	= ARRAY_SIZE(nor_partitions),
 };
 
-static struct resource p2_flash_resource = {
+static struct resource nor_resource = {
 	.start		= OMAP_CS0_PHYS,
 	.end		= OMAP_CS0_PHYS + SZ_32M - 1,
 	.flags		= IORESOURCE_MEM,
 };
 
-static struct platform_device p2_flash_device = {
+static struct platform_device nor_device = {
 	.name		= "omapflash",
 	.id		= 0,
 	.dev		= {
-		.platform_data	= &p2_flash_data,
+		.platform_data	= &nor_data,
 	},
 	.num_resources	= 1,
-	.resource	= &p2_flash_resource,
+	.resource	= &nor_resource,
+};
+
+static struct nand_platform_data nand_data = {
+	.options	= NAND_SAMSUNG_LP_OPTIONS,
+};
+
+static struct resource nand_resource = {
+	.start		= OMAP_CS3_PHYS,
+	.end		= OMAP_CS3_PHYS + SZ_4K - 1,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device nand_device = {
+	.name		= "omapnand",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &nand_resource,
 };
 
 static struct platform_device smc91x_device = {
@@ -106,10 +127,18 @@ static struct platform_device smc91x_dev
 };
 
 static struct platform_device *devices[] __initdata = {
-	&p2_flash_device,
+	&nor_device,
+	&nand_device,
 	&smc91x_device,
 };
 
+#define P2_NAND_RB_GPIO_PIN	62
+
+static int nand_dev_ready(struct nand_platform_data *data)
+{
+	return omap_get_gpio_datain(P2_NAND_RB_GPIO_PIN);
+}
+
 static struct omap_uart_config perseus2_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1)),
 };
@@ -126,7 +155,13 @@ static struct omap_board_config_kernel p
 
 static void __init omap_perseus2_init(void)
 {
-	(void) platform_add_devices(devices, ARRAY_SIZE(devices));
+	if (!(omap_request_gpio(P2_NAND_RB_GPIO_PIN)))
+		nand_data.dev_ready = nand_dev_ready;
+
+	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
+	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	omap_board_config = perseus2_config;
 	omap_board_config_size = ARRAY_SIZE(perseus2_config);
diff --git a/drivers/mtd/nand/omap-nand-flash.c b/drivers/mtd/nand/omap-nand-flash.c
index d697296..3799be0 100644
--- a/drivers/mtd/nand/omap-nand-flash.c
+++ b/drivers/mtd/nand/omap-nand-flash.c
@@ -1,323 +1,183 @@
 /*
- *  drivers/mtd/nand/omap-nand-flash.c
+ * drivers/mtd/nand/omap-nand-flash.c
  *
- *  Copyright (c) 2004 Texas Instruments
- *  Jian Zhang <jzhang@ti.com>
- *  Copyright (c) 2004 David Brownell
- *
- *  Derived from drivers/mtd/autcpu12.c
- *
- *  Copyright (c) 2002 Thomas Gleixner <tgxl@linutronix.de>
+ * Copyright (c) 2004 Texas Instruments, Jian Zhang <jzhang@ti.com>
+ * Copyright (c) 2004 David Brownell
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- *  Overview:
- *   This is a device driver for the NAND flash device found on the
- *   TI H3/H2  boards. It supports 16-bit 32MiB Samsung k9f5616 chip.
- *
  */
 
-#include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+
 #include <asm/io.h>
-#include <asm/arch/hardware.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/mux.h>
-#include <asm/arch/tc.h>
-#include <asm/sizes.h>
+#include <asm/hardware.h>
 #include <asm/mach-types.h>
+#include <asm/mach/flash.h>
+#include <asm/arch/tc.h>
 
-#define H3_NAND_RB_GPIO_PIN		10
-#define H2_NAND_RB_GPIO_PIN		62
-#define P2_NAND_RB_GPIO_PIN		62
-#define NETSTAR_NAND_RB_GPIO_PIN	 1
-/*
- * MTD structure for H3 board
- */
-static struct mtd_info *omap_nand_mtd = NULL;
-
-static void __iomem *omap_nand_flash_base;
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
 
-/*
- * Define partitions for flash devices
- */
+#define	DRIVER_NAME	"omapnand"
 
 #ifdef CONFIG_MTD_PARTITIONS
-static struct mtd_partition static_partition[] = {
-	{ .name = "Booting Image",
-	  .offset =	0,
-	  .size = 64 * 1024,
-	  .mask_flags =	MTD_WRITEABLE  /* force read-only */
- 	},
-	{ .name = "U-Boot",
-	  .offset =	MTDPART_OFS_APPEND,
-	  .size = 256 * 1024,
-          .mask_flags = MTD_WRITEABLE  /* force read-only */
- 	},
-	{ .name = "U-Boot Environment",
-	  .offset =	MTDPART_OFS_APPEND,
-	  .size = 192 * 1024
-	},
-	{ .name = "Kernel",
-	  .offset =	MTDPART_OFS_APPEND,
-	  .size = 2 * SZ_1M
-	},
-	{ .name = "File System",
-	  .size = MTDPART_SIZ_FULL,
-	  .offset =	MTDPART_OFS_APPEND,
-	},
-};
-
-const char *part_probes[] = { "cmdlinepart", NULL,  };
-
+static const char *part_probes[] = { "cmdlinepart", NULL };
 #endif
 
-/* H2/H3 maps two address LSBs to CLE and ALE; MSBs make CS_2B */
-#define	MASK_CLE	0x02
-#define	MASK_ALE	0x04
-
+struct omap_nand_info {
+	struct nand_platform_data *pdata;
+	struct mtd_partition	*parts;
+	struct mtd_info		mtd;
+	struct nand_chip	nand;
+};
 
-/* 
+/*
  *	hardware specific access to control-lines
-*/
+ *	NOTE:  boards may use different bits for these!!
+ */
+#define	MASK_CLE	0x02
+#define	MASK_ALE	0x04
 static void omap_nand_hwcontrol(struct mtd_info *mtd, int cmd)
 {
 	struct nand_chip *this = mtd->priv;
-	u32 IO_ADDR_W = (u32) this->IO_ADDR_W;
+	unsigned long IO_ADDR_W = (unsigned long) this->IO_ADDR_W;
 
-	IO_ADDR_W &= ~(MASK_ALE|MASK_CLE);
-	switch(cmd){
+	switch (cmd) {
 		case NAND_CTL_SETCLE: IO_ADDR_W |= MASK_CLE; break;
+		case NAND_CTL_CLRCLE: IO_ADDR_W &= ~MASK_CLE; break;
 		case NAND_CTL_SETALE: IO_ADDR_W |= MASK_ALE; break;
+		case NAND_CTL_CLRALE: IO_ADDR_W &= ~MASK_ALE; break;
 	}
 	this->IO_ADDR_W = (void __iomem *) IO_ADDR_W;
 }
 
-/*
- *	chip busy R/B detection
- */
-static int omap_nand_ready(struct mtd_info *mtd)
-{
-	if (machine_is_omap_h3())
-		return omap_get_gpio_datain(H3_NAND_RB_GPIO_PIN);
-	if (machine_is_omap_h2())
-		return omap_get_gpio_datain(H2_NAND_RB_GPIO_PIN);
-	if (machine_is_omap_perseus2())
-		return omap_get_gpio_datain(H2_NAND_RB_GPIO_PIN);
-	if (machine_is_netstar())
-		return omap_get_gpio_datain(NETSTAR_NAND_RB_GPIO_PIN);
-	return 0;
-}
-
-/* Scan to find existance of the device at omap_nand_flash_base.
-   This also allocates oob and data internal buffers */
-static int __init probe_nand_chip(void)
+static int omap_nand_dev_ready(struct mtd_info *mtd)
 {
-        struct nand_chip *this;
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info, mtd);
 
-        this = (struct nand_chip *) (&omap_nand_mtd[1]);
-       
-	/* Initialize structures */
-        memset((char *) this, 0, sizeof(struct nand_chip));
-        
-	this->IO_ADDR_R = omap_nand_flash_base;
-        this->IO_ADDR_W = omap_nand_flash_base;
-        this->options = NAND_SAMSUNG_LP_OPTIONS;
-        this->hwcontrol = omap_nand_hwcontrol;
-        this->eccmode = NAND_ECC_SOFT;
-
-        /* try 16-bit chip first */
-	this->options |= NAND_BUSWIDTH_16;
-        if (nand_scan (omap_nand_mtd, 1)) {
-		if (machine_is_omap_h3()) 
-			return -ENXIO;
-
-		/* then try 8-bit chip for H2 */
-        	memset((char *) this, 0, sizeof(struct nand_chip));
-        	this->IO_ADDR_R = omap_nand_flash_base;
-        	this->IO_ADDR_W = omap_nand_flash_base;
-		this->options = NAND_SAMSUNG_LP_OPTIONS;
-		this->hwcontrol = omap_nand_hwcontrol;
-        	this->eccmode = NAND_ECC_SOFT;
-                if (nand_scan (omap_nand_mtd, 1)) {
-                        return -ENXIO;
-                }
-        }
-
-	return 0;
+	return info->pdata->dev_ready(info->pdata);
 }
 
-static char nand1_name [] = "nand";
-
-/*
- * Main initialization routine
- */
-int __init omap_nand_init (void)
+static int __devinit omap_nand_probe(struct device *dev)
 {
-	struct nand_chip *this;
-	struct mtd_partition *dynamic_partition = 0;
-	int err = 0;
-	int nandboot = 0;
-
-	if (!(machine_is_omap_h2() || machine_is_omap_h3() || machine_is_netstar() || machine_is_omap_perseus2()))
-		return -ENODEV;
-
-	/* Allocate memory for MTD device structure and private data */
-	omap_nand_mtd = kmalloc (sizeof(struct mtd_info) + sizeof (struct nand_chip),
-				GFP_KERNEL);
-	if (!omap_nand_mtd) {
-		printk (KERN_WARNING "Unable to allocate NAND MTD device structure.\n");
-		err = -ENOMEM;
-		goto out;
+	struct omap_nand_info		*info;
+	struct platform_device		*pdev = to_platform_device(dev);
+	struct nand_platform_data	*pdata = pdev->dev.platform_data;
+	struct resource			*res = pdev->resource;
+	unsigned long			size = res->end - res->start + 1;
+	int				err;
+
+	info = kmalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	memset(info, 0, sizeof(struct omap_nand_info));
+
+	if (!request_mem_region(res->start, size, dev->driver->name)) {
+		err = -EBUSY;
+		goto out_free_info;
 	}
 
-	/* Get pointer to private data */
-	this = (struct nand_chip *) (&omap_nand_mtd[1]);
-
-	/* Initialize structures */
-	memset((char *) omap_nand_mtd, 0, sizeof(struct mtd_info) + sizeof(struct nand_chip));
-
-	/* Link the private data with the MTD structure */
-	omap_nand_mtd->priv = this;
-
-	if (machine_is_omap_h2() || machine_is_omap_perseus2()) {
-		/* FIXME on H2, R/B needs M7_1610_GPIO62 ... */
-		this->chip_delay = 15;
-		omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
-		omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
-	} else if (machine_is_omap_h3()) {
-		if (omap_request_gpio(H3_NAND_RB_GPIO_PIN) != 0) {
-			printk(KERN_ERR "NAND: Unable to get GPIO pin for R/B, use delay\n");
-        		/* 15 us command delay time */
-        		this->chip_delay = 15;
-		} else {
-			/* GPIO10 for input. it is in GPIO1 module */
-			omap_set_gpio_direction(H3_NAND_RB_GPIO_PIN, 1);
-		
-			/* GPIO10 Func_MUX_CTRL reg bit 29:27, Configure V2 to mode1 as GPIO */
-			/* GPIO10 pullup/down register, Enable pullup on GPIO10 */
-			omap_cfg_reg(V2_1710_GPIO10);
-
-			this->dev_ready = omap_nand_ready;
-		}
-	} else if (machine_is_netstar()) {
-		if (omap_request_gpio(NETSTAR_NAND_RB_GPIO_PIN) != 0) {
-			printk(KERN_ERR "NAND: Unable to get GPIO pin for R/B, use delay\n");
-			/* 15 us command delay time */
-			this->chip_delay = 15;
-		} else {
-			omap_set_gpio_direction(NETSTAR_NAND_RB_GPIO_PIN, 1);
-			this->dev_ready = omap_nand_ready;
-		}
+	info->nand.IO_ADDR_R = ioremap(res->start, size);
+	if (!info->nand.IO_ADDR_R) {
+		err = -ENOMEM;
+		goto out_release_mem_region;
 	}
-
-        /* try the first address */
-	omap_nand_flash_base = ioremap(OMAP_NAND_FLASH_START1, SZ_4K);
-	omap_nand_mtd->name = nand1_name;
-	if (probe_nand_chip()){
-		nandboot = 1;
-		/* try the second address */
-		iounmap(omap_nand_flash_base);
-		omap_nand_flash_base = ioremap(OMAP_NAND_FLASH_START2, SZ_4K);
-		if (probe_nand_chip()){
-			iounmap(omap_nand_flash_base);
-                        err = -ENXIO;
-                        goto out_mtd;
+	info->nand.IO_ADDR_W = info->nand.IO_ADDR_R;
+	info->nand.hwcontrol = omap_nand_hwcontrol;
+	info->nand.eccmode = NAND_ECC_SOFT;
+	info->nand.options = pdata->options;
+	if (pdata->dev_ready)
+		info->nand.dev_ready = omap_nand_dev_ready;
+	else
+		info->nand.chip_delay = 20;
+
+	info->mtd.name = pdev->dev.bus_id;
+	info->mtd.priv = &info->nand;
+
+	info->pdata = pdata;
+
+	/* DIP switches on H2 and some other boards change between 8 and 16 bit
+	 * bus widths for flash.  Try the other width if the first try fails.
+	 */
+	if (nand_scan(&info->mtd, 1)) {
+		info->nand.options ^= NAND_BUSWIDTH_16;
+		if (nand_scan(&info->mtd, 1)) {
+			err = -ENXIO;
+			goto out_iounmap;
 		}
 	}
+	info->mtd.owner = THIS_MODULE;
 
-	/* Register the partitions */
-	switch(omap_nand_mtd->size) {
-	case SZ_128M:
-		if (!(machine_is_netstar()))
-			goto out_unsupported;
-		/* fall through */
-	case SZ_64M:
-		if (!(machine_is_netstar() || machine_is_omap_perseus2()))
-			goto out_unsupported;
-		/* fall through */
-	case SZ_32M:
 #ifdef CONFIG_MTD_PARTITIONS
-		err = parse_mtd_partitions(omap_nand_mtd, part_probes,
-					&dynamic_partition, 0);
-		if (err > 0)
-			err = add_mtd_partitions(omap_nand_mtd,
-					dynamic_partition, err);
-		else if (nandboot)
-			err = add_mtd_partitions(omap_nand_mtd,
-					static_partition,
-					ARRAY_SIZE(static_partition));
-		else
+	err = parse_mtd_partitions(&info->mtd, part_probes, &info->parts, 0);
+	if (err > 0)
+		add_mtd_partitions(&info->mtd, info->parts, err);
+	else if (err < 0 && pdata->parts)
+		add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
+	else
 #endif
-			err = add_mtd_device(omap_nand_mtd);
-		if (err)
-			goto out_buf;
-		break;
-out_unsupported:
-	default:
-		printk(KERN_WARNING "Unsupported NAND device\n");
-		err = -ENXIO;
-		goto out_buf;
-	}
+		add_mtd_device(&info->mtd);
 
-	goto out;
+	dev_set_drvdata(&pdev->dev, info);
 
-out_buf:
-	nand_release (omap_nand_mtd);
-	if (this->dev_ready) {
-		if (machine_is_omap_h2())
-			omap_free_gpio(H2_NAND_RB_GPIO_PIN);
-		else if (machine_is_omap_perseus2())
-			omap_free_gpio(P2_NAND_RB_GPIO_PIN);
-		else if (machine_is_omap_h3())
-	 		omap_free_gpio(H3_NAND_RB_GPIO_PIN);
-		else if (machine_is_netstar())
-			omap_free_gpio(NETSTAR_NAND_RB_GPIO_PIN);
-	}
-	iounmap(omap_nand_flash_base);
+	return 0;
+
+out_iounmap:
+	iounmap(info->nand.IO_ADDR_R);
+out_release_mem_region:
+	release_mem_region(res->start, size);
+out_free_info:
+	kfree(info);
 
-out_mtd:
-	kfree (omap_nand_mtd);
-out:
 	return err;
 }
 
-module_init(omap_nand_init);
+static int __devexit omap_nand_remove(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_nand_info *info = dev_get_drvdata(&pdev->dev);
 
-/*
- * Clean up routine
- */
-static void __exit omap_nand_cleanup (void)
+	dev_set_drvdata(&pdev->dev, NULL);
+	/* Release NAND device, its internal structures and partitions */
+	nand_release(&info->mtd);
+	iounmap(info->nand.IO_ADDR_R);
+	kfree(info);
+	return 0;
+}
+
+static struct device_driver omap_nand_driver = {
+	.name	= DRIVER_NAME,
+	.bus	= &platform_bus_type,
+	.probe	= omap_nand_probe,
+	.remove	= __devexit_p(omap_nand_remove),
+};
+MODULE_ALIAS(DRIVER_NAME);
+
+static int __init omap_nand_init(void)
 {
-        struct nand_chip *this = omap_nand_mtd->priv;
-	if (this->dev_ready) {
-		if (machine_is_omap_h2())
-			omap_free_gpio(H2_NAND_RB_GPIO_PIN);
-		else if (machine_is_omap_h2())
-			omap_free_gpio(H2_NAND_RB_GPIO_PIN);
-		else if (machine_is_omap_h3())
-	 		omap_free_gpio(H3_NAND_RB_GPIO_PIN);
-		else if (machine_is_netstar())
-			omap_free_gpio(NETSTAR_NAND_RB_GPIO_PIN);
-	}
+	return driver_register(&omap_nand_driver);
+}
 
-	/* nand_release frees MTD partitions, MTD structure
-	   and nand internal buffers*/
-	nand_release (omap_nand_mtd);
-	kfree (omap_nand_mtd);
- 
-	iounmap(omap_nand_flash_base);
+static void __exit omap_nand_exit(void)
+{
+	driver_unregister(&omap_nand_driver);
 }
 
-module_exit(omap_nand_cleanup);
+module_init(omap_nand_init);
+module_exit(omap_nand_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Jian Zhang <jzhang@ti.com>");
-MODULE_DESCRIPTION("Glue layer for NAND flash on H2/H3 boards");
+MODULE_AUTHOR("Jian Zhang <jzhang@ti.com> (and others)");
+MODULE_DESCRIPTION("Glue layer for NAND flash on TI OMAP boards");
+
diff --git a/include/asm-arm/arch-omap/board-h2.h b/include/asm-arm/arch-omap/board-h2.h
index 39ca5a3..b2888ef 100644
--- a/include/asm-arm/arch-omap/board-h2.h
+++ b/include/asm-arm/arch-omap/board-h2.h
@@ -34,9 +34,5 @@
 /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
 #define OMAP1610_ETHR_START		0x04000300
 
-/* Samsung NAND flash at CS2B or CS3(NAND Boot) */
-#define OMAP_NAND_FLASH_START1           0x0A000000 /* CS2B */
-#define OMAP_NAND_FLASH_START2           0x0C000000 /* CS3 */
-
 #endif /*  __ASM_ARCH_OMAP_H2_H */
 
diff --git a/include/asm-arm/arch-omap/board-h3.h b/include/asm-arm/arch-omap/board-h3.h
index 1b12c1d..761ea0a 100644
--- a/include/asm-arm/arch-omap/board-h3.h
+++ b/include/asm-arm/arch-omap/board-h3.h
@@ -30,10 +30,6 @@
 /* In OMAP1710 H3 the Ethernet is directly connected to CS1 */
 #define OMAP1710_ETHR_START		0x04000300
 
-/* Samsung NAND flash at CS2B or CS3(NAND Boot) */
-#define OMAP_NAND_FLASH_START1           0x0A000000 /* CS2B */
-#define OMAP_NAND_FLASH_START2           0x0C000000 /* CS3 */
-
 #define MAXIRQNUM			(IH_BOARD_BASE)
 #define MAXFIQNUM			MAXIRQNUM
 #define MAXSWINUM			MAXIRQNUM
diff --git a/include/asm-arm/arch-omap/board-perseus2.h b/include/asm-arm/arch-omap/board-perseus2.h
index 691e52a..eb74420 100644
--- a/include/asm-arm/arch-omap/board-perseus2.h
+++ b/include/asm-arm/arch-omap/board-perseus2.h
@@ -42,8 +42,4 @@
 
 #define NR_IRQS			(MAXIRQNUM + 1)
 
-/* Samsung NAND flash at CS2B or CS3(NAND Boot) */
-#define OMAP_NAND_FLASH_START1	   0x0A000000 /* CS2B */
-#define OMAP_NAND_FLASH_START2	   0x0C000000 /* CS3 */
-
 #endif
diff --git a/include/asm-arm/mach/flash.h b/include/asm-arm/mach/flash.h
index 05b029e..664b708 100644
--- a/include/asm-arm/mach/flash.h
+++ b/include/asm-arm/mach/flash.h
@@ -36,4 +36,18 @@ struct flash_platform_data {
 	unsigned int	nr_parts;
 };
 
+/**
+ * struct nand_platform_data - platform data describing NAND flash banks
+ * @dev_ready:	tests if the NAND flash is ready (READY signal is high)
+ * @options:	bitmask for nand_chip.options
+ * @parts:	optional array of mtd_partitions for static partitioning
+ * @nr_parts:	number of mtd_partitions for static partitoning
+ */
+struct nand_platform_data {
+	int		(*dev_ready)(struct nand_platform_data *data);
+	unsigned int	options;
+	struct mtd_partition *parts;
+	unsigned int	nr_parts;
+};
+
 #endif
