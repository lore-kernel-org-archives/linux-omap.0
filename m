From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 18/21] OMAP: DSS2: Taal: Add panel specific configuration structure
Date: Mon,  3 May 2010 09:18:38 +0300
Message-ID: <453fa1efec72cc2a4c029b6791c373a4a2e7ad7d.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
 <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
 <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88fcf26f978d38a25000c2f472a4ad8f79ac285.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ba3a895d56c242fe4edbcfc4abd3c608da3db77a.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1a68710812da041ef583944411a1b7027d216c96.1272621452.git.ext-jani.1.nikula@nokia.com>
 <85172e14c23339065e319230f9707353409a901e.1272621452.git.ext-jani.1.nikula@nokia.com>
 <6e9febe4d2179309dcf93b7a8e897890c871f086.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ad1917b1c316a85051c4a908705d403956ca1720.1272621452.git.ext-jani.1.nikula@nokia.com>
 <4004b06a47d3c1d20d6d8a30ddccdf536faeb5a0.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88e1b382ddf14870c7a44e7ca620ad84d883b50.1272621452.git.ext-jani.1.nikula@nokia.com>
 <5a5dc1e253df571477551b8f63560ad9d1a3ab2b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <df2ca92a00d718b95aa6a7875a4199882c86f513.1272621452.git.ext-jani.1.nikula@nokia.com>
 <d76f00a4c763b84d7511a9f0c98eb7117e9e6a3e.1272621452.git.ext-jani.1.nikula@nokia.com>
 <261f7b2c8cf1120e05d9664137e22ed237657c60.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34496 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab0ECGTC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:19:02 -0400
In-Reply-To: <261f7b2c8cf1120e05d9664137e22ed237657c60.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Add a structure for panel specific configration to be able to support
more than one panel in the future.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |  107 +++++++++++++++++++++++------
 1 files changed, 86 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index f5a1422..508207c 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -68,6 +68,58 @@ static irqreturn_t taal_te_isr(int irq, void *data);
 static void taal_te_timeout_work_callback(struct work_struct *work);
 static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable);
 
+/**
+ * struct panel_config - panel configuration
+ * @name: panel name
+ * @type: panel type
+ * @timings: panel resolution
+ * @sleep: various panel specific delays, passed to msleep() if non-zero
+ * @reset_sequence: reset sequence timings, passed to udelay() if non-zero
+ */
+struct panel_config {
+	const char *name;
+	int type;
+
+	struct omap_video_timings timings;
+
+	struct {
+		unsigned int sleep_in;
+		unsigned int sleep_out;
+		unsigned int hw_reset;
+		unsigned int enable_te;
+	} sleep;
+
+	struct {
+		unsigned int high;
+		unsigned int low;
+	} reset_sequence;
+};
+
+enum {
+	PANEL_TAAL,
+};
+
+static struct panel_config panel_configs[] = {
+	{
+		.name		= "taal",
+		.type		= PANEL_TAAL,
+		.timings	= {
+			.x_res		= 864,
+			.y_res		= 480,
+		},
+		.sleep		= {
+			.sleep_in	= 5,
+			.sleep_out	= 5,
+			.hw_reset	= 5,
+			.enable_te	= 100, /* possible panel bug */
+		},
+		.reset_sequence	= {
+			.high		= 10,
+			.low		= 10,
+		},
+	},
+};
+
 struct taal_data {
 	struct mutex lock;
 
@@ -104,6 +156,8 @@ struct taal_data {
 
 	struct workqueue_struct *esd_wq;
 	struct delayed_work esd_work;
+
+	struct panel_config *panel_config;
 };
 
 static inline struct nokia_dsi_panel_data
@@ -173,7 +227,8 @@ static int taal_sleep_in(struct taal_data *td)
 
 	hw_guard_start(td, 120);
 
-	msleep(5);
+	if (td->panel_config->sleep.sleep_in)
+		msleep(td->panel_config->sleep.sleep_in);
 
 	return 0;
 }
@@ -190,7 +245,8 @@ static int taal_sleep_out(struct taal_data *td)
 
 	hw_guard_start(td, 120);
 
-	msleep(5);
+	if (td->panel_config->sleep.sleep_out)
+		msleep(td->panel_config->sleep.sleep_out);
 
 	return 0;
 }
@@ -509,20 +565,24 @@ static struct attribute_group taal_attr_group = {
 
 static void taal_hw_reset(struct omap_dss_device *dssdev)
 {
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 
 	if (panel_data->reset_gpio == -1)
 		return;
 
 	gpio_set_value(panel_data->reset_gpio, 1);
-	udelay(10);
+	if (td->panel_config->reset_sequence.high)
+		udelay(td->panel_config->reset_sequence.high);
 	/* reset the panel */
 	gpio_set_value(panel_data->reset_gpio, 0);
-	/* assert reset for at least 10us */
-	udelay(10);
+	/* assert reset */
+	if (td->panel_config->reset_sequence.low)
+		udelay(td->panel_config->reset_sequence.low);
 	gpio_set_value(panel_data->reset_gpio, 1);
-	/* wait 5ms after releasing reset */
-	msleep(5);
+	/* wait after releasing reset */
+	if (td->panel_config->sleep.hw_reset)
+		msleep(td->panel_config->sleep.hw_reset);
 }
 
 static int taal_probe(struct omap_dss_device *dssdev)
@@ -531,12 +591,8 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	struct taal_data *td;
 	struct backlight_device *bldev;
 	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
-	int r;
-
-	const struct omap_video_timings taal_panel_timings = {
-		.x_res		= 864,
-		.y_res		= 480,
-	};
+	struct panel_config *panel_config = NULL;
+	int r, i;
 
 	dev_dbg(&dssdev->dev, "probe\n");
 
@@ -545,8 +601,20 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(panel_configs); i++) {
+		if (strcmp(panel_data->name, panel_configs[i].name) == 0) {
+			panel_config = &panel_configs[i];
+			break;
+		}
+	}
+
+	if (!panel_config) {
+		r = -EINVAL;
+		goto err;
+	}
+
 	dssdev->panel.config = OMAP_DSS_LCD_TFT;
-	dssdev->panel.timings = taal_panel_timings;
+	dssdev->panel.timings = panel_config->timings;
 	dssdev->ctrl.pixel_size = 24;
 
 	td = kzalloc(sizeof(*td), GFP_KERNEL);
@@ -555,6 +623,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		goto err;
 	}
 	td->dssdev = dssdev;
+	td->panel_config = panel_config;
 
 	mutex_init(&td->lock);
 
@@ -687,9 +756,6 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	u8 id1, id2, id3;
 	int r;
 
-	/* it seems we have to wait a bit until taal is ready */
-	msleep(5);
-
 	r = omapdss_dsi_display_enable(dssdev);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to enable DSI\n");
@@ -775,7 +841,7 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 	r = taal_dcs_write_0(DCS_DISPLAY_OFF);
 	if (!r) {
 		r = taal_sleep_in(td);
-		/* wait a bit so that the message goes through */
+		/* HACK: wait a bit so that the message goes through */
 		msleep(10);
 	}
 
@@ -1051,9 +1117,8 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	if (!panel_data->use_ext_te)
 		omapdss_dsi_enable_te(dssdev, enable);
 
-	/* XXX for some reason, DSI TE breaks if we don't wait here.
-	 * Panel bug? Needs more studying */
-	msleep(100);
+	if (td->panel_config->sleep.enable_te)
+		msleep(td->panel_config->sleep.enable_te);
 
 	return r;
 }
-- 
1.6.5.2

