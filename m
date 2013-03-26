From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 5/8] omapdss: DISPC: add max pixel clock limits for LCD and TV managers
Date: Tue, 26 Mar 2013 19:15:22 +0530
Message-ID: <1364305525-28496-6-git-send-email-archit@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com>
 <1364305525-28496-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46637 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934405Ab3CZNqk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:46:40 -0400
In-Reply-To: <1364305525-28496-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, robdclark@gmail.com, andy.gross@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

Each version of OMAP has a limitation on the maximum pixel clock frequency
supported by an overlay manager. This limit isn't checked by omapdss. Add
dispc feats for lcd and tv managers and check whether the target timings can
be supported or not.

The pixel clock limitations are actually more complex. They depend on which OPP
OMAP is in, and they also depend on which encoder is the manager connected to.
The OPP dependence is ignored as DSS forces the PM framework to be on OPP100
when DSS is enabled, and the encoder dependencies are ignored by DISPC for now.
These limits should come from the encoder driver.

The OMAP2 TRM doesn't mention the maximum pixel clock limit. This value is left
as half of DSS_FCLK, as OMAP2 requires the PCD to be atleast 2.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 8cfa27b..73a730a 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -69,6 +69,8 @@ struct dispc_features {
 	u8 mgr_height_start;
 	u16 mgr_width_max;
 	u16 mgr_height_max;
+	unsigned long max_lcd_pclk;
+	unsigned long max_tv_pclk;
 	int (*calc_scaling) (unsigned long pclk, unsigned long lclk,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
@@ -2825,6 +2827,15 @@ static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
 	return true;
 }
 
+static bool _dispc_mgr_pclk_ok(enum omap_channel channel,
+		unsigned long pclk)
+{
+	if (dss_mgr_is_lcd(channel))
+		return pclk <= dispc.feat->max_lcd_pclk ? true : false;
+	else
+		return pclk <= dispc.feat->max_tv_pclk ? true : false;
+}
+
 bool dispc_mgr_timings_ok(enum omap_channel channel,
 		const struct omap_video_timings *timings)
 {
@@ -2832,11 +2843,13 @@ bool dispc_mgr_timings_ok(enum omap_channel channel,
 
 	timings_ok = _dispc_mgr_size_ok(timings->x_res, timings->y_res);
 
-	if (dss_mgr_is_lcd(channel))
-		timings_ok =  timings_ok && _dispc_lcd_timings_ok(timings->hsw,
-						timings->hfp, timings->hbp,
-						timings->vsw, timings->vfp,
-						timings->vbp);
+	timings_ok &= _dispc_mgr_pclk_ok(channel, timings->pixel_clock * 1000);
+
+	if (dss_mgr_is_lcd(channel)) {
+		timings_ok &= _dispc_lcd_timings_ok(timings->hsw, timings->hfp,
+				timings->hbp, timings->vsw, timings->vfp,
+				timings->vbp);
+	}
 
 	return timings_ok;
 }
@@ -3491,6 +3504,7 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.mgr_height_start	=	26,
 	.mgr_width_max		=	2048,
 	.mgr_height_max		=	2048,
+	.max_lcd_pclk		=	66500000,
 	.calc_scaling		=	dispc_ovl_calc_scaling_24xx,
 	.calc_core_clk		=	calc_core_clk_24xx,
 	.num_fifos		=	3,
@@ -3508,6 +3522,8 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
 	.mgr_height_start	=	26,
 	.mgr_width_max		=	2048,
 	.mgr_height_max		=	2048,
+	.max_lcd_pclk		=	173000000,
+	.max_tv_pclk		=	59000000,
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
@@ -3525,6 +3541,8 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
 	.mgr_height_start	=	26,
 	.mgr_width_max		=	2048,
 	.mgr_height_max		=	2048,
+	.max_lcd_pclk		=	173000000,
+	.max_tv_pclk		=	59000000,
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
@@ -3542,6 +3560,8 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.mgr_height_start	=	26,
 	.mgr_width_max		=	2048,
 	.mgr_height_max		=	2048,
+	.max_lcd_pclk		=	170000000,
+	.max_tv_pclk		=	185625000,
 	.calc_scaling		=	dispc_ovl_calc_scaling_44xx,
 	.calc_core_clk		=	calc_core_clk_44xx,
 	.num_fifos		=	5,
@@ -3559,6 +3579,8 @@ static const struct dispc_features omap54xx_dispc_feats __initconst = {
 	.mgr_height_start	=	27,
 	.mgr_width_max		=	4096,
 	.mgr_height_max		=	4096,
+	.max_lcd_pclk		=	170000000,
+	.max_tv_pclk		=	186000000,
 	.calc_scaling		=	dispc_ovl_calc_scaling_44xx,
 	.calc_core_clk		=	calc_core_clk_44xx,
 	.num_fifos		=	5,
-- 
1.7.10.4

