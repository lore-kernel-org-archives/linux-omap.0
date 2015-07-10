From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/12] mtd: nand: omap: Move NAND write protect code from GPMC to NAND driver
Date: Fri, 10 Jul 2015 15:23:32 +0300
Message-ID: <1436531019-18088-6-git-send-email-rogerq@ti.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436531019-18088-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The write protect (WP) pin is only used for NAND devices. So move
the code into the NAND driver.

Get rid of gpmc_configure() as it is no longer used.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/gpmc-nand.c              |  4 ----
 drivers/memory/omap-gpmc.c                   | 30 ----------------------------
 drivers/mtd/nand/omap2.c                     | 23 +++++++++++++++++++++
 include/linux/omap-gpmc.h                    |  3 ---
 include/linux/platform_data/mtd-nand-omap2.h |  1 +
 5 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index ff578d4..9cb8ce6 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -117,10 +117,6 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 	if (err < 0)
 		goto out_free_cs;
 
-	err = gpmc_configure(GPMC_CONFIG_WP, 0);
-	if (err < 0)
-		goto out_free_cs;
-
 	if (!gpmc_hwecc_bch_capable(gpmc_nand_data->ecc_opt)) {
 		pr_err("omap2-nand: Unsupported NAND ECC scheme selected\n");
 		err = -EINVAL;
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index dd55a51..650f9b8 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -151,7 +151,6 @@
 
 #define GPMC_DEVICETYPE_NOR		0
 #define GPMC_DEVICETYPE_NAND		2
-#define GPMC_CONFIG_WRITEPROTECT	0x00000010
 #define WR_RD_PIN_MONITORING		0x00600000
 
 /* ECC commands */
@@ -987,35 +986,6 @@ void gpmc_cs_free(int cs)
 }
 EXPORT_SYMBOL(gpmc_cs_free);
 
-/**
- * gpmc_configure - write request to configure gpmc
- * @cmd: command type
- * @wval: value to write
- * @return status of the operation
- */
-int gpmc_configure(int cmd, int wval)
-{
-	u32 regval;
-
-	switch (cmd) {
-	case GPMC_CONFIG_WP:
-		regval = gpmc_read_reg(GPMC_CONFIG);
-		if (wval)
-			regval &= ~GPMC_CONFIG_WRITEPROTECT; /* WP is ON */
-		else
-			regval |= GPMC_CONFIG_WRITEPROTECT;  /* WP is OFF */
-		gpmc_write_reg(GPMC_CONFIG, regval);
-		break;
-
-	default:
-		pr_err("%s: command not supported\n", __func__);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(gpmc_configure);
-
 void gpmc_get_mem_resource(struct resource *res)
 {
 	res->start =  phys_base;
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 3d0f73c..25a3d05 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -140,6 +140,9 @@
 #define GPMC_IRQ_FIFOEVENT	BIT(0)
 #define GPMC_IRQ_TERMCOUNT	BIT(1)
 
+/* GPMC_CONFIG register bits */
+#define GPMC_CONFIG_WRITEPROTECT	BIT(4)
+
 /* GPMC register offsets */
 #define GPMC_REVISION		0x00
 #define GPMC_SYSCONFIG		0x10
@@ -215,6 +218,22 @@ struct omap_nand_info {
 };
 
 /**
+ * omap_nand_writeprotect - Control the WP line to the NAND chip
+ */
+static void omap_nand_writeprotect(struct omap_nand_info *info, bool on)
+{
+	u32 val;
+
+	val = readl(info->reg.gpmc_config);
+	if (on)
+		val &= GPMC_CONFIG_WRITEPROTECT; /* WP pin is active low */
+	else
+		val |= GPMC_CONFIG_WRITEPROTECT;
+
+	writel(val, info->reg.gpmc_config);
+}
+
+/**
  * omap_prefetch_enable - configures and starts prefetch transfer
  * @cs: cs (chip select) number
  * @fifo_th: fifo threshold to be used for read/ write
@@ -1713,6 +1732,7 @@ static void gpmc_update_nand_reg(struct omap_nand_info *info)
 	int cs = info->gpmc_cs;
 	void __iomem *gpmc_base = info->gpmc_base;
 
+	reg->gpmc_config = gpmc_base + GPMC_CONFIG;
 	reg->gpmc_status = gpmc_base + GPMC_STATUS;
 	reg->gpmc_irqstatus = gpmc_base + GPMC_IRQSTATUS;
 	reg->gpmc_irqenable = gpmc_base + GPMC_IRQENABLE;
@@ -2141,6 +2161,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 	nand_chip->ecc.layout = ecclayout;
 
 scan_tail:
+	/* turn off write protect */
+	omap_nand_writeprotect(info, false);
+
 	/* second phase scan */
 	if (nand_scan_tail(mtd)) {
 		err = -ENXIO;
diff --git a/include/linux/omap-gpmc.h b/include/linux/omap-gpmc.h
index 36f33ba..d13e172 100644
--- a/include/linux/omap-gpmc.h
+++ b/include/linux/omap-gpmc.h
@@ -10,8 +10,6 @@
 #include <linux/platform_data/gpmc-omap.h>
 #include <linux/ioport.h>
 
-#define GPMC_CONFIG_WP		0x00000005
-
 extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
 			     struct gpmc_settings *gpmc_s,
 			     struct gpmc_device_timings *dev_t);
@@ -31,7 +29,6 @@ extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t,
 extern int gpmc_cs_program_settings(int cs, struct gpmc_settings *p);
 extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
-extern int gpmc_configure(int cmd, int wval);
 extern void gpmc_read_settings_dt(struct device_node *np,
 				  struct gpmc_settings *p);
 
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 4427f92..e9b16b5 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -45,6 +45,7 @@ enum omap_ecc {
 };
 
 struct gpmc_nand_regs {
+	void __iomem	*gpmc_config;
 	void __iomem	*gpmc_status;
 	void __iomem	*gpmc_irqstatus;
 	void __iomem	*gpmc_irqenable;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
