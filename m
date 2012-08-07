From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 2/6] OMAPDSS: DSS: Remove redundant functions
Date: Tue, 7 Aug 2012 13:57:52 +0530
Message-ID: <ccdea286ee482194f1ae8182ca0022e30946b5ff.1343912533.git.cmahapatra@ti.com>
References: <cover.1343912532.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44857 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab2HGIaB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Aug 2012 04:30:01 -0400
In-Reply-To: <cover.1343912532.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Functions dss_calc_clock_rates() and dss_get_clock_div() are removed as these
functions have become redundant and no longer used.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dss.c |   45 -----------------------------------------
 drivers/video/omap2/dss/dss.h |    2 --
 2 files changed, 47 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 04b4586..7b1c6ac 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -431,31 +431,6 @@ enum omap_dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel)
 	}
 }
 
-/* calculate clock rates using dividers in cinfo */
-int dss_calc_clock_rates(struct dss_clock_info *cinfo)
-{
-	if (dss.dpll4_m4_ck) {
-		unsigned long prate;
-		u16 fck_div_max = 16;
-
-		if (cpu_is_omap3630() || cpu_is_omap44xx())
-			fck_div_max = 32;
-
-		if (cinfo->fck_div > fck_div_max || cinfo->fck_div == 0)
-			return -EINVAL;
-
-		prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
-
-		cinfo->fck = prate / cinfo->fck_div;
-	} else {
-		if (cinfo->fck_div != 0)
-			return -EINVAL;
-		cinfo->fck = clk_get_rate(dss.dss_clk);
-	}
-
-	return 0;
-}
-
 int dss_set_clock_div(struct dss_clock_info *cinfo)
 {
 	if (dss.dpll4_m4_ck) {
@@ -478,26 +453,6 @@ int dss_set_clock_div(struct dss_clock_info *cinfo)
 	return 0;
 }
 
-int dss_get_clock_div(struct dss_clock_info *cinfo)
-{
-	cinfo->fck = clk_get_rate(dss.dss_clk);
-
-	if (dss.dpll4_m4_ck) {
-		unsigned long prate;
-
-		prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
-
-		if (cpu_is_omap3630() || cpu_is_omap44xx())
-			cinfo->fck_div = prate / (cinfo->fck);
-		else
-			cinfo->fck_div = prate / (cinfo->fck / 2);
-	} else {
-		cinfo->fck_div = 0;
-	}
-
-	return 0;
-}
-
 unsigned long dss_get_dpll4_rate(void)
 {
 	if (dss.dpll4_m4_ck)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d87b885..5773c86 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -311,9 +311,7 @@ void dss_set_venc_output(enum omap_dss_venc_type type);
 void dss_set_dac_pwrdn_bgz(bool enable);
 
 unsigned long dss_get_dpll4_rate(void);
-int dss_calc_clock_rates(struct dss_clock_info *cinfo);
 int dss_set_clock_div(struct dss_clock_info *cinfo);
-int dss_get_clock_div(struct dss_clock_info *cinfo);
 int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 		struct dispc_clock_info *dispc_cinfo);
 
-- 
1.7.10

