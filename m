From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] OMAPDSS: fix dss_fck clock rate rounding
Date: Thu, 11 Apr 2013 12:31:01 +0300
Message-ID: <1365672662-612-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56454 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935076Ab3DKJbK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Apr 2013 05:31:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DSS func clock is calculated with prate / div * m. However, the current
omapdss code calculates it with prate * m / div, which yields a slightly
different result when there's a remainder. For example, 432000000 / 14 *
2 = 61714284, but 432000000 * 2 / 14 = 61714285.

In addition to that, the clock framework wants the clock rate given with
clk_set_rate to be higher than the actual (truncated) end result. So, if
prate is 432000000, and div is 14, the real result is 30857142.8571...
We need to call clk_set_rate with 30857143, which gives us a clock of
30857142. That's why we need to use DIV_ROUND_UP() when calling
clk_set_rate.

This patch fixes the clock calculation.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index fdd32e8..b9f6f24 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -480,6 +480,7 @@ bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data)
 	unsigned long fck_hw_max;
 	unsigned long fckd_hw_max;
 	unsigned long prate;
+	unsigned m;
 
 	if (dss.dpll4_m4_ck == NULL) {
 		/*
@@ -495,15 +496,16 @@ bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data)
 	fck_hw_max = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 	fckd_hw_max = dss.feat->fck_div_max;
 
-	prate = dss_get_dpll4_rate() * dss.feat->dss_fck_multiplier;
+	m = dss.feat->dss_fck_multiplier;
+	prate = dss_get_dpll4_rate();
 
 	fck_min = fck_min ? fck_min : 1;
 
-	fckd_start = min(prate / fck_min, fckd_hw_max);
-	fckd_stop = max(DIV_ROUND_UP(prate, fck_hw_max), 1ul);
+	fckd_start = min(prate * m / fck_min, fckd_hw_max);
+	fckd_stop = max(DIV_ROUND_UP(prate * m, fck_hw_max), 1ul);
 
 	for (fckd = fckd_start; fckd >= fckd_stop; --fckd) {
-		fck = prate / fckd;
+		fck = prate / fckd * m;
 
 		if (func(fckd, fck, data))
 			return true;
@@ -521,7 +523,8 @@ int dss_set_clock_div(struct dss_clock_info *cinfo)
 		prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
 		DSSDBG("dpll4_m4 = %ld\n", prate);
 
-		r = clk_set_rate(dss.dpll4_m4_ck, prate / cinfo->fck_div);
+		r = clk_set_rate(dss.dpll4_m4_ck,
+				DIV_ROUND_UP(prate, cinfo->fck_div));
 		if (r)
 			return r;
 	} else {
@@ -531,7 +534,9 @@ int dss_set_clock_div(struct dss_clock_info *cinfo)
 
 	dss.dss_clk_rate = clk_get_rate(dss.dss_clk);
 
-	WARN_ONCE(dss.dss_clk_rate != cinfo->fck, "clk rate mismatch");
+	WARN_ONCE(dss.dss_clk_rate != cinfo->fck,
+			"clk rate mismatch: %lu != %lu", dss.dss_clk_rate,
+			cinfo->fck);
 
 	DSSDBG("fck = %ld (%d)\n", cinfo->fck, cinfo->fck_div);
 
-- 
1.7.10.4

