From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 21/26] OMAPDSS: Taal: convert to platform device
Date: Tue, 26 Mar 2013 15:33:51 +0200
Message-ID: <1364304836-18134-22-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36260 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934241Ab3CZNfB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:35:01 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Convert Taal  driver from omap_dss_driver to a platform driver. The
driver uses the new panel support from omapdss.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |  294 +++++++++++++++++------------
 1 file changed, 173 insertions(+), 121 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 2fc923d..01de2a9 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -31,6 +31,7 @@
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-nokia-dsi.h>
@@ -55,6 +56,9 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable);
 static int taal_panel_reset(struct omap_dss_device *dssdev);
 
 struct taal_data {
+	struct omap_dss_device dssdev;
+	struct platform_device *pdev;
+
 	struct mutex lock;
 
 	struct backlight_device *bldev;
@@ -64,7 +68,7 @@ struct taal_data {
 					 */
 	unsigned long	hw_guard_wait;	/* max guard time in jiffies */
 
-	struct omap_dss_device *dssdev;
+	struct omap_dss_output *src;
 
 	/* panel HW configuration from DT or platform data */
 	int reset_gpio;
@@ -99,6 +103,10 @@ struct taal_data {
 	struct delayed_work ulps_work;
 };
 
+static struct omap_dss_driver taal_driver;
+
+#define to_panel_data(x) container_of(x, struct taal_data, dssdev)
+
 static void taal_esd_work(struct work_struct *work);
 static void taal_ulps_work(struct work_struct *work);
 
@@ -123,7 +131,7 @@ static int taal_dcs_read_1(struct taal_data *td, u8 dcs_cmd, u8 *data)
 	int r;
 	u8 buf[1];
 
-	r = dsi_vc_dcs_read(td->dssdev, td->channel, dcs_cmd, buf, 1);
+	r = dsi_vc_dcs_read(&td->dssdev, td->channel, dcs_cmd, buf, 1);
 
 	if (r < 0)
 		return r;
@@ -135,7 +143,7 @@ static int taal_dcs_read_1(struct taal_data *td, u8 dcs_cmd, u8 *data)
 
 static int taal_dcs_write_0(struct taal_data *td, u8 dcs_cmd)
 {
-	return dsi_vc_dcs_write(td->dssdev, td->channel, &dcs_cmd, 1);
+	return dsi_vc_dcs_write(&td->dssdev, td->channel, &dcs_cmd, 1);
 }
 
 static int taal_dcs_write_1(struct taal_data *td, u8 dcs_cmd, u8 param)
@@ -143,7 +151,7 @@ static int taal_dcs_write_1(struct taal_data *td, u8 dcs_cmd, u8 param)
 	u8 buf[2];
 	buf[0] = dcs_cmd;
 	buf[1] = param;
-	return dsi_vc_dcs_write(td->dssdev, td->channel, buf, 2);
+	return dsi_vc_dcs_write(&td->dssdev, td->channel, buf, 2);
 }
 
 static int taal_sleep_in(struct taal_data *td)
@@ -155,7 +163,7 @@ static int taal_sleep_in(struct taal_data *td)
 	hw_guard_wait(td);
 
 	cmd = MIPI_DCS_ENTER_SLEEP_MODE;
-	r = dsi_vc_dcs_write_nosync(td->dssdev, td->channel, &cmd, 1);
+	r = dsi_vc_dcs_write_nosync(&td->dssdev, td->channel, &cmd, 1);
 	if (r)
 		return r;
 
@@ -216,7 +224,7 @@ static int taal_set_update_window(struct taal_data *td,
 	buf[3] = (x2 >> 8) & 0xff;
 	buf[4] = (x2 >> 0) & 0xff;
 
-	r = dsi_vc_dcs_write_nosync(td->dssdev, td->channel, buf, sizeof(buf));
+	r = dsi_vc_dcs_write_nosync(&td->dssdev, td->channel, buf, sizeof(buf));
 	if (r)
 		return r;
 
@@ -226,18 +234,18 @@ static int taal_set_update_window(struct taal_data *td,
 	buf[3] = (y2 >> 8) & 0xff;
 	buf[4] = (y2 >> 0) & 0xff;
 
-	r = dsi_vc_dcs_write_nosync(td->dssdev, td->channel, buf, sizeof(buf));
+	r = dsi_vc_dcs_write_nosync(&td->dssdev, td->channel, buf, sizeof(buf));
 	if (r)
 		return r;
 
-	dsi_vc_send_bta_sync(td->dssdev, td->channel);
+	dsi_vc_send_bta_sync(&td->dssdev, td->channel);
 
 	return r;
 }
 
 static void taal_queue_esd_work(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 
 	if (td->esd_interval > 0)
 		queue_delayed_work(td->workqueue, &td->esd_work,
@@ -246,14 +254,14 @@ static void taal_queue_esd_work(struct omap_dss_device *dssdev)
 
 static void taal_cancel_esd_work(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 
 	cancel_delayed_work(&td->esd_work);
 }
 
 static void taal_queue_ulps_work(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 
 	if (td->ulps_timeout > 0)
 		queue_delayed_work(td->workqueue, &td->ulps_work,
@@ -262,14 +270,14 @@ static void taal_queue_ulps_work(struct omap_dss_device *dssdev)
 
 static void taal_cancel_ulps_work(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 
 	cancel_delayed_work(&td->ulps_work);
 }
 
 static int taal_enter_ulps(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	int r;
 
 	if (td->ulps_enabled)
@@ -291,7 +299,7 @@ static int taal_enter_ulps(struct omap_dss_device *dssdev)
 	return 0;
 
 err:
-	dev_err(&dssdev->dev, "enter ULPS failed");
+	dev_err(&td->pdev->dev, "enter ULPS failed");
 	taal_panel_reset(dssdev);
 
 	td->ulps_enabled = false;
@@ -303,7 +311,7 @@ err:
 
 static int taal_exit_ulps(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	int r;
 
 	if (!td->ulps_enabled)
@@ -311,7 +319,7 @@ static int taal_exit_ulps(struct omap_dss_device *dssdev)
 
 	r = omapdss_dsi_display_enable(dssdev);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to enable DSI\n");
+		dev_err(&td->pdev->dev, "failed to enable DSI\n");
 		goto err1;
 	}
 
@@ -319,7 +327,7 @@ static int taal_exit_ulps(struct omap_dss_device *dssdev)
 
 	r = _taal_enable_te(dssdev, true);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to re-enable TE");
+		dev_err(&td->pdev->dev, "failed to re-enable TE");
 		goto err2;
 	}
 
@@ -333,7 +341,7 @@ static int taal_exit_ulps(struct omap_dss_device *dssdev)
 	return 0;
 
 err2:
-	dev_err(&dssdev->dev, "failed to exit ULPS");
+	dev_err(&td->pdev->dev, "failed to exit ULPS");
 
 	r = taal_panel_reset(dssdev);
 	if (!r) {
@@ -349,7 +357,7 @@ err1:
 
 static int taal_wake_up(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 
 	if (td->ulps_enabled)
 		return taal_exit_ulps(dssdev);
@@ -362,7 +370,7 @@ static int taal_wake_up(struct omap_dss_device *dssdev)
 static int taal_bl_update_status(struct backlight_device *dev)
 {
 	struct omap_dss_device *dssdev = dev_get_drvdata(&dev->dev);
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	int r;
 	int level;
 
@@ -372,7 +380,7 @@ static int taal_bl_update_status(struct backlight_device *dev)
 	else
 		level = 0;
 
-	dev_dbg(&dssdev->dev, "update brightness to %d\n", level);
+	dev_dbg(&td->pdev->dev, "update brightness to %d\n", level);
 
 	mutex_lock(&td->lock);
 
@@ -417,8 +425,10 @@ static void taal_get_resolution(struct omap_dss_device *dssdev,
 static ssize_t taal_num_errors_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+
+	struct platform_device *pdev = to_platform_device(dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
+	struct omap_dss_device *dssdev = &td->dssdev;
 	u8 errors = 0;
 	int r;
 
@@ -447,8 +457,9 @@ static ssize_t taal_num_errors_show(struct device *dev,
 static ssize_t taal_hw_revision_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
+	struct omap_dss_device *dssdev = &td->dssdev;
 	u8 id1, id2, id3;
 	int r;
 
@@ -485,8 +496,8 @@ static ssize_t show_cabc_mode(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
 	const char *mode_str;
 	int mode;
 	int len;
@@ -505,8 +516,9 @@ static ssize_t store_cabc_mode(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
+	struct omap_dss_device *dssdev = &td->dssdev;
 	int i;
 	int r;
 
@@ -567,8 +579,9 @@ static ssize_t taal_store_esd_interval(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
+	struct omap_dss_device *dssdev = &td->dssdev;
 
 	unsigned long t;
 	int r;
@@ -591,8 +604,8 @@ static ssize_t taal_show_esd_interval(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
 	unsigned t;
 
 	mutex_lock(&td->lock);
@@ -606,8 +619,9 @@ static ssize_t taal_store_ulps(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
+	struct omap_dss_device *dssdev = &td->dssdev;
 	unsigned long t;
 	int r;
 
@@ -640,8 +654,8 @@ static ssize_t taal_show_ulps(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
 	unsigned t;
 
 	mutex_lock(&td->lock);
@@ -655,8 +669,9 @@ static ssize_t taal_store_ulps_timeout(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
+	struct omap_dss_device *dssdev = &td->dssdev;
 	unsigned long t;
 	int r;
 
@@ -686,8 +701,8 @@ static ssize_t taal_show_ulps_timeout(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
 	unsigned t;
 
 	mutex_lock(&td->lock);
@@ -727,7 +742,7 @@ static struct attribute_group taal_attr_group = {
 
 static void taal_hw_reset(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 
 	if (!gpio_is_valid(td->reset_gpio))
 		return;
@@ -743,9 +758,17 @@ static void taal_hw_reset(struct omap_dss_device *dssdev)
 	msleep(5);
 }
 
-static void taal_probe_pdata(struct taal_data *td,
-		const struct nokia_dsi_panel_data *pdata)
+static int taal_probe_pdata(struct platform_device *pdev)
 {
+	const struct nokia_dsi_panel_data *pdata = dev_get_platdata(&pdev->dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
+
+	td->src = omap_dss_find_output(pdata->source);
+	if (!td->src) {
+		dev_err(&pdev->dev, "Failed to find video source\n");
+		return -ENODEV;
+	}
+
 	td->reset_gpio = pdata->reset_gpio;
 
 	if (pdata->use_ext_te)
@@ -759,32 +782,44 @@ static void taal_probe_pdata(struct taal_data *td,
 	td->use_dsi_backlight = pdata->use_dsi_backlight;
 
 	td->pin_config = pdata->pin_config;
+
+	td->dssdev.name = pdata->name;
+
+	return 0;
 }
 
-static int taal_probe(struct omap_dss_device *dssdev)
+static int taal_probe(struct platform_device *pdev)
 {
+	const struct nokia_dsi_panel_data *pdata = dev_get_platdata(&pdev->dev);
+	struct omap_dss_device *dssdev;
 	struct backlight_properties props;
 	struct taal_data *td;
 	struct backlight_device *bldev = NULL;
 	int r;
 
-	dev_dbg(&dssdev->dev, "probe\n");
+	dev_dbg(&pdev->dev, "probe\n");
 
-	td = devm_kzalloc(&dssdev->dev, sizeof(*td), GFP_KERNEL);
+	td = devm_kzalloc(&pdev->dev, sizeof(*td), GFP_KERNEL);
 	if (!td)
 		return -ENOMEM;
 
-	dev_set_drvdata(&dssdev->dev, td);
-	td->dssdev = dssdev;
+	td->pdev = pdev;
 
-	if (dssdev->data) {
-		const struct nokia_dsi_panel_data *pdata = dssdev->data;
+	dev_set_drvdata(&pdev->dev, td);
 
-		taal_probe_pdata(td, pdata);
+	if (pdata) {
+		r = taal_probe_pdata(pdev);
+		if (r) {
+			dev_err(&pdev->dev, "failed to read platform data\n");
+			return r;
+		}
 	} else {
 		return -ENODEV;
 	}
 
+	dssdev = &td->dssdev;
+	dssdev->driver = &taal_driver;
+	dssdev->panel_dev = &pdev->dev;
 	dssdev->panel.timings.x_res = 864;
 	dssdev->panel.timings.y_res = 480;
 	dssdev->panel.timings.pixel_clock = DIV_ROUND_UP(864 * 480 * 60, 1000);
@@ -792,46 +827,55 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
 
+	dev_set_drvdata(&pdev->dev, td);
+
+
+	r = omap_dsi_register_panel(dssdev, td->src);
+	if (r) {
+		dev_err(&pdev->dev, "Failed to register panel\n");
+		return r;
+	}
+
 	mutex_init(&td->lock);
 
 	atomic_set(&td->do_update, 0);
 
 	if (gpio_is_valid(td->reset_gpio)) {
-		r = devm_gpio_request_one(&dssdev->dev, td->reset_gpio,
+		r = devm_gpio_request_one(&pdev->dev, td->reset_gpio,
 				GPIOF_OUT_INIT_LOW, "taal rst");
 		if (r) {
-			dev_err(&dssdev->dev, "failed to request reset gpio\n");
+			dev_err(&pdev->dev, "failed to request reset gpio\n");
 			return r;
 		}
 	}
 
 	if (gpio_is_valid(td->ext_te_gpio)) {
-		r = devm_gpio_request_one(&dssdev->dev, td->ext_te_gpio,
+		r = devm_gpio_request_one(&pdev->dev, td->ext_te_gpio,
 				GPIOF_IN, "taal irq");
 		if (r) {
-			dev_err(&dssdev->dev, "GPIO request failed\n");
+			dev_err(&pdev->dev, "GPIO request failed\n");
 			return r;
 		}
 
-		r = devm_request_irq(&dssdev->dev, gpio_to_irq(td->ext_te_gpio),
+		r = devm_request_irq(&pdev->dev, gpio_to_irq(td->ext_te_gpio),
 				taal_te_isr,
 				IRQF_TRIGGER_RISING,
 				"taal vsync", dssdev);
 
 		if (r) {
-			dev_err(&dssdev->dev, "IRQ request failed\n");
+			dev_err(&pdev->dev, "IRQ request failed\n");
 			return r;
 		}
 
 		INIT_DEFERRABLE_WORK(&td->te_timeout_work,
 					taal_te_timeout_work_callback);
 
-		dev_dbg(&dssdev->dev, "Using GPIO TE\n");
+		dev_dbg(&pdev->dev, "Using GPIO TE\n");
 	}
 
 	td->workqueue = create_singlethread_workqueue("taal_esd");
 	if (td->workqueue == NULL) {
-		dev_err(&dssdev->dev, "can't create ESD workqueue\n");
+		dev_err(&pdev->dev, "can't create ESD workqueue\n");
 		return -ENOMEM;
 	}
 	INIT_DEFERRABLE_WORK(&td->esd_work, taal_esd_work);
@@ -844,8 +888,8 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		props.max_brightness = 255;
 
 		props.type = BACKLIGHT_RAW;
-		bldev = backlight_device_register(dev_name(&dssdev->dev),
-				&dssdev->dev, dssdev, &taal_bl_ops, &props);
+		bldev = backlight_device_register(dev_name(&pdev->dev),
+				&pdev->dev, dssdev, &taal_bl_ops, &props);
 		if (IS_ERR(bldev)) {
 			r = PTR_ERR(bldev);
 			goto err_bl;
@@ -862,19 +906,19 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	r = omap_dsi_request_vc(dssdev, &td->channel);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to get virtual channel\n");
+		dev_err(&pdev->dev, "failed to get virtual channel\n");
 		goto err_req_vc;
 	}
 
 	r = omap_dsi_set_vc_id(dssdev, td->channel, TCH);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to set VC_ID\n");
+		dev_err(&pdev->dev, "failed to set VC_ID\n");
 		goto err_vc_id;
 	}
 
-	r = sysfs_create_group(&dssdev->dev.kobj, &taal_attr_group);
+	r = sysfs_create_group(&pdev->dev.kobj, &taal_attr_group);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to create sysfs files\n");
+		dev_err(&pdev->dev, "failed to create sysfs files\n");
 		goto err_vc_id;
 	}
 
@@ -890,14 +934,15 @@ err_bl:
 	return r;
 }
 
-static void __exit taal_remove(struct omap_dss_device *dssdev)
+static int __exit taal_remove(struct platform_device *pdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
+	struct omap_dss_device *dssdev = &td->dssdev;
 	struct backlight_device *bldev;
 
-	dev_dbg(&dssdev->dev, "remove\n");
+	dev_dbg(&pdev->dev, "remove\n");
 
-	sysfs_remove_group(&dssdev->dev.kobj, &taal_attr_group);
+	sysfs_remove_group(&pdev->dev.kobj, &taal_attr_group);
 	omap_dsi_release_vc(dssdev, td->channel);
 
 	bldev = td->bldev;
@@ -913,11 +958,15 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 
 	/* reset, to be sure that the panel is in a valid state */
 	taal_hw_reset(dssdev);
+
+	omap_dsi_free_panel(&td->dssdev);
+
+	return 0;
 }
 
 static int taal_power_on(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	u8 id1, id2, id3;
 	int r;
 	struct omap_dss_dsi_config dsi_config = {
@@ -932,19 +981,19 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 
 	r = omapdss_dsi_configure_pins(dssdev, &td->pin_config);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to configure DSI pins\n");
+		dev_err(&td->pdev->dev, "failed to configure DSI pins\n");
 		goto err0;
 	};
 
 	r = omapdss_dsi_set_config(dssdev, &dsi_config);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to configure DSI\n");
+		dev_err(&td->pdev->dev, "failed to configure DSI\n");
 		goto err0;
 	}
 
 	r = omapdss_dsi_display_enable(dssdev);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to enable DSI\n");
+		dev_err(&td->pdev->dev, "failed to enable DSI\n");
 		goto err0;
 	}
 
@@ -999,10 +1048,10 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	td->enabled = 1;
 
 	if (!td->intro_printed) {
-		dev_info(&dssdev->dev, "panel revision %02x.%02x.%02x\n",
+		dev_info(&td->pdev->dev, "panel revision %02x.%02x.%02x\n",
 			id1, id2, id3);
 		if (td->cabc_broken)
-			dev_info(&dssdev->dev,
+			dev_info(&td->pdev->dev,
 					"old Taal version, CABC disabled\n");
 		td->intro_printed = true;
 	}
@@ -1011,7 +1060,7 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 
 	return 0;
 err:
-	dev_err(&dssdev->dev, "error while enabling panel, issuing HW reset\n");
+	dev_err(&td->pdev->dev, "error while enabling panel, issuing HW reset\n");
 
 	taal_hw_reset(dssdev);
 
@@ -1022,7 +1071,7 @@ err0:
 
 static void taal_power_off(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	int r;
 
 	dsi_disable_video_output(dssdev, td->channel);
@@ -1032,7 +1081,7 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 		r = taal_sleep_in(td);
 
 	if (r) {
-		dev_err(&dssdev->dev,
+		dev_err(&td->pdev->dev,
 				"error disabling panel, issuing HW reset\n");
 		taal_hw_reset(dssdev);
 	}
@@ -1044,7 +1093,9 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 
 static int taal_panel_reset(struct omap_dss_device *dssdev)
 {
-	dev_err(&dssdev->dev, "performing LCD reset\n");
+	struct taal_data *td = to_panel_data(dssdev);
+
+	dev_err(&td->pdev->dev, "performing LCD reset\n");
 
 	taal_power_off(dssdev);
 	taal_hw_reset(dssdev);
@@ -1053,10 +1104,10 @@ static int taal_panel_reset(struct omap_dss_device *dssdev)
 
 static int taal_enable(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	int r;
 
-	dev_dbg(&dssdev->dev, "enable\n");
+	dev_dbg(&td->pdev->dev, "enable\n");
 
 	mutex_lock(&td->lock);
 
@@ -1082,16 +1133,16 @@ static int taal_enable(struct omap_dss_device *dssdev)
 
 	return 0;
 err:
-	dev_dbg(&dssdev->dev, "enable failed\n");
+	dev_dbg(&td->pdev->dev, "enable failed\n");
 	mutex_unlock(&td->lock);
 	return r;
 }
 
 static void taal_disable(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 
-	dev_dbg(&dssdev->dev, "disable\n");
+	dev_dbg(&td->pdev->dev, "disable\n");
 
 	mutex_lock(&td->lock);
 
@@ -1118,14 +1169,16 @@ static void taal_disable(struct omap_dss_device *dssdev)
 static void taal_framedone_cb(int err, void *data)
 {
 	struct omap_dss_device *dssdev = data;
-	dev_dbg(&dssdev->dev, "framedone, err %d\n", err);
+	struct taal_data *td = to_panel_data(dssdev);
+
+	dev_dbg(&td->pdev->dev, "framedone, err %d\n", err);
 	dsi_bus_unlock(dssdev);
 }
 
 static irqreturn_t taal_te_isr(int irq, void *data)
 {
 	struct omap_dss_device *dssdev = data;
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	int old;
 	int r;
 
@@ -1142,7 +1195,7 @@ static irqreturn_t taal_te_isr(int irq, void *data)
 
 	return IRQ_HANDLED;
 err:
-	dev_err(&dssdev->dev, "start update failed\n");
+	dev_err(&td->pdev->dev, "start update failed\n");
 	dsi_bus_unlock(dssdev);
 	return IRQ_HANDLED;
 }
@@ -1151,9 +1204,9 @@ static void taal_te_timeout_work_callback(struct work_struct *work)
 {
 	struct taal_data *td = container_of(work, struct taal_data,
 					te_timeout_work.work);
-	struct omap_dss_device *dssdev = td->dssdev;
+	struct omap_dss_device *dssdev = &td->dssdev;
 
-	dev_err(&dssdev->dev, "TE not received for 250ms!\n");
+	dev_err(&td->pdev->dev, "TE not received for 250ms!\n");
 
 	atomic_set(&td->do_update, 0);
 	dsi_bus_unlock(dssdev);
@@ -1162,10 +1215,10 @@ static void taal_te_timeout_work_callback(struct work_struct *work)
 static int taal_update(struct omap_dss_device *dssdev,
 				    u16 x, u16 y, u16 w, u16 h)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	int r;
 
-	dev_dbg(&dssdev->dev, "update %d, %d, %d x %d\n", x, y, w, h);
+	dev_dbg(&td->pdev->dev, "update %d, %d, %d x %d\n", x, y, w, h);
 
 	mutex_lock(&td->lock);
 	dsi_bus_lock(dssdev);
@@ -1208,23 +1261,23 @@ err:
 
 static int taal_sync(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 
-	dev_dbg(&dssdev->dev, "sync\n");
+	dev_dbg(&td->pdev->dev, "sync\n");
 
 	mutex_lock(&td->lock);
 	dsi_bus_lock(dssdev);
 	dsi_bus_unlock(dssdev);
 	mutex_unlock(&td->lock);
 
-	dev_dbg(&dssdev->dev, "sync done\n");
+	dev_dbg(&td->pdev->dev, "sync done\n");
 
 	return 0;
 }
 
 static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	int r;
 
 	if (enable)
@@ -1243,7 +1296,7 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 
 static int taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	int r;
 
 	mutex_lock(&td->lock);
@@ -1279,7 +1332,7 @@ err:
 
 static int taal_get_te(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	int r;
 
 	mutex_lock(&td->lock);
@@ -1291,7 +1344,7 @@ static int taal_get_te(struct omap_dss_device *dssdev)
 
 static int taal_run_test(struct omap_dss_device *dssdev, int test_num)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 	u8 id1, id2, id3;
 	int r;
 
@@ -1336,7 +1389,7 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 	int first = 1;
 	int plen;
 	unsigned buf_used = 0;
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct taal_data *td = to_panel_data(dssdev);
 
 	if (size < w * h * 3)
 		return -ENOMEM;
@@ -1380,19 +1433,19 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 				buf + buf_used, size - buf_used);
 
 		if (r < 0) {
-			dev_err(&dssdev->dev, "read error\n");
+			dev_err(&td->pdev->dev, "read error\n");
 			goto err3;
 		}
 
 		buf_used += r;
 
 		if (r < plen) {
-			dev_err(&dssdev->dev, "short read\n");
+			dev_err(&td->pdev->dev, "short read\n");
 			break;
 		}
 
 		if (signal_pending(current)) {
-			dev_err(&dssdev->dev, "signal pending, "
+			dev_err(&td->pdev->dev, "signal pending, "
 					"aborting memory read\n");
 			r = -ERESTARTSYS;
 			goto err3;
@@ -1414,7 +1467,7 @@ static void taal_ulps_work(struct work_struct *work)
 {
 	struct taal_data *td = container_of(work, struct taal_data,
 			ulps_work.work);
-	struct omap_dss_device *dssdev = td->dssdev;
+	struct omap_dss_device *dssdev = &td->dssdev;
 
 	mutex_lock(&td->lock);
 
@@ -1435,7 +1488,7 @@ static void taal_esd_work(struct work_struct *work)
 {
 	struct taal_data *td = container_of(work, struct taal_data,
 			esd_work.work);
-	struct omap_dss_device *dssdev = td->dssdev;
+	struct omap_dss_device *dssdev = &td->dssdev;
 	u8 state1, state2;
 	int r;
 
@@ -1450,26 +1503,26 @@ static void taal_esd_work(struct work_struct *work)
 
 	r = taal_wake_up(dssdev);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to exit ULPS\n");
+		dev_err(&td->pdev->dev, "failed to exit ULPS\n");
 		goto err;
 	}
 
 	r = taal_dcs_read_1(td, MIPI_DCS_GET_DIAGNOSTIC_RESULT, &state1);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to read Taal status\n");
+		dev_err(&td->pdev->dev, "failed to read Taal status\n");
 		goto err;
 	}
 
 	/* Run self diagnostics */
 	r = taal_sleep_out(td);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to run Taal self-diagnostics\n");
+		dev_err(&td->pdev->dev, "failed to run Taal self-diagnostics\n");
 		goto err;
 	}
 
 	r = taal_dcs_read_1(td, MIPI_DCS_GET_DIAGNOSTIC_RESULT, &state2);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to read Taal status\n");
+		dev_err(&td->pdev->dev, "failed to read Taal status\n");
 		goto err;
 	}
 
@@ -1477,7 +1530,7 @@ static void taal_esd_work(struct work_struct *work)
 	 * Bit6 if the test passes.
 	 */
 	if (!((state1 ^ state2) & (1 << 6))) {
-		dev_err(&dssdev->dev, "LCD self diagnostics failed\n");
+		dev_err(&td->pdev->dev, "LCD self diagnostics failed\n");
 		goto err;
 	}
 	/* Self-diagnostics result is also shown on TE GPIO line. We need
@@ -1495,7 +1548,7 @@ static void taal_esd_work(struct work_struct *work)
 	mutex_unlock(&td->lock);
 	return;
 err:
-	dev_err(&dssdev->dev, "performing LCD reset\n");
+	dev_err(&td->pdev->dev, "performing LCD reset\n");
 
 	taal_panel_reset(dssdev);
 
@@ -1507,9 +1560,6 @@ err:
 }
 
 static struct omap_dss_driver taal_driver = {
-	.probe		= taal_probe,
-	.remove		= __exit_p(taal_remove),
-
 	.enable		= taal_enable,
 	.disable	= taal_disable,
 
@@ -1524,23 +1574,25 @@ static struct omap_dss_driver taal_driver = {
 
 	.run_test	= taal_run_test,
 	.memory_read	= taal_memory_read,
+};
 
-	.driver         = {
-		.name   = "taal",
-		.owner  = THIS_MODULE,
+static struct platform_driver taal_platform_driver = {
+	.probe	= taal_probe,
+	.remove	= __exit_p(taal_remove),
+	.driver	= {
+		.name	= "taal",
+		.owner	= THIS_MODULE,
 	},
 };
 
 static int __init taal_init(void)
 {
-	omap_dss_register_driver(&taal_driver);
-
-	return 0;
+	return platform_driver_register(&taal_platform_driver);
 }
 
 static void __exit taal_exit(void)
 {
-	omap_dss_unregister_driver(&taal_driver);
+	platform_driver_unregister(&taal_platform_driver);
 }
 
 module_init(taal_init);
-- 
1.7.10.4

