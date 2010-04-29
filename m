From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH v2 3/3] omap: gpmc-nand: add ability to keep timings defined by the bootloader
Date: Thu, 29 Apr 2010 11:48:12 +0300
Message-ID: <f20c8d0dc1c81a0cc5a334d03c9c7dc73046293d.1272530653.git.mike@compulab.co.il>
References: <cover.1272530653.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:38483 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757260Ab0D3VDA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 17:03:00 -0400
In-Reply-To: <cover.1272530653.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, vimal.newwork@gmail.com, s-ghorai@ti.com, Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/gpmc-nand.c        |   21 +++++++++++++++++----
 arch/arm/plat-omap/include/plat/nand.h |    1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 9434c80..96f0c7f 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -22,6 +22,7 @@
 #define WR_RD_PIN_MONITORING	0x00600000
 
 static struct omap_nand_platform_data *gpmc_nand_data;
+static struct gpmc_timings gpmc_default_timings;
 
 static struct resource gpmc_nand_resource = {
 	.flags		= IORESOURCE_MEM,
@@ -65,21 +66,28 @@ static void omap2_nand_gpmc_round_timings(struct gpmc_timings *src,
 
 static int omap2_nand_gpmc_retime(void)
 {
+	struct device *dev = &gpmc_nand_device.dev;
+	struct gpmc_timings *gpmc_t = gpmc_nand_data->gpmc_t;
 	struct gpmc_timings t;
 	int err;
 
-	if (!gpmc_nand_data->gpmc_t)
+	if (!gpmc_t) {
+		dev_warn(dev, "No timings provided, skipping retime\n");
 		return 0;
+	}
 
-	memset(&t, 0, sizeof(t));
-	omap2_nand_gpmc_round_timings(gpmc_nand_data->gpmc_t, &t);
+	if (!gpmc_nand_data->keep_timings) {
+		memset(&t, 0, sizeof(t));
+		omap2_nand_gpmc_round_timings(gpmc_nand_data->gpmc_t, &t);
+		gpmc_t = &t;
+	}
 
 	/* Configure GPMC */
 	gpmc_cs_write_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG1,
 			GPMC_CONFIG1_DEVICESIZE(gpmc_nand_data->devsize) |
 			GPMC_CONFIG1_DEVICETYPE_NAND);
 
-	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
+	err = gpmc_cs_set_timings(gpmc_nand_data->cs, gpmc_t);
 	if (err)
 		return err;
 
@@ -116,6 +124,11 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
 		return err;
 	}
 
+	if (gpmc_nand_data->keep_timings) {
+		gpmc_cs_get_timings(gpmc_nand_data->cs, &gpmc_default_timings);
+		gpmc_nand_data->gpmc_t = &gpmc_default_timings;
+	}
+
 	err = gpmc_nand_setup();
 	if (err < 0) {
 		dev_err(dev, "NAND platform setup failed: %d\n", err);
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index f8efd54..0f727ea 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -24,6 +24,7 @@ struct omap_nand_platform_data {
 	void __iomem		*gpmc_cs_baseaddr;
 	void __iomem		*gpmc_baseaddr;
 	int			devsize;
+	bool			keep_timings;
 };
 
 /* size (4 KiB) for IO mapping */
-- 
1.6.6.2

