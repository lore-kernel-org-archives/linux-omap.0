From: Archit Taneja <archit@ti.com>
Subject: [PATCH 05/17] OMAPDSS: Add some new fields to omap_video_timings
Date: Tue, 26 Jun 2012 15:06:42 +0530
Message-ID: <1340703414-1915-7-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43255 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755744Ab2FZJin (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:38:43 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Some panel timing related fields are contained in omap_panel_config in the form
of flags. The fields are:

- Hsync logic level
- Vsync logic level
- Data driven on rising/falling edge of pixel clock
- Output enable/Data enable logic level
- HSYNC/VSYNC driven on rising/falling edge of pixel clock

Out of these parameters, Hsync and Vsync logic levels are a part of the timings
in the Xorg modeline configuration. So it makes sense to move the to
omap_video_timings. The rest aren't a part of modeline, but it still makes
sense to move these since they are related to panel timings.

These fields stored in omap_panel_config in dssdev are configured for LCD
panels, and the corresponding LCD managers in the DISPC_POL_FREQo registers.

Add the above fields in omap_video_timings. Represent their state via new enums.
The parameter pclk_edge is configured via omap_dss_signal_level, however it
actually configures whether data is driven on the rising or falling edge. This
is a bit unclean, but it prevents us from creating another enum.

Add these parameters to the omap_video_timings instances in the panel drivers.
Keep the corresponding IVS, IHS, IPC, IEO, RF and ONOFF flags in
omap_panel_config for now. The struct will be removed later.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c     |    3 ++
 drivers/video/omap2/displays/panel-generic-dpi.c   |   53 ++++++++++++++++++++
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    3 ++
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    4 ++
 drivers/video/omap2/displays/panel-picodlp.c       |    4 ++
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    3 ++
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    4 ++
 drivers/video/omap2/dss/hdmi_panel.c               |    5 +-
 drivers/video/omap2/dss/sdi.c                      |    2 +
 include/video/omapdss.h                            |   37 ++++++++++++++
 10 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index 8264043..067c8a8 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -487,6 +487,9 @@ static struct omap_video_timings acx_panel_timings = {
 	.vfp		= 3,
 	.vsw		= 3,
 	.vbp		= 4,
+
+	.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+	.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 };
 
 static int acx_panel_probe(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index fe7e48c..e5bba0b 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -69,6 +69,9 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 11,
 			.vfp		= 3,
 			.vbp		= 2,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IEO,
@@ -92,6 +95,9 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 1,
 			.vfp		= 1,
 			.vbp		= 1,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 50,
@@ -114,6 +120,11 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 4,
 			.vsw		= 2,
 			.vbp		= 2,
+
+			.vsync_level		= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level		= OMAPDSS_SIG_ACTIVE_LOW,
+			.pclk_edge		= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_vsync_edge	= OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IPC |
@@ -138,6 +149,9 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 4,
 			.vsw		= 10,
 			.vbp		= 12 - 10,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
@@ -160,6 +174,9 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 2,
 			.vfp		= 4,
 			.vbp		= 11,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
@@ -182,6 +199,10 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 10,
 			.vfp		= 2,
 			.vbp		= 2,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.de_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IEO,
@@ -205,6 +226,9 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 3,
 			.vfp		= 12,
 			.vbp		= 25,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
@@ -227,6 +251,9 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 1,
 			.vfp		= 2,
 			.vbp		= 7,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.name			= "nec_nl2432dr22-11b",
@@ -266,6 +293,9 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 10,
 			.vfp		= 2,
 			.vbp		= 2,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 
@@ -286,6 +316,9 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 3,
 			.vfp		= 13,
 			.vbp		= 29,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.name			= "focaltech_etm070003dh6",
@@ -306,6 +339,10 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 23,
 			.vfp		= 1,
 			.vbp		= 1,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.pclk_edge	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IPC,
@@ -348,6 +385,10 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 10,
 			.vfp		= 12,
 			.vbp		= 23,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.de_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IEO,
@@ -405,6 +446,10 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 2,
 			.vfp		= 10,
 			.vbp		= 33,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.pclk_edge	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IPC,
@@ -426,6 +471,10 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 2,
 			.vfp		= 10,
 			.vbp		= 33,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.pclk_edge	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IPC,
@@ -447,6 +496,10 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsw		= 4,
 			.vfp		= 1,
 			.vbp		= 23,
+
+			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+			.pclk_edge	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
 		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
 						OMAP_DSS_LCD_IPC,
diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index 474a003..d9565c4e 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -40,6 +40,9 @@ static struct omap_video_timings lb035q02_timings = {
 	.vsw		= 2,
 	.vfp		= 4,
 	.vbp		= 18,
+
+	.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+	.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 };
 
 static int lb035q02_panel_power_on(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index e4153f3..ff863d1 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -76,6 +76,10 @@ static struct omap_video_timings nec_8048_panel_timings = {
 	.vfp		= 3,
 	.vsw		= 1,
 	.vbp		= 4,
+
+	.vsync_level		= OMAPDSS_SIG_ACTIVE_LOW,
+	.hsync_level		= OMAPDSS_SIG_ACTIVE_LOW,
+	.hsync_vsync_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
 };
 
 static int nec_8048_bl_update_status(struct backlight_device *bl)
diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 91e44c6..95fda38 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -69,6 +69,10 @@ static struct omap_video_timings pico_ls_timings = {
 	.vsw		= 2,
 	.vfp		= 3,
 	.vbp		= 14,
+
+	.vsync_level		= OMAPDSS_SIG_ACTIVE_LOW,
+	.hsync_level		= OMAPDSS_SIG_ACTIVE_LOW,
+	.hsync_vsync_edge	= OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 };
 
 static inline struct picodlp_panel_data
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index 8070b88..9854f35 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -44,6 +44,9 @@ static struct omap_video_timings sharp_ls_timings = {
 	.vsw		= 1,
 	.vfp		= 1,
 	.vbp		= 1,
+
+	.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+	.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 };
 
 static int sharp_ls_bl_update_status(struct backlight_device *bl)
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index 9b43714..446cef6 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -267,6 +267,10 @@ static const struct omap_video_timings tpo_td043_timings = {
 	.vsw		= 1,
 	.vfp		= 39,
 	.vbp		= 34,
+
+	.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+	.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+	.pclk_edge	= OMAPDSS_SIG_ACTIVE_LOW,
 };
 
 static int tpo_td043_power_on(struct tpo_td043_device *tpo_td043)
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index b902218..aa0f3c2 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -45,7 +45,10 @@ static int hdmi_panel_probe(struct omap_dss_device *dssdev)
 
 	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
 
-	dssdev->panel.timings = (struct omap_video_timings){640, 480, 25175, 96, 16, 48, 2 , 11, 31};
+	dssdev->panel.timings = (struct omap_video_timings)
+			{ 640, 480, 25175, 96, 16, 48, 2, 11, 31,
+				OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
+			};
 
 	DSSDBG("hdmi_panel_probe x_res= %d y_res = %d\n",
 		dssdev->panel.timings.x_res,
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 5268fdb..9330410 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -80,6 +80,8 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	/* 15.5.9.1.2 */
 	dssdev->panel.config |= OMAP_DSS_LCD_RF | OMAP_DSS_LCD_ONOFF;
 
+	dssdev->panel.timings.hsync_vsync_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
+
 	dispc_mgr_set_pol_freq(dssdev->manager->id, dssdev->panel.config);
 
 	r = dss_calc_clock_div(t->pixel_clock * 1000, &dss_cinfo, &dispc_cinfo);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b9a180f..1d1a2be 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -125,6 +125,17 @@ enum omap_panel_config {
 	OMAP_DSS_LCD_ONOFF		= 1<<5,
 };
 
+enum omap_dss_signal_level {
+	OMAPDSS_SIG_ACTIVE_HIGH,
+	OMAPDSS_SIG_ACTIVE_LOW,
+};
+
+enum omap_dss_signal_edge {
+	OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
+	OMAPDSS_DRIVE_SIG_RISING_EDGE,
+	OMAPDSS_DRIVE_SIG_FALLING_EDGE,
+};
+
 enum omap_dss_venc_type {
 	OMAP_DSS_VENC_TYPE_COMPOSITE,
 	OMAP_DSS_VENC_TYPE_SVIDEO,
@@ -377,6 +388,32 @@ struct omap_video_timings {
 	u16 vfp;	/* Vertical front porch */
 	/* Unit: line clocks */
 	u16 vbp;	/* Vertical back porch */
+
+	/*
+	 * Vsync logic level
+	 * default value: OMAPDSS_SIG_ACTIVE_HIGH
+	 */
+	enum omap_dss_signal_level vsync_level;
+	/*
+	 * Hsync logic level
+	 * default value: OMAPDSS_SIG_ACTIVE_HIGH
+	 */
+	enum omap_dss_signal_level hsync_level;
+	/*
+	 * Pixel clock edge to drive LCD data
+	 * default value: OMAPDSS_SIG_ACTIVE_HIGH
+	 */
+	enum omap_dss_signal_level pclk_edge;
+	/*
+	 * Data enable logic level
+	 * default value: OMAPDSS_SIG_ACTIVE_HIGH
+	 */
+	enum omap_dss_signal_level de_level;
+	/*
+	 * Pixel clock edges to drive HSYNC and VSYNC pins
+	 * default value: OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES
+	 */
+	enum omap_dss_signal_edge hsync_vsync_edge;
 };
 
 #ifdef CONFIG_OMAP2_DSS_VENC
-- 
1.7.9.5

