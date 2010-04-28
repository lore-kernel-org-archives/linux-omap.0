From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 2/2] omap: gpmc-nand: add ability to keep timings defined by the bootloader
Date: Wed, 28 Apr 2010 19:06:05 +0300
Message-ID: <d97635d8d65238f8801db6bcf4e89e2fb1b44b17.1272470212.git.mike@compulab.co.il>
References: <cover.1272470212.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:48299 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755056Ab0D1QHk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 12:07:40 -0400
In-Reply-To: <cover.1272470212.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: s-ghorai@ti.com, linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/gpmc-nand.c        |   19 ++++++++++++++++++-
 arch/arm/plat-omap/include/plat/nand.h |    1 +
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index e57fb29..7c6c027 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -22,6 +22,7 @@
 #define WR_RD_PIN_MONITORING	0x00600000
 
 static struct omap_nand_platform_data *gpmc_nand_data;
+static struct gpmc_timings gpmc_default_timings;
 
 static struct resource gpmc_nand_resource = {
 	.flags		= IORESOURCE_MEM,
@@ -34,13 +35,24 @@ static struct platform_device gpmc_nand_device = {
 	.resource	= &gpmc_nand_resource,
 };
 
+static void gpmc_nand_detect_timings(void)
+{
+	struct gpmc_timings t;
+
+	memset(&t, 0, sizeof(t));
+	gpmc_cs_get_timings(gpmc_nand_data->cs, &gpmc_default_timings);
+}
+
 static int omap2_nand_gpmc_retime(void)
 {
+	struct device *dev = &gpmc_nand_device.dev;
 	struct gpmc_timings t;
 	int err;
 
-	if (!gpmc_nand_data->gpmc_t)
+	if (!gpmc_nand_data->gpmc_t) {
+		dev_warn(dev, "No timings provided, skipping retime\n");
 		return 0;
+	}
 
 	memset(&t, 0, sizeof(t));
 	t.sync_clk = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->sync_clk);
@@ -112,6 +124,11 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
 		return err;
 	}
 
+	if (gpmc_nand_data->keep_timings) {
+		gpmc_nand_detect_timings();
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

