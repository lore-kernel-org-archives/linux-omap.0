From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v3 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver migration
Date: Thu, 21 Jun 2012 18:09:12 +0530
Message-ID: <c9fbc9345f72216d3d92e65ed39ca3101a459f46.1340281127.git.afzal@ti.com>
References: <cover.1340281127.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53143 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753593Ab2FUMyt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jun 2012 08:54:49 -0400
In-Reply-To: <cover.1340281127.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Reorganize gpmc-onenand initialization so that changes
required for gpmc driver migration can be made smooth.

Ensuring sync read/write are disabled in onenand cannot
be expected to work properly unless GPMC is setup, this
has been removed.

Refactor set_async_mode & set_sync_mode functions to
separate out timing calculation & actual configuration
(GPMC & OneNAND side).

Thanks to Jon for his suggestions.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

v3:
Refactor set_sync/async functions to separate out timing and
 configurations
v2:
Move ensuring that async mode in OneNAND has been setup from
 set_sync to setup function, improve commit message

 arch/arm/mach-omap2/gpmc-onenand.c |  134 +++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 65 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 8863e0a..789ca8c9 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/onenand_regs.h>
 #include <linux/io.h>
+#include <linux/err.h>
 
 #include <asm/mach/flash.h>
 
@@ -25,6 +26,7 @@
 
 #define	ONENAND_IO_SIZE	SZ_128K
 
+static int hf, vhf, sync_read, sync_write, latency;
 static struct omap_onenand_platform_data *gpmc_onenand_data;
 
 static struct resource gpmc_onenand_resource = {
@@ -38,11 +40,9 @@ static struct platform_device gpmc_onenand_device = {
 	.resource	= &gpmc_onenand_resource,
 };
 
-static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
+static struct gpmc_timings omap2_onenand_calc_async_timings(void)
 {
 	struct gpmc_timings t;
-	u32 reg;
-	int err;
 
 	const int t_cer = 15;
 	const int t_avdp = 12;
@@ -55,11 +55,6 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 	const int t_wpl = 40;
 	const int t_wph = 30;
 
-	/* Ensure sync read and sync write are disabled */
-	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
-	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
-	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
-
 	memset(&t, 0, sizeof(t));
 	t.sync_clk = 0;
 	t.cs_on = 0;
@@ -86,12 +81,21 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
 	t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
 
+	return t;
+}
+
+static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base,
+							struct gpmc_timings *t)
+{
+	u32 reg;
+	int err;
+
 	/* Configure GPMC for asynchronous read */
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
 			  GPMC_CONFIG1_DEVICESIZE_16 |
 			  GPMC_CONFIG1_MUXADDDATA);
 
-	err = gpmc_cs_set_timings(cs, &t);
+	err = gpmc_cs_set_timings(cs, t);
 	if (err)
 		return err;
 
@@ -103,8 +107,7 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 	return 0;
 }
 
-static void set_onenand_cfg(void __iomem *onenand_base, int latency,
-				int sync_read, int sync_write, int hf, int vhf)
+static void set_onenand_cfg(void __iomem *onenand_base)
 {
 	u32 reg;
 
@@ -172,9 +175,9 @@ static int omap2_onenand_get_freq(struct omap_onenand_platform_data *cfg,
 	return freq;
 }
 
-static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
-					void __iomem *onenand_base,
-					int *freq_ptr)
+static struct gpmc_timings
+omap2_onenand_calc_sync_timings(struct omap_onenand_platform_data *cfg,
+						int freq, bool clk_dep)
 {
 	struct gpmc_timings t;
 	const int t_cer  = 15;
@@ -184,28 +187,15 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	const int t_wpl  = 40;
 	const int t_wph  = 30;
 	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
-	int div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
-	int first_time = 0, hf = 0, vhf = 0, sync_read = 0, sync_write = 0;
-	int err, ticks_cez;
-	int cs = cfg->cs, freq = *freq_ptr;
-	u32 reg;
-	bool clk_dep = false;
+	int div, fclk_offset_ns, fclk_offset, gpmc_clk_ns;
+	int ticks_cez;
+	int cs = cfg->cs;
 
 	if (cfg->flags & ONENAND_SYNC_READ) {
 		sync_read = 1;
 	} else if (cfg->flags & ONENAND_SYNC_READWRITE) {
 		sync_read = 1;
 		sync_write = 1;
-	} else
-		return omap2_onenand_set_async_mode(cs, onenand_base);
-
-	if (!freq) {
-		/* Very first call freq is not known */
-		err = omap2_onenand_set_async_mode(cs, onenand_base);
-		if (err)
-			return err;
-		freq = omap2_onenand_get_freq(cfg, onenand_base, &clk_dep);
-		first_time = 1;
 	}
 
 	switch (freq) {
@@ -279,36 +269,16 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 		}
 	}
 
-	if (first_time)
-		set_onenand_cfg(onenand_base, latency,
-					sync_read, sync_write, hf, vhf);
+	/* Set synchronous read timings */
+	memset(&t, 0, sizeof(t));
 
 	if (div == 1) {
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
-		reg |= (1 << 7);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG2, reg);
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG3);
-		reg |= (1 << 7);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG3, reg);
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG4);
-		reg |= (1 << 7);
-		reg |= (1 << 23);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG4, reg);
-	} else {
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
-		reg &= ~(1 << 7);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG2, reg);
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG3);
-		reg &= ~(1 << 7);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG3, reg);
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG4);
-		reg &= ~(1 << 7);
-		reg &= ~(1 << 23);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG4, reg);
+		t.bool_timings.cs_extra_delay = true;
+		t.bool_timings.adv_extra_delay = true;
+		t.bool_timings.oe_extra_delay = true;
+		t.bool_timings.we_extra_delay = true;
 	}
 
-	/* Set synchronous read timings */
-	memset(&t, 0, sizeof(t));
 	t.sync_clk = min_gpmc_clk_period;
 	t.cs_on = 0;
 	t.adv_on = 0;
@@ -357,6 +327,17 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 		}
 	}
 
+	return t;
+}
+
+static int omap2_onenand_set_sync_mode(int cs, struct gpmc_timings *t,
+					void __iomem *onenand_base, int initial)
+{
+	int err;
+
+	if (initial)
+		set_onenand_cfg(onenand_base);
+
 	/* Configure GPMC for synchronous read */
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
 			  GPMC_CONFIG1_WRAPBURST_SUPP |
@@ -372,13 +353,11 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 			  GPMC_CONFIG1_DEVICETYPE_NOR |
 			  GPMC_CONFIG1_MUXADDDATA);
 
-	err = gpmc_cs_set_timings(cs, &t);
+	err = gpmc_cs_set_timings(cs, t);
 	if (err)
 		return err;
 
-	set_onenand_cfg(onenand_base, latency, sync_read, sync_write, hf, vhf);
-
-	*freq_ptr = freq;
+	set_onenand_cfg(onenand_base);
 
 	return 0;
 }
@@ -386,13 +365,38 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
 {
 	struct device *dev = &gpmc_onenand_device.dev;
+	struct gpmc_timings t;
+	int ret, first_time = 0, freq = *freq_ptr;
+	unsigned l = ONENAND_SYNC_READ | ONENAND_SYNC_READWRITE;
+	bool clk_dep = false;
+
+	t = omap2_onenand_calc_async_timings();
+	ret = omap2_onenand_set_async_mode(gpmc_onenand_data->cs,
+							onenand_base, &t);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(dev, "unable to set to async mode\n");
+		return ret;
+	}
+
+	if (!(gpmc_onenand_data->flags & l))
+		return 0;
+
+	/* setup sync mode */
+	if (!freq) {
+		/* Very first call freq is not known */
+		freq = omap2_onenand_get_freq(gpmc_onenand_data,
+						onenand_base, &clk_dep);
+		first_time = 1;
+	}
 
-	/* Set sync timings in GPMC */
-	if (omap2_onenand_set_sync_mode(gpmc_onenand_data, onenand_base,
-			freq_ptr) < 0) {
-		dev_err(dev, "Unable to set synchronous mode\n");
-		return -EINVAL;
+	t = omap2_onenand_calc_sync_timings(gpmc_onenand_data, freq, clk_dep);
+	ret = omap2_onenand_set_sync_mode(gpmc_onenand_data->cs, &t,
+						onenand_base, first_time);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(dev, "unable to set to sync mode\n");
+		return ret;
 	}
+	*freq_ptr = freq;
 
 	return 0;
 }
-- 
1.7.10.2

