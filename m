From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/8] OMAP: DSS2: DISPC: Fix minimum PCD value
Date: Wed, 31 Aug 2011 16:21:41 +0300
Message-ID: <1314796908-17354-2-git-send-email-tomi.valkeinen@ti.com>
References: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:54544 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755406Ab1HaNWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:22:05 -0400
In-Reply-To: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The current driver had a hardcoded minimum value of 2 for pixel clock
divisor (PCD). This doesn't seem to be right.

OMAP4 TRM says that PCD can be 1 when not downscaling, and inverted
pixel clock (IPC) is off.

OMAP3 TRM says the same, but also in the register descriptions that PCD
value 1 is invalid.

OMAP2 TRM says PCD 2 is the minimum.

OMAP2 is still untested, but for both OMAP3 and OMAP4 PCD of 1 seems to
work fine.

This patch adds a new DSS feature, FEAT_PARAM_DSS_PCD, which is used to
find the minimum and maximum PCD. The minimum is set to 2 for OMAP2, and
1 for OMAP3/4.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   14 ++++++++++----
 drivers/video/omap2/dss/dss_features.c |    3 +++
 drivers/video/omap2/dss/dss_features.h |    1 +
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index de20936..7f3d847 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2339,7 +2339,7 @@ static void dispc_mgr_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
 		u16 pck_div)
 {
 	BUG_ON(lck_div < 1);
-	BUG_ON(pck_div < 2);
+	BUG_ON(pck_div < 1);
 
 	dispc_write_reg(DISPC_DIVISORo(channel),
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
@@ -2726,11 +2726,17 @@ void dispc_mgr_set_pol_freq(enum omap_channel channel,
 void dispc_find_clk_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
 		struct dispc_clock_info *cinfo)
 {
-	u16 pcd_min = is_tft ? 2 : 3;
+	u16 pcd_min, pcd_max;
 	unsigned long best_pck;
 	u16 best_ld, cur_ld;
 	u16 best_pd, cur_pd;
 
+	pcd_min = dss_feat_get_param_min(FEAT_PARAM_DSS_PCD);
+	pcd_max = dss_feat_get_param_max(FEAT_PARAM_DSS_PCD);
+
+	if (!is_tft)
+		pcd_min = 3;
+
 	best_pck = 0;
 	best_ld = 0;
 	best_pd = 0;
@@ -2738,7 +2744,7 @@ void dispc_find_clk_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
 	for (cur_ld = 1; cur_ld <= 255; ++cur_ld) {
 		unsigned long lck = fck / cur_ld;
 
-		for (cur_pd = pcd_min; cur_pd <= 255; ++cur_pd) {
+		for (cur_pd = pcd_min; cur_pd <= pcd_max; ++cur_pd) {
 			unsigned long pck = lck / cur_pd;
 			long old_delta = abs(best_pck - req_pck);
 			long new_delta = abs(pck - req_pck);
@@ -2773,7 +2779,7 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 {
 	if (cinfo->lck_div > 255 || cinfo->lck_div == 0)
 		return -EINVAL;
-	if (cinfo->pck_div < 2 || cinfo->pck_div > 255)
+	if (cinfo->pck_div < 1 || cinfo->pck_div > 255)
 		return -EINVAL;
 
 	cinfo->lck = dispc_fclk_rate / cinfo->lck_div;
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index b63c5f8..85b07ca 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -281,6 +281,7 @@ static const char * const omap4_dss_clk_source_names[] = {
 
 static const struct dss_param_range omap2_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
+	[FEAT_PARAM_DSS_PCD]			= { 2, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, 0 },
@@ -291,6 +292,7 @@ static const struct dss_param_range omap2_dss_param_range[] = {
 
 static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
+	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 7) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 11) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 4) - 1 },
@@ -301,6 +303,7 @@ static const struct dss_param_range omap3_dss_param_range[] = {
 
 static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 186000000 },
+	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 4271e96..158d922 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -73,6 +73,7 @@ enum dss_feat_reg_field {
 
 enum dss_range_param {
 	FEAT_PARAM_DSS_FCK,
+	FEAT_PARAM_DSS_PCD,
 	FEAT_PARAM_DSIPLL_REGN,
 	FEAT_PARAM_DSIPLL_REGM,
 	FEAT_PARAM_DSIPLL_REGM_DISPC,
-- 
1.7.4.1

