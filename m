From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/15] OMAPDSS: DISPC: remove OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES
Date: Thu, 26 Feb 2015 14:48:59 +0200
Message-ID: <1424954949-12801-5-git-send-email-tomi.valkeinen@ti.com>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49921 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932164AbbBZMtj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 07:49:39 -0500
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DISPC can drive data lines either on rising or falling pixel clock edge,
which can be configured by the user.

Sync lines can also be driven on rising or falling pixel clock edge, but
additionally the HW can be configured to drive the sync lines on
opposite clock edge from the data lines.

This opposite edge setting does not make any sense, as the same effect
can be achieved by just setting the sync lines to be driven on the other
edge compared to the data lines. It feels like some kind of backward
compatibility option, even if all DSS versions seem to have the same
implementation.

To simplify the code and configuration of the signals, and to make the
dispc timings more compatible with what is used on other platforms,
let's just remove the whole opposite-edge support.

The drivers that used OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES setting are
changed so that they use the opposite setting from the data edge.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c                       |  2 +-
 drivers/video/fbdev/omap2/displays-new/connector-dvi.c         |  2 +-
 .../video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c  |  2 +-
 .../video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c   |  2 +-
 drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c  |  2 +-
 drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c  |  2 +-
 drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c  |  2 +-
 drivers/video/fbdev/omap2/dss/dispc.c                          | 10 +++-------
 drivers/video/fbdev/omap2/dss/display.c                        |  4 +++-
 drivers/video/fbdev/omap2/dss/dsi.c                            |  2 +-
 drivers/video/fbdev/omap2/dss/rfbi.c                           |  2 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c                 |  4 ++--
 include/video/omapdss.h                                        |  1 -
 13 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index a94b11f7859d..2c2173bc3f00 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -102,7 +102,7 @@ void copy_timings_drm_to_omap(struct omap_video_timings *timings,
 
 	timings->data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 	timings->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
-	timings->sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
+	timings->sync_pclk_edge = OMAPDSS_DRIVE_SIG_FALLING_EDGE;
 }
 
 static enum drm_connector_status omap_connector_detect(
diff --git a/drivers/video/fbdev/omap2/displays-new/connector-dvi.c b/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
index 0cdc97413020..a8ce920fa797 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
@@ -37,7 +37,7 @@ static const struct omap_video_timings dvic_default_timings = {
 	.hsync_level	= OMAPDSS_SIG_ACTIVE_HIGH,
 	.data_pclk_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
 	.de_level	= OMAPDSS_SIG_ACTIVE_HIGH,
-	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
+	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 };
 
 struct panel_drv_data {
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
index 27d4fcfa1824..9974a37a11af 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
@@ -37,7 +37,7 @@ static struct omap_video_timings lb035q02_timings = {
 	.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 	.data_pclk_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
 	.de_level	= OMAPDSS_SIG_ACTIVE_HIGH,
-	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
+	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 };
 
 struct panel_drv_data {
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
index 18b19b6e1ac2..eae263702964 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
@@ -54,7 +54,7 @@ static const struct omap_video_timings sharp_ls_timings = {
 	.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 	.data_pclk_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
 	.de_level	= OMAPDSS_SIG_ACTIVE_HIGH,
-	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
+	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 };
 
 #define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev)
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
index 337ccc5c0f5e..90cbc4c3406c 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
@@ -108,7 +108,7 @@ static const struct omap_video_timings acx565akm_panel_timings = {
 
 	.data_pclk_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
 	.de_level	= OMAPDSS_SIG_ACTIVE_HIGH,
-	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
+	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 };
 
 #define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev)
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
index fbba0b8ca871..9edc51133c59 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
@@ -58,7 +58,7 @@ static struct omap_video_timings td028ttec1_panel_timings = {
 
 	.data_pclk_edge	= OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 	.de_level	= OMAPDSS_SIG_ACTIVE_HIGH,
-	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
+	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
 };
 
 #define JBT_COMMAND	0x000
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
index 5aba76bca25a..79e4a029aab9 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
@@ -91,7 +91,7 @@ static const struct omap_video_timings tpo_td043_timings = {
 	.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 	.data_pclk_edge	= OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 	.de_level	= OMAPDSS_SIG_ACTIVE_HIGH,
-	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
+	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
 };
 
 #define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev)
diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index a19a1d4b2d19..11bd780fcdfa 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2934,22 +2934,18 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 	case OMAPDSS_DRIVE_SIG_FALLING_EDGE:
 		ipc = true;
 		break;
-	case OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES:
 	default:
 		BUG();
 	}
 
+	/* always use the 'rf' setting */
+	onoff = true;
+
 	switch (sync_pclk_edge) {
-	case OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES:
-		onoff = false;
-		rf = false;
-		break;
 	case OMAPDSS_DRIVE_SIG_FALLING_EDGE:
-		onoff = true;
 		rf = false;
 		break;
 	case OMAPDSS_DRIVE_SIG_RISING_EDGE:
-		onoff = true;
 		rf = true;
 		break;
 	default:
diff --git a/drivers/video/fbdev/omap2/dss/display.c b/drivers/video/fbdev/omap2/dss/display.c
index 2412a0dd0c13..a6fd2d35ad60 100644
--- a/drivers/video/fbdev/omap2/dss/display.c
+++ b/drivers/video/fbdev/omap2/dss/display.c
@@ -295,7 +295,9 @@ void videomode_to_omap_video_timings(const struct videomode *vm,
 		OMAPDSS_DRIVE_SIG_RISING_EDGE :
 		OMAPDSS_DRIVE_SIG_FALLING_EDGE;
 
-	ovt->sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
+	ovt->sync_pclk_edge = vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE ?
+		OMAPDSS_DRIVE_SIG_FALLING_EDGE :
+		OMAPDSS_DRIVE_SIG_RISING_EDGE;
 }
 EXPORT_SYMBOL(videomode_to_omap_video_timings);
 
diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 5081f6fb1737..28b0bc11669d 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -4137,7 +4137,7 @@ static int dsi_display_init_dispc(struct platform_device *dsidev,
 	dsi->timings.vsync_level = OMAPDSS_SIG_ACTIVE_HIGH;
 	dsi->timings.data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 	dsi->timings.de_level = OMAPDSS_SIG_ACTIVE_HIGH;
-	dsi->timings.sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
+	dsi->timings.sync_pclk_edge = OMAPDSS_DRIVE_SIG_FALLING_EDGE;
 
 	dss_mgr_set_timings(mgr, &dsi->timings);
 
diff --git a/drivers/video/fbdev/omap2/dss/rfbi.c b/drivers/video/fbdev/omap2/dss/rfbi.c
index 28e694b11ff9..065effca9236 100644
--- a/drivers/video/fbdev/omap2/dss/rfbi.c
+++ b/drivers/video/fbdev/omap2/dss/rfbi.c
@@ -869,7 +869,7 @@ static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
 	rfbi.timings.vsync_level = OMAPDSS_SIG_ACTIVE_HIGH;
 	rfbi.timings.data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 	rfbi.timings.de_level = OMAPDSS_SIG_ACTIVE_HIGH;
-	rfbi.timings.sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
+	rfbi.timings.sync_pclk_edge = OMAPDSS_DRIVE_SIG_FALLING_EDGE;
 
 	dss_mgr_set_timings(mgr, &rfbi.timings);
 }
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index 22f07f88bc40..4f0cbb54d4db 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -2073,7 +2073,7 @@ static int omapfb_mode_to_timings(const char *mode_str,
 	} else {
 		timings->data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 		timings->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
-		timings->sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
+		timings->sync_pclk_edge = OMAPDSS_DRIVE_SIG_FALLING_EDGE;
 	}
 
 	timings->pixelclock = PICOS2KHZ(var->pixclock) * 1000;
@@ -2223,7 +2223,7 @@ static void fb_videomode_to_omap_timings(struct fb_videomode *m,
 	} else {
 		t->data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 		t->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
-		t->sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
+		t->sync_pclk_edge = OMAPDSS_DRIVE_SIG_FALLING_EDGE;
 	}
 
 	t->x_res = m->xres;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 60de61fea8e3..7414e4a97508 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -134,7 +134,6 @@ enum omap_dss_signal_level {
 };
 
 enum omap_dss_signal_edge {
-	OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
 	OMAPDSS_DRIVE_SIG_RISING_EDGE,
 	OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 };
-- 
2.3.0

