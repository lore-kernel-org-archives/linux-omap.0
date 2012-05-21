From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/8] OMAPDSS: HACK: VENC/DISPC: Delay dividing Y resolution for managers connected to VENC
Date: Mon, 21 May 2012 12:28:05 +0300
Message-ID: <1337592486-13040-8-git-send-email-tomi.valkeinen@ti.com>
References: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:58687 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932501Ab2EUJ2h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:28:37 -0400
Received: by lahc1 with SMTP id c1so4416175lah.18
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:28:34 -0700 (PDT)
In-Reply-To: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Archit Taneja <archit@ti.com>

DSS2 driver uses the timings in manager's private data to check the validity of
overlay and manager infos written by the user. For VENC interface, we divide the
Y resolution by half when writing to the DISPC_DIGIT_SIZE register as the
content is interlaced. However, the height of the manager/display with respect
to the content shown through VENC still remains the same.

The VENC driver divides the y_res parameter in omap_video_timings by half, and
then applies the configuration. This leads to manager's private data storing
the wrong Y resolution. Hence, overlay related checks fail.

Ensure that manager's private data stores the original timings, and the Y
resolution is halved only when we write to the DISPC register. This is a hack,
the proper solution would be to pass some sort of interlace parameter which
makes the call whether we should divide y_res or not.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   29 ++++++++++++++++-------------
 drivers/video/omap2/dss/venc.c  |    6 +-----
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 9626b2c..4749ac3 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2665,37 +2665,40 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 {
 	unsigned xtot, ytot;
 	unsigned long ht, vt;
+	struct omap_video_timings t = *timings;
 
-	DSSDBG("channel %d xres %u yres %u\n", channel, timings->x_res,
-			timings->y_res);
+	DSSDBG("channel %d xres %u yres %u\n", channel, t.x_res, t.y_res);
 
-	if (!dispc_mgr_timings_ok(channel, timings)) {
+	if (!dispc_mgr_timings_ok(channel, &t)) {
 		BUG();
 		return;
 	}
 
 	if (dispc_mgr_is_lcd(channel)) {
-		_dispc_mgr_set_lcd_timings(channel, timings->hsw, timings->hfp,
-				timings->hbp, timings->vsw, timings->vfp,
-				timings->vbp);
+		_dispc_mgr_set_lcd_timings(channel, t.hsw, t.hfp, t.hbp, t.vsw,
+				t.vfp, t.vbp);
 
-		xtot = timings->x_res + timings->hfp + timings->hsw +
-				timings->hbp;
-		ytot = timings->y_res + timings->vfp + timings->vsw +
-				timings->vbp;
+		xtot = t.x_res + t.hfp + t.hsw + t.hbp;
+		ytot = t.y_res + t.vfp + t.vsw + t.vbp;
 
 		ht = (timings->pixel_clock * 1000) / xtot;
 		vt = (timings->pixel_clock * 1000) / xtot / ytot;
 
 		DSSDBG("pck %u\n", timings->pixel_clock);
 		DSSDBG("hsw %d hfp %d hbp %d vsw %d vfp %d vbp %d\n",
-			timings->hsw, timings->hfp, timings->hbp,
-			timings->vsw, timings->vfp, timings->vbp);
+			t.hsw, t.hfp, t.hbp, t.vsw, t.vfp, t.vbp);
 
 		DSSDBG("hsync %luHz, vsync %luHz\n", ht, vt);
+	} else {
+		enum dss_hdmi_venc_clk_source_select source;
+
+		source = dss_get_hdmi_venc_clk_source();
+
+		if (source == DSS_VENC_TV_CLK)
+			t.y_res /= 2;
 	}
 
-	dispc_mgr_set_size(channel, timings->x_res, timings->y_res);
+	dispc_mgr_set_size(channel, t.x_res, t.y_res);
 }
 
 static void dispc_mgr_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 1dbf155..09be43d 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -422,7 +422,6 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 {
 	u32 l;
 	int r;
-	struct omap_video_timings timings;
 
 	venc_reset();
 	venc_write_config(venc_timings_to_config(&dssdev->panel.timings));
@@ -442,10 +441,7 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 
 	venc_write_reg(VENC_OUTPUT_CONTROL, l);
 
-	timings = dssdev->panel.timings;
-	timings.y_res /= 2;
-
-	dss_mgr_set_timings(dssdev->manager, &timings);
+	dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
 
 	r = regulator_enable(venc.vdda_dac_reg);
 	if (r)
-- 
1.7.9.5

