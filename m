From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Date: Wed, 8 Aug 2012 17:08:19 +0530
Message-ID: <1344425899-28267-1-git-send-email-cmahapatra@ti.com>
References: <19a46cc15dc7add0671dd8c32f5398249c0420ab.1343912533.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33684 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755967Ab2HHLkn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Aug 2012 07:40:43 -0400
In-Reply-To: <19a46cc15dc7add0671dd8c32f5398249c0420ab.1343912533.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

All the cpu_is checks have been moved to dss_init_features function providing a
much more generic and cleaner interface. The OMAP version and revision specific
functions are initialized by dss_features structure local to dss.c.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dss.c |  154 ++++++++++++++++++++++++++++++-----------
 1 file changed, 114 insertions(+), 40 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 7b1c6ac..f5971ac 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -65,6 +65,20 @@ struct dss_reg {
 static int dss_runtime_get(void);
 static void dss_runtime_put(void);
 
+static bool check_dss_cinfo_fck(void);
+static bool check_dss_cinfo_fck_34xx(void);
+
+static int dss_get_clk_24xx(struct clk *clk);
+static int dss_get_clk_3xxx(struct clk *clk);
+static int dss_get_clk_44xx(struct clk *clk);
+
+struct dss_features {
+	u16 fck_div_max;
+	int factor;
+	bool (*check_cinfo_fck) (void);
+	int (*get_clk) (struct clk *clk);
+};
+
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
@@ -83,6 +97,8 @@ static struct {
 
 	bool		ctx_valid;
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
+
+	const struct dss_features *feat;
 } dss;
 
 static const char * const dss_generic_clk_source_names[] = {
@@ -91,6 +107,34 @@ static const char * const dss_generic_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_FCK",
 };
 
+static const struct dss_features omap2_dss_features = {
+	.fck_div_max		=	16,
+	.factor			=	2,
+	.check_cinfo_fck	=	check_dss_cinfo_fck,
+	.get_clk		=	dss_get_clk_24xx,
+};
+
+static const struct dss_features omap34_dss_features = {
+	.fck_div_max		=	16,
+	.factor			=	2,
+	.check_cinfo_fck	=	check_dss_cinfo_fck_34xx,
+	.get_clk		=	dss_get_clk_3xxx,
+};
+
+static const struct dss_features omap36_dss_features = {
+	.fck_div_max		=	32,
+	.factor			=	1,
+	.check_cinfo_fck	=	check_dss_cinfo_fck,
+	.get_clk		=	dss_get_clk_3xxx,
+};
+
+static const struct dss_features omap4_dss_features = {
+	.fck_div_max		=	32,
+	.factor			=	1,
+	.check_cinfo_fck	=	check_dss_cinfo_fck,
+	.get_clk		=	dss_get_clk_44xx,
+};
+
 static inline void dss_write_reg(const struct dss_reg idx, u32 val)
 {
 	__raw_writel(val, dss.base + idx.idx);
@@ -236,7 +280,6 @@ const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src)
 	return dss_generic_clk_source_names[clk_src];
 }
 
-
 void dss_dump_clocks(struct seq_file *s)
 {
 	unsigned long dpll4_ck_rate;
@@ -259,18 +302,10 @@ void dss_dump_clocks(struct seq_file *s)
 
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
@@ -461,6 +496,25 @@ unsigned long dss_get_dpll4_rate(void)
 		return 0;
 }
 
+static bool check_dss_cinfo_fck_34xx(void)
+{
+	unsigned long prate = dss_get_dpll4_rate();
+	unsigned long fck = clk_get_rate(dss.dss_clk);
+
+	if (prate == dss.cache_prate || dss.cache_dss_cinfo.fck == fck)
+		return true;
+	return false;
+}
+
+static bool check_dss_cinfo_fck(void)
+{
+	unsigned long fck = clk_get_rate(dss.dss_clk);
+
+	if (dss.cache_dss_cinfo.fck == fck)
+		return true;
+	return false;
+}
+
 int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 		struct dispc_clock_info *dispc_cinfo)
 {
@@ -470,7 +524,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 
 	unsigned long fck, max_dss_fck;
 
-	u16 fck_div, fck_div_max = 16;
+	u16 fck_div;
 
 	int match = 0;
 	int min_fck_per_pck;
@@ -479,10 +533,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 
 	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
-	fck = clk_get_rate(dss.dss_clk);
-	if (req_pck == dss.cache_req_pck &&
-			((cpu_is_omap34xx() && prate == dss.cache_prate) ||
-			 dss.cache_dss_cinfo.fck == fck)) {
+	if (req_pck == dss.cache_req_pck && dss.feat->check_cinfo_fck()) {
 		DSSDBG("dispc clock info found from cache.\n");
 		*dss_cinfo = dss.cache_dss_cinfo;
 		*dispc_cinfo = dss.cache_dispc_cinfo;
@@ -519,13 +570,10 @@ retry:
 
 		goto found;
 	} else {
-		if (cpu_is_omap3630() || cpu_is_omap44xx())
-			fck_div_max = 32;
-
-		for (fck_div = fck_div_max; fck_div > 0; --fck_div) {
+		for (fck_div = dss.feat->fck_div_max; fck_div > 0; --fck_div) {
 			struct dispc_clock_info cur_dispc;
 
-			if (fck_div_max == 32)
+			if (dss.feat->fck_div_max == 32)
 				fck = prate / fck_div;
 			else
 				fck = prate / fck_div * 2;
@@ -619,6 +667,32 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
 	return REG_GET(DSS_CONTROL, 15, 15);
 }
 
+static int dss_get_clk_24xx(struct clk *clk)
+{
+	clk = NULL;
+	return true;
+}
+
+static int dss_get_clk_3xxx(struct clk *clk)
+{
+	clk = clk_get(NULL, "dpll4_m4_ck");
+	if (IS_ERR(clk)) {
+		DSSERR("Failed to get dpll4_m4_ck\n");
+		return PTR_ERR(clk);
+	}
+	return true;
+}
+
+static int dss_get_clk_44xx(struct clk *clk)
+{
+	clk = clk_get(NULL, "dpll_per_m5x2_ck");
+	if (IS_ERR(clk)) {
+		DSSERR("Failed to get dpll_per_m5x2_ck\n");
+		return PTR_ERR(clk);
+	}
+	return true;
+}
+
 static int dss_get_clocks(void)
 {
 	struct clk *clk;
@@ -633,23 +707,9 @@ static int dss_get_clocks(void)
 
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
-	}
+	r = dss.feat->get_clk(clk);
+	if (r != true)
+		goto err;
 
 	dss.dpll4_m4_ck = clk;
 
@@ -704,6 +764,18 @@ void dss_debug_dump_clocks(struct seq_file *s)
 }
 #endif
 
+static void dss_init_features(void)
+{
+	if (cpu_is_omap24xx())
+		dss.feat = &omap2_dss_features;
+	else if (cpu_is_omap34xx())
+		dss.feat = &omap34_dss_features;
+	else if (cpu_is_omap3630())
+		dss.feat = &omap36_dss_features;
+	else
+		dss.feat = &omap4_dss_features;
+}
+
 /* DSS HW IP initialisation */
 static int __init omap_dsshw_probe(struct platform_device *pdev)
 {
@@ -750,6 +822,8 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 
+	dss_init_features();
+
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
-- 
1.7.10

