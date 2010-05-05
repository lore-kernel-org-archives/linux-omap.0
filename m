From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 16/21] OMAP: DSS2: Taal: Use Nokia DSI panel data
Date: Wed,  5 May 2010 17:27:36 +0300
Message-ID: <690ef5c45aee3fb87a40fa03039356f8238925dc.1273067195.git.ext-jani.1.nikula@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65036 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934770Ab0EEO2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:12 -0400
In-Reply-To: <4f2a95d67d2b8004f4a2055681690920ebeb8e8f.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Get board specific information from the Nokia DSI panel data structure
instead of the DSS.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   59 ++++++++++++++++++----------
 1 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 0c259ab..538829b 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -33,6 +33,7 @@
 #include <linux/mutex.h>
 
 #include <plat/display.h>
+#include <plat/nokia-dsi-panel.h>
 
 /* DSI Virtual channel. Hardcoded for now. */
 #define TCH 0
@@ -85,7 +86,6 @@ struct taal_data {
 	bool mirror;
 
 	bool te_enabled;
-	bool use_ext_te;
 
 	atomic_t do_update;
 	struct {
@@ -107,6 +107,12 @@ struct taal_data {
 	struct delayed_work esd_work;
 };
 
+static inline struct nokia_dsi_panel_data
+*get_panel_data(const struct omap_dss_device *dssdev)
+{
+	return (struct nokia_dsi_panel_data *) dssdev->data;
+}
+
 static void taal_esd_work(struct work_struct *work);
 
 static void hw_guard_start(struct taal_data *td, int guard_msec)
@@ -288,6 +294,7 @@ static int taal_bl_update_status(struct backlight_device *dev)
 {
 	struct omap_dss_device *dssdev = dev_get_drvdata(&dev->dev);
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 	int level;
 
@@ -310,10 +317,10 @@ static int taal_bl_update_status(struct backlight_device *dev)
 			r = 0;
 		}
 	} else {
-		if (!dssdev->set_backlight)
+		if (!panel_data->set_backlight)
 			r = -EINVAL;
 		else
-			r = dssdev->set_backlight(dssdev, level);
+			r = panel_data->set_backlight(dssdev, level);
 	}
 
 	mutex_unlock(&td->lock);
@@ -503,16 +510,18 @@ static struct attribute_group taal_attr_group = {
 
 static void taal_hw_reset(struct omap_dss_device *dssdev)
 {
-	if (dssdev->reset_gpio == -1)
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
+
+	if (panel_data->reset_gpio == -1)
 		return;
 
-	gpio_set_value(dssdev->reset_gpio, 1);
+	gpio_set_value(panel_data->reset_gpio, 1);
 	udelay(10);
 	/* reset the panel */
-	gpio_set_value(dssdev->reset_gpio, 0);
+	gpio_set_value(panel_data->reset_gpio, 0);
 	/* assert reset for at least 10us */
 	udelay(10);
-	gpio_set_value(dssdev->reset_gpio, 1);
+	gpio_set_value(panel_data->reset_gpio, 1);
 	/* wait 5ms after releasing reset */
 	msleep(5);
 }
@@ -522,6 +531,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	struct backlight_properties props;
 	struct taal_data *td;
 	struct backlight_device *bldev;
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	const struct omap_video_timings taal_panel_timings = {
@@ -531,6 +541,11 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	dev_dbg(&dssdev->dev, "probe\n");
 
+	if (!panel_data || !panel_data->name) {
+		r = -EINVAL;
+		goto err;
+	}
+
 	dssdev->panel.config = OMAP_DSS_LCD_TFT;
 	dssdev->panel.timings = taal_panel_timings;
 	dssdev->ctrl.pixel_size = 24;
@@ -561,7 +576,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	/* if no platform set_backlight() defined, presume DSI backlight
 	 * control */
 	memset(&props, 0, sizeof(props));
-	if (!dssdev->set_backlight)
+	if (!panel_data->set_backlight)
 		td->use_dsi_bl = true;
 
 	if (td->use_dsi_bl)
@@ -586,8 +601,8 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	taal_bl_update_status(bldev);
 
-	if (dssdev->phy.dsi.ext_te) {
-		int gpio = dssdev->phy.dsi.ext_te_gpio;
+	if (panel_data->use_ext_te) {
+		int gpio = panel_data->ext_te_gpio;
 
 		r = gpio_request(gpio, "taal irq");
 		if (r) {
@@ -610,8 +625,6 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		INIT_DELAYED_WORK_DEFERRABLE(&td->te_timeout_work,
 					taal_te_timeout_work_callback);
 
-		td->use_ext_te = true;
-
 		dev_dbg(&dssdev->dev, "Using GPIO TE\n");
 	}
 
@@ -623,11 +636,11 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	return 0;
 err_sysfs:
-	if (td->use_ext_te)
-		free_irq(gpio_to_irq(dssdev->phy.dsi.ext_te_gpio), dssdev);
+	if (panel_data->use_ext_te)
+		free_irq(gpio_to_irq(panel_data->ext_te_gpio), dssdev);
 err_irq:
-	if (td->use_ext_te)
-		gpio_free(dssdev->phy.dsi.ext_te_gpio);
+	if (panel_data->use_ext_te)
+		gpio_free(panel_data->ext_te_gpio);
 err_gpio:
 	backlight_device_unregister(bldev);
 err_bl:
@@ -641,14 +654,15 @@ err:
 static void taal_remove(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	struct backlight_device *bldev;
 
 	dev_dbg(&dssdev->dev, "remove\n");
 
 	sysfs_remove_group(&dssdev->dev.kobj, &taal_attr_group);
 
-	if (td->use_ext_te) {
-		int gpio = dssdev->phy.dsi.ext_te_gpio;
+	if (panel_data->use_ext_te) {
+		int gpio = panel_data->ext_te_gpio;
 		free_irq(gpio_to_irq(gpio), dssdev);
 		gpio_free(gpio);
 	}
@@ -958,6 +972,7 @@ static int taal_update(struct omap_dss_device *dssdev,
 				    u16 x, u16 y, u16 w, u16 h)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	dev_dbg(&dssdev->dev, "update %d, %d, %d x %d\n", x, y, w, h);
@@ -978,7 +993,7 @@ static int taal_update(struct omap_dss_device *dssdev,
 	if (r)
 		goto err;
 
-	if (td->te_enabled && td->use_ext_te) {
+	if (td->te_enabled && panel_data->use_ext_te) {
 		td->update_region.x = x;
 		td->update_region.y = y;
 		td->update_region.w = w;
@@ -1021,6 +1036,7 @@ static int taal_sync(struct omap_dss_device *dssdev)
 
 static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	if (enable)
@@ -1028,7 +1044,7 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	else
 		r = taal_dcs_write_0(DCS_TEAR_OFF);
 
-	if (!td->use_ext_te)
+	if (!panel_data->use_ext_te)
 		omapdss_dsi_enable_te(dssdev, enable);
 
 	/* XXX for some reason, DSI TE breaks if we don't wait here.
@@ -1272,6 +1288,7 @@ static void taal_esd_work(struct work_struct *work)
 	struct taal_data *td = container_of(work, struct taal_data,
 			esd_work.work);
 	struct omap_dss_device *dssdev = td->dssdev;
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	u8 state1, state2;
 	int r;
 
@@ -1312,7 +1329,7 @@ static void taal_esd_work(struct work_struct *work)
 	}
 	/* Self-diagnostics result is also shown on TE GPIO line. We need
 	 * to re-enable TE after self diagnostics */
-	if (td->use_ext_te && td->te_enabled) {
+	if (td->te_enabled && panel_data->use_ext_te) {
 		r = taal_dcs_write_1(DCS_TEAR_ON, 0);
 		if (r)
 			goto err;
-- 
1.6.5.2

