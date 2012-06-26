From: Archit Taneja <archit@ti.com>
Subject: [PATCH 03/17] OMAPDSS: Remove passive matrix LCD support (part 3)
Date: Tue, 26 Jun 2012 15:06:40 +0530
Message-ID: <1340703414-1915-5-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41529 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029Ab2FZJiZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:38:25 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Remove omap_lcd_display_type enum

The enum omap_lcd_display_type is used to configure the lcd display type in
DISPC. Remove this enum and always set display type to TFT by creating function
dss_mgr_set_lcd_type_tft().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   23 +++--------------------
 drivers/video/omap2/dss/dpi.c   |    4 ++--
 drivers/video/omap2/dss/dsi.c   |    9 +++++----
 drivers/video/omap2/dss/dss.h   |    3 +--
 drivers/video/omap2/dss/rfbi.c  |    3 +--
 drivers/video/omap2/dss/sdi.c   |    3 +--
 include/video/omapdss.h         |    5 -----
 7 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3aa8c9c..01c81a7 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2439,29 +2439,12 @@ void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable)
 }
 
 
-void dispc_mgr_set_lcd_display_type(enum omap_channel channel,
-		enum omap_lcd_display_type type)
+void dispc_mgr_set_lcd_type_tft(enum omap_channel channel)
 {
-	int mode;
-
-	switch (type) {
-	case OMAP_DSS_LCD_DISPLAY_STN:
-		mode = 0;
-		break;
-
-	case OMAP_DSS_LCD_DISPLAY_TFT:
-		mode = 1;
-		break;
-
-	default:
-		BUG();
-		return;
-	}
-
 	if (channel == OMAP_DSS_CHANNEL_LCD2)
-		REG_FLD_MOD(DISPC_CONTROL2, mode, 3, 3);
+		REG_FLD_MOD(DISPC_CONTROL2, 1, 3, 3);
 	else
-		REG_FLD_MOD(DISPC_CONTROL, mode, 3, 3);
+		REG_FLD_MOD(DISPC_CONTROL, 1, 3, 3);
 }
 
 void dispc_set_loadmode(enum omap_dss_load_mode mode)
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index e21955c..018be20 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -180,8 +180,8 @@ static void dpi_basic_init(struct omap_dss_device *dssdev)
 	dispc_mgr_set_io_pad_mode(DSS_IO_PAD_MODE_BYPASS);
 	dispc_mgr_enable_stallmode(dssdev->manager->id, false);
 
-	dispc_mgr_set_lcd_display_type(dssdev->manager->id,
-			OMAP_DSS_LCD_DISPLAY_TFT);
+	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
+
 	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
 			dssdev->phy.dpi.data_lines);
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 0eb5452..061bf53 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4383,10 +4383,11 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
 	}
 
-		dispc_mgr_set_lcd_display_type(dssdev->manager->id,
-			OMAP_DSS_LCD_DISPLAY_TFT);
-		dispc_mgr_set_tft_data_lines(dssdev->manager->id,
-			dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt));
+	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
+
+	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
+		dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt));
+
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d33df16..ffbff49 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -411,8 +411,7 @@ bool dispc_mgr_is_channel_enabled(enum omap_channel channel);
 void dispc_mgr_set_io_pad_mode(enum dss_io_pad_mode mode);
 void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable);
 void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
-void dispc_mgr_set_lcd_display_type(enum omap_channel channel,
-		enum omap_lcd_display_type type);
+void dispc_mgr_set_lcd_type_tft(enum omap_channel channel);
 void dispc_mgr_set_timings(enum omap_channel channel,
 		struct omap_video_timings *timings);
 void dispc_mgr_set_pol_freq(enum omap_channel channel,
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 3d8c206..45084d8 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -885,8 +885,7 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 		goto err1;
 	}
 
-	dispc_mgr_set_lcd_display_type(dssdev->manager->id,
-			OMAP_DSS_LCD_DISPLAY_TFT);
+	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
 
 	dispc_mgr_set_io_pad_mode(DSS_IO_PAD_MODE_RFBI);
 	dispc_mgr_enable_stallmode(dssdev->manager->id, true);
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index d07ecc4..1a369de 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -40,8 +40,7 @@ static void sdi_basic_init(struct omap_dss_device *dssdev)
 	dispc_mgr_set_io_pad_mode(DSS_IO_PAD_MODE_BYPASS);
 	dispc_mgr_enable_stallmode(dssdev->manager->id, false);
 
-	dispc_mgr_set_lcd_display_type(dssdev->manager->id,
-			OMAP_DSS_LCD_DISPLAY_TFT);
+	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
 
 	dispc_mgr_set_tft_data_lines(dssdev->manager->id, 24);
 	dispc_lcd_enable_signal_polarity(1);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index e3b7dd1..b9a180f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -99,11 +99,6 @@ enum omap_color_mode {
 	OMAP_DSS_COLOR_XRGB16_1555	= 1 << 18, /* xRGB16 - 1555 */
 };
 
-enum omap_lcd_display_type {
-	OMAP_DSS_LCD_DISPLAY_STN,
-	OMAP_DSS_LCD_DISPLAY_TFT,
-};
-
 enum omap_dss_load_mode {
 	OMAP_DSS_LOAD_CLUT_AND_FRAME	= 0,
 	OMAP_DSS_LOAD_CLUT_ONLY		= 1,
-- 
1.7.9.5

