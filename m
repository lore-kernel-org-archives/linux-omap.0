From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v2 2/2] omap3 nand: fix issue in board file to detect the nand
Date: Fri, 14 May 2010 20:53:11 +0530
Message-ID: <1273850591-19040-3-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1273850591-19040-1-git-send-email-s-ghorai@ti.com>
 <1273850591-19040-2-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57974 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277Ab0ENPXg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 May 2010 11:23:36 -0400
In-Reply-To: <1273850591-19040-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, tony@atomide.com, sakoman@gmail.com, mike@compulab.co.il, Artem.Bityutskiy@nokia.com, Sukumar Ghorai <s-ghorai@ti.com>

Board file modified to pass the GMPC phys_base address to nand driver. This is
required to adopt the _prob function as in omap2.c

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c         |   16 +---------------
 arch/arm/mach-omap2/board-devkit8000.c     |   16 +---------------
 arch/arm/mach-omap2/board-omap3beagle.c    |   16 +---------------
 arch/arm/mach-omap2/board-omap3touchbook.c |   16 +---------------
 arch/arm/mach-omap2/board-overo.c          |   17 +----------------
 5 files changed, 5 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index fb23122..0544294
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -224,23 +224,9 @@ static struct omap_nand_platform_data cm_t35_nand_data = {
 
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
index ca4e409..9a8135d
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -101,20 +101,6 @@ static struct omap_nand_platform_data devkit8000_nand_data = {
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
@@ -601,7 +587,7 @@ static void __init devkit8000_flash_init(void)
 		devkit8000_nand_data.cs = nandcs;
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (platform_device_register(&devkit8000_nand_device) < 0)
+		if (gpmc_nand_init(&devkit8000_nand_data) < 0)
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index becaebe..bf31b7c
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -89,20 +89,6 @@ static struct omap_nand_platform_data omap3beagle_nand_data = {
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
@@ -397,7 +383,7 @@ static void __init omap3beagle_flash_init(void)
 		omap3beagle_nand_data.cs = nandcs;
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (platform_device_register(&omap3beagle_nand_device) < 0)
+		if (gpmc_nand_init(&omap3beagle_nand_data) < 0)
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index d6f1b12..e8ad30c
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -103,20 +103,6 @@ static struct omap_nand_platform_data omap3touchbook_nand_data = {
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
@@ -479,7 +465,7 @@ static void __init omap3touchbook_flash_init(void)
 		omap3touchbook_nand_data.cs = nandcs;
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (platform_device_register(&omap3touchbook_nand_device) < 0)
+		if (gpmc_nand_init(&omap3touchbook_nand_data) < 0)
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index bf2ec32..cddc7ad
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -229,21 +229,6 @@ static struct omap_nand_platform_data overo_nand_data = {
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
@@ -272,7 +257,7 @@ static void __init overo_flash_init(void)
 		overo_nand_data.cs = nandcs;
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (platform_device_register(&overo_nand_device) < 0)
+		if (gpmc_nand_init(&overo_nand_data) < 0)
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
