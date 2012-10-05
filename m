From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v8 4/6] ARM: OMAP2+: onenand: refactor for clarity
Date: Fri, 5 Oct 2012 21:09:35 +0530
Message-ID: <10661a7dddaf69d67efb2f4dfcf83ff86f2e9a74.1349444936.git.afzal@ti.com>
References: <cover.1349444935.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48465 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638Ab2JEPjp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 11:39:45 -0400
In-Reply-To: <cover.1349444935.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Refactor set_async_mode & set_sync_mode functions to
separate out timing calculation & actual configuration
(GPMC & OneNAND side).

Thanks to Jon for his suggestions.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Reviewed-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c | 174 +++++++++++++++++++++++--------------
 1 file changed, 109 insertions(+), 65 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 3b61544..e1328f5 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -16,6 +16,7 @@
 #include <linux/mtd/onenand_regs.h>
 #include <linux/io.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
+#include <linux/err.h>
 
 #include <asm/mach/flash.h>
 
@@ -25,6 +26,14 @@
 
 #define	ONENAND_IO_SIZE	SZ_128K
 
+#define	ONENAND_FLAG_SYNCREAD	(1 << 0)
+#define	ONENAND_FLAG_SYNCWRITE	(1 << 1)
+#define	ONENAND_FLAG_HF		(1 << 2)
+#define	ONENAND_FLAG_VHF	(1 << 3)
+
+static unsigned onenand_flags;
+static unsigned latency;
+
 static struct omap_onenand_platform_data *gpmc_onenand_data;
 
 static struct resource gpmc_onenand_resource = {
@@ -38,11 +47,9 @@ static struct platform_device gpmc_onenand_device = {
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
@@ -55,11 +62,6 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
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
@@ -86,25 +88,30 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
 	t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
 
+	return t;
+}
+
+static int gpmc_set_async_mode(int cs, struct gpmc_timings *t)
+{
 	/* Configure GPMC for asynchronous read */
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
 			  GPMC_CONFIG1_DEVICESIZE_16 |
 			  GPMC_CONFIG1_MUXADDDATA);
 
-	err = gpmc_cs_set_timings(cs, &t);
-	if (err)
-		return err;
+	return gpmc_cs_set_timings(cs, t);
+}
+
+static void omap2_onenand_set_async_mode(void __iomem *onenand_base)
+{
+	u32 reg;
 
 	/* Ensure sync read and sync write are disabled */
 	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
 	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
 	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
-
-	return 0;
 }
 
-static void set_onenand_cfg(void __iomem *onenand_base, int latency,
-				int sync_read, int sync_write, int hf, int vhf)
+static void set_onenand_cfg(void __iomem *onenand_base)
 {
 	u32 reg;
 
@@ -112,19 +119,19 @@ static void set_onenand_cfg(void __iomem *onenand_base, int latency,
 	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
 	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
 		ONENAND_SYS_CFG1_BL_16;
-	if (sync_read)
+	if (onenand_flags & ONENAND_FLAG_SYNCREAD)
 		reg |= ONENAND_SYS_CFG1_SYNC_READ;
 	else
 		reg &= ~ONENAND_SYS_CFG1_SYNC_READ;
-	if (sync_write)
+	if (onenand_flags & ONENAND_FLAG_SYNCWRITE)
 		reg |= ONENAND_SYS_CFG1_SYNC_WRITE;
 	else
 		reg &= ~ONENAND_SYS_CFG1_SYNC_WRITE;
-	if (hf)
+	if (onenand_flags & ONENAND_FLAG_HF)
 		reg |= ONENAND_SYS_CFG1_HF;
 	else
 		reg &= ~ONENAND_SYS_CFG1_HF;
-	if (vhf)
+	if (onenand_flags & ONENAND_FLAG_VHF)
 		reg |= ONENAND_SYS_CFG1_VHF;
 	else
 		reg &= ~ONENAND_SYS_CFG1_VHF;
@@ -172,9 +179,9 @@ static int omap2_onenand_get_freq(struct omap_onenand_platform_data *cfg,
 	return freq;
 }
 
-static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
-					void __iomem *onenand_base,
-					int *freq_ptr)
+static struct gpmc_timings
+omap2_onenand_calc_sync_timings(struct omap_onenand_platform_data *cfg,
+				int freq, bool clk_dep)
 {
 	struct gpmc_timings t;
 	const int t_cer  = 15;
@@ -184,29 +191,14 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	const int t_wpl  = 40;
 	const int t_wph  = 30;
 	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
-	int div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
-	int first_time = 0, hf = 0, vhf = 0, sync_read = 0, sync_write = 0;
-	int err, ticks_cez;
-	int cs = cfg->cs, freq = *freq_ptr;
-	u32 reg;
-	bool clk_dep = false;
-
-	if (cfg->flags & ONENAND_SYNC_READ) {
-		sync_read = 1;
-	} else if (cfg->flags & ONENAND_SYNC_READWRITE) {
-		sync_read = 1;
-		sync_write = 1;
-	} else
-		return omap2_onenand_set_async_mode(cs, onenand_base);
+	int div, fclk_offset_ns, fclk_offset, gpmc_clk_ns;
+	int ticks_cez;
+	int cs = cfg->cs;
 
-	if (!freq) {
-		/* Very first call freq is not known */
-		err = omap2_onenand_set_async_mode(cs, onenand_base);
-		if (err)
-			return err;
-		freq = omap2_onenand_get_freq(cfg, onenand_base, &clk_dep);
-		first_time = 1;
-	}
+	if (cfg->flags & ONENAND_SYNC_READ)
+		onenand_flags = ONENAND_FLAG_SYNCREAD;
+	else if (cfg->flags & ONENAND_SYNC_READWRITE)
+		onenand_flags = ONENAND_FLAG_SYNCREAD | ONENAND_FLAG_SYNCWRITE;
 
 	switch (freq) {
 	case 104:
@@ -244,19 +236,23 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 		t_ach   = 9;
 		t_aavdh = 7;
 		t_rdyo  = 15;
-		sync_write = 0;
+		onenand_flags &= ~ONENAND_FLAG_SYNCWRITE;
 		break;
 	}
 
 	div = gpmc_cs_calc_divider(cs, min_gpmc_clk_period);
 	gpmc_clk_ns = gpmc_ticks_to_ns(div);
 	if (gpmc_clk_ns < 15) /* >66Mhz */
-		hf = 1;
+		onenand_flags |= ONENAND_FLAG_HF;
+	else
+		onenand_flags &= ~ONENAND_FLAG_HF;
 	if (gpmc_clk_ns < 12) /* >83Mhz */
-		vhf = 1;
-	if (vhf)
+		onenand_flags |= ONENAND_FLAG_VHF;
+	else
+		onenand_flags &= ~ONENAND_FLAG_VHF;
+	if (onenand_flags & ONENAND_FLAG_VHF)
 		latency = 8;
-	else if (hf)
+	else if (onenand_flags & ONENAND_FLAG_HF)
 		latency = 6;
 	else if (gpmc_clk_ns >= 25) /* 40 MHz*/
 		latency = 3;
@@ -279,9 +275,8 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 		}
 	}
 
-	if (first_time)
-		set_onenand_cfg(onenand_base, latency,
-					sync_read, sync_write, hf, vhf);
+	/* Set synchronous read timings */
+	memset(&t, 0, sizeof(t));
 
 	if (div == 1) {
 		t.bool_timings.cs_extra_delay = true;
@@ -290,8 +285,6 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 		t.bool_timings.we_extra_delay = true;
 	}
 
-	/* Set synchronous read timings */
-	memset(&t, 0, sizeof(t));
 	t.sync_clk = min_gpmc_clk_period;
 	t.cs_on = 0;
 	t.adv_on = 0;
@@ -315,7 +308,7 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	t.clk_activation = fclk_offset_ns;
 
 	/* Write */
-	if (sync_write) {
+	if (onenand_flags & ONENAND_FLAG_SYNCWRITE) {
 		t.adv_wr_off = t.adv_rd_off;
 		t.we_on  = 0;
 		t.we_off = t.cs_rd_off;
@@ -340,6 +333,14 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 		}
 	}
 
+	return t;
+}
+
+static int gpmc_set_sync_mode(int cs, struct gpmc_timings *t)
+{
+	unsigned sync_read = onenand_flags & ONENAND_FLAG_SYNCREAD;
+	unsigned sync_write = onenand_flags & ONENAND_FLAG_SYNCWRITE;
+
 	/* Configure GPMC for synchronous read */
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
 			  GPMC_CONFIG1_WRAPBURST_SUPP |
@@ -355,11 +356,47 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 			  GPMC_CONFIG1_DEVICETYPE_NOR |
 			  GPMC_CONFIG1_MUXADDDATA);
 
-	err = gpmc_cs_set_timings(cs, &t);
-	if (err)
-		return err;
+	return gpmc_cs_set_timings(cs, t);
+}
+
+static int omap2_onenand_setup_async(void __iomem *onenand_base)
+{
+	struct gpmc_timings t;
+	int ret;
+
+	omap2_onenand_set_async_mode(onenand_base);
+
+	t = omap2_onenand_calc_async_timings();
+
+	ret = gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
+	omap2_onenand_set_async_mode(onenand_base);
+
+	return 0;
+}
+
+static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
+{
+	int ret, freq = *freq_ptr;
+	struct gpmc_timings t;
+	bool clk_dep = false;
+
+	if (!freq) {
+		/* Very first call freq is not known */
+		freq = omap2_onenand_get_freq(gpmc_onenand_data,
+						onenand_base, &clk_dep);
+		set_onenand_cfg(onenand_base);
+	}
+
+	t = omap2_onenand_calc_sync_timings(gpmc_onenand_data, freq, clk_dep);
 
-	set_onenand_cfg(onenand_base, latency, sync_read, sync_write, hf, vhf);
+	ret = gpmc_set_sync_mode(gpmc_onenand_data->cs, &t);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
+	set_onenand_cfg(onenand_base);
 
 	*freq_ptr = freq;
 
@@ -369,15 +406,22 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
 {
 	struct device *dev = &gpmc_onenand_device.dev;
+	unsigned l = ONENAND_SYNC_READ | ONENAND_SYNC_READWRITE;
+	int ret;
 
-	/* Set sync timings in GPMC */
-	if (omap2_onenand_set_sync_mode(gpmc_onenand_data, onenand_base,
-			freq_ptr) < 0) {
-		dev_err(dev, "Unable to set synchronous mode\n");
-		return -EINVAL;
+	ret = omap2_onenand_setup_async(onenand_base);
+	if (ret) {
+		dev_err(dev, "unable to set to async mode\n");
+		return ret;
 	}
 
-	return 0;
+	if (!(gpmc_onenand_data->flags & l))
+		return 0;
+
+	ret = omap2_onenand_setup_sync(onenand_base, freq_ptr);
+	if (ret)
+		dev_err(dev, "unable to set to sync mode\n");
+	return ret;
 }
 
 void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
-- 
1.7.12

