From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/7] OMAPDSS: rename parent clk variables
Date: Mon, 18 Nov 2013 14:39:01 +0200
Message-ID: <1384778344-8226-5-git-send-email-tomi.valkeinen@ti.com>
References: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45009 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab3KRMjV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:39:21 -0500
In-Reply-To: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Rename the variables related to DSS fclk's parent: "clk_name" and
"dpll4_m4_ck", to "parent_clk_name" and "parent_clk", which much better
tell what they mean.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 3dea532..d510ba3 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -67,7 +67,7 @@ static void dss_runtime_put(void);
 struct dss_features {
 	u8 fck_div_max;
 	u8 dss_fck_multiplier;
-	const char *clk_name;
+	const char *parent_clk_name;
 	int (*dpi_select_source)(enum omap_channel channel);
 };
 
@@ -75,7 +75,7 @@ static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
 
-	struct clk	*dpll4_m4_ck;
+	struct clk	*parent_clk;
 	struct clk	*dss_clk;
 	unsigned long	dss_clk_rate;
 
@@ -445,7 +445,7 @@ bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data)
 	unsigned long prate;
 	unsigned m;
 
-	if (dss.dpll4_m4_ck == NULL) {
+	if (dss.parent_clk == NULL) {
 		fck = clk_get_rate(dss.dss_clk);
 		return func(fck, data);
 	}
@@ -475,15 +475,15 @@ int dss_set_fck_rate(unsigned long rate)
 {
 	DSSDBG("set fck to %lu\n", rate);
 
-	if (dss.dpll4_m4_ck) {
+	if (dss.parent_clk) {
 		unsigned long prate;
 		unsigned m;
 		int r;
 
-		prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
+		prate = clk_get_rate(clk_get_parent(dss.parent_clk));
 		m = dss.feat->dss_fck_multiplier;
 
-		r = clk_set_rate(dss.dpll4_m4_ck, rate * m);
+		r = clk_set_rate(dss.parent_clk, rate * m);
 		if (r)
 			return r;
 	}
@@ -499,8 +499,8 @@ int dss_set_fck_rate(unsigned long rate)
 
 unsigned long dss_get_dpll4_rate(void)
 {
-	if (dss.dpll4_m4_ck)
-		return clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
+	if (dss.parent_clk)
+		return clk_get_rate(clk_get_parent(dss.parent_clk));
 	else
 		return 0;
 }
@@ -517,7 +517,7 @@ static int dss_setup_default_clock(void)
 	unsigned fck_div;
 	int r;
 
-	if (dss.dpll4_m4_ck == NULL)
+	if (dss.parent_clk == NULL)
 		return 0;
 
 	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
@@ -654,25 +654,25 @@ static int dss_get_clocks(void)
 
 	dss.dss_clk = clk;
 
-	if (dss.feat->clk_name) {
-		clk = clk_get(NULL, dss.feat->clk_name);
+	if (dss.feat->parent_clk_name) {
+		clk = clk_get(NULL, dss.feat->parent_clk_name);
 		if (IS_ERR(clk)) {
-			DSSERR("Failed to get %s\n", dss.feat->clk_name);
+			DSSERR("Failed to get %s\n", dss.feat->parent_clk_name);
 			return PTR_ERR(clk);
 		}
 	} else {
 		clk = NULL;
 	}
 
-	dss.dpll4_m4_ck = clk;
+	dss.parent_clk = clk;
 
 	return 0;
 }
 
 static void dss_put_clocks(void)
 {
-	if (dss.dpll4_m4_ck)
-		clk_put(dss.dpll4_m4_ck);
+	if (dss.parent_clk)
+		clk_put(dss.parent_clk);
 }
 
 static int dss_runtime_get(void)
@@ -715,35 +715,35 @@ static const struct dss_features omap24xx_dss_feats __initconst = {
 	 */
 	.fck_div_max		=	6,
 	.dss_fck_multiplier	=	2,
-	.clk_name		=	"dss1_fck",
+	.parent_clk_name	=	"dss1_fck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
 
 static const struct dss_features omap34xx_dss_feats __initconst = {
 	.fck_div_max		=	16,
 	.dss_fck_multiplier	=	2,
-	.clk_name		=	"dpll4_m4_ck",
+	.parent_clk_name	=	"dpll4_m4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
 
 static const struct dss_features omap3630_dss_feats __initconst = {
 	.fck_div_max		=	32,
 	.dss_fck_multiplier	=	1,
-	.clk_name		=	"dpll4_m4_ck",
+	.parent_clk_name	=	"dpll4_m4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
 
 static const struct dss_features omap44xx_dss_feats __initconst = {
 	.fck_div_max		=	32,
 	.dss_fck_multiplier	=	1,
-	.clk_name		=	"dpll_per_m5x2_ck",
+	.parent_clk_name	=	"dpll_per_m5x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap4,
 };
 
 static const struct dss_features omap54xx_dss_feats __initconst = {
 	.fck_div_max		=	64,
 	.dss_fck_multiplier	=	1,
-	.clk_name		=	"dpll_per_h12x2_ck",
+	.parent_clk_name	=	"dpll_per_h12x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap5,
 };
 
-- 
1.8.3.2

