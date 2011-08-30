From: Archit Taneja <archit@ti.com>
Subject: [PATCH 08/10] OMAP: DSS2: Clean up stallmode and io pad mode selection
Date: Tue, 30 Aug 2011 16:21:33 +0530
Message-ID: <1314701495-11247-9-git-send-email-archit@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37619 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab1H3Kxg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 06:53:36 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7UAralE009699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:36 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UAraG7009433
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:36 -0500 (CDT)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UAra0S025411
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:36 -0500 (CDT)
In-Reply-To: <1314701495-11247-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Split the function dispc_set_parallel_interface_mode() into 2 separate
functions called dispc_mgr_set_io_pad_mode() and dispc_mgr_enable_stallmode().
The current function tries to set 2 different modes(io pad mode and stall mode)
based on a parameter omap_parallel_interface_mode which loosely corresponds to
the panel interface type.

This isn't correct because a) these 2 modes are independent to some extent,
b) we are currently configuring gpout0/gpout1 for DSI panels which is
unnecessary, c) a DSI Video mode panel won't get configured correctly.

Splitting the functions allows the interface driver to set these modes
independently and hence allow more flexibility.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   47 +++++++++++++++++---------------------
 drivers/video/omap2/dss/dpi.c   |    5 ++-
 drivers/video/omap2/dss/dsi.c   |    3 +-
 drivers/video/omap2/dss/dss.h   |   12 +++++-----
 drivers/video/omap2/dss/rfbi.c  |    4 +-
 drivers/video/omap2/dss/sdi.c   |    4 +-
 6 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d156a52..4107e0b 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2205,46 +2205,41 @@ void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 		REG_FLD_MOD(DISPC_CONTROL, code, 9, 8);
 }
 
-void dispc_mgr_set_parallel_interface_mode(enum omap_channel channel,
-		enum omap_parallel_interface_mode mode)
+void dispc_mgr_set_io_pad_mode(enum dss_io_pad_mode mode)
 {
 	u32 l;
-	int stallmode;
-	int gpout0 = 1;
-	int gpout1;
+	int gpout0, gpout1;
 
 	switch (mode) {
-	case OMAP_DSS_PARALLELMODE_BYPASS:
-		stallmode = 0;
-		gpout1 = 1;
+	case DSS_IO_PAD_MODE_RESET:
+		gpout0 = 0;
+		gpout1 = 0;
 		break;
-
-	case OMAP_DSS_PARALLELMODE_RFBI:
-		stallmode = 1;
+	case DSS_IO_PAD_MODE_RFBI:
+		gpout0 = 1;
 		gpout1 = 0;
 		break;
-
-	case OMAP_DSS_PARALLELMODE_DSI:
-		stallmode = 1;
+	case DSS_IO_PAD_MODE_BYPASS:
+		gpout0 = 1;
 		gpout1 = 1;
 		break;
-
 	default:
 		BUG();
 		return;
 	}
 
-	if (channel == OMAP_DSS_CHANNEL_LCD2) {
-		l = dispc_read_reg(DISPC_CONTROL2);
-		l = FLD_MOD(l, stallmode, 11, 11);
-		dispc_write_reg(DISPC_CONTROL2, l);
-	} else {
-		l = dispc_read_reg(DISPC_CONTROL);
-		l = FLD_MOD(l, stallmode, 11, 11);
-		l = FLD_MOD(l, gpout0, 15, 15);
-		l = FLD_MOD(l, gpout1, 16, 16);
-		dispc_write_reg(DISPC_CONTROL, l);
-	}
+	l = dispc_read_reg(DISPC_CONTROL);
+	l = FLD_MOD(l, gpout0, 15, 15);
+	l = FLD_MOD(l, gpout1, 16, 16);
+	dispc_write_reg(DISPC_CONTROL, l);
+}
+
+void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable)
+{
+	if (channel == OMAP_DSS_CHANNEL_LCD2)
+		REG_FLD_MOD(DISPC_CONTROL2, enable, 11, 11);
+	else
+		REG_FLD_MOD(DISPC_CONTROL, enable, 11, 11);
 }
 
 static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 1edc832..483888a 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -166,8 +166,9 @@ static void dpi_basic_init(struct omap_dss_device *dssdev)
 
 	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
 
-	dispc_mgr_set_parallel_interface_mode(dssdev->manager->id,
-			OMAP_DSS_PARALLELMODE_BYPASS);
+	dispc_mgr_set_io_pad_mode(DSS_IO_PAD_MODE_BYPASS);
+	dispc_mgr_enable_stallmode(dssdev->manager->id, false);
+
 	dispc_mgr_set_lcd_display_type(dssdev->manager->id, is_tft ?
 			OMAP_DSS_LCD_DISPLAY_TFT : OMAP_DSS_LCD_DISPLAY_STN);
 	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 20cad1b..c2c2fa7 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4019,8 +4019,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 	dispc_mgr_set_lcd_display_type(dssdev->manager->id,
 			OMAP_DSS_LCD_DISPLAY_TFT);
 
-	dispc_mgr_set_parallel_interface_mode(dssdev->manager->id,
-			OMAP_DSS_PARALLELMODE_DSI);
+	dispc_mgr_enable_stallmode(dssdev->manager->id, true);
 	dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 1);
 
 	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3ec8dd7..f4196f5 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -97,10 +97,10 @@ extern unsigned int dss_debug;
 #define FLD_MOD(orig, val, start, end) \
 	(((orig) & ~FLD_MASK(start, end)) | FLD_VAL(val, start, end))
 
-enum omap_parallel_interface_mode {
-	OMAP_DSS_PARALLELMODE_BYPASS,		/* MIPI DPI */
-	OMAP_DSS_PARALLELMODE_RFBI,		/* MIPI DBI */
-	OMAP_DSS_PARALLELMODE_DSI,
+enum dss_io_pad_mode {
+	DSS_IO_PAD_MODE_RESET,
+	DSS_IO_PAD_MODE_RFBI,
+	DSS_IO_PAD_MODE_BYPASS,
 };
 
 enum dss_hdmi_venc_clk_source_select {
@@ -429,8 +429,8 @@ bool dispc_mgr_go_busy(enum omap_channel channel);
 void dispc_mgr_go(enum omap_channel channel);
 void dispc_mgr_enable(enum omap_channel channel, bool enable);
 bool dispc_mgr_is_channel_enabled(enum omap_channel channel);
-void dispc_mgr_set_parallel_interface_mode(enum omap_channel channel,
-		enum omap_parallel_interface_mode mode);
+void dispc_mgr_set_io_pad_mode(enum dss_io_pad_mode mode);
+void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable);
 void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
 void dispc_mgr_set_lcd_display_type(enum omap_channel channel,
 		enum omap_lcd_display_type type);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index b4a131a..1bd3703 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -868,8 +868,8 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 	dispc_mgr_set_lcd_display_type(dssdev->manager->id,
 			OMAP_DSS_LCD_DISPLAY_TFT);
 
-	dispc_mgr_set_parallel_interface_mode(dssdev->manager->id,
-			OMAP_DSS_PARALLELMODE_RFBI);
+	dispc_mgr_set_io_pad_mode(DSS_IO_PAD_MODE_RFBI);
+	dispc_mgr_enable_stallmode(dssdev->manager->id, true);
 
 	dispc_mgr_set_tft_data_lines(dssdev->manager->id, dssdev->ctrl.pixel_size);
 
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index e2f35c0..695dc04 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -35,8 +35,8 @@ static struct {
 static void sdi_basic_init(struct omap_dss_device *dssdev)
 
 {
-	dispc_mgr_set_parallel_interface_mode(dssdev->manager->id,
-			OMAP_DSS_PARALLELMODE_BYPASS);
+	dispc_mgr_set_io_pad_mode(DSS_IO_PAD_MODE_BYPASS);
+	dispc_mgr_enable_stallmode(dssdev->manager->id, false);
 
 	dispc_mgr_set_lcd_display_type(dssdev->manager->id,
 			OMAP_DSS_LCD_DISPLAY_TFT);
-- 
1.7.1

