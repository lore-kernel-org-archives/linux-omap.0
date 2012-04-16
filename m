From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/6] OMAPDSS: DISPC: Use a common function to set manager timings
Date: Mon, 16 Apr 2012 12:53:43 +0530
Message-ID: <1334561027-28569-3-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56327 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab2DPHY3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 03:24:29 -0400
In-Reply-To: <1334561027-28569-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Currently, a LCD manager's timings is set by dispc_mgr_set_lcd_timings() and TV
manager's timings is set by dispc_set_digit_size(). Use a common function called
dispc_mgr_set_timings() which sets timings for both type of managers.

We finally want the interface drivers to use an overlay manager function to
configure it's timings, having a common DISPC function would make things
cleaner.

For LCD managers, dispc_mgr_set_timings() sets LCD size and blanking values, for
TV manager, it sets only the TV size since blanking values don't exist for TV.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   43 +++++++++++++++++++++-----------------
 drivers/video/omap2/dss/dpi.c   |    2 +-
 drivers/video/omap2/dss/dsi.c   |    4 +-
 drivers/video/omap2/dss/dss.h   |    3 +-
 drivers/video/omap2/dss/hdmi.c  |    3 +-
 drivers/video/omap2/dss/rfbi.c  |    4 +-
 drivers/video/omap2/dss/sdi.c   |    2 +-
 drivers/video/omap2/dss/venc.c  |    7 ++++-
 8 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index c6ac161..f1e5337 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -992,7 +992,7 @@ static void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width,
 	dispc_write_reg(DISPC_SIZE_MGR(channel), val);
 }
 
-void dispc_set_digit_size(u16 width, u16 height)
+static void dispc_mgr_set_digit_size(u16 width, u16 height)
 {
 	u32 val;
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
@@ -2341,37 +2341,42 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 }
 
 /* change name to mode? */
-void dispc_mgr_set_lcd_timings(enum omap_channel channel,
+void dispc_mgr_set_timings(enum omap_channel channel,
 		struct omap_video_timings *timings)
 {
 	unsigned xtot, ytot;
 	unsigned long ht, vt;
 
-	if (!_dispc_lcd_timings_ok(timings->hsw, timings->hfp,
-				timings->hbp, timings->vsw,
-				timings->vfp, timings->vbp))
-		BUG();
+	DSSDBG("channel %d xres %u yres %u\n", channel, timings->x_res,
+			timings->y_res);
+
+	if (dispc_mgr_is_lcd(channel)) {
+		if (!dispc_lcd_timings_ok(timings))
+			BUG();
 
-	_dispc_mgr_set_lcd_timings(channel, timings->hsw, timings->hfp,
-			timings->hbp, timings->vsw, timings->vfp,
-			timings->vbp);
+		_dispc_mgr_set_lcd_timings(channel, timings->hsw, timings->hfp,
+				timings->hbp, timings->vsw, timings->vfp,
+				timings->vbp);
 
-	dispc_mgr_set_lcd_size(channel, timings->x_res, timings->y_res);
+		dispc_mgr_set_lcd_size(channel, timings->x_res, timings->y_res);
 
-	xtot = timings->x_res + timings->hfp + timings->hsw + timings->hbp;
-	ytot = timings->y_res + timings->vfp + timings->vsw + timings->vbp;
+		xtot = timings->x_res + timings->hfp + timings->hsw +
+				timings->hbp;
+		ytot = timings->y_res + timings->vfp + timings->vsw +
+				timings->vbp;
 
-	ht = (timings->pixel_clock * 1000) / xtot;
-	vt = (timings->pixel_clock * 1000) / xtot / ytot;
+		ht = (timings->pixel_clock * 1000) / xtot;
+		vt = (timings->pixel_clock * 1000) / xtot / ytot;
 
-	DSSDBG("channel %d xres %u yres %u\n", channel, timings->x_res,
-			timings->y_res);
-	DSSDBG("pck %u\n", timings->pixel_clock);
-	DSSDBG("hsw %d hfp %d hbp %d vsw %d vfp %d vbp %d\n",
+		DSSDBG("pck %u\n", timings->pixel_clock);
+		DSSDBG("hsw %d hfp %d hbp %d vsw %d vfp %d vbp %d\n",
 			timings->hsw, timings->hfp, timings->hbp,
 			timings->vsw, timings->vfp, timings->vbp);
 
-	DSSDBG("hsync %luHz, vsync %luHz\n", ht, vt);
+		DSSDBG("hsync %luHz, vsync %luHz\n", ht, vt);
+	} else {
+		dispc_mgr_set_digit_size(timings->x_res, timings->y_res);
+	}
 }
 
 static void dispc_mgr_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index faaf305..7dd7f9d 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -156,7 +156,7 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 		t->pixel_clock = pck;
 	}
 
-	dispc_mgr_set_lcd_timings(dssdev->manager->id, t);
+	dispc_mgr_set_timings(dssdev->manager->id, t);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 0d2c53f..b6cf03c 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4219,12 +4219,12 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		dispc_mgr_enable_stallmode(dssdev->manager->id, true);
 		dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 1);
 
-		dispc_mgr_set_lcd_timings(dssdev->manager->id, &timings);
+		dispc_mgr_set_timings(dssdev->manager->id, &timings);
 	} else {
 		dispc_mgr_enable_stallmode(dssdev->manager->id, false);
 		dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 0);
 
-		dispc_mgr_set_lcd_timings(dssdev->manager->id,
+		dispc_mgr_set_timings(dssdev->manager->id,
 			&dssdev->panel.timings);
 	}
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index e8dea74..da91822 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -407,7 +407,6 @@ void dispc_disable_sidle(void);
 void dispc_lcd_enable_signal_polarity(bool act_high);
 void dispc_lcd_enable_signal(bool enable);
 void dispc_pck_free_enable(bool enable);
-void dispc_set_digit_size(u16 width, u16 height);
 void dispc_enable_fifomerge(bool enable);
 void dispc_enable_gamma_table(bool enable);
 void dispc_set_loadmode(enum omap_dss_load_mode mode);
@@ -442,7 +441,7 @@ void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable);
 void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
 void dispc_mgr_set_lcd_display_type(enum omap_channel channel,
 		enum omap_lcd_display_type type);
-void dispc_mgr_set_lcd_timings(enum omap_channel channel,
+void dispc_mgr_set_timings(enum omap_channel channel,
 		struct omap_video_timings *timings);
 void dispc_mgr_set_pol_freq(enum omap_channel channel,
 		enum omap_panel_config config, u8 acbi, u8 acb);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index c4b4f69..56f6e9c 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -376,8 +376,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	dispc_enable_gamma_table(0);
 
 	/* tv size */
-	dispc_set_digit_size(dssdev->panel.timings.x_res,
-			dssdev->panel.timings.y_res);
+	dispc_mgr_set_timings(dssdev->manager->id, &dssdev->panel.timings);
 
 	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 1);
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 97b6c4a..a81ffcb 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -320,7 +320,7 @@ static void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 
 	DSSDBG("rfbi_transfer_area %dx%d\n", width, height);
 
-	dispc_mgr_set_lcd_timings(dssdev->manager->id, &timings);
+	dispc_mgr_set_timings(dssdev->manager->id, &timings);
 
 	dispc_mgr_enable(dssdev->manager->id, true);
 
@@ -804,7 +804,7 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 	if (*w == 0 || *h == 0)
 		return -EINVAL;
 
-	dispc_mgr_set_lcd_timings(dssdev->manager->id, &timings);
+	dispc_mgr_set_timings(dssdev->manager->id, &timings);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 8266ca0..741b834 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -107,7 +107,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	}
 
 
-	dispc_mgr_set_lcd_timings(dssdev->manager->id, t);
+	dispc_mgr_set_timings(dssdev->manager->id, t);
 
 	r = dss_set_clock_div(&dss_cinfo);
 	if (r)
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 13a20da..30bbb63 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -421,6 +421,7 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 {
 	u32 l;
 	int r;
+	struct omap_video_timings timings;
 
 	venc_reset();
 	venc_write_config(venc_timings_to_config(&dssdev->panel.timings));
@@ -440,8 +441,10 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 
 	venc_write_reg(VENC_OUTPUT_CONTROL, l);
 
-	dispc_set_digit_size(dssdev->panel.timings.x_res,
-			dssdev->panel.timings.y_res/2);
+	timings = dssdev->panel.timings;
+	timings.y_res /= 2;
+
+	dispc_mgr_set_timings(dssdev->manager->id, &timings);
 
 	r = regulator_enable(venc.vdda_dac_reg);
 	if (r)
-- 
1.7.5.4

