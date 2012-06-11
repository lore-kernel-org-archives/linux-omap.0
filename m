From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 1/9] ARM: OMAP2+: gpmc-nand: Adapt to use gpmc driver
Date: Mon, 11 Jun 2012 20:29:15 +0530
Message-ID: <876bbe1b59df7d0b09f7505e4b19aabd2b4ed8a4.1339419379.git.afzal@ti.com>
References: <cover.1339419379.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49839 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369Ab2FKPOy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 11:14:54 -0400
In-Reply-To: <cover.1339419379.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Currently gpmc is configured in platform for nand. As now
gpmc driver is present, populate details needed for the
driver to configure gpmc, gpmc driver would configure based
on this information. Old interface has been left as is so
that platforms can continue configuring gpmc using old
interface too. This is done so that driver conversion can
be done gradually without breaking any.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c        |   41 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/nand.h |    7 ++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 045596a..13248d7 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -21,6 +21,20 @@
 #include <plat/board.h>
 #include <plat/gpmc.h>
 
+static struct gpmc_cs_data gpmc_nand_cs_info = {
+	.have_config	= true,
+	.config		= GPMC_CONFIG1_DEVICETYPE_NAND,
+	.irq_config	= GPMC_IRQ_FIFOEVENTENABLE | GPMC_IRQ_COUNT_EVENT,
+};
+
+static struct gpmc_device_pdata gpmc_nand_info = {
+	.name		= "omap2-nand",
+	.id		= 0,
+	.cs_data	= &gpmc_nand_cs_info,
+	.num_cs		= 1,
+	.is_nand	= true,
+};
+
 static struct resource gpmc_nand_resource[] = {
 	{
 		.flags		= IORESOURCE_MEM,
@@ -76,6 +90,13 @@ static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gpmc_nand_data
 	t.cs_wr_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_wr_off);
 	t.wr_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->wr_cycle);
 
+	/* gpmc driver interface being used */
+	if (gpmc_nand_info.pdata != NULL) {
+		gpmc_nand_cs_info.time_ctrl.type = has_period;
+		gpmc_nand_cs_info.time_ctrl.timings = t;
+		return 0;
+	}
+
 	/* Configure GPMC */
 	if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
 		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_DEV_SIZE, 1);
@@ -139,3 +160,23 @@ out_free_cs:
 
 	return err;
 }
+
+struct gpmc_device_pdata *
+__init gpmc_nand_update(struct omap_nand_platform_data *gpmc_nand_data)
+{
+	gpmc_nand_info.pdata = gpmc_nand_data;
+	gpmc_nand_info.pdata_size = sizeof(*gpmc_nand_data);
+
+	gpmc_nand_cs_info.cs = gpmc_nand_data->cs;
+	gpmc_nand_cs_info.mem_size = NAND_IO_SIZE;
+
+	if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
+		gpmc_nand_cs_info.config |= GPMC_CONFIG1_DEVICESIZE_16;
+	if (gpmc_nand_data->dev_ready)
+		gpmc_nand_cs_info.config |= GPMC_CONFIG1_WAIT_READ_MON |
+						GPMC_CONFIG1_WAIT_WRITE_MON;
+
+	omap2_nand_gpmc_retime(gpmc_nand_data);
+
+	return &gpmc_nand_info;
+}
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index 290cef5..27700e1 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -36,9 +36,16 @@ struct omap_nand_platform_data {
 
 #if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
 extern int gpmc_nand_init(struct omap_nand_platform_data *d);
+struct gpmc_device_pdata *
+gpmc_nand_update(struct omap_nand_platform_data *gpmc_nand_data);
 #else
 static inline int gpmc_nand_init(struct omap_nand_platform_data *d)
 {
 	return 0;
 }
+static inline struct gpmc_device_pdata *
+gpmc_nand_update(struct omap_nand_platform_data *gpmc_nand_data)
+{
+	return NULL;
+};
 #endif
-- 
1.7.10.2

