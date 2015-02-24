From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 7/8 v2] ARM OMAP2+ GPMC: calculate GPMCFCLKDIVIDER based on WAITMONITORINGTIME
Date: Tue, 24 Feb 2015 21:05:29 +0100
Message-ID: <1424808331-17592-7-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

The WAITMONITORINGTIME is expressed as a number of GPMC_CLK clock cycles,
even though the access is defined as asynchronous, and no GPMC_CLK clock
is provided to the external device. Still, GPMCFCLKDIVIDER is used as a divider
for the GPMC clock, so it must be programmed to define the
correct WAITMONITORINGTIME delay.

Calculate GPMCFCLKDIVIDER independent of gpmc,sync-clk-ps in DT for
truly asynchronous accesses, i.e. both read and write asynchronous.

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 arch/arm/mach-omap2/gpmc-nand.c    | 17 ++++-----
 arch/arm/mach-omap2/gpmc-onenand.c |  4 +--
 drivers/memory/omap-gpmc.c         | 74 ++++++++++++++++++++++++++++++++++----
 include/linux/omap-gpmc.h          |  2 +-
 4 files changed, 80 insertions(+), 17 deletions(-)

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
 
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index a6abaf0..9cf8d21 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -139,6 +139,8 @@
 #define GPMC_CONFIG1_WAIT_READ_MON      (1 << 22)
 #define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
 #define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
+/** WAITMONITORINGTIME Max Ticks */
+#define GPMC_CONFIG1_WAIT_MON_TIME_MAX  2
 #define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
 #define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
 #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
@@ -511,13 +513,41 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 			t->field, #field) < 0)			\
 		return -1
 
+/**
+ * gpmc_calc_waitmonitoring_divider - calculate proper GPMCFCLKDIVIDER based on WAITMONITORINGTIME
+ * @wait_monitoring WAITMONITORINGTIME in ns.
+ * @return          -1 on failure to scale, else proper divider > 0.
+ * @note            WAITMONITORINGTIME will be _at least_ as long as desired.
+ *                  i.e. read timings should be kept            -> don't sample bus too early
+ *                  while write timings should work out as well -> data is longer on bus
+ */
+static int gpmc_calc_waitmonitoring_divider(unsigned int wait_monitoring)
+{
+
+	int div = gpmc_ns_to_ticks(wait_monitoring);
+
+	div += GPMC_CONFIG1_WAIT_MON_TIME_MAX - 1;
+	div /= GPMC_CONFIG1_WAIT_MON_TIME_MAX;
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
@@ -526,7 +556,13 @@ int gpmc_calc_divider(unsigned int sync_clk)
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
@@ -536,6 +572,32 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	if (div < 0)
 		return div;
 
+	/* 
+	 * See if we need to change the divider for waitmonitoringtime.
+	 * 
+	 * If DT contains sync-clk-ps for truly asynchronous accesses,
+	 * ignore it as long as waitmonitoringtime is used.
+	 * 
+	 * This protects mixed synchronous and asynchronous devices,
+	 * i.e. must not change div to scale async waitmonitoringtime or
+	 * sync accesses would be broken.
+	 * 
+	 * We raise an error later if waitmonitoringtime does not fit.
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
@@ -1793,7 +1855,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
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
