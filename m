From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 07/39] ARM: OMAP2+: gpmc-nand: Adapt to use gpmc driver
Date: Tue, 1 May 2012 17:36:52 +0530
Message-ID: <c960251ba763804fb120e2f1986e0c7628baeefc.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1335873032.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently gpmc is configured in platform for nand.
As configuring gpmc has been moved to gpmc driver,
populate details needed for the driver to configure
gpmc. gpmc driver would configure based on this
information.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/gpmc-nand.c        |   84 ++++++++++++--------------------
 arch/arm/plat-omap/include/plat/nand.h |    8 +--
 2 files changed, 35 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 386dec8..190cdc1 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -21,24 +21,30 @@
 #include <plat/board.h>
 #include <plat/gpmc.h>
 
-static struct resource gpmc_nand_resource = {
-	.flags		= IORESOURCE_MEM,
+
+static struct gpmc_cs_data gpmc_nand_cs_info = {
+	.have_config	= true,
+	.config		= GPMC_DEVICETYPE_NAND,
+	.irq_config	= GPMC_IRQ_FIFOEVENTENABLE | GPMC_IRQ_COUNT_EVENT,
 };
 
-static struct platform_device gpmc_nand_device = {
+static struct gpmc_device_pdata gpmc_nand_info = {
 	.name		= "omap2-nand",
 	.id		= 0,
-	.num_resources	= 1,
-	.resource	= &gpmc_nand_resource,
+	.cs_data	= &gpmc_nand_cs_info,
+	.num_cs		= 1,
+	.is_nand	= true,
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
@@ -68,56 +74,26 @@ static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gpmc_nand_data
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
+	gpmc_nand_cs_info.cs = gpmc_nand_data->cs;
+	gpmc_nand_cs_info.mem_size = NAND_IO_SIZE;
 
-	err = gpmc_cs_request(gpmc_nand_data->cs, NAND_IO_SIZE,
-				&gpmc_nand_data->phys_base);
-	if (err < 0) {
-		dev_err(dev, "Cannot request GPMC CS\n");
-		return err;
-	}
+	gpmc_nand_cs_info.timing = gpmc_nand_retime(gpmc_nand_data);
 
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
+	if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
+		gpmc_nand_cs_info.config |= GPMC_DEVICESIZE_16;
 
-out_free_cs:
-	gpmc_cs_free(gpmc_nand_data->cs);
+	if (gpmc_nand_data->dev_ready)
+		gpmc_nand_cs_info.config |= GPMC_WAIT_READ_MON |
+						GPMC_WAIT_WRITE_MON;
 
-	return err;
+	return &gpmc_nand_info;
 }
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index 86e4d9c..30c61c9 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -36,10 +36,12 @@ struct omap_nand_platform_data {
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
1.7.10

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
