From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH 3/4] OMAP: DSS2: Using dss_features to clean cpu checks for clocks
Date: Thu,  3 Feb 2011 19:26:58 +0530
Message-ID: <1296741419-9037-4-git-send-email-raghuveer.murthy@ti.com>
References: <1296741419-9037-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33673 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756424Ab1BCOC2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 09:02:28 -0500
In-Reply-To: <1296741419-9037-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomba@iki.fi
Cc: linux-omap@vger.kernel.org

dss_features are used to substitute cpu_is_xxxx() checks for DPLL clock source

Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
---
 drivers/video/omap2/dss/dss.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index add82e6..654f5e6 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -320,8 +320,9 @@ int dss_calc_clock_rates(struct dss_clock_info *cinfo)
 {
 	unsigned long prate;
 
-	if (cinfo->fck_div > (cpu_is_omap3630() ? 32 : 16) ||
-						cinfo->fck_div == 0)
+	if (cinfo->fck_div >
+		(dss_has_feature(FEAT_DPLL_FCK_32_DIV) ? 32 : 16) ||
+			cinfo->fck_div == 0)
 		return -EINVAL;
 
 	prate = clk_get_rate(clk_get_parent(dss.dpll_per_mx_ck));
@@ -336,9 +337,9 @@ int dss_set_clock_div(struct dss_clock_info *cinfo)
 	unsigned long prate;
 	int r;
 
-	if (cpu_is_omap34xx()) {
+	if (dss_has_feature(FEAT_VAR_DPLL_FCK)) {
 		prate = clk_get_rate(clk_get_parent(dss.dpll_per_mx_ck));
-		DSSDBG("dpll4_m4 = %ld\n", prate);
+		DSSDBG("dpll_per_mx parent rate = %ld\n", prate);
 
 		r = clk_set_rate(dss.dpll_per_mx_ck, prate / cinfo->fck_div);
 		if (r)
@@ -354,10 +355,10 @@ int dss_get_clock_div(struct dss_clock_info *cinfo)
 {
 	cinfo->fck = dss_clk_get_rate(DSS_CLK_FCK);
 
-	if (cpu_is_omap34xx()) {
+	if (dss_has_feature(FEAT_VAR_DPLL_FCK)) {
 		unsigned long prate;
 		prate = clk_get_rate(clk_get_parent(dss.dpll_per_mx_ck));
-		if (cpu_is_omap3630())
+		if (dss_has_feature(FEAT_DPLL_FCK_32_DIV))
 			cinfo->fck_div = prate / (cinfo->fck);
 		else
 			cinfo->fck_div = prate / (cinfo->fck / 2);
@@ -370,7 +371,7 @@ int dss_get_clock_div(struct dss_clock_info *cinfo)
 
 unsigned long dss_get_dpll_per_rate(void)
 {
-	if (cpu_is_omap34xx())
+	if (dss_has_feature(FEAT_VAR_DPLL_FCK))
 		return clk_get_rate(clk_get_parent(dss.dpll_per_mx_ck));
 	else
 		return 0;
@@ -395,8 +396,9 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 
 	fck = dss_clk_get_rate(DSS_CLK_FCK);
 	if (req_pck == dss.cache_req_pck &&
-			((cpu_is_omap34xx() && prate == dss.cache_prate) ||
-			 dss.cache_dss_cinfo.fck == fck)) {
+		((dss_has_feature(FEAT_VAR_DPLL_FCK) &&
+			prate == dss.cache_prate) ||
+			dss.cache_dss_cinfo.fck == fck)) {
 		DSSDBG("dispc clock info found from cache.\n");
 		*dss_cinfo = dss.cache_dss_cinfo;
 		*dispc_cinfo = dss.cache_dispc_cinfo;
@@ -417,7 +419,7 @@ retry:
 	memset(&best_dss, 0, sizeof(best_dss));
 	memset(&best_dispc, 0, sizeof(best_dispc));
 
-	if (cpu_is_omap24xx()) {
+	if (!dss_has_feature(FEAT_VAR_DPLL_FCK)) {
 		struct dispc_clock_info cur_dispc;
 		/* XXX can we change the clock on omap2? */
 		fck = dss_clk_get_rate(DSS_CLK_FCK);
@@ -432,12 +434,13 @@ retry:
 		best_dispc = cur_dispc;
 
 		goto found;
-	} else if (cpu_is_omap34xx()) {
-		for (fck_div = (cpu_is_omap3630() ? 32 : 16);
-					fck_div > 0; --fck_div) {
+	} else {
+		for (fck_div =
+			(dss_has_feature(FEAT_DPLL_FCK_32_DIV) ? 32 : 16);
+				fck_div > 0; --fck_div) {
 			struct dispc_clock_info cur_dispc;
 
-			if (cpu_is_omap3630())
+			if (dss_has_feature(FEAT_DPLL_FCK_32_DIV))
 				fck = prate / fck_div;
 			else
 				fck = prate / fck_div * 2;
@@ -465,8 +468,6 @@ retry:
 					goto found;
 			}
 		}
-	} else {
-		BUG();
 	}
 
 found:
@@ -650,7 +651,7 @@ fail0:
 
 static void dss_exit(void)
 {
-	if (cpu_is_omap34xx())
+	if (dss_has_feature(FEAT_VAR_DPLL_FCK))
 		clk_put(dss.dpll_per_mx_ck);
 
 	free_irq(dss.irq, NULL);
-- 
1.7.0.4

