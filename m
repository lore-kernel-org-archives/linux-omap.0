From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/17] OMAPDSS: Taal: Reogranize for device tree
Date: Wed,  5 Sep 2012 11:25:45 +0300
Message-ID: <1346833555-31258-8-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:39450 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758093Ab2IEI01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:27 -0400
Received: by lagy9 with SMTP id y9so139355lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:24 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Reorganize taal driver to make it easier to integrate device tree code.
Instead of storing the panel's platform data, we'll "parse" the platform
data and store the required information in driver's own data. This way
adding device tree data parsing is simple.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |  127 +++++++++++++++++------------
 1 file changed, 74 insertions(+), 53 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 1255864..4cf9416 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -121,6 +121,18 @@ struct taal_data {
 
 	struct omap_dss_device *dssdev;
 
+	/* panel specific HW info */
+	struct panel_config *panel_config;
+
+	/* panel HW configuration from DT or platform data */
+	int reset_gpio;
+	int ext_te_gpio;
+
+	bool use_dsi_backlight;
+
+	struct omap_dsi_pin_config pin_config;
+
+	/* runtime variables */
 	bool enabled;
 	u8 rotate;
 	bool mirror;
@@ -145,16 +157,8 @@ struct taal_data {
 	bool ulps_enabled;
 	unsigned ulps_timeout;
 	struct delayed_work ulps_work;
-
-	struct panel_config *panel_config;
 };
 
-static inline struct nokia_dsi_panel_data
-*get_panel_data(const struct omap_dss_device *dssdev)
-{
-	return (struct nokia_dsi_panel_data *) dssdev->data;
-}
-
 static void taal_esd_work(struct work_struct *work);
 static void taal_ulps_work(struct work_struct *work);
 
@@ -371,7 +375,6 @@ static void taal_cancel_ulps_work(struct omap_dss_device *dssdev)
 static int taal_enter_ulps(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	if (td->ulps_enabled)
@@ -383,7 +386,8 @@ static int taal_enter_ulps(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
-	disable_irq(gpio_to_irq(panel_data->ext_te_gpio));
+	if (gpio_is_valid(td->ext_te_gpio))
+		disable_irq(gpio_to_irq(td->ext_te_gpio));
 
 	omapdss_dsi_display_disable(dssdev, false, true);
 
@@ -405,7 +409,6 @@ err:
 static int taal_exit_ulps(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	if (!td->ulps_enabled)
@@ -425,7 +428,8 @@ static int taal_exit_ulps(struct omap_dss_device *dssdev)
 		goto err2;
 	}
 
-	enable_irq(gpio_to_irq(panel_data->ext_te_gpio));
+	if (gpio_is_valid(td->ext_te_gpio))
+		enable_irq(gpio_to_irq(td->ext_te_gpio));
 
 	taal_queue_ulps_work(dssdev);
 
@@ -438,7 +442,8 @@ err2:
 
 	r = taal_panel_reset(dssdev);
 	if (!r) {
-		enable_irq(gpio_to_irq(panel_data->ext_te_gpio));
+		if (gpio_is_valid(td->ext_te_gpio))
+			enable_irq(gpio_to_irq(td->ext_te_gpio));
 		td->ulps_enabled = false;
 	}
 err1:
@@ -835,71 +840,93 @@ static struct attribute_group taal_attr_group = {
 static void taal_hw_reset(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 
-	if (panel_data->reset_gpio == -1)
+	if (!gpio_is_valid(td->reset_gpio))
 		return;
 
-	gpio_set_value(panel_data->reset_gpio, 1);
+	gpio_set_value(td->reset_gpio, 1);
 	if (td->panel_config->reset_sequence.high)
 		udelay(td->panel_config->reset_sequence.high);
 	/* reset the panel */
-	gpio_set_value(panel_data->reset_gpio, 0);
+	gpio_set_value(td->reset_gpio, 0);
 	/* assert reset */
 	if (td->panel_config->reset_sequence.low)
 		udelay(td->panel_config->reset_sequence.low);
-	gpio_set_value(panel_data->reset_gpio, 1);
+	gpio_set_value(td->reset_gpio, 1);
 	/* wait after releasing reset */
 	if (td->panel_config->sleep.hw_reset)
 		msleep(td->panel_config->sleep.hw_reset);
 }
 
+static void taal_probe_pdata(struct taal_data *td,
+		const struct nokia_dsi_panel_data *pdata)
+{
+	td->reset_gpio = pdata->reset_gpio;
+
+	if (pdata->use_ext_te)
+		td->ext_te_gpio = pdata->ext_te_gpio;
+	else
+		td->ext_te_gpio = -1;
+
+	td->esd_interval = pdata->esd_interval;
+	td->ulps_timeout = pdata->ulps_timeout;
+
+	td->use_dsi_backlight = pdata->use_dsi_backlight;
+
+	td->pin_config = pdata->pin_config;
+}
+
 static int taal_probe(struct omap_dss_device *dssdev)
 {
 	struct backlight_properties props;
 	struct taal_data *td;
 	struct backlight_device *bldev = NULL;
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
-	struct panel_config *panel_config = NULL;
 	int r, i;
+	const char *panel_name;
 
 	dev_dbg(&dssdev->dev, "probe\n");
 
-	if (!panel_data || !panel_data->name)
+	td = devm_kzalloc(&dssdev->dev, sizeof(*td), GFP_KERNEL);
+	if (!td)
+		return -ENOMEM;
+
+	dev_set_drvdata(&dssdev->dev, td);
+	td->dssdev = dssdev;
+
+	if (dssdev->data) {
+		const struct nokia_dsi_panel_data *pdata = dssdev->data;
+
+		taal_probe_pdata(td, pdata);
+
+		panel_name = pdata->name;
+	} else {
+		return -ENODEV;
+	}
+
+	if (panel_name == NULL)
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(panel_configs); i++) {
-		if (strcmp(panel_data->name, panel_configs[i].name) == 0) {
-			panel_config = &panel_configs[i];
+		if (strcmp(panel_name, panel_configs[i].name) == 0) {
+			td->panel_config = &panel_configs[i];
 			break;
 		}
 	}
 
-	if (!panel_config)
+	if (!td->panel_config)
 		return -EINVAL;
 
-	dssdev->panel.timings = panel_config->timings;
+	dssdev->panel.timings = td->panel_config->timings;
 	dssdev->panel.dsi_pix_fmt = OMAP_DSS_DSI_FMT_RGB888;
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
 
-	td = devm_kzalloc(&dssdev->dev, sizeof(*td), GFP_KERNEL);
-	if (!td)
-		return -ENOMEM;
-	td->dssdev = dssdev;
-	td->panel_config = panel_config;
-	td->esd_interval = panel_data->esd_interval;
-	td->ulps_enabled = false;
-	td->ulps_timeout = panel_data->ulps_timeout;
-
 	mutex_init(&td->lock);
 
 	atomic_set(&td->do_update, 0);
 
-	dev_set_drvdata(&dssdev->dev, td);
-
-	if (gpio_is_valid(panel_data->reset_gpio)) {
-		r = devm_gpio_request_one(&dssdev->dev, panel_data->reset_gpio,
+	if (gpio_is_valid(td->reset_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev, td->reset_gpio,
 				GPIOF_OUT_INIT_LOW, "taal rst");
 		if (r) {
 			dev_err(&dssdev->dev, "failed to request reset gpio\n");
@@ -907,17 +934,15 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		}
 	}
 
-	if (panel_data->use_ext_te) {
-		int gpio = panel_data->ext_te_gpio;
-
-		r = devm_gpio_request_one(&dssdev->dev, gpio, GPIOF_IN,
-				"taal irq");
+	if (gpio_is_valid(td->ext_te_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev, td->ext_te_gpio,
+				GPIOF_IN, "taal irq");
 		if (r) {
 			dev_err(&dssdev->dev, "GPIO request failed\n");
 			return r;
 		}
 
-		r = devm_request_irq(&dssdev->dev, gpio_to_irq(gpio),
+		r = devm_request_irq(&dssdev->dev, gpio_to_irq(td->ext_te_gpio),
 				taal_te_isr,
 				IRQF_TRIGGER_RISING,
 				"taal vsync", dssdev);
@@ -943,7 +968,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	taal_hw_reset(dssdev);
 
-	if (panel_data->use_dsi_backlight) {
+	if (td->use_dsi_backlight) {
 		memset(&props, 0, sizeof(struct backlight_properties));
 		props.max_brightness = 255;
 
@@ -1022,11 +1047,10 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 static int taal_power_on(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	u8 id1, id2, id3;
 	int r;
 
-	r = omapdss_dsi_configure_pins(dssdev, &panel_data->pin_config);
+	r = omapdss_dsi_configure_pins(dssdev, &td->pin_config);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to configure DSI pins\n");
 		goto err0;
@@ -1339,7 +1363,6 @@ static int taal_update(struct omap_dss_device *dssdev,
 				    u16 x, u16 y, u16 w, u16 h)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	dev_dbg(&dssdev->dev, "update %d, %d, %d x %d\n", x, y, w, h);
@@ -1363,7 +1386,7 @@ static int taal_update(struct omap_dss_device *dssdev,
 	if (r)
 		goto err;
 
-	if (td->te_enabled && panel_data->use_ext_te) {
+	if (td->te_enabled && gpio_is_valid(td->ext_te_gpio)) {
 		schedule_delayed_work(&td->te_timeout_work,
 				msecs_to_jiffies(250));
 		atomic_set(&td->do_update, 1);
@@ -1402,7 +1425,6 @@ static int taal_sync(struct omap_dss_device *dssdev)
 static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	if (enable)
@@ -1410,7 +1432,7 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	else
 		r = taal_dcs_write_0(td, MIPI_DCS_SET_TEAR_OFF);
 
-	if (!panel_data->use_ext_te)
+	if (!gpio_is_valid(td->ext_te_gpio))
 		omapdss_dsi_enable_te(dssdev, enable);
 
 	if (td->panel_config->sleep.enable_te)
@@ -1720,7 +1742,6 @@ static void taal_esd_work(struct work_struct *work)
 	struct taal_data *td = container_of(work, struct taal_data,
 			esd_work.work);
 	struct omap_dss_device *dssdev = td->dssdev;
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	u8 state1, state2;
 	int r;
 
@@ -1767,7 +1788,7 @@ static void taal_esd_work(struct work_struct *work)
 	}
 	/* Self-diagnostics result is also shown on TE GPIO line. We need
 	 * to re-enable TE after self diagnostics */
-	if (td->te_enabled && panel_data->use_ext_te) {
+	if (td->te_enabled && gpio_is_valid(td->ext_te_gpio)) {
 		r = taal_dcs_write_1(td, MIPI_DCS_SET_TEAR_ON, 0);
 		if (r)
 			goto err;
-- 
1.7.9.5

