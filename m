From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 18/21] OMAP: DSS2: Taal: Add panel specific configuration structure
Date: Wed,  5 May 2010 17:27:38 +0300
Message-ID: <e149b5cf7d3dbed1961e06dc82291412e3223101.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
 <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
 <94d9d7bebbf7588bd77b65e6a46044240140a350.1273067195.git.ext-jani.1.nikula@nokia.com>
 <61a89461654fe44174902f6e29b8acded7529b67.1273067195.git.ext-jani.1.nikula@nokia.com>
 <16a98ca1b45ba9b9bb30f23d242449c1d440df07.1273067195.git.ext-jani.1.nikula@nokia.com>
 <aa1e310d0d385db39b5d53ba4d3dcf02b7e2f47f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <0cfff2a3cbb4231b41b382caf8aab7c52f47b0d5.1273067195.git.ext-jani.1.nikula@nokia.com>
 <adb61d94ee2a25284f6bd3f55ec4213501cbe8e3.1273067195.git.ext-jani.1.nikula@nokia.com>
 <4cb510ffbc3216e2a7dac16edaff5fb1980b3315.1273067195.git.ext-jani.1.nikula@nokia.com>
 <8665676eca5bbd3be35b63f7110f629e94a6babe.1273067195.git.ext-jani.1.nikula@nokia.com>
 <a4e7d90e0f036e227a29d94e28b7036c2f9d419b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <ca7ff2e5a165ca8488190520f1f75e6e37642d3b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <4f2a95d67d2b8004f4a2055681690920ebeb8e8f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <690ef5c45aee3fb87a40fa03039356f8238925dc.1273067195.git.ext-jani.1.nikula@nokia.com>
 <025c12267d4bd88e1f59d9e13aafec247fe3c730.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34147 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932530Ab0EEO2S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:18 -0400
In-Reply-To: <025c12267d4bd88e1f59d9e13aafec247fe3c730.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Add a structure for panel specific configration to be able to support
more than one panel in the future.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |  108 +++++++++++++++++++++++------
 1 files changed, 87 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 9502a4d..9f40f32 100644
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
 
@@ -686,9 +755,6 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	u8 id1, id2, id3;
 	int r;
 
-	/* it seems we have to wait a bit until taal is ready */
-	msleep(5);
-
 	r = omapdss_dsi_display_enable(dssdev);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to enable DSI\n");
@@ -774,7 +840,7 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 	r = taal_dcs_write_0(DCS_DISPLAY_OFF);
 	if (!r) {
 		r = taal_sleep_in(td);
-		/* wait a bit so that the message goes through */
+		/* HACK: wait a bit so that the message goes through */
 		msleep(10);
 	}
 
@@ -1036,6 +1102,7 @@ static int taal_sync(struct omap_dss_device *dssdev)
 
 static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
@@ -1047,9 +1114,8 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
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

