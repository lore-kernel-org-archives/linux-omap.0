From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] omap: cleanup NAND platform data
Date: Fri,  3 Jun 2011 22:56:33 +0300
Message-ID: <1307130993-15265-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46723 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab1FCT4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 15:56:39 -0400
Received: by fxm17 with SMTP id 17so1495239fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 12:56:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

omap_nand_platform_data fields 'options', 'gpio_irq', 'nand_setup' and
'dma_channel' are never referenced by the NAND driver, yet various
board files are initializing those fields. This is both incorrect and
confusing, so remove them. This allows to get rid of a global
variable in gpmc-nand.c.

This also corrects an issue where some boards are trying to pass NAND
16bit flag through .options, but the driver is using .devsize instead
and ignoring .options.

Finally, .dev_ready is treated as a flag by the driver, so make it bool
instead of a function pointer.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-cm-t35.c         |    2 --
 arch/arm/mach-omap2/board-cm-t3517.c       |    1 -
 arch/arm/mach-omap2/board-flash.c          |    4 ----
 arch/arm/mach-omap2/common-board-devices.c |    6 ++----
 arch/arm/mach-omap2/gpmc-nand.c            |   10 +++-------
 arch/arm/plat-omap/include/plat/nand.h     |    6 +-----
 6 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index c63115b..99238e6 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -164,9 +164,7 @@ static struct mtd_partition cm_t35_nand_partitions[] = {
 static struct omap_nand_platform_data cm_t35_nand_data = {
 	.parts			= cm_t35_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(cm_t35_nand_partitions),
-	.dma_channel		= -1,	/* disable DMA in OMAP NAND driver */
 	.cs			= 0,
-
 };
 
 static void __init cm_t35_init_nand(void)
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 08f08e8..c80d862 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -237,7 +237,6 @@ static struct mtd_partition cm_t3517_nand_partitions[] = {
 static struct omap_nand_platform_data cm_t3517_nand_data = {
 	.parts			= cm_t3517_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(cm_t3517_nand_partitions),
-	.dma_channel		= -1,	/* disable DMA in OMAP NAND driver */
 	.cs			= 0,
 };
 
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 729892f..aa1b0cb 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -132,11 +132,7 @@ static struct gpmc_timings nand_timings = {
 };
 
 static struct omap_nand_platform_data board_nand_data = {
-	.nand_setup	= NULL,
 	.gpmc_t		= &nand_timings,
-	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
-	.dev_ready	= NULL,
-	.devsize	= 0,	/* '0' for 8-bit, '1' for 16-bit device */
 };
 
 void
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index e94903b..366171d 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -115,9 +115,7 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 #endif
 
 #if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
-static struct omap_nand_platform_data nand_data = {
-	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
-};
+static struct omap_nand_platform_data nand_data;
 
 void __init omap_nand_flash_init(int options, struct mtd_partition *parts,
 				 int nr_parts)
@@ -148,7 +146,7 @@ void __init omap_nand_flash_init(int options, struct mtd_partition *parts,
 		nand_data.cs = nandcs;
 		nand_data.parts = parts;
 		nand_data.nr_parts = nr_parts;
-		nand_data.options = options;
+		nand_data.devsize = options;
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
 		if (gpmc_nand_init(&nand_data) < 0)
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index c1791d0..8ad210b 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -20,8 +20,6 @@
 #include <plat/board.h>
 #include <plat/gpmc.h>
 
-static struct omap_nand_platform_data *gpmc_nand_data;
-
 static struct resource gpmc_nand_resource = {
 	.flags		= IORESOURCE_MEM,
 };
@@ -33,7 +31,7 @@ static struct platform_device gpmc_nand_device = {
 	.resource	= &gpmc_nand_resource,
 };
 
-static int omap2_nand_gpmc_retime(void)
+static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gpmc_nand_data)
 {
 	struct gpmc_timings t;
 	int err;
@@ -83,13 +81,11 @@ static int omap2_nand_gpmc_retime(void)
 	return 0;
 }
 
-int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
+int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data)
 {
 	int err	= 0;
 	struct device *dev = &gpmc_nand_device.dev;
 
-	gpmc_nand_data = _nand_data;
-	gpmc_nand_data->nand_setup = omap2_nand_gpmc_retime;
 	gpmc_nand_device.dev.platform_data = gpmc_nand_data;
 
 	err = gpmc_cs_request(gpmc_nand_data->cs, NAND_IO_SIZE,
@@ -100,7 +96,7 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
 	}
 
 	 /* Set timings in GPMC */
-	err = omap2_nand_gpmc_retime();
+	err = omap2_nand_gpmc_retime(gpmc_nand_data);
 	if (err < 0) {
 		dev_err(dev, "Unable to set gpmc timings: %d\n", err);
 		return err;
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index d86d1ec..67fc506 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -19,15 +19,11 @@ enum nand_io {
 };
 
 struct omap_nand_platform_data {
-	unsigned int		options;
 	int			cs;
-	int			gpio_irq;
 	struct mtd_partition	*parts;
 	struct gpmc_timings	*gpmc_t;
 	int			nr_parts;
-	int			(*nand_setup)(void);
-	int			(*dev_ready)(struct omap_nand_platform_data *);
-	int			dma_channel;
+	bool			dev_ready;
 	int			gpmc_irq;
 	enum nand_io		xfer_type;
 	unsigned long		phys_base;
-- 
1.7.0.4

