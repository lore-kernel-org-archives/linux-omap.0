From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/11] OMAPDSS: DISPC: scaler debug print
Date: Wed, 17 Jun 2015 15:54:33 +0300
Message-ID: <1434545675-477-10-git-send-email-tomi.valkeinen@ti.com>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56645 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755319AbbFQMzD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 08:55:03 -0400
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Improve the DISPC debug print for scaling.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 646d94a71a79..f8c9115cdb4b 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2418,6 +2418,9 @@ static int dispc_ovl_calc_scaling_44xx(unsigned long pclk, unsigned long lclk,
 	return 0;
 }
 
+#define DIV_FRAC(dividend, divisor) \
+	((dividend) * 100 / (divisor) - ((dividend) / (divisor) * 100))
+
 static int dispc_ovl_calc_scaling(unsigned long pclk, unsigned long lclk,
 		enum omap_overlay_caps caps,
 		const struct omap_video_timings *mgr_timings,
@@ -2477,8 +2480,19 @@ static int dispc_ovl_calc_scaling(unsigned long pclk, unsigned long lclk,
 	if (ret)
 		return ret;
 
-	DSSDBG("required core clk rate = %lu Hz\n", core_clk);
-	DSSDBG("current core clk rate = %lu Hz\n", dispc_core_clk_rate());
+	DSSDBG("%dx%d -> %dx%d (%d.%02d x %d.%02d), decim %dx%d %dx%d (%d.%02d x %d.%02d), taps %d, req clk %lu, cur clk %lu\n",
+		width, height,
+		out_width, out_height,
+		out_width / width, DIV_FRAC(out_width, width),
+		out_height / height, DIV_FRAC(out_height, height),
+
+		decim_x, decim_y,
+		width / decim_x, height / decim_y,
+		out_width / (width / decim_x), DIV_FRAC(out_width, width / decim_x),
+		out_height / (height / decim_y), DIV_FRAC(out_height, height / decim_y),
+
+		*five_taps ? 5 : 3,
+		core_clk, dispc_core_clk_rate());
 
 	if (!core_clk || core_clk > dispc_core_clk_rate()) {
 		DSSERR("failed to set up scaling, "
-- 
2.1.4

