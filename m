From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 6/8] ARM OMAP2+ GPMC: calculate GPMCFCLKDIVIDER based on WAITMONITORINGTIME
Date: Thu, 26 Feb 2015 15:45:54 +0100
Message-ID: <1424961956-29353-7-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smarthost.TechFak.Uni-Bielefeld.DE ([129.70.137.17]:35697 "EHLO
	smarthost.TechFak.Uni-Bielefeld.DE" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932431AbbBZOq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 09:46:26 -0500
In-Reply-To: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, rogerq@ti.com, linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>

The WAITMONITORINGTIME is expressed as a number of GPMC_CLK clock cycles,
even though the access is defined as asynchronous, and no GPMC_CLK clock
is provided to the external device. Still, GPMCFCLKDIVIDER is used as a divider
for the GPMC clock, so it must be programmed to define the
correct WAITMONITORINGTIME delay.

Calculate GPMCFCLKDIVIDER independent of gpmc,sync-clk-ps in DT for
pure asynchronous accesses, i.e. both read and write asynchronous.

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 arch/arm/mach-omap2/gpmc-nand.c    | 17 ++++----
 arch/arm/mach-omap2/gpmc-onenand.c |  4 +-
 arch/arm/mach-omap2/usb-tusb6010.c |  4 +-
 drivers/memory/omap-gpmc.c         | 82 ++++++++++++++++++++++++++++++++++----
 include/linux/omap-gpmc.h          |  2 +-
 5 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index d5951b1..e863a59 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -96,14 +96,6 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 	gpmc_nand_res[1].start = gpmc_get_client_irq(GPMC_IRQ_FIFOEVENTENABLE);
 	gpmc_nand_res[2].start = gpmc_get_client_irq(GPMC_IRQ_COUNT_EVENT);
 
-	if (gpmc_t) {
-		err = gpmc_cs_set_timings(gpmc_nand_data->cs, gpmc_t);
-		if (err < 0) {
-			pr_err("omap2-gpmc: Unable to set gpmc timings: %d\n", err);
-			return err;
-		}
-	}
-
 	memset(&s, 0, sizeof(struct gpmc_settings));
 	if (gpmc_nand_data->of_node)
 		gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
@@ -111,6 +103,15 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 		gpmc_set_legacy(gpmc_nand_data, &s);
 
 	s.device_nand = true;
+
+	if (gpmc_t) {
+		err = gpmc_cs_set_timings(gpmc_nand_data->cs, gpmc_t, &s);
+		if (err < 0) {
+			pr_err("omap2-gpmc: Unable to set gpmc timings: %d\n", err);
+			return err;
+		}
+	}
+
 	err = gpmc_cs_program_settings(gpmc_nand_data->cs, &s);
 	if (err < 0)
 		goto out_free_cs;
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 53d197e..f899e77 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -293,7 +293,7 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 	if (ret < 0)
 		return ret;
 
-	ret = gpmc_cs_set_timings(gpmc_onenand_data->cs, &t);
+	ret = gpmc_cs_set_timings(gpmc_onenand_data->cs, &t, &onenand_async);
 	if (ret < 0)
 		return ret;
 
@@ -331,7 +331,7 @@ static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
 	if (ret < 0)
 		return ret;
 
-	ret = gpmc_cs_set_timings(gpmc_onenand_data->cs, &t);
+	ret = gpmc_cs_set_timings(gpmc_onenand_data->cs, &t, &onenand_sync);
 	if (ret < 0)
 		return ret;
 
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 8333400..e554d9e 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -71,7 +71,7 @@ static int tusb_set_async_mode(unsigned sysclk_ps)
 
 	gpmc_calc_timings(&t, &tusb_async, &dev_t);
 
-	return gpmc_cs_set_timings(async_cs, &t);
+	return gpmc_cs_set_timings(async_cs, &t, &tusb_async);
 }
 
 static int tusb_set_sync_mode(unsigned sysclk_ps)
@@ -98,7 +98,7 @@ static int tusb_set_sync_mode(unsigned sysclk_ps)
 
 	gpmc_calc_timings(&t, &tusb_sync, &dev_t);
 
-	return gpmc_cs_set_timings(sync_cs, &t);
+	return gpmc_cs_set_timings(sync_cs, &t, &tusb_sync);
 }
 
 /* tusb driver calls this when it changes the chip's clocking */
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 4139f0d..d71ea05 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -138,7 +138,9 @@
 #define GPMC_CONFIG1_PAGE_LEN(val)      ((val & 3) << 23)
 #define GPMC_CONFIG1_WAIT_READ_MON      (1 << 22)
 #define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
-#define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
+#define GPMC_CONFIG1_WAIT_MON_TIME(val) ((val & 3) << 18)
+/** WAITMONITORINGTIME Max Ticks */
+#define GPMC_CONFIG1_WAITMONITORINGTIME_MAX  2
 #define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
 #define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
 #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
@@ -515,13 +517,46 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 			t->field, #field) < 0)			\
 		return -1
 
+/**
+ * gpmc_calc_waitmonitoring_divider - calculate proper GPMCFCLKDIVIDER based on WAITMONITORINGTIME
+ * @wait_monitoring WAITMONITORINGTIME in ns.
+ * @return          -1 on failure to scale, else proper divider > 0.
+ * @note            WAITMONITORINGTIME will be _at least_ as long as desired.
+ *                  i.e. read timings should be kept            -> don't sample bus too early
+ *                  while write timings should work out as well -> data is longer on bus
+ *                  Formula:
+ *                  gpmc_clk_div + 1 = ceil(ceil(waitmonitoringtime_ns / gpmc_fclk_ns)
+ *                                     / waitmonitoring_ticks)
+ *                  WAITMONITORINGTIME resulting in 0 or 1 tick with div = 1 are caught by
+ *                  div <= 0 check.
+ */
+static int gpmc_calc_waitmonitoring_divider(unsigned int wait_monitoring)
+{
+
+	int div = gpmc_ns_to_ticks(wait_monitoring);
+
+	div += GPMC_CONFIG1_WAITMONITORINGTIME_MAX - 1;
+	div /= GPMC_CONFIG1_WAITMONITORINGTIME_MAX;
+
+	if (div > 4)
+		return -1;
+	if (div <= 0)
+		div = 1;
+
+	return div;
+
+}
+
+/**
+ * gpmc_calc_divider - calculate GPMC_FCLK divider for sync_clk GPMC_CLK period.
+ * @sync_clk GPMC_CLK period in ps.
+ * @return   Returns at least 1 if GPMC_FCLK can be divided to GPMC_CLK.
+ *           Else, returns -1.
+ */
 int gpmc_calc_divider(unsigned int sync_clk)
 {
-	int div;
-	u32 l;
+	int div = gpmc_ps_to_ticks(sync_clk);
 
-	l = sync_clk + (gpmc_get_fclk_period() - 1);
-	div = l / gpmc_get_fclk_period();
 	if (div > 4)
 		return -1;
 	if (div <= 0)
@@ -530,7 +565,13 @@ int gpmc_calc_divider(unsigned int sync_clk)
 	return div;
 }
 
-int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
+/**
+ * gpmc_cs_set_timings - program timing parameters for Chip Select Region.
+ * @cs   Chip Select Region.
+ * @t    GPMC timing parameters.
+ * @s    GPMC timing settings.
+ */
+int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t, const struct gpmc_settings *s)
 {
 	int div;
 	u32 l;
@@ -540,6 +581,33 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	if (div < 0)
 		return div;
 
+	/*
+	 * See if we need to change the divider for waitmonitoringtime.
+	 *
+	 * Calculate GPMCFCLKDIVIDER independent of gpmc,sync-clk-ps in DT for
+	 * pure asynchronous accesses, i.e. both read and write asynchronous.
+	 * However, only do so if WAITMONITORINGTIME is actually used, i.e.
+	 * either WAITREADMONITORING or WAITWRITEMONITORING is set.
+	 *
+	 * This statement must not change div to scale async WAITMONITORINGTIME to
+	 * protect mixed synchronous and asynchronous accesses.
+	 *
+	 * We raise an error later if WAITMONITORINGTIME does not fit.
+	 */
+	if (!s->sync_read && !s->sync_write &&
+	    (s->wait_on_read || s->wait_on_write)
+	   ) {
+
+		div = gpmc_calc_waitmonitoring_divider(t->wait_monitoring);
+		if (div < 0) {
+			pr_err("%s: waitmonitoringtime %3d ns too large for greatest gpmcfclkdivider.\n",
+			       __func__,
+			       t->wait_monitoring
+			       );
+			return -1;
+		}
+	}
+
 	GPMC_SET_ONE(GPMC_CS_CONFIG2,  0,  3, cs_on);
 	GPMC_SET_ONE(GPMC_CS_CONFIG2,  8, 12, cs_rd_off);
 	GPMC_SET_ONE(GPMC_CS_CONFIG2, 16, 20, cs_wr_off);
@@ -1797,7 +1865,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	if (ret < 0)
 		goto err;
 
-	ret = gpmc_cs_set_timings(cs, &gpmc_t);
+	ret = gpmc_cs_set_timings(cs, &gpmc_t, &gpmc_s);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to set gpmc timings for: %s\n",
 			child->name);
diff --git a/include/linux/omap-gpmc.h b/include/linux/omap-gpmc.h
index c2080ee..9301437 100644
--- a/include/linux/omap-gpmc.h
+++ b/include/linux/omap-gpmc.h
@@ -163,7 +163,7 @@ extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
 
 extern void gpmc_cs_write_reg(int cs, int idx, u32 val);
 extern int gpmc_calc_divider(unsigned int sync_clk);
-extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
+extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t, const struct gpmc_settings *s);
 extern int gpmc_cs_program_settings(int cs, struct gpmc_settings *p);
 extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
-- 
2.3.0

