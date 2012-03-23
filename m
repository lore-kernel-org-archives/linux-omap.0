From: Afzal Mohammed <afzal@ti.com>
Subject: [RFC][PATCH 3/5] ARM: OMAP2+: gpmc-nand: populate gpmc configs
Date: Fri, 23 Mar 2012 12:06:55 +0530
Message-ID: <1332484615-22030-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47802 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab2CWGyv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 02:54:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Currently gpmc is configured in platform for nand.
As configuring gpmc has been moved to gpmc driver,
populate details needed for the driver to configure
gpmc. gpmc driver would configure based on this
information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c        |   88 ++++++++++++--------------------
 arch/arm/plat-omap/include/plat/nand.h |    8 +--
 2 files changed, 39 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 386dec8..acec0ea 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -21,24 +21,29 @@
 #include <plat/board.h>
 #include <plat/gpmc.h>
 
-static struct resource gpmc_nand_resource = {
-	.flags		= IORESOURCE_MEM,
+
+#define	GPMC_NAND_CONFIG_NUM	3
+
+static struct gpmc_config gpmc_nand_config[GPMC_NAND_CONFIG_NUM] = {
+	{ GPMC_CONFIG_DEV_TYPE, GPMC_DEVICETYPE_NAND},
 };
 
-static struct platform_device gpmc_nand_device = {
+static struct gpmc_device_pdata gpmc_nand_info = {
 	.name		= "omap2-nand",
 	.id		= 0,
-	.num_resources	= 1,
-	.resource	= &gpmc_nand_resource,
+	.config		= gpmc_nand_config,
+	.num_config	= ARRAY_SIZE(gpmc_nand_config),
 };
 
-static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gpmc_nand_data)
-{
-	struct gpmc_timings t;
-	int err;
+static struct gpmc_timings t;
 
-	if (!gpmc_nand_data->gpmc_t)
+static struct gpmc_timings *
+gpmc_nand_retime(struct omap_nand_platform_data *gpmc_nand_data)
+{
+	if (!gpmc_nand_data->gpmc_t) {
+		pr_warn("gpmc timings not provided\n");
 		return 0;
+	}
 
 	memset(&t, 0, sizeof(t));
 	t.sync_clk = gpmc_nand_data->gpmc_t->sync_clk;
@@ -68,56 +73,31 @@ static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gpmc_nand_data
 	t.cs_wr_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_wr_off);
 	t.wr_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->wr_cycle);
 
-	/* Configure GPMC */
-	if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
-		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_DEV_SIZE, 1);
-	else
-		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_DEV_SIZE, 0);
-	gpmc_cs_configure(gpmc_nand_data->cs,
-			GPMC_CONFIG_DEV_TYPE, GPMC_DEVICETYPE_NAND);
-	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
-	if (err)
-		return err;
-
-	return 0;
+	return &t;
 }
 
-int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data)
+struct gpmc_device_pdata *
+__init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data)
 {
-	int err	= 0;
-	struct device *dev = &gpmc_nand_device.dev;
+	gpmc_nand_info.pdata = gpmc_nand_data;
+	gpmc_nand_info.pdata_size = sizeof(*gpmc_nand_data);
 
-	gpmc_nand_device.dev.platform_data = gpmc_nand_data;
+	gpmc_nand_info.cs = gpmc_nand_data->cs;
+	gpmc_nand_info.mem_size = NAND_IO_SIZE;
 
-	err = gpmc_cs_request(gpmc_nand_data->cs, NAND_IO_SIZE,
-				&gpmc_nand_data->phys_base);
-	if (err < 0) {
-		dev_err(dev, "Cannot request GPMC CS\n");
-		return err;
-	}
+	gpmc_nand_info.timing = gpmc_nand_retime(gpmc_nand_data);
 
-	 /* Set timings in GPMC */
-	err = omap2_nand_gpmc_retime(gpmc_nand_data);
-	if (err < 0) {
-		dev_err(dev, "Unable to set gpmc timings: %d\n", err);
-		return err;
-	}
-
-	/* Enable RD PIN Monitoring Reg */
-	if (gpmc_nand_data->dev_ready) {
-		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_RDY_BSY, 1);
-	}
-
-	err = platform_device_register(&gpmc_nand_device);
-	if (err < 0) {
-		dev_err(dev, "Unable to register NAND device\n");
-		goto out_free_cs;
-	}
-
-	return 0;
+	gpmc_nand_config[1].cmd = GPMC_CONFIG_DEV_SIZE;
+	if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
+		gpmc_nand_config[1].val = 1;
+	else
+		gpmc_nand_config[1].val = 0;
 
-out_free_cs:
-	gpmc_cs_free(gpmc_nand_data->cs);
+	gpmc_nand_config[2].cmd = GPMC_CONFIG_RDY_BSY;
+	if (gpmc_nand_data->dev_ready)
+		gpmc_nand_config[2].val = 1;
+	else
+		gpmc_nand_config[2].val = 0;
 
-	return err;
+	return &gpmc_nand_info;
 }
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index 67fc506..d2daeba 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -35,10 +35,12 @@ struct omap_nand_platform_data {
 #define	NAND_IO_SIZE	4
 
 #if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
-extern int gpmc_nand_init(struct omap_nand_platform_data *d);
+extern struct gpmc_device_pdata *
+gpmc_nand_init(struct omap_nand_platform_data *d);
 #else
-static inline int gpmc_nand_init(struct omap_nand_platform_data *d)
+static inline struct gpmc_device_pdata *
+gpmc_nand_init(struct omap_nand_platform_data *d)
 {
-	return 0;
+	return NULL;
 }
 #endif
-- 
1.7.9.3

