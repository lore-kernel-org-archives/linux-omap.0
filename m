From: Archit Taneja <archit@ti.com>
Subject: [PATCH 4/6] OMAPDSS: DISPC: Remove usage of dispc_mgr_get_device()
Date: Mon, 7 May 2012 16:51:34 +0530
Message-ID: <1336389696-21636-5-git-send-email-archit@ti.com>
References: <1336389696-21636-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53746 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755567Ab2EGLWh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 07:22:37 -0400
In-Reply-To: <1336389696-21636-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The functions calc_fclk_five_taps() and check_horiz_timing_omap3() use the
function dispc_mgr_get_device() to get the omap_dss_device pointer to which
the manager is connected, the width of the panel is derived from that.

Replace this by using dss_mgr_get_device() which returns the manager's timing
stored in it's private data in APPLY. This contains the latest timings applied
to the manager. Remove the function dispc_mgr_get_device() as it isn't used
any more.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index c198cc8..ef131cd 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -413,14 +413,6 @@ static inline bool dispc_mgr_is_lcd(enum omap_channel channel)
 		return false;
 }
 
-static struct omap_dss_device *dispc_mgr_get_device(enum omap_channel channel)
-{
-	struct omap_overlay_manager *mgr =
-		omap_dss_get_overlay_manager(channel);
-
-	return mgr ? mgr->device : NULL;
-}
-
 u32 dispc_mgr_get_vsync_irq(enum omap_channel channel)
 {
 	switch (channel) {
@@ -1665,14 +1657,17 @@ static int check_horiz_timing_omap3(enum omap_channel channel, u16 pos_x,
 		u16 width, u16 height, u16 out_width, u16 out_height)
 {
 	int DS = DIV_ROUND_UP(height, out_height);
-	struct omap_dss_device *dssdev = dispc_mgr_get_device(channel);
-	struct omap_video_timings t = dssdev->panel.timings;
+	struct omap_overlay_manager *mgr;
+	struct omap_video_timings *t;
 	unsigned long nonactive, lclk, pclk;
 	static const u8 limits[3] = { 8, 10, 20 };
 	u64 val, blank;
 	int i;
 
-	nonactive = t.x_res + t.hfp + t.hsw + t.hbp - out_width;
+	mgr = omap_dss_get_overlay_manager(channel);
+	t = dss_mgr_get_timings(mgr);
+
+	nonactive = t->x_res + t->hfp + t->hsw + t->hbp - out_width;
 	pclk = dispc_mgr_pclk_rate(channel);
 	if (dispc_mgr_is_lcd(channel))
 		lclk = dispc_mgr_lclk_rate(channel);
@@ -1684,7 +1679,7 @@ static int check_horiz_timing_omap3(enum omap_channel channel, u16 pos_x,
 		i++;
 	if (out_width < width)
 		i++;
-	blank = div_u64((u64)(t.hbp + t.hsw + t.hfp) * lclk, pclk);
+	blank = div_u64((u64)(t->hbp + t->hsw + t->hfp) * lclk, pclk);
 	DSSDBG("blanking period + ppl = %llu (limit = %u)\n", blank, limits[i]);
 	if (blank <= limits[i])
 		return -EINVAL;
@@ -1725,8 +1720,14 @@ static unsigned long calc_core_clk_five_taps(enum omap_channel channel,
 		return (unsigned long) pclk;
 
 	if (height > out_height) {
-		struct omap_dss_device *dssdev = dispc_mgr_get_device(channel);
-		unsigned int ppl = dssdev->panel.timings.x_res;
+		struct omap_overlay_manager *mgr;
+		struct omap_video_timings *mgr_timings;
+		unsigned int ppl;
+
+		mgr = omap_dss_get_overlay_manager(channel);
+		mgr_timings = dss_mgr_get_timings(mgr);
+
+		ppl = mgr_timings->x_res;
 
 		tmp = pclk * height * out_width;
 		do_div(tmp, 2 * out_height * ppl);
-- 
1.7.5.4

