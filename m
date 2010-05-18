From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v3 3/3] omap3 nand: fix issue in board file to detect nand
Date: Tue, 18 May 2010 16:46:29 +0530
Message-ID: <1274181389-7488-4-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1274181389-7488-1-git-send-email-s-ghorai@ti.com>
 <1274181389-7488-2-git-send-email-s-ghorai@ti.com>
 <1274181389-7488-3-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38358 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756946Ab0ERLQy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 07:16:54 -0400
In-Reply-To: <1274181389-7488-3-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, tony@atomide.com, sakoman@gmail.com, mike@compulab.co.il, Artem.Bityutskiy@nokia.com, Sukumar Ghorai <s-ghorai@ti.com>

Board file modified for not to provide gpmc phys_base address to nand driver.
The gpmc_nand_init funciton is now used to detect the nand and required to
adopt _prob function as in nand/omap2.c

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c         |   20 +-------------------
 arch/arm/mach-omap2/board-devkit8000.c     |   25 +------------------------
 arch/arm/mach-omap2/board-omap3beagle.c    |   24 +-----------------------
 arch/arm/mach-omap2/board-omap3touchbook.c |   25 +------------------------
 arch/arm/mach-omap2/board-overo.c          |   24 +-----------------------
 5 files changed, 5 insertions(+), 113 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index f4e8063..8a41268
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -61,8 +61,6 @@
 #define SB_T35_SMSC911X_GPIO	65
 
 #define NAND_BLOCK_SIZE		SZ_128K
-#define GPMC_CS0_BASE		0x60
-#define GPMC_CS0_BASE_ADDR	(OMAP34XX_GPMC_VIRT + GPMC_CS0_BASE)
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <linux/smsc911x.h>
@@ -223,28 +221,12 @@ static struct omap_nand_platform_data cm_t35_nand_data = {
 	.nr_parts		= ARRAY_SIZE(cm_t35_nand_partitions),
 	.dma_channel		= -1,	/* disable DMA in OMAP NAND driver */
 	.cs			= 0,
-	.gpmc_cs_baseaddr	= (void __iomem *)GPMC_CS0_BASE_ADDR,
-	.gpmc_baseaddr		= (void __iomem *)OMAP34XX_GPMC_VIRT,
 
 };
 
-static struct resource cm_t35_nand_resource = {
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device cm_t35_nand_device = {
-	.name		= "omap2-nand",
-	.id		= -1,
-	.num_resources	= 1,
-	.resource	= &cm_t35_nand_resource,
-	.dev		= {
-		.platform_data	= &cm_t35_nand_data,
-	},
-};
-
 static void __init cm_t35_init_nand(void)
 {
-	if (platform_device_register(&cm_t35_nand_device) < 0)
+	if (gpmc_nand_init(&cm_t35_nand_data) < 0)
 		pr_err("CM-T35: Unable to register NAND device\n");
 }
 #else
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 6d910df..b172414
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -58,9 +58,6 @@
 #include "mux.h"
 #include "hsmmc.h"
 
-#define GPMC_CS0_BASE  0x60
-#define GPMC_CS_SIZE   0x30
-
 #define NAND_BLOCK_SIZE		SZ_128K
 
 #define OMAP_DM9000_GPIO_IRQ	25
@@ -104,20 +101,6 @@ static struct omap_nand_platform_data devkit8000_nand_data = {
 	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
 };
 
-static struct resource devkit8000_nand_resource = {
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device devkit8000_nand_device = {
-	.name		= "omap2-nand",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &devkit8000_nand_data,
-	},
-	.num_resources	= 1,
-	.resource	= &devkit8000_nand_resource,
-};
-
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -581,8 +564,6 @@ static void __init devkit8000_flash_init(void)
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
 
-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
 	/* find out the chip-select on which NAND exists */
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
@@ -604,13 +585,9 @@ static void __init devkit8000_flash_init(void)
 
 	if (nandcs < GPMC_CS_NUM) {
 		devkit8000_nand_data.cs = nandcs;
-		devkit8000_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		devkit8000_nand_data.gpmc_baseaddr = (void *)
-			(gpmc_base_add);
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (platform_device_register(&devkit8000_nand_device) < 0)
+		if (gpmc_nand_init(&devkit8000_nand_data) < 0)
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 5df89f6..9ec3ef8 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -47,9 +47,6 @@
 #include "mux.h"
 #include "hsmmc.h"
 
-#define GPMC_CS0_BASE  0x60
-#define GPMC_CS_SIZE   0x30
-
 #define NAND_BLOCK_SIZE		SZ_128K
 
 static struct mtd_partition omap3beagle_nand_partitions[] = {
@@ -92,20 +89,6 @@ static struct omap_nand_platform_data omap3beagle_nand_data = {
 	.dev_ready	= NULL,
 };
 
-static struct resource omap3beagle_nand_resource = {
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device omap3beagle_nand_device = {
-	.name		= "omap2-nand",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &omap3beagle_nand_data,
-	},
-	.num_resources	= 1,
-	.resource	= &omap3beagle_nand_resource,
-};
-
 #include "sdram-micron-mt46h32m32lf-6.h"
 
 static struct omap2_hsmmc_info mmc[] = {
@@ -377,8 +360,6 @@ static void __init omap3beagle_flash_init(void)
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
 
-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
 	/* find out the chip-select on which NAND exists */
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
@@ -400,12 +381,9 @@ static void __init omap3beagle_flash_init(void)
 
 	if (nandcs < GPMC_CS_NUM) {
 		omap3beagle_nand_data.cs = nandcs;
-		omap3beagle_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		omap3beagle_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (platform_device_register(&omap3beagle_nand_device) < 0)
+		if (gpmc_nand_init(&omap3beagle_nand_data) < 0)
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index c59050d..29dd266
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -54,9 +54,6 @@
 
 #include <asm/setup.h>
 
-#define GPMC_CS0_BASE  0x60
-#define GPMC_CS_SIZE   0x30
-
 #define NAND_BLOCK_SIZE		SZ_128K
 
 #define OMAP3_AC_GPIO		136
@@ -106,20 +103,6 @@ static struct omap_nand_platform_data omap3touchbook_nand_data = {
 	.dev_ready	= NULL,
 };
 
-static struct resource omap3touchbook_nand_resource = {
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device omap3touchbook_nand_device = {
-	.name		= "omap2-nand",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &omap3touchbook_nand_data,
-	},
-	.num_resources	= 1,
-	.resource	= &omap3touchbook_nand_resource,
-};
-
 #include "sdram-micron-mt46h32m32lf-6.h"
 
 static struct omap2_hsmmc_info mmc[] = {
@@ -459,8 +442,6 @@ static void __init omap3touchbook_flash_init(void)
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
 
-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
 	/* find out the chip-select on which NAND exists */
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
@@ -482,13 +463,9 @@ static void __init omap3touchbook_flash_init(void)
 
 	if (nandcs < GPMC_CS_NUM) {
 		omap3touchbook_nand_data.cs = nandcs;
-		omap3touchbook_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		omap3touchbook_nand_data.gpmc_baseaddr =
-						(void *) (gpmc_base_add);
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (platform_device_register(&omap3touchbook_nand_device) < 0)
+		if (gpmc_nand_init(&omap3touchbook_nand_data) < 0)
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 24b32d7..df0fb0d
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -58,8 +58,6 @@
 #define OVERO_GPIO_USBH_NRESET	183
 
 #define NAND_BLOCK_SIZE SZ_128K
-#define GPMC_CS0_BASE  0x60
-#define GPMC_CS_SIZE   0x30
 
 #define OVERO_SMSC911X_CS      5
 #define OVERO_SMSC911X_GPIO    176
@@ -231,28 +229,11 @@ static struct omap_nand_platform_data overo_nand_data = {
 	.dma_channel = -1,	/* disable DMA in OMAP NAND driver */
 };
 
-static struct resource overo_nand_resource = {
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device overo_nand_device = {
-	.name		= "omap2-nand",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &overo_nand_data,
-	},
-	.num_resources	= 1,
-	.resource	= &overo_nand_resource,
-};
-
-
 static void __init overo_flash_init(void)
 {
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
 
-	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
-
 	/* find out the chip-select on which NAND exists */
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
@@ -274,12 +255,9 @@ static void __init overo_flash_init(void)
 
 	if (nandcs < GPMC_CS_NUM) {
 		overo_nand_data.cs = nandcs;
-		overo_nand_data.gpmc_cs_baseaddr = (void *)
-			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
-		overo_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (platform_device_register(&overo_nand_device) < 0)
+		if (gpmc_nand_init(&overo_nand_data) < 0)
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
