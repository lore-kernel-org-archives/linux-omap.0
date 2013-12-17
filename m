From: Archit Taneja <archit@ti.com>
Subject: [PATCH] omapdss: dispc: Preload more data in pipeline DMAs for OMAP4+ SoCs
Date: Tue, 17 Dec 2013 16:40:21 +0530
Message-ID: <1387278621-10966-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48156 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab3LQLK2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 06:10:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

DISPC pipeline DMAs preload some bytes of pixel data in the vertical blanking
region before the start of each frame. The preload ensures the pipeline doesn't
underflow when the active region of the display starts.

DISPC_GFX/VIDp_PRELOAD registers allow us to program how many bytes of data
should be preloaded for each pipeline. Calculating a precise preload value
would be a complex function of the pixel clock of the connected display, the
vertical blanking duration and the interconnect traffic at that instance. If
the register is left untouched, a default value is preloaded.

We observe underflows for OMAP4+ SoCs for certain bandwidth intensive use cases
with many other initiators active, and in situations where memory access isn't
very efficient(like accessing Tiler mapped buffers and EMIF configured in
non-interleaved more). The cause of the underflow is because the default preload
value isn't sufficient for the DMA to reach a steady state. We configure the
PRELOAD register such that the pipelines preload data up to the high threshold
of the FIFO.

Preloading lot of data for older SoCs can have a negative impact. Due to slower
interconnects, it's possible that the DISPC DMA cannot preload up to the high
threshold within the vertical blanking region of the panel. We leave the PRELOAD
registers to their reset values since we haven't faced underflows with these
SoCs because of low value of PRELOAD.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 6578540..ace179e 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -90,6 +90,8 @@ struct dispc_features {
 
 	/* revert to the OMAP4 mechanism of DISPC Smart Standby operation */
 	bool mstandby_workaround:1;
+
+	bool set_max_preload:1;
 };
 
 #define DISPC_MAX_NR_FIFOS 5
@@ -1200,6 +1202,15 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 	dispc_write_reg(DISPC_OVL_FIFO_THRESHOLD(plane),
 			FLD_VAL(high, hi_start, hi_end) |
 			FLD_VAL(low, lo_start, lo_end));
+
+	/*
+	 * configure the preload to the pipeline's high threhold, if HT it's too
+	 * large for the preload field, set the threshold to the maximum value
+	 * that can be held by the preload register
+	 */
+	if (dss_has_feature(FEAT_PRELOAD) && dispc.feat->set_max_preload &&
+			plane != OMAP_DSS_WB)
+		dispc_write_reg(DISPC_OVL_PRELOAD(plane), min(high, 0xfff));
 }
 EXPORT_SYMBOL(dispc_ovl_set_fifo_threshold);
 
@@ -3525,6 +3536,7 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.calc_core_clk		=	calc_core_clk_24xx,
 	.num_fifos		=	3,
 	.no_framedone_tv	=	true,
+	.set_max_preload	=	false,
 };
 
 static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
@@ -3544,6 +3556,7 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
 	.no_framedone_tv	=	true,
+	.set_max_preload	=	false,
 };
 
 static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
@@ -3563,6 +3576,7 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
 	.no_framedone_tv	=	true,
+	.set_max_preload	=	false,
 };
 
 static const struct dispc_features omap44xx_dispc_feats __initconst = {
@@ -3582,6 +3596,7 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.calc_core_clk		=	calc_core_clk_44xx,
 	.num_fifos		=	5,
 	.gfx_fifo_workaround	=	true,
+	.set_max_preload	=	true,
 };
 
 static const struct dispc_features omap54xx_dispc_feats __initconst = {
@@ -3602,6 +3617,7 @@ static const struct dispc_features omap54xx_dispc_feats __initconst = {
 	.num_fifos		=	5,
 	.gfx_fifo_workaround	=	true,
 	.mstandby_workaround	=	true,
+	.set_max_preload	=	true,
 };
 
 static int __init dispc_init_features(struct platform_device *pdev)
-- 
1.8.3.2

