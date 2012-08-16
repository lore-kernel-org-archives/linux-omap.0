From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V4 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Date: Thu, 16 Aug 2012 16:48:33 +0530
Message-ID: <1345115913-6773-1-git-send-email-cmahapatra@ti.com>
References: <1344859176-4512-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60736 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab2HPLXH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Aug 2012 07:23:07 -0400
In-Reply-To: <1344859176-4512-1-git-send-email-cmahapatra@ti.com>
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
 drivers/video/omap2/dss/dss.c |  114 ++++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 41 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 7b1c6ac..a9cb84b 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -31,6 +31,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/gfp.h>
 
 #include <video/omapdss.h>
 
@@ -65,6 +66,12 @@ struct dss_reg {
 static int dss_runtime_get(void);
 static void dss_runtime_put(void);
 
+struct dss_features {
+	u16 fck_div_max;
+	int dss_fck_multiplier;
+	char *clk_name;
+};
+
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
@@ -83,6 +90,8 @@ static struct {
 
 	bool		ctx_valid;
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
+
+	const struct dss_features *feat;
 } dss;
 
 static const char * const dss_generic_clk_source_names[] = {
@@ -91,6 +100,30 @@ static const char * const dss_generic_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_FCK",
 };
 
+static const struct dss_features omap24xx_dss_features __initconst = {
+	.fck_div_max		=	16,
+	.dss_fck_multiplier	=	2,
+	.clk_name		=	NULL,
+};
+
+static const struct dss_features omap34xx_dss_features __initconst = {
+	.fck_div_max		=	16,
+	.dss_fck_multiplier	=	2,
+	.clk_name		=	"dpll4_m4_ck",
+};
+
+static const struct dss_features omap3630_dss_features __initconst = {
+	.fck_div_max		=	32,
+	.dss_fck_multiplier	=	1,
+	.clk_name		=	"dpll4_m4_ck",
+};
+
+static const struct dss_features omap44xx_dss_features __initconst = {
+	.fck_div_max		=	32,
+	.dss_fck_multiplier	=	1,
+	.clk_name		=	"dpll_per_m5x2_ck",
+};
+
 static inline void dss_write_reg(const struct dss_reg idx, u32 val)
 {
 	__raw_writel(val, dss.base + idx.idx);
@@ -236,7 +269,6 @@ const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src)
 	return dss_generic_clk_source_names[clk_src];
 }
 
-
 void dss_dump_clocks(struct seq_file *s)
 {
 	unsigned long dpll4_ck_rate;
@@ -259,18 +291,10 @@ void dss_dump_clocks(struct seq_file *s)
 
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
+				dss.feat->dss_fck_multiplier, fclk_rate);
 	} else {
 		seq_printf(s, "%s (%s) = %lu\n",
 				fclk_name, fclk_real_name,
@@ -470,7 +494,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 
 	unsigned long fck, max_dss_fck;
 
-	u16 fck_div, fck_div_max = 16;
+	u16 fck_div;
 
 	int match = 0;
 	int min_fck_per_pck;
@@ -480,9 +504,8 @@ int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
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
@@ -519,16 +542,10 @@ retry:
 
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
+			fck = prate / fck_div * dss.feat->dss_fck_multiplier;
 
 			if (fck > max_dss_fck)
 				continue;
@@ -633,22 +650,11 @@ static int dss_get_clocks(void)
 
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
@@ -704,6 +710,28 @@ void dss_debug_dump_clocks(struct seq_file *s)
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
+		dss.feat = &omap24xx_dss_features;
+	else if (cpu_is_omap34xx())
+		dss.feat = &omap34xx_dss_features;
+	else if (cpu_is_omap3630())
+		dss.feat = &omap3630_dss_features;
+	else if (cpu_is_omap44xx())
+		dss.feat = &omap44xx_dss_features;
+	else
+		return -ENODEV;
+
+	return 0;
+}
+
 /* DSS HW IP initialisation */
 static int __init omap_dsshw_probe(struct platform_device *pdev)
 {
@@ -750,6 +778,10 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 
+	r = dss_init_features(&dss.pdev->dev);
+	if (r)
+		return r;
+
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
-- 
1.7.10

changes since V1
	V2 : moved dss_ops structure definitions from dss_features.c to dss.c
	     renamed dss_ops to dss_features
	     removed dss_get_clk_24xx(), dss_get_clk_34xx(), dss_get_clk_44xx,
		set_dump_clk_str_24_34() and set_dump_clk_str() replacing them
		with appropiate variables in dss_features structure 
	V3 : used __initdata before dss_features definitions and __init before
		dss_init_features()
	     initialized dss.feat with devm_kzalloc
	     removed definitions of check_dss_cinfo_fck(),
		check_dss_cinfo_fck_34xx(), dss_get_clk_24xx(), dss_get_clk_34xx()
		and dss_get_clk_44xx() replacing them with appropiate variables
	V4 : replaced __initdata with __initconst as per guidelines in
		include/linux/init.h
	     renamed various dss_features structures to give consistent naming
	     removed dss.feat deinitialization code from omap_dispchw_remove()
	     replaced #include <linux/dma-mapping.h> with <linux/gfx.h>
	     renamed factor variable of dss_features structure with
		dss_fck_multiplier
	     added a check for omap4 in dss_init_features()
	     
