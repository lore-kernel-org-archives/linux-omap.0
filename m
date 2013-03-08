From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/20] OMAPDSS: Taal: remove multi-panel support
Date: Fri, 8 Mar 2013 13:51:40 +0200
Message-ID: <1362743515-10152-6-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44105 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756681Ab3CHLwN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 06:52:13 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Taal panel driver was originally meant to support multiple different DSI
command mode panel models. This never realized, and the multi-panel
support code is lying there unused, making the driver more difficult to
maintain.

This patch removes the multi-panel support from Taal driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |  109 ++++-------------------------
 1 file changed, 15 insertions(+), 94 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index a32407a..038a815 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -54,61 +54,6 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable);
 
 static int taal_panel_reset(struct omap_dss_device *dssdev);
 
-/**
- * struct panel_config - panel configuration
- * @name: panel name
- * @type: panel type
- * @timings: panel resolution
- * @sleep: various panel specific delays, passed to msleep() if non-zero
- * @reset_sequence: reset sequence timings, passed to udelay() if non-zero
- * @regulators: array of panel regulators
- * @num_regulators: number of regulators in the array
- */
-struct panel_config {
-	const char *name;
-	int type;
-
-	struct omap_video_timings timings;
-
-	struct {
-		unsigned int sleep_in;
-		unsigned int sleep_out;
-		unsigned int hw_reset;
-		unsigned int enable_te;
-	} sleep;
-
-	struct {
-		unsigned int high;
-		unsigned int low;
-	} reset_sequence;
-
-};
-
-enum {
-	PANEL_TAAL,
-};
-
-static struct panel_config panel_configs[] = {
-	{
-		.name		= "taal",
-		.type		= PANEL_TAAL,
-		.timings	= {
-			.x_res		= 864,
-			.y_res		= 480,
-		},
-		.sleep		= {
-			.sleep_in	= 5,
-			.sleep_out	= 5,
-			.hw_reset	= 5,
-			.enable_te	= 100, /* possible panel bug */
-		},
-		.reset_sequence	= {
-			.high		= 10,
-			.low		= 10,
-		},
-	},
-};
-
 struct taal_data {
 	struct mutex lock;
 
@@ -121,9 +66,6 @@ struct taal_data {
 
 	struct omap_dss_device *dssdev;
 
-	/* panel specific HW info */
-	struct panel_config *panel_config;
-
 	/* panel HW configuration from DT or platform data */
 	int reset_gpio;
 	int ext_te_gpio;
@@ -221,8 +163,7 @@ static int taal_sleep_in(struct taal_data *td)
 
 	hw_guard_start(td, 120);
 
-	if (td->panel_config->sleep.sleep_in)
-		msleep(td->panel_config->sleep.sleep_in);
+	msleep(5);
 
 	return 0;
 }
@@ -239,8 +180,7 @@ static int taal_sleep_out(struct taal_data *td)
 
 	hw_guard_start(td, 120);
 
-	if (td->panel_config->sleep.sleep_out)
-		msleep(td->panel_config->sleep.sleep_out);
+	msleep(5);
 
 	return 0;
 }
@@ -845,17 +785,14 @@ static void taal_hw_reset(struct omap_dss_device *dssdev)
 		return;
 
 	gpio_set_value(td->reset_gpio, 1);
-	if (td->panel_config->reset_sequence.high)
-		udelay(td->panel_config->reset_sequence.high);
+	udelay(10);
 	/* reset the panel */
 	gpio_set_value(td->reset_gpio, 0);
 	/* assert reset */
-	if (td->panel_config->reset_sequence.low)
-		udelay(td->panel_config->reset_sequence.low);
+	udelay(10);
 	gpio_set_value(td->reset_gpio, 1);
 	/* wait after releasing reset */
-	if (td->panel_config->sleep.hw_reset)
-		msleep(td->panel_config->sleep.hw_reset);
+	msleep(5);
 }
 
 static void taal_probe_pdata(struct taal_data *td,
@@ -881,8 +818,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	struct backlight_properties props;
 	struct taal_data *td;
 	struct backlight_device *bldev = NULL;
-	int r, i;
-	const char *panel_name;
+	int r;
 
 	dev_dbg(&dssdev->dev, "probe\n");
 
@@ -897,26 +833,12 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		const struct nokia_dsi_panel_data *pdata = dssdev->data;
 
 		taal_probe_pdata(td, pdata);
-
-		panel_name = pdata->name;
 	} else {
 		return -ENODEV;
 	}
 
-	if (panel_name == NULL)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(panel_configs); i++) {
-		if (strcmp(panel_name, panel_configs[i].name) == 0) {
-			td->panel_config = &panel_configs[i];
-			break;
-		}
-	}
-
-	if (!td->panel_config)
-		return -EINVAL;
-
-	dssdev->panel.timings = td->panel_config->timings;
+	dssdev->panel.timings.x_res = 864;
+	dssdev->panel.timings.y_res = 480;
 	dssdev->panel.dsi_pix_fmt = OMAP_DSS_DSI_FMT_RGB888;
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
@@ -1086,8 +1008,7 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 		goto err;
 
 	/* on early Taal revisions CABC is broken */
-	if (td->panel_config->type == PANEL_TAAL &&
-		(id2 == 0x00 || id2 == 0xff || id2 == 0x81))
+	if (id2 == 0x00 || id2 == 0xff || id2 == 0x81)
 		td->cabc_broken = true;
 
 	r = taal_dcs_write_1(td, DCS_BRIGHTNESS, 0xff);
@@ -1129,8 +1050,8 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	td->enabled = 1;
 
 	if (!td->intro_printed) {
-		dev_info(&dssdev->dev, "%s panel revision %02x.%02x.%02x\n",
-			td->panel_config->name, id1, id2, id3);
+		dev_info(&dssdev->dev, "panel revision %02x.%02x.%02x\n",
+			id1, id2, id3);
 		if (td->cabc_broken)
 			dev_info(&dssdev->dev,
 					"old Taal version, CABC disabled\n");
@@ -1311,8 +1232,8 @@ static int taal_update(struct omap_dss_device *dssdev,
 
 	/* XXX no need to send this every frame, but dsi break if not done */
 	r = taal_set_update_window(td, 0, 0,
-			td->panel_config->timings.x_res,
-			td->panel_config->timings.y_res);
+			dssdev->panel.timings.x_res,
+			dssdev->panel.timings.y_res);
 	if (r)
 		goto err;
 
@@ -1365,8 +1286,8 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	if (!gpio_is_valid(td->ext_te_gpio))
 		omapdss_dsi_enable_te(dssdev, enable);
 
-	if (td->panel_config->sleep.enable_te)
-		msleep(td->panel_config->sleep.enable_te);
+	/* possible panel bug */
+	msleep(100);
 
 	return r;
 }
-- 
1.7.10.4

