From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 16/21] OMAP: DSS2: Taal: Use Nokia DSI panel data
Date: Mon,  3 May 2010 09:18:36 +0300
Message-ID: <d76f00a4c763b84d7511a9f0c98eb7117e9e6a3e.1272621452.git.ext-jani.1.nikula@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30960 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab0ECGS4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:56 -0400
In-Reply-To: <df2ca92a00d718b95aa6a7875a4199882c86f513.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
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
index c326e51..b68976b 100644
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
@@ -559,7 +574,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	/* if no platform set_backlight() defined, presume DSI backlight
 	 * control */
 	memset(&props, 0, sizeof(props));
-	if (!dssdev->set_backlight)
+	if (!panel_data->set_backlight)
 		td->use_dsi_bl = true;
 
 	if (td->use_dsi_bl)
@@ -584,8 +599,8 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	taal_bl_update_status(bldev);
 
-	if (dssdev->phy.dsi.ext_te) {
-		int gpio = dssdev->phy.dsi.ext_te_gpio;
+	if (panel_data->use_ext_te) {
+		int gpio = panel_data->ext_te_gpio;
 
 		r = gpio_request(gpio, "taal irq");
 		if (r) {
@@ -608,8 +623,6 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		INIT_DELAYED_WORK_DEFERRABLE(&td->te_timeout_work,
 					taal_te_timeout_work_callback);
 
-		td->use_ext_te = true;
-
 		dev_dbg(&dssdev->dev, "Using GPIO TE\n");
 	}
 
@@ -624,11 +637,11 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
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
@@ -642,14 +655,15 @@ err:
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
@@ -959,6 +973,7 @@ static int taal_update(struct omap_dss_device *dssdev,
 				    u16 x, u16 y, u16 w, u16 h)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	dev_dbg(&dssdev->dev, "update %d, %d, %d x %d\n", x, y, w, h);
@@ -979,7 +994,7 @@ static int taal_update(struct omap_dss_device *dssdev,
 	if (r)
 		goto err;
 
-	if (td->te_enabled && td->use_ext_te) {
+	if (td->te_enabled && panel_data->use_ext_te) {
 		td->update_region.x = x;
 		td->update_region.y = y;
 		td->update_region.w = w;
@@ -1023,6 +1038,7 @@ static int taal_sync(struct omap_dss_device *dssdev)
 static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	td->te_enabled = enable;
@@ -1032,7 +1048,7 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	else
 		r = taal_dcs_write_0(DCS_TEAR_OFF);
 
-	if (!td->use_ext_te)
+	if (!panel_data->use_ext_te)
 		omapdss_dsi_enable_te(dssdev, enable);
 
 	/* XXX for some reason, DSI TE breaks if we don't wait here.
@@ -1265,6 +1281,7 @@ static void taal_esd_work(struct work_struct *work)
 	struct taal_data *td = container_of(work, struct taal_data,
 			esd_work.work);
 	struct omap_dss_device *dssdev = td->dssdev;
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	u8 state1, state2;
 	int r;
 
@@ -1305,7 +1322,7 @@ static void taal_esd_work(struct work_struct *work)
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

