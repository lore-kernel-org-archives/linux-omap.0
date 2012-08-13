From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/9] ARM/ASoC: omap-mcbsp: Move OMAP2+ clock parenting code to ASoC driver
Date: Mon, 13 Aug 2012 17:22:40 +0300
Message-ID: <1344867768-26335-2-git-send-email-peter.ujfalusi@ti.com>
References: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:42234 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751817Ab2HMOWi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 10:22:38 -0400
Received: by obbwd20 with SMTP id wd20so7417897obb.9
        for <linux-omap@vger.kernel.org>; Mon, 13 Aug 2012 07:22:37 -0700 (PDT)
In-Reply-To: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Move the McBSP CLKS re-parenting code to ASoC driver from
arch/arm/mach-omap2.
The call fort the re-parenting has been already limited to OMAP2+ SoC in
the ASoC driver. There is no longer need to have callback function for it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap2/mcbsp.c             |   40 -------------------------------
 arch/arm/plat-omap/include/plat/mcbsp.h |    1 -
 sound/soc/omap/mcbsp.c                  |   31 ++++++++++++++++++++----
 3 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 577cb77..ebc801e 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -101,45 +101,6 @@ static int omap4_mcbsp4_mux_rx_clk(struct device *dev, const char *signal,
 	return 0;
 }
 
-/* McBSP CLKS source switching function */
-static int omap2_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
-				   const char *src)
-{
-	struct clk *fck_src;
-	char *fck_src_name;
-	int r;
-
-	if (!strcmp(src, "clks_ext"))
-		fck_src_name = "pad_fck";
-	else if (!strcmp(src, "clks_fclk"))
-		fck_src_name = "prcm_fck";
-	else
-		return -EINVAL;
-
-	fck_src = clk_get(dev, fck_src_name);
-	if (IS_ERR_OR_NULL(fck_src)) {
-		pr_err("omap-mcbsp: %s: could not clk_get() %s\n", "clks",
-		       fck_src_name);
-		return -EINVAL;
-	}
-
-	pm_runtime_put_sync(dev);
-
-	r = clk_set_parent(clk, fck_src);
-	if (IS_ERR_VALUE(r)) {
-		pr_err("omap-mcbsp: %s: could not clk_set_parent() to %s\n",
-		       "clks", fck_src_name);
-		clk_put(fck_src);
-		return -EINVAL;
-	}
-
-	pm_runtime_get_sync(dev);
-
-	clk_put(fck_src);
-
-	return 0;
-}
-
 static int omap3_enable_st_clock(unsigned int id, bool enable)
 {
 	unsigned int w;
@@ -181,7 +142,6 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		pdata->reg_size = 4;
 		pdata->has_ccr = true;
 	}
-	pdata->set_clk_src = omap2_mcbsp_set_clk_src;
 
 	/* On OMAP2/3 the McBSP1 port has 6 pin configuration */
 	if (id == 1 && oh->class->rev < MCBSP_CONFIG_TYPE4)
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 1881412..0a7d5ca 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -47,7 +47,6 @@ struct omap_mcbsp_platform_data {
 	bool has_wakeup; /* Wakeup capability */
 	bool has_ccr; /* Transceiver has configuration control registers */
 	int (*enable_st_clock)(unsigned int, bool);
-	int (*set_clk_src)(struct device *dev, struct clk *clk, const char *src);
 	int (*mux_signal)(struct device *dev, const char *signal, const char *src);
 };
 
diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index d33c48b..d901fc0 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/mcbsp.h>
 
@@ -726,19 +727,39 @@ void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int tx, int rx)
 
 int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 {
+	struct clk *fck_src;
 	const char *src;
+	int r;
 
 	if (fck_src_id == MCBSP_CLKS_PAD_SRC)
-		src = "clks_ext";
+		src = "pad_fck";
 	else if (fck_src_id == MCBSP_CLKS_PRCM_SRC)
-		src = "clks_fclk";
+		src = "prcm_fck";
 	else
 		return -EINVAL;
 
-	if (mcbsp->pdata->set_clk_src)
-		return mcbsp->pdata->set_clk_src(mcbsp->dev, mcbsp->fclk, src);
-	else
+	fck_src = clk_get(mcbsp->dev, src);
+	if (IS_ERR_OR_NULL(fck_src)) {
+		dev_err(mcbsp->dev, "CLKS: could not clk_get() %s\n", src);
 		return -EINVAL;
+	}
+
+	pm_runtime_put_sync(mcbsp->dev);
+
+	r = clk_set_parent(mcbsp->fclk, fck_src);
+	if (r) {
+		dev_err(mcbsp->dev, "CLKS: could not clk_set_parent() to %s\n",
+			src);
+		clk_put(fck_src);
+		return r;
+	}
+
+	pm_runtime_get_sync(mcbsp->dev);
+
+	clk_put(fck_src);
+
+	return 0;
+
 }
 
 int omap_mcbsp_6pin_src_mux(struct omap_mcbsp *mcbsp, u8 mux)
-- 
1.7.8.6

