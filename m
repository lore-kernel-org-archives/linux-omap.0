From: Archit Taneja <archit@ti.com>
Subject: [PATCH 02/17] OMAPDSS: Remove passive matrix lcd support (part 2)
Date: Tue, 26 Jun 2012 15:06:38 +0530
Message-ID: <1340703414-1915-3-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37149 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab2FZJiP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 05:38:15 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Remove OMAP_DSS_LCD_TFT as a omap_panel_config flag.

We don't support passive matrix displays any more. Remove this flag from all the
panel drivers.

Force the display_type to OMAP_DSS_LCD_DISPLAY_TFT in the interface drivers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c     |    4 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |   61 ++++++++------------
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    3 +-
 drivers/video/omap2/displays/panel-n8x0.c          |    1 -
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    5 +-
 drivers/video/omap2/displays/panel-picodlp.c       |    4 +-
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    3 +-
 drivers/video/omap2/displays/panel-taal.c          |    1 -
 drivers/video/omap2/displays/panel-tfp410.c        |    1 -
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    4 +-
 drivers/video/omap2/dss/display.c                  |    4 --
 drivers/video/omap2/dss/dpi.c                      |    8 +--
 drivers/video/omap2/dss/hdmi_panel.c               |    3 +-
 include/video/omapdss.h                            |    2 -
 14 files changed, 37 insertions(+), 67 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index f7821f7..8264043 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -498,8 +498,8 @@ static int acx_panel_probe(struct omap_dss_device *dssdev)
 	struct backlight_properties props;
 
 	dev_dbg(&dssdev->dev, "%s\n", __func__);
-	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					OMAP_DSS_LCD_IHS;
+	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
+
 	/* FIXME AC bias ? */
 	dssdev->panel.timings = acx_panel_timings;
 
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index bd2700c..3e47490 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -76,8 +76,8 @@ static struct panel_config generic_dpi_panels[] = {
 		},
 		.acbi			= 0x0,
 		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
+						OMAP_DSS_LCD_IEO,
 		.power_on_delay		= 50,
 		.power_off_delay	= 100,
 		.name			= "sharp_lq",
@@ -101,8 +101,7 @@ static struct panel_config generic_dpi_panels[] = {
 		},
 		.acbi			= 0x0,
 		.acb			= 0x28,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-						OMAP_DSS_LCD_IHS,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 50,
 		.power_off_delay	= 100,
 		.name			= "sharp_ls",
@@ -126,9 +125,9 @@ static struct panel_config generic_dpi_panels[] = {
 		},
 		.acbi			= 0x0,
 		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC |
-					OMAP_DSS_LCD_ONOFF,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
+						OMAP_DSS_LCD_IPC |
+						OMAP_DSS_LCD_ONOFF,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "toppoly_tdo35s",
@@ -152,8 +151,7 @@ static struct panel_config generic_dpi_panels[] = {
 		},
 		.acbi			= 0x0,
 		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-						OMAP_DSS_LCD_IHS,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "samsung_lte430wq_f0c",
@@ -177,8 +175,7 @@ static struct panel_config generic_dpi_panels[] = {
 		},
 		.acbi			= 0x0,
 		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-						OMAP_DSS_LCD_IHS,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "seiko_70wvw1tz3",
@@ -202,8 +199,8 @@ static struct panel_config generic_dpi_panels[] = {
 		},
 		.acbi			= 0x0,
 		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
+						OMAP_DSS_LCD_IEO,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "powertip_ph480272t",
@@ -227,8 +224,7 @@ static struct panel_config generic_dpi_panels[] = {
 		},
 		.acbi			= 0x0,
 		.acb			= 0x28,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "innolux_at070tn83",
@@ -250,8 +246,7 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 2,
 			.vbp		= 7,
 		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-						OMAP_DSS_LCD_IHS,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.name			= "nec_nl2432dr22-11b",
 	},
 
@@ -271,8 +266,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 1,
 			.vbp		= 1,
 		},
-		.config			= OMAP_DSS_LCD_TFT,
-
 		.name			= "h4",
 	},
 
@@ -292,8 +285,7 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 2,
 			.vbp		= 2,
 		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-						OMAP_DSS_LCD_IHS,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 
 		.name			= "apollon",
 	},
@@ -313,8 +305,7 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 13,
 			.vbp		= 29,
 		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS,
 		.name			= "focaltech_etm070003dh6",
 	},
 
@@ -336,8 +327,8 @@ static struct panel_config generic_dpi_panels[] = {
 		},
 		.acbi			= 0x0,
 		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
+						OMAP_DSS_LCD_IPC,
 		.power_on_delay		= 0,
 		.power_off_delay	= 0,
 		.name			= "microtips_umsh_8173md",
@@ -359,8 +350,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 4,
 			.vbp		= 2,
 		},
-		.config			= OMAP_DSS_LCD_TFT,
-
 		.name			= "ortustech_com43h4m10xtc",
 	},
 
@@ -381,8 +370,8 @@ static struct panel_config generic_dpi_panels[] = {
 			.vbp		= 23,
 		},
 		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
+						OMAP_DSS_LCD_IEO,
 
 		.name			= "innolux_at080tn52",
 	},
@@ -402,7 +391,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 26,
 			.vbp		= 1,
 		},
-		.config			= OMAP_DSS_LCD_TFT,
 		.name			= "mitsubishi_aa084sb01",
 	},
 	/* EDT ET0500G0DH6 */
@@ -420,7 +408,6 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 35,
 			.vbp		= 10,
 		},
-		.config			= OMAP_DSS_LCD_TFT,
 		.name			= "edt_et0500g0dh6",
 	},
 
@@ -440,8 +427,8 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 10,
 			.vbp		= 33,
 		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
+						OMAP_DSS_LCD_IPC,
 		.name			= "primeview_pd050vl1",
 	},
 
@@ -461,8 +448,8 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 10,
 			.vbp		= 33,
 		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
+						OMAP_DSS_LCD_IPC,
 		.name			= "primeview_pm070wl4",
 	},
 
@@ -482,8 +469,8 @@ static struct panel_config generic_dpi_panels[] = {
 			.vfp		= 1,
 			.vbp		= 23,
 		},
-		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.config			= OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
+						OMAP_DSS_LCD_IPC,
 		.name			= "primeview_pd104slf",
 	},
 };
diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index b4a1555..474a003 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -82,8 +82,7 @@ static int lb035q02_panel_probe(struct omap_dss_device *dssdev)
 	struct lb035q02_data *ld;
 	int r;
 
-	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-		OMAP_DSS_LCD_IHS;
+	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
 	dssdev->panel.timings = lb035q02_timings;
 
 	ld = kzalloc(sizeof(*ld), GFP_KERNEL);
diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index dcbd00e..e68d11d 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -473,7 +473,6 @@ static int n8x0_panel_probe(struct omap_dss_device *dssdev)
 
 	mutex_init(&ddata->lock);
 
-	dssdev->panel.config = OMAP_DSS_LCD_TFT;
 	dssdev->panel.timings.x_res = 800;
 	dssdev->panel.timings.y_res = 480;
 	dssdev->ctrl.pixel_size = 16;
diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index 8717b43..e4153f3 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -116,9 +116,8 @@ static int nec_8048_panel_probe(struct omap_dss_device *dssdev)
 	struct backlight_properties props;
 	int r;
 
-	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-				OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_RF |
-				OMAP_DSS_LCD_ONOFF;
+	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS |
+				OMAP_DSS_LCD_RF | OMAP_DSS_LCD_ONOFF;
 	dssdev->panel.timings = nec_8048_panel_timings;
 
 	necd = kzalloc(sizeof(*necd), GFP_KERNEL);
diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 13012f9..44627f9 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -414,8 +414,8 @@ static int picodlp_panel_probe(struct omap_dss_device *dssdev)
 	struct i2c_client *picodlp_i2c_client;
 	int r = 0, picodlp_adapter_id;
 
-	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_ONOFF |
-				OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IVS;
+	dssdev->panel.config = OMAP_DSS_LCD_ONOFF | OMAP_DSS_LCD_IHS |
+				OMAP_DSS_LCD_IVS;
 	dssdev->panel.acb = 0x0;
 	dssdev->panel.timings = pico_ls_timings;
 
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index 47ea1d1..98a0ff5 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -86,8 +86,7 @@ static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
 	struct sharp_data *sd;
 	int r;
 
-	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-		OMAP_DSS_LCD_IHS;
+	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
 	dssdev->panel.acb = 0x28;
 	dssdev->panel.timings = sharp_ls_timings;
 
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 463a682..a31cba4 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -882,7 +882,6 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	dssdev->panel.config = OMAP_DSS_LCD_TFT;
 	dssdev->panel.timings = panel_config->timings;
 	dssdev->panel.dsi_pix_fmt = OMAP_DSS_DSI_FMT_RGB888;
 
diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index 423f73e..6abadb6 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -95,7 +95,6 @@ static int tfp410_probe(struct omap_dss_device *dssdev)
 		return -ENOMEM;
 
 	dssdev->panel.timings = tfp410_default_timings;
-	dssdev->panel.config = OMAP_DSS_LCD_TFT;
 
 	ddata->dssdev = dssdev;
 	mutex_init(&ddata->lock);
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index 9dbc5e3..9b43714 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -405,8 +405,8 @@ static int tpo_td043_probe(struct omap_dss_device *dssdev)
 		return -ENODEV;
 	}
 
-	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IHS |
-				OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IPC;
+	dssdev->panel.config = OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IVS |
+				OMAP_DSS_LCD_IPC;
 	dssdev->panel.timings = tpo_td043_timings;
 	dssdev->ctrl.pixel_size = 24;
 
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 8aa6f23..37d6504 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -327,10 +327,6 @@ bool dss_use_replication(struct omap_dss_device *dssdev,
 	if (mode != OMAP_DSS_COLOR_RGB12U && mode != OMAP_DSS_COLOR_RGB16)
 		return false;
 
-	if (dssdev->type == OMAP_DISPLAY_TYPE_DPI &&
-			(dssdev->panel.config & OMAP_DSS_LCD_TFT) == 0)
-		return false;
-
 	switch (dssdev->type) {
 	case OMAP_DISPLAY_TYPE_DPI:
 		bpp = dssdev->phy.dpi.data_lines;
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index ca0e45a..e21955c 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -177,15 +177,11 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 
 static void dpi_basic_init(struct omap_dss_device *dssdev)
 {
-	bool is_tft;
-
-	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
-
 	dispc_mgr_set_io_pad_mode(DSS_IO_PAD_MODE_BYPASS);
 	dispc_mgr_enable_stallmode(dssdev->manager->id, false);
 
-	dispc_mgr_set_lcd_display_type(dssdev->manager->id, is_tft ?
-			OMAP_DSS_LCD_DISPLAY_TFT : OMAP_DSS_LCD_DISPLAY_STN);
+	dispc_mgr_set_lcd_display_type(dssdev->manager->id,
+			OMAP_DSS_LCD_DISPLAY_TFT);
 	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
 			dssdev->phy.dpi.data_lines);
 }
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 266b361..b902218 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -43,8 +43,7 @@ static int hdmi_panel_probe(struct omap_dss_device *dssdev)
 {
 	DSSDBG("ENTER hdmi_panel_probe\n");
 
-	dssdev->panel.config = OMAP_DSS_LCD_TFT |
-			OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
+	dssdev->panel.config = OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
 
 	dssdev->panel.timings = (struct omap_video_timings){640, 480, 25175, 96, 16, 48, 2 , 11, 31};
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 5d0f432..e3b7dd1 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -128,8 +128,6 @@ enum omap_panel_config {
 	OMAP_DSS_LCD_IEO		= 1<<3,
 	OMAP_DSS_LCD_RF			= 1<<4,
 	OMAP_DSS_LCD_ONOFF		= 1<<5,
-
-	OMAP_DSS_LCD_TFT		= 1<<20,
 };
 
 enum omap_dss_venc_type {
-- 
1.7.9.5

