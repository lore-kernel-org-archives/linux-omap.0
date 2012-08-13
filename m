From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Date: Mon, 13 Aug 2012 17:29:36 +0530
Message-ID: <1344859176-4512-1-git-send-email-cmahapatra@ti.com>
References: <1344425899-28267-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58687 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653Ab2HMMCy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 08:02:54 -0400
In-Reply-To: <1344425899-28267-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

All the cpu_is checks have been moved to dss_init_features function providing a
much more generic and cleaner interface. The OMAP version and revision specific
initializations in various functions are cleaned and the necessary data are
moved to dss_features structure which is local to dss.c.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dss.c |  115 ++++++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 41 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 7b1c6ac..6ab236e 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -31,6 +31,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/dma-mapping.h>
 
 #include <video/omapdss.h>
 
@@ -65,6 +66,13 @@ struct dss_reg {
 static int dss_runtime_get(void);
 static void dss_runtime_put(void);
 
+struct dss_features {
+	u16 fck_div_max;
+	int factor;
+	char *clk_name;
+	bool (*check_cinfo_fck) (void);
+};
+
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
@@ -83,6 +91,8 @@ static struct {
 
 	bool		ctx_valid;
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
+
+	const struct dss_features *feat;
 } dss;
 
 static const char * const dss_generic_clk_source_names[] = {
@@ -91,6 +101,30 @@ static const char * const dss_generic_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_FCK",
 };
 
+static const struct __initdata dss_features omap2_dss_features = {
+	.fck_div_max		=	16,
+	.factor			=	2,
+	.clk_name		=	NULL,
+};
+
+static const struct __initdata dss_features omap34_dss_features = {
+	.fck_div_max		=	16,
+	.factor			=	2,
+	.clk_name		=	"dpll4_m4_ck",
+};
+
+static const struct __initdata dss_features omap36_dss_features = {
+	.fck_div_max		=	32,
+	.factor			=	1,
+	.clk_name		=	"dpll4_m4_ck",
+};
+
+static const struct __initdata dss_features omap4_dss_features = {
+	.fck_div_max		=	32,
+	.factor			=	1,
+	.clk_name		=	"dpll_per_m5x2_ck",
+};
+
 static inline void dss_write_reg(const struct dss_reg idx, u32 val)
 {
 	__raw_writel(val, dss.base + idx.idx);
@@ -236,7 +270,6 @@ const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src)
 	return dss_generic_clk_source_names[clk_src];
 }
 
-
 void dss_dump_clocks(struct seq_file *s)
 {
 	unsigned long dpll4_ck_rate;
@@ -259,18 +292,10 @@ void dss_dump_clocks(struct seq_file *s)
 
 		seq_printf(s, "dpll4_ck %lu\n", dpll4_ck_rate);
 
-		if (cpu_is_omap3630() || cpu_is_omap44xx())
-			seq_printf(s, "%s (%s) = %lu / %lu  = %lu\n",
-					fclk_name, fclk_real_name,
-					dpll4_ck_rate,
-					dpll4_ck_rate / dpll4_m4_ck_rate,
-					fclk_rate);
-		else
-			seq_printf(s, "%s (%s) = %lu / %lu * 2 = %lu\n",
-					fclk_name, fclk_real_name,
-					dpll4_ck_rate,
-					dpll4_ck_rate / dpll4_m4_ck_rate,
-					fclk_rate);
+		seq_printf(s, "%s (%s) = %lu / %lu * %d  = %lu\n",
+				fclk_name, fclk_real_name, dpll4_ck_rate,
+				dpll4_ck_rate / dpll4_m4_ck_rate,
+				dss.feat->factor, fclk_rate);
 	} else {
 		seq_printf(s, "%s (%s) = %lu\n",
 				fclk_name, fclk_real_name,
@@ -470,7 +495,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 
 	unsigned long fck, max_dss_fck;
 
-	u16 fck_div, fck_div_max = 16;
+	u16 fck_div;
 
 	int match = 0;
 	int min_fck_per_pck;
@@ -480,9 +505,8 @@ int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
 	fck = clk_get_rate(dss.dss_clk);
-	if (req_pck == dss.cache_req_pck &&
-			((cpu_is_omap34xx() && prate == dss.cache_prate) ||
-			 dss.cache_dss_cinfo.fck == fck)) {
+	if (req_pck == dss.cache_req_pck && prate == dss.cache_prate &&
+		dss.cache_dss_cinfo.fck == fck) {
 		DSSDBG("dispc clock info found from cache.\n");
 		*dss_cinfo = dss.cache_dss_cinfo;
 		*dispc_cinfo = dss.cache_dispc_cinfo;
@@ -519,16 +543,10 @@ retry:
 
 		goto found;
 	} else {
-		if (cpu_is_omap3630() || cpu_is_omap44xx())
-			fck_div_max = 32;
-
-		for (fck_div = fck_div_max; fck_div > 0; --fck_div) {
+		for (fck_div = dss.feat->fck_div_max; fck_div > 0; --fck_div) {
 			struct dispc_clock_info cur_dispc;
 
-			if (fck_div_max == 32)
-				fck = prate / fck_div;
-			else
-				fck = prate / fck_div * 2;
+			fck = prate / fck_div * dss.feat->factor;
 
 			if (fck > max_dss_fck)
 				continue;
@@ -633,22 +651,11 @@ static int dss_get_clocks(void)
 
 	dss.dss_clk = clk;
 
-	if (cpu_is_omap34xx()) {
-		clk = clk_get(NULL, "dpll4_m4_ck");
-		if (IS_ERR(clk)) {
-			DSSERR("Failed to get dpll4_m4_ck\n");
-			r = PTR_ERR(clk);
-			goto err;
-		}
-	} else if (cpu_is_omap44xx()) {
-		clk = clk_get(NULL, "dpll_per_m5x2_ck");
-		if (IS_ERR(clk)) {
-			DSSERR("Failed to get dpll_per_m5x2_ck\n");
-			r = PTR_ERR(clk);
-			goto err;
-		}
-	} else { /* omap24xx */
-		clk = NULL;
+	clk = clk_get(NULL, dss.feat->clk_name);
+	if (IS_ERR(clk)) {
+		DSSERR("Failed to get %s\n", dss.feat->clk_name);
+		r = PTR_ERR(clk);
+		goto err;
 	}
 
 	dss.dpll4_m4_ck = clk;
@@ -704,6 +711,26 @@ void dss_debug_dump_clocks(struct seq_file *s)
 }
 #endif
 
+static int __init dss_init_features(struct device *dev)
+{
+	dss.feat = devm_kzalloc(dev, sizeof(*dss.feat), GFP_KERNEL);
+	if (!dss.feat) {
+		dev_err(dev, "Failed to allocate local DSS Features\n");
+		return -ENOMEM;
+	}
+
+	if (cpu_is_omap24xx())
+		dss.feat = &omap2_dss_features;
+	else if (cpu_is_omap34xx())
+		dss.feat = &omap34_dss_features;
+	else if (cpu_is_omap3630())
+		dss.feat = &omap36_dss_features;
+	else
+		dss.feat = &omap4_dss_features;
+
+	return 0;
+}
+
 /* DSS HW IP initialisation */
 static int __init omap_dsshw_probe(struct platform_device *pdev)
 {
@@ -750,6 +777,10 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 
+	r = dss_init_features(&dss.pdev->dev);
+	if (r)
+		return r;
+
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
@@ -772,6 +803,8 @@ static int __exit omap_dsshw_remove(struct platform_device *pdev)
 
 	dss_put_clocks();
 
+	devm_kfree(&dss.pdev->dev, (void *)dss.feat);
+
 	return 0;
 }
 
-- 
1.7.10

