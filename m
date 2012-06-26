From: Archit Taneja <archit@ti.com>
Subject: [PATCH 11/17] OMAPDSS: Remove omap_panel_config enum from omap_dss_device
Date: Tue, 26 Jun 2012 15:06:48 +0530
Message-ID: <1340703414-1915-13-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37208 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab2FZJjJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 05:39:09 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

omap_panel_config contains fields which are finally written to DISPC_POL_FREQo
registers. These are now held by omap_video_timings and are set when the manager
timings are applied.

Remove the omap_panel_config enum, and remove all it's references from panel or
interface drivers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c     |    1 -
 drivers/video/omap2/displays/panel-generic-dpi.c   |   29 --------------------
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    1 -
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    2 --
 drivers/video/omap2/displays/panel-picodlp.c       |    2 --
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    1 -
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    2 --
 drivers/video/omap2/dss/hdmi_panel.c               |    2 --
 drivers/video/omap2/dss/sdi.c                      |    2 --
 include/video/omapdss.h                            |   11 --------
 10 files changed, 53 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index 067c8a8..c6a2d51 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -501,7 +501,6 @@ static int acx_panel_probe(struct omap_dss_device *dssdev)
 	struct backlight_properties props;
 
 	dev_dbg(&dssdev->dev, "%s\n", __func__);
-	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
 
 	/* FIXME AC bias ? */
 	dssdev->panel.timings = acx_panel_timings;
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index e5bba0b..96e3d2b 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -40,8 +40,6 @@
 struct panel_config {
 	struct omap_video_timings timings;
 
-	enum omap_panel_config config;
-
 	int power_on_delay;
 	int power_off_delay;
 
@@ -73,8 +71,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
-						OMAP_DSS_LCD_IEO,
 		.power_on_delay		= 50,
 		.power_off_delay	= 100,
 		.name			= "sharp_lq",
@@ -99,7 +95,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 50,
 		.power_off_delay	= 100,
 		.name			= "sharp_ls",
@@ -126,9 +121,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.pclk_edge		= OMAPDSS_SIG_ACTIVE_LOW,
 			.hsync_vsync_edge	= OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
-						OMAP_DSS_LCD_IPC |
-						OMAP_DSS_LCD_ONOFF,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "toppoly_tdo35s",
@@ -153,7 +145,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "samsung_lte430wq_f0c",
@@ -178,7 +169,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "seiko_70wvw1tz3",
@@ -204,8 +194,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.de_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
-						OMAP_DSS_LCD_IEO,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "powertip_ph480272t",
@@ -230,7 +218,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "innolux_at070tn83",
@@ -255,7 +242,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.name			= "nec_nl2432dr22-11b",
 	},
 
@@ -297,8 +283,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
-
 		.name			= "apollon",
 	},
 	/* FocalTech ETM070003DH6 */
@@ -320,7 +304,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.name			= "focaltech_etm070003dh6",
 	},
 
@@ -344,8 +327,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.pclk_edge	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
-						OMAP_DSS_LCD_IPC,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "microtips_umsh_8173md",
@@ -390,9 +371,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.de_level	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
-						OMAP_DSS_LCD_IEO,
-
 		.name			= "innolux_at080tn52",
 	},
 
@@ -451,8 +429,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.pclk_edge	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
-						OMAP_DSS_LCD_IPC,
 		.name			= "primeview_pd050vl1",
 	},
 
@@ -476,8 +452,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.pclk_edge	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
-						OMAP_DSS_LCD_IPC,
 		.name			= "primeview_pm070wl4",
 	},
 
@@ -501,8 +475,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
 			.pclk_edge	= OMAPDSS_SIG_ACTIVE_LOW,
 		},
-		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
-						OMAP_DSS_LCD_IPC,
 		.name			= "primeview_pd104slf",
 	},
 };
@@ -592,7 +564,6 @@ static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 	if (!panel_config)
 		return -EINVAL;
 
-	dssdev->panel.config = panel_config->config;
 	dssdev->panel.timings = panel_config->timings;
 
 	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index d9565c4e..d8cfc83 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -85,7 +85,6 @@ static int lb035q02_panel_probe(struct omap_dss_device *dssdev)
 	struct lb035q02_data *ld;
 	int r;
 
-	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
 	dssdev->panel.timings = lb035q02_timings;
 
 	ld = kzalloc(sizeof(*ld), GFP_KERNEL);
diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index ff863d1..bccd451 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -120,8 +120,6 @@ static int nec_8048_panel_probe(struct omap_dss_device *dssdev)
 	struct backlight_properties props;
 	int r;
 
-	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
-				OMAP_DSS_LCD_RF | OMAP_DSS_LCD_ONOFF;
 	dssdev->panel.timings = nec_8048_panel_timings;
 
 	necd = kzalloc(sizeof(*necd), GFP_KERNEL);
diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 95fda38..29705cf 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -418,8 +418,6 @@ static int picodlp_panel_probe(struct omap_dss_device *dssdev)
 	struct i2c_client *picodlp_i2c_client;
 	int r = 0, picodlp_adapter_id;
 
-	dssdev->panel.config = OMAP_DSS_LCD_ONOFF | OMAP_DSS_LCD_IHS |
-				OMAP_DSS_LCD_IVS;
 	dssdev->panel.timings = pico_ls_timings;
 
 	picod =  kzalloc(sizeof(struct picodlp_data), GFP_KERNEL);
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index 9854f35..6d54a1a 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -89,7 +89,6 @@ static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
 	struct sharp_data *sd;
 	int r;
 
-	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
 	dssdev->panel.timings = sharp_ls_timings;
 
 	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index 446cef6..c5a0868 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -409,8 +409,6 @@ static int tpo_td043_probe(struct omap_dss_device *dssdev)
 		return -ENODEV;
 	}
 
-	dssdev->panel.config = OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IVS |
-				OMAP_DSS_LCD_IPC;
 	dssdev->panel.timings = tpo_td043_timings;
 	dssdev->ctrl.pixel_size = 24;
 
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index aa0f3c2..a991840 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -43,8 +43,6 @@ static int hdmi_panel_probe(struct omap_dss_device *dssdev)
 {
 	DSSDBG("ENTER hdmi_panel_probe\n");
 
-	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
-
 	dssdev->panel.timings = (struct omap_video_timings)
 			{ 640, 480, 25175, 96, 16, 48, 2, 11, 31,
 				OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 264efd5..2fd8540 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -78,8 +78,6 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	sdi_basic_init(dssdev);
 
 	/* 15.5.9.1.2 */
-	dssdev->panel.config |= OMAP_DSS_LCD_RF | OMAP_DSS_LCD_ONOFF;
-
 	dssdev->panel.timings.hsync_vsync_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 
 	r = dss_calc_clock_div(t->pixel_clock * 1000, &dss_cinfo, &dispc_cinfo);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 1d1a2be..5de5c9c 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -116,15 +116,6 @@ enum omap_rfbi_te_mode {
 	OMAP_DSS_RFBI_TE_MODE_2 = 2,
 };
 
-enum omap_panel_config {
-	OMAP_DSS_LCD_IVS		= 1<<0,
-	OMAP_DSS_LCD_IHS		= 1<<1,
-	OMAP_DSS_LCD_IPC		= 1<<2,
-	OMAP_DSS_LCD_IEO		= 1<<3,
-	OMAP_DSS_LCD_RF			= 1<<4,
-	OMAP_DSS_LCD_ONOFF		= 1<<5,
-};
-
 enum omap_dss_signal_level {
 	OMAPDSS_SIG_ACTIVE_HIGH,
 	OMAPDSS_SIG_ACTIVE_LOW,
@@ -598,8 +589,6 @@ struct omap_dss_device {
 		/* Unit: line clocks */
 		int acb;	/* ac-bias pin frequency */
 
-		enum omap_panel_config config;
-
 		enum omap_dss_dsi_pixel_format dsi_pix_fmt;
 		enum omap_dss_dsi_mode dsi_mode;
 		struct omap_dss_dsi_videomode_data dsi_vm_data;
-- 
1.7.9.5

