From: Archit Taneja <archit@ti.com>
Subject: [PATCH 09/10] OMAP: DSS2: Create an enum for DSI pixel formats
Date: Tue, 30 Aug 2011 16:21:34 +0530
Message-ID: <1314701495-11247-10-git-send-email-archit@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42703 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab1H3Kxk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 06:53:40 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7UAre3b000782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:40 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UAreWM009441
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:40 -0500 (CDT)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UAreVm025479
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:40 -0500 (CDT)
In-Reply-To: <1314701495-11247-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Currently, DSI pixel info is only represented by the pixel size in bits using
the pixel_size parameter in omap_dss_device struct's ctrl member.

This is not sufficient information for DSI video mode usage, as two of the
supported formats(RGB666 loosely packed, and RGB888) have the same pixel
container size, but different data_type values for the video mode packet header.

Create enum "omap_dss_dsi_pixel_format" which describes the pixel data format
the panel is configured for.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |    2 +-
 drivers/video/omap2/dss/dsi.c             |   24 ++++++++++++++++++++----
 include/video/omapdss.h                   |    8 ++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 7675687..ddc696d 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -976,7 +976,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	dssdev->panel.config = OMAP_DSS_LCD_TFT;
 	dssdev->panel.timings = panel_config->timings;
-	dssdev->ctrl.pixel_size = 24;
+	dssdev->panel.dsi_pix_fmt = OMAP_DSS_DSI_FMT_RGB888;
 
 	td = kzalloc(sizeof(*td), GFP_KERNEL);
 	if (!td) {
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index c2c2fa7..582ae7b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -422,6 +422,21 @@ static inline int wait_for_bit_change(struct platform_device *dsidev,
 	return value;
 }
 
+static inline u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt)
+{
+	switch (fmt) {
+	case OMAP_DSS_DSI_FMT_RGB888:
+	case OMAP_DSS_DSI_FMT_RGB666:
+		return 24;
+	case OMAP_DSS_DSI_FMT_RGB666_PACKED:
+		return 18;
+	case OMAP_DSS_DSI_FMT_RGB565:
+		return 16;
+	default:
+		BUG();
+	}
+}
+
 #ifdef DEBUG
 static void dsi_perf_mark_setup(struct platform_device *dsidev)
 {
@@ -438,6 +453,7 @@ static void dsi_perf_mark_start(struct platform_device *dsidev)
 static void dsi_perf_show(struct platform_device *dsidev, const char *name)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_dss_device *dssdev = dsi->update_region.device;
 	ktime_t t, setup_time, trans_time;
 	u32 total_bytes;
 	u32 setup_us, trans_us, total_us;
@@ -461,7 +477,7 @@ static void dsi_perf_show(struct platform_device *dsidev, const char *name)
 
 	total_bytes = dsi->update_region.w *
 		dsi->update_region.h *
-		dsi->update_region.device->ctrl.pixel_size / 8;
+		dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt) / 8;
 
 	printk(KERN_INFO "DSI(%s): %u us + %u us = %u us (%uHz), "
 			"%u bytes, %u kbytes/sec\n",
@@ -3689,7 +3705,7 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 	dsi_set_lp_rx_timeout(dsidev, 0x1fff, true, true);
 	dsi_set_hs_tx_timeout(dsidev, 0x1fff, true, true);
 
-	switch (dssdev->ctrl.pixel_size) {
+	switch (dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt)) {
 	case 16:
 		buswidth = 0;
 		break;
@@ -3814,7 +3830,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 
 	dsi_vc_config_source(dsidev, channel, DSI_VC_SOURCE_VP);
 
-	bytespp	= dssdev->ctrl.pixel_size / 8;
+	bytespp	= dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt) / 8;
 	bytespl = w * bytespp;
 	bytespf = bytespl * h;
 
@@ -4023,7 +4039,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 	dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 1);
 
 	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
-			dssdev->ctrl.pixel_size);
+			dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt));
 
 	{
 		struct omap_video_timings timings = {
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 8c94d95..1e9a35c 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -129,6 +129,13 @@ enum omap_dss_venc_type {
 	OMAP_DSS_VENC_TYPE_SVIDEO,
 };
 
+enum omap_dss_dsi_pixel_format {
+	OMAP_DSS_DSI_FMT_RGB888,
+	OMAP_DSS_DSI_FMT_RGB666,
+	OMAP_DSS_DSI_FMT_RGB666_PACKED,
+	OMAP_DSS_DSI_FMT_RGB565,
+};
+
 enum omap_dss_dsi_mode {
 	OMAP_DSS_DSI_CMD_MODE = 0,
 	OMAP_DSS_DSI_VIDEO_MODE,
@@ -489,6 +496,7 @@ struct omap_dss_device {
 
 		enum omap_panel_config config;
 
+		enum omap_dss_dsi_pixel_format dsi_pix_fmt;
 		enum omap_dss_dsi_mode dsi_mode;
 	} panel;
 
-- 
1.7.1

