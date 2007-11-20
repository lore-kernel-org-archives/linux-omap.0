From: "Choraria, Rohit" <rohitkc@ti.com>
Subject: [PATCH] OMAP: FLASH: Move Flash specific device info in a separate
	board file
Date: Tue, 20 Nov 2007 19:53:24 +0530
Message-ID: <AC2D475575504148943F5EB0938951C4012717DD@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
This patch moves the SDP3430 NOR and OneNAND devices to a new file
board-3430sdp-flash.c. It also adds the support for ethernet on ES2 SDP.

Regards,
Rohit

Signed-off-by: Rohit Choraria <rohitkc@ti.com>
---
 arch/arm/mach-omap2/Makefile              |    3=20
 arch/arm/mach-omap2/board-3430sdp-flash.c |  196 =
++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-3430sdp.c       |   81 ++----------
 include/asm-arm/arch-omap/board-3430sdp.h |   16 +-
 include/asm-arm/arch-omap/gpmc.h          |   79 ++++++++----
 5 files changed, 278 insertions(+), 97 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/board-3430sdp-flash.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/arch/arm/mach-omap2/board-3430sdp-flash.c	2007-11-19 =
13:52:25.224981776 -0500
@@ -0,0 +1,196 @@
+/*
+ * linux/arch/arm/mach-omap2/board-3430sdp-flash.c
+ *
+ * Copyright (c) 2007 Texas Instruments
+ *
+ * Modified from mach-omap2/board-2430sdp-flash.c
+ * Author: Rohit Choraria <rohitkc@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/onenand_regs.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#include <asm/mach/flash.h>
+#include <asm/arch/onenand.h>
+#include <asm/arch/board.h>
+#include <asm/arch/gpmc.h>
+
+static struct mtd_partition sdp_nor_partitions[] =3D {
+	/* bootloader (U-Boot, etc) in first sector */
+	{
+		.name		=3D "Bootloader-NOR",
+		.offset		=3D 0,
+		.size		=3D SZ_256K,
+		.mask_flags	=3D MTD_WRITEABLE, /* force read-only */
+	},
+	/* bootloader params in the next sector */
+	{
+		.name		=3D "Params-NOR",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D SZ_256K,
+		.mask_flags	=3D 0,
+	},
+	/* kernel */
+	{
+		.name		=3D "Kernel-NOR",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D SZ_2M,
+		.mask_flags	=3D 0
+	},
+	/* file system */
+	{
+		.name		=3D "Filesystem-NOR",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D MTDPART_SIZ_FULL,
+		.mask_flags	=3D 0
+	}
+};
+
+static struct flash_platform_data sdp_nor_data =3D {
+	.map_name	=3D "cfi_probe",
+	.width		=3D 2,
+	.parts		=3D sdp_nor_partitions,
+	.nr_parts	=3D ARRAY_SIZE(sdp_nor_partitions),
+};
+
+static struct resource sdp_nor_resource =3D {
+	.start		=3D 0,
+	.end		=3D 0,
+	.flags		=3D IORESOURCE_MEM,
+};
+
+static struct platform_device sdp_nor_device =3D {
+	.name		=3D "omapflash",
+	.id		=3D 0,
+	.dev		=3D {
+			.platform_data  =3D &sdp_nor_data,
+	},
+	.num_resources	=3D 1,
+	.resource	=3D &sdp_nor_resource,
+};
+
+static int sdp_onenand_setup(void __iomem *);
+
+static struct mtd_partition sdp_onenand_partitions[] =3D {
+	{
+		.name		=3D "X-Loader-OneNAND",
+		.offset		=3D 0,
+		.size		=3D 4 * (64 * 2048),
+		.mask_flags	=3D MTD_WRITEABLE	 /* force read-only */
+	},
+	{
+		.name		=3D "U-Boot-OneNAND",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D 2 * (64 * 2048),
+		.mask_flags	=3D MTD_WRITEABLE	 /* force read-only */
+	},
+	{
+		.name		=3D "U-Boot Environment-OneNAND",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D 1 * (64 * 2048),
+	},
+	{
+		.name		=3D "Kernel-OneNAND",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D 16 * (64 * 2048),
+	},
+	{
+		.name		=3D "File System-OneNAND",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data sdp_onenand_data =3D {
+	.parts		=3D sdp_onenand_partitions,
+	.nr_parts	=3D ARRAY_SIZE(sdp_onenand_partitions),
+	.onenand_setup	=3D sdp_onenand_setup,
+	.dma_channel	=3D -1,	/* disable DMA in OMAP OneNAND driver */
+};
+
+static struct platform_device sdp_onenand_device =3D {
+	.name		=3D "omap2-onenand",
+	.id		=3D -1,
+	.dev =3D {
+		.platform_data =3D &sdp_onenand_data,
+	},
+};
+
+/*
+ * sdp_onenand_setup - The function configures the onenand flash.
+ * @onenand_base: Onenand base address
+ *
+ * @return int:	Currently always returning zero.
+ */
+static int sdp_onenand_setup(void __iomem *onenand_base)
+{
+	/* Onenand setup does nothing at present */
+	return 0;
+}
+/**
+ * sdp3430_flash_init - Identify devices connected to GPMC and =
register.
+ *
+ * @return - void.
+ */
+void __init sdp3430_flash_init(void)
+{
+	unsigned long	gpmc_base_add, gpmc_cs_base_add;
+	u8		cs =3D 0;
+	u8		onenandcs =3D GPMC_CS_NUM + 1;
+
+	gpmc_base_add	=3D OMAP34XX_GPMC_VIRT;
+
+	/* Configure start address and size of NOR device */
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+		sdp_nor_resource.start =3D FLASH_BASE_SDPV2;
+		sdp_nor_resource.end   =3D FLASH_BASE_SDPV2
+						+ FLASH_SIZE_SDPV2 - 1;
+	} else {
+		sdp_nor_resource.start =3D FLASH_BASE_SDPV1;
+		sdp_nor_resource.end   =3D FLASH_BASE_SDPV1
+						+ FLASH_SIZE_SDPV1 - 1;
+	}
+
+	if (platform_device_register(&sdp_nor_device) < 0)
+		printk(KERN_ERR "Unable to register NOR device\n");
+
+	while (cs < GPMC_CS_NUM) {
+		u32 ret =3D 0;
+		gpmc_cs_base_add =3D
+			(gpmc_base_add + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE));
+
+		/*
+		* xloader/Uboot would have programmed the oneNAND
+		* base address for us This is a ugly hack. The proper
+		* way of doing this is to pass the setup of u-boot up
+		* to kernel using kernel params - something on the
+		* lines of machineID. Check if oneNAND is configured
+		*/
+		ret =3D __raw_readl(gpmc_cs_base_add + GPMC_CS_CONFIG7);
+		if ((ret & 0x3F) =3D=3D (ONENAND_MAP >> 24))
+			onenandcs =3D cs;
+		cs++;
+	}
+	if (onenandcs > GPMC_CS_NUM) {
+		printk(KERN_INFO "OneNAND: Unable to find configuration "
+				" in GPMC\n ");
+		return;
+	}
+
+	if (onenandcs < GPMC_CS_NUM) {
+		sdp_onenand_data.cs =3D onenandcs;
+		if (platform_device_register(&sdp_onenand_device) < 0)
+			printk(KERN_ERR "Unable to register OneNAND device\n");
+	}
+}
+
Index: linux-omap/arch/arm/mach-omap2/board-3430sdp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/board-3430sdp.c	2007-11-19 =
14:14:03.000000000 -0500
+++ linux-omap/arch/arm/mach-omap2/board-3430sdp.c	2007-11-19 =
14:14:15.469794288 -0500
@@ -15,8 +15,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/workqueue.h>
@@ -29,7 +27,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/flash.h>
=20
 #include <asm/arch/twl4030.h>
 #include <asm/arch/mcspi.h>
@@ -44,76 +41,21 @@
 #include <asm/io.h>
 #include <asm/delay.h>
=20
-#define	SDP3430_FLASH_CS	0
 #define	SDP3430_SMC91X_CS	3
=20
 #define ENABLE_VAUX3_DEDICATED	0x03
 #define ENABLE_VAUX3_DEV_GRP	0x20
=20
-static struct mtd_partition sdp3430_partitions[] =3D {
-	/* bootloader (U-Boot, etc) in first sector */
-	{
-		  .name		=3D "bootloader",
-		  .offset		=3D 0,
-		  .size		=3D SZ_256K,
-		  .mask_flags	=3D MTD_WRITEABLE, /* force read-only */
-	},
-	/* bootloader params in the next sector */
-	{
-		  .name		=3D "params",
-		  .offset		=3D MTDPART_OFS_APPEND,
-		  .size		=3D SZ_128K,
-		  .mask_flags	=3D 0,
-	},
-	/* kernel */
-	{
-		  .name		=3D "kernel",
-		  .offset		=3D MTDPART_OFS_APPEND,
-		  .size		=3D SZ_2M,
-		  .mask_flags	=3D 0
-	},
-	/* file system */
-	{
-		  .name		=3D "filesystem",
-		  .offset		=3D MTDPART_OFS_APPEND,
-		  .size		=3D MTDPART_SIZ_FULL,
-		  .mask_flags	=3D 0
-	}
-};
-
-static struct flash_platform_data sdp3430_flash_data =3D {
-	.map_name	=3D "cfi_probe",
-	.width		=3D 2,
-	.parts		=3D sdp3430_partitions,
-	.nr_parts	=3D ARRAY_SIZE(sdp3430_partitions),
-};
-
-static struct resource sdp3430_flash_resource =3D {
-	.start		=3D FLASH_BASE,
-	.end		=3D FLASH_BASE + SZ_64M - 1,
-	.flags		=3D IORESOURCE_MEM,
-};
-
-static struct platform_device sdp3430_flash_device =3D {
-	.name		=3D "omapflash",
-	.id		=3D 0,
-	.dev		=3D {
-		.platform_data	=3D &sdp3430_flash_data,
-	},
-	.num_resources	=3D 1,
-	.resource	=3D &sdp3430_flash_resource,
-};
-
 static struct resource sdp3430_smc91x_resources[] =3D {
 	[0] =3D {
 		.start	=3D OMAP34XX_ETHR_START,
 		.end	=3D OMAP34XX_ETHR_START + SZ_4K,
-		.flags		=3D IORESOURCE_MEM,
+		.flags	=3D IORESOURCE_MEM,
 	},
 	[1] =3D {
-		.start		=3D OMAP_GPIO_IRQ(OMAP34XX_ETHR_GPIO_IRQ),
+		.start	=3D 0,
 		.end	=3D 0,
-		.flags		=3D IORESOURCE_IRQ,
+		.flags	=3D IORESOURCE_IRQ,
 	},
 };
=20
@@ -256,7 +198,6 @@
 };
 static struct platform_device *sdp3430_devices[] __initdata =3D {
 	&sdp3430_smc91x_device,
-	&sdp3430_flash_device,
 	&sdp3430_kp_device,
 };
=20
@@ -266,6 +207,7 @@
 	unsigned long cs_mem_base;
 	unsigned int rate;
 	struct clk *l3ck;
+	int eth_gpio =3D 0;
=20
 	eth_cs	=3D SDP3430_SMC91X_CS;
=20
@@ -284,12 +226,19 @@
 	sdp3430_smc91x_resources[0].end   =3D cs_mem_base + 0xf;
 	udelay(100);
=20
-	if (omap_request_gpio(OMAP34XX_ETHR_GPIO_IRQ) < 0) {
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0))
+		eth_gpio =3D OMAP34XX_ETHR_GPIO_IRQ_SDPV2;
+	else
+		eth_gpio =3D OMAP34XX_ETHR_GPIO_IRQ_SDPV1;
+
+	sdp3430_smc91x_resources[1].start =3D OMAP_GPIO_IRQ(eth_gpio);
+
+	if (omap_request_gpio(eth_gpio) < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
-			OMAP34XX_ETHR_GPIO_IRQ);
+			eth_gpio);
 		return;
 	}
-	omap_set_gpio_direction(OMAP34XX_ETHR_GPIO_IRQ, 1);
+	omap_set_gpio_direction(eth_gpio, 1);
 }
=20
 static void __init omap_3430sdp_init_irq(void)
@@ -314,6 +263,7 @@
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
 }
+extern void __init sdp3430_flash_init(void);
=20
 static void __init omap_3430sdp_init(void)
 {
@@ -322,6 +272,7 @@
 	omap_board_config_size =3D ARRAY_SIZE(sdp3430_config);
 	spi_register_board_info(sdp3430_spi_board_info,
 				ARRAY_SIZE(sdp3430_spi_board_info));
+	sdp3430_flash_init();
 	ads7846_dev_init();
 	omap_serial_init();
 }
Index: linux-omap/include/asm-arm/arch-omap/board-3430sdp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/include/asm-arm/arch-omap/board-3430sdp.h	2007-11-19 =
13:36:16.000000000 -0500
+++ linux-omap/include/asm-arm/arch-omap/board-3430sdp.h	2007-11-19 =
14:24:42.763431160 -0500
@@ -34,7 +34,8 @@
 /* Placeholder for 3430SDP specific defines */
=20
 #define OMAP34XX_ETHR_START		DEBUG_BASE
-#define OMAP34XX_ETHR_GPIO_IRQ		29
+#define OMAP34XX_ETHR_GPIO_IRQ_SDPV1	29
+#define OMAP34XX_ETHR_GPIO_IRQ_SDPV2	6
=20
 /*
  * GPIO used for TSC2046, TI's Touchscreen controller
@@ -55,10 +56,15 @@
  * OneNand Mapped to 0x20000000
  * Boot Mode(NAND/NOR). The other on CS1
  */
-#define FLASH_BASE	0x04000000  /* NOR flash (64 Meg aligned) */
-#define DEBUG_BASE	0x08000000  /* debug board */
-#define NAND_BASE	0x0C000000  /* NAND flash */
-#define ONENAND_MAP	0x20000000  /* OneNand flash */
+#define FLASH_BASE_SDPV1	0x04000000  /* NOR flash (64 Meg aligned) */
+#define FLASH_BASE_SDPV2	0x10000000  /* NOR flash (256 Meg aligned) */
+#define DEBUG_BASE		0x08000000  /* debug board */
+#define NAND_BASE		0x0C000000  /* NAND flash */
+#define ONENAND_MAP		0x20000000  /* OneNand flash */
+
+/* various memory sizes */
+#define FLASH_SIZE_SDPV1	SZ_64M
+#define FLASH_SIZE_SDPV2	SZ_128M
=20
 #ifdef CONFIG_TWL4030_CORE
=20
Index: linux-omap/arch/arm/mach-omap2/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/Makefile	2007-11-19 =
13:37:33.000000000 -0500
+++ linux-omap/arch/arm/mach-omap2/Makefile	2007-11-19 =
14:22:32.974162128 -0500
@@ -28,7 +28,8 @@
 					   board-2430sdp-flash.o \
 					   board-2430sdp-usb.o
 obj-$(CONFIG_MACH_OMAP_2430OSK)		+=3D board-2430osk.o
-obj-$(CONFIG_MACH_OMAP_3430SDP)		+=3D board-3430sdp.o
+obj-$(CONFIG_MACH_OMAP_3430SDP)		+=3D board-3430sdp.o \
+					   board-3430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+=3D board-apollon.o \
 					   board-apollon-keys.o
 obj-$(CONFIG_MACH_NOKIA_N800)		+=3D board-n800.o board-n800-flash.o \
Index: linux-omap/include/asm-arm/arch-omap/gpmc.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/include/asm-arm/arch-omap/gpmc.h	2007-11-19 =
13:36:16.000000000 -0500
+++ linux-omap/include/asm-arm/arch-omap/gpmc.h	2007-11-20 =
11:24:38.032203488 -0500
@@ -14,6 +14,36 @@
 /* Maximum Number of Chip Selects */
 #define GPMC_CS_NUM		8
=20
+#define GPMC_REVISION		0x00
+#define GPMC_SYSCONFIG		0x10
+#define GPMC_SYSSTATUS		0x14
+#define GPMC_IRQSTATUS		0x18
+#define GPMC_IRQENABLE		0x1C
+#define GPMC_TIMEOUT_CTRL	0x40
+#define GPMC_ERR_ADDRESS	0x44
+#define GPMC_ERR_TYPE		0x48
+#define GPMC_CONFIG		0x50
+#define GPMC_STATUS		0x54
+#define GPMC_PREFETCH_CONFIG1	0x1e0
+#define GPMC_PREFETCH_CONFIG2	0x1e4
+#define GPMC_PREFETCH_CONTROL	0x1e8
+#define GPMC_PREFETCH_STATUS	0x1f0
+#define GPMC_ECC_CONFIG		0x1F4
+#define GPMC_ECC_CONTROL	0x1F8
+#define GPMC_ECC_SIZE_CONFIG	0x1FC
+#define GPMC_ECC1_RESULT	0x200
+#define GPMC_ECC2_RESULT	0x204
+#define GPMC_ECC3_RESULT	0x208
+#define GPMC_ECC4_RESULT	0x20C
+#define GPMC_ECC5_RESULT	0x210
+#define GPMC_ECC6_RESULT	0x214
+#define GPMC_ECC7_RESULT	0x218
+#define GPMC_ECC8_RESULT	0x21C
+#define GPMC_ECC9_RESULT	0x220
+
+#define GPMC_CS0_BASE		0x60
+#define GPMC_CS_SIZE		0x30
+
 #define GPMC_CS_CONFIG1		0x00
 #define GPMC_CS_CONFIG2		0x04
 #define GPMC_CS_CONFIG3		0x08
@@ -25,33 +55,30 @@
 #define GPMC_CS_NAND_ADDRESS	0x20
 #define GPMC_CS_NAND_DATA	0x24
=20
-#define GPMC_CONFIG		0x50
-#define GPMC_STATUS		0x54
-
-#define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
-#define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
-#define GPMC_CONFIG1_READTYPE_ASYNC     (0 << 29)
-#define GPMC_CONFIG1_READTYPE_SYNC      (1 << 29)
-#define GPMC_CONFIG1_WRITEMULTIPLE_SUPP (1 << 28)
-#define GPMC_CONFIG1_WRITETYPE_ASYNC    (0 << 27)
-#define GPMC_CONFIG1_WRITETYPE_SYNC     (1 << 27)
+#define GPMC_CONFIG1_WRAPBURST_SUPP	(1 << 31)
+#define GPMC_CONFIG1_READMULTIPLE_SUPP	(1 << 30)
+#define GPMC_CONFIG1_READTYPE_ASYNC	(0 << 29)
+#define GPMC_CONFIG1_READTYPE_SYNC	(1 << 29)
+#define GPMC_CONFIG1_WRITEMULTIPLE_SUPP	(1 << 28)
+#define GPMC_CONFIG1_WRITETYPE_ASYNC	(0 << 27)
+#define GPMC_CONFIG1_WRITETYPE_SYNC	(1 << 27)
 #define GPMC_CONFIG1_CLKACTIVATIONTIME(val) ((val & 3) << 25)
-#define GPMC_CONFIG1_PAGE_LEN(val)      ((val & 3) << 23)
-#define GPMC_CONFIG1_WAIT_READ_MON      (1 << 22)
-#define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
-#define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
-#define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
-#define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
-#define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
-#define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
-#define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
-#define GPMC_CONFIG1_DEVICETYPE_NAND    GPMC_CONFIG1_DEVICETYPE(1)
-#define GPMC_CONFIG1_MUXADDDATA         (1 << 9)
-#define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
-#define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
-#define GPMC_CONFIG1_FCLK_DIV2          (GPMC_CONFIG1_FCLK_DIV(1))
-#define GPMC_CONFIG1_FCLK_DIV3          (GPMC_CONFIG1_FCLK_DIV(2))
-#define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
+#define GPMC_CONFIG1_PAGE_LEN(val)	((val & 3) << 23)
+#define GPMC_CONFIG1_WAIT_READ_MON	(1 << 22)
+#define GPMC_CONFIG1_WAIT_WRITE_MON	(1 << 21)
+#define GPMC_CONFIG1_WAIT_MON_IIME(val)	((val & 3) << 18)
+#define GPMC_CONFIG1_WAIT_PIN_SEL(val)	((val & 3) << 16)
+#define GPMC_CONFIG1_DEVICESIZE(val)	((val & 3) << 12)
+#define GPMC_CONFIG1_DEVICESIZE_16	GPMC_CONFIG1_DEVICESIZE(1)
+#define GPMC_CONFIG1_DEVICETYPE(val)	((val & 3) << 10)
+#define GPMC_CONFIG1_DEVICETYPE_NOR	GPMC_CONFIG1_DEVICETYPE(0)
+#define GPMC_CONFIG1_DEVICETYPE_NAND	GPMC_CONFIG1_DEVICETYPE(1)
+#define GPMC_CONFIG1_MUXADDDATA		(1 << 9)
+#define GPMC_CONFIG1_TIME_PARA_GRAN	(1 << 4)
+#define GPMC_CONFIG1_FCLK_DIV(val)	(val & 3)
+#define GPMC_CONFIG1_FCLK_DIV2		(GPMC_CONFIG1_FCLK_DIV(1))
+#define GPMC_CONFIG1_FCLK_DIV3		(GPMC_CONFIG1_FCLK_DIV(2))
+#define GPMC_CONFIG1_FCLK_DIV4		(GPMC_CONFIG1_FCLK_DIV(3))
=20
 /*
  * Note that all values in this struct are in nanoseconds, while
