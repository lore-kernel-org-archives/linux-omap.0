From: Archit Taneja <archit@ti.com>
Subject: [PATCH 07/17] OMAPDSS: DISPC: Configure newly added omap_video_timing fields
Date: Tue, 26 Jun 2012 15:06:44 +0530
Message-ID: <1340703414-1915-9-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43265 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755877Ab2FZJiw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:38:52 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Hsync, Vsync, Data enable enable logic levels and latching info of Data lanes,
Hsync and Vsync signals(with respect to pixel clock) are newly added parameters
in omap_video_timings.

Program these in dispc_mgr_set_lcd_timings. These will be configured when the
manager's timings are set via dss_mgr_set_timings().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   43 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d974be9..184d37b 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2620,9 +2620,16 @@ bool dispc_mgr_timings_ok(enum omap_channel channel,
 }
 
 static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
-		int hfp, int hbp, int vsw, int vfp, int vbp)
+		int hfp, int hbp, int vsw, int vfp, int vbp,
+		enum omap_dss_signal_level vsync_level,
+		enum omap_dss_signal_level hsync_level,
+		enum omap_dss_signal_level pclk_edge,
+		enum omap_dss_signal_level de_level,
+		enum omap_dss_signal_edge hsync_vsync_edge)
+
 {
-	u32 timing_h, timing_v;
+	u32 timing_h, timing_v, l;
+	bool onoff, rf;
 
 	if (cpu_is_omap24xx() || omap_rev() < OMAP3430_REV_ES3_0) {
 		timing_h = FLD_VAL(hsw-1, 5, 0) | FLD_VAL(hfp-1, 15, 8) |
@@ -2640,6 +2647,32 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 
 	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
 	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
+
+	switch (hsync_vsync_edge) {
+	case OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES:
+		onoff = false;
+		rf = false;
+		break;
+	case OMAPDSS_DRIVE_SIG_FALLING_EDGE:
+		onoff = true;
+		rf = false;
+		break;
+	case OMAPDSS_DRIVE_SIG_RISING_EDGE:
+		onoff = true;
+		rf = true;
+		break;
+	default:
+		BUG();
+	};
+
+	l = dispc_read_reg(DISPC_POL_FREQ(channel));
+	l |= FLD_VAL(onoff, 17, 17);
+	l |= FLD_VAL(rf, 16, 16);
+	l |= FLD_VAL(de_level, 15, 15);
+	l |= FLD_VAL(pclk_edge, 14, 14);
+	l |= FLD_VAL(hsync_level, 13, 13);
+	l |= FLD_VAL(vsync_level, 12, 12);
+	dispc_write_reg(DISPC_POL_FREQ(channel), l);
 }
 
 /* change name to mode? */
@@ -2659,7 +2692,8 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 
 	if (dispc_mgr_is_lcd(channel)) {
 		_dispc_mgr_set_lcd_timings(channel, t.hsw, t.hfp, t.hbp, t.vsw,
-				t.vfp, t.vbp);
+				t.vfp, t.vbp, t.vsync_level, t.hsync_level,
+				t.pclk_edge, t.de_level, t.hsync_vsync_edge);
 
 		xtot = t.x_res + t.hfp + t.hsw + t.hbp;
 		ytot = t.y_res + t.vfp + t.vsw + t.vbp;
@@ -2670,6 +2704,9 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 		DSSDBG("pck %u\n", timings->pixel_clock);
 		DSSDBG("hsw %d hfp %d hbp %d vsw %d vfp %d vbp %d\n",
 			t.hsw, t.hfp, t.hbp, t.vsw, t.vfp, t.vbp);
+		DSSDBG("vsync_level %d hsync_level %d pclk_edge %d de_level %d hsync_vsync_edge %d\n",
+			t.vsync_level, t.hsync_level, t.pclk_edge, t.de_level,
+			t.hsync_vsync_edge);
 
 		DSSDBG("hsync %luHz, vsync %luHz\n", ht, vt);
 	} else {
-- 
1.7.9.5

