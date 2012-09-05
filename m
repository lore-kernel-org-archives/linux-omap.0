From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/17] OMAPDSS: Taal: use devm_* functions
Date: Wed,  5 Sep 2012 11:25:39 +0300
Message-ID: <1346833555-31258-2-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:45140 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756713Ab2IEI0O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:14 -0400
Received: by lbbgj3 with SMTP id gj3so189747lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:11 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use devm_ functions in panel-taal.c's probe when possible. Also reorder
the initialization sequence so that devm_ allocations are done before
things that require explicit freeing. This simplifies the probe and
remove functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |  118 +++++++++++------------------
 1 file changed, 44 insertions(+), 74 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 7b2d7bb..1255864 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -865,10 +865,8 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	dev_dbg(&dssdev->dev, "probe\n");
 
-	if (!panel_data || !panel_data->name) {
-		r = -EINVAL;
-		goto err;
-	}
+	if (!panel_data || !panel_data->name)
+		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(panel_configs); i++) {
 		if (strcmp(panel_data->name, panel_configs[i].name) == 0) {
@@ -877,21 +875,17 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		}
 	}
 
-	if (!panel_config) {
-		r = -EINVAL;
-		goto err;
-	}
+	if (!panel_config)
+		return -EINVAL;
 
 	dssdev->panel.timings = panel_config->timings;
 	dssdev->panel.dsi_pix_fmt = OMAP_DSS_DSI_FMT_RGB888;
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
 
-	td = kzalloc(sizeof(*td), GFP_KERNEL);
-	if (!td) {
-		r = -ENOMEM;
-		goto err;
-	}
+	td = devm_kzalloc(&dssdev->dev, sizeof(*td), GFP_KERNEL);
+	if (!td)
+		return -ENOMEM;
 	td->dssdev = dssdev;
 	td->panel_config = panel_config;
 	td->esd_interval = panel_data->esd_interval;
@@ -902,26 +896,51 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	atomic_set(&td->do_update, 0);
 
-	td->workqueue = create_singlethread_workqueue("taal_esd");
-	if (td->workqueue == NULL) {
-		dev_err(&dssdev->dev, "can't create ESD workqueue\n");
-		r = -ENOMEM;
-		goto err_wq;
-	}
-	INIT_DELAYED_WORK_DEFERRABLE(&td->esd_work, taal_esd_work);
-	INIT_DELAYED_WORK(&td->ulps_work, taal_ulps_work);
-
 	dev_set_drvdata(&dssdev->dev, td);
 
 	if (gpio_is_valid(panel_data->reset_gpio)) {
-		r = gpio_request_one(panel_data->reset_gpio, GPIOF_OUT_INIT_LOW,
-				"taal rst");
+		r = devm_gpio_request_one(&dssdev->dev, panel_data->reset_gpio,
+				GPIOF_OUT_INIT_LOW, "taal rst");
 		if (r) {
 			dev_err(&dssdev->dev, "failed to request reset gpio\n");
-			goto err_rst_gpio;
+			return r;
 		}
 	}
 
+	if (panel_data->use_ext_te) {
+		int gpio = panel_data->ext_te_gpio;
+
+		r = devm_gpio_request_one(&dssdev->dev, gpio, GPIOF_IN,
+				"taal irq");
+		if (r) {
+			dev_err(&dssdev->dev, "GPIO request failed\n");
+			return r;
+		}
+
+		r = devm_request_irq(&dssdev->dev, gpio_to_irq(gpio),
+				taal_te_isr,
+				IRQF_TRIGGER_RISING,
+				"taal vsync", dssdev);
+
+		if (r) {
+			dev_err(&dssdev->dev, "IRQ request failed\n");
+			return r;
+		}
+
+		INIT_DELAYED_WORK_DEFERRABLE(&td->te_timeout_work,
+					taal_te_timeout_work_callback);
+
+		dev_dbg(&dssdev->dev, "Using GPIO TE\n");
+	}
+
+	td->workqueue = create_singlethread_workqueue("taal_esd");
+	if (td->workqueue == NULL) {
+		dev_err(&dssdev->dev, "can't create ESD workqueue\n");
+		return -ENOMEM;
+	}
+	INIT_DELAYED_WORK_DEFERRABLE(&td->esd_work, taal_esd_work);
+	INIT_DELAYED_WORK(&td->ulps_work, taal_ulps_work);
+
 	taal_hw_reset(dssdev);
 
 	if (panel_data->use_dsi_backlight) {
@@ -945,31 +964,6 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		taal_bl_update_status(bldev);
 	}
 
-	if (panel_data->use_ext_te) {
-		int gpio = panel_data->ext_te_gpio;
-
-		r = gpio_request_one(gpio, GPIOF_IN, "taal irq");
-		if (r) {
-			dev_err(&dssdev->dev, "GPIO request failed\n");
-			goto err_gpio;
-		}
-
-		r = request_irq(gpio_to_irq(gpio), taal_te_isr,
-				IRQF_TRIGGER_RISING,
-				"taal vsync", dssdev);
-
-		if (r) {
-			dev_err(&dssdev->dev, "IRQ request failed\n");
-			gpio_free(gpio);
-			goto err_irq;
-		}
-
-		INIT_DELAYED_WORK_DEFERRABLE(&td->te_timeout_work,
-					taal_te_timeout_work_callback);
-
-		dev_dbg(&dssdev->dev, "Using GPIO TE\n");
-	}
-
 	r = omap_dsi_request_vc(dssdev, &td->channel);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to get virtual channel\n");
@@ -993,29 +987,16 @@ static int taal_probe(struct omap_dss_device *dssdev)
 err_vc_id:
 	omap_dsi_release_vc(dssdev, td->channel);
 err_req_vc:
-	if (panel_data->use_ext_te)
-		free_irq(gpio_to_irq(panel_data->ext_te_gpio), dssdev);
-err_irq:
-	if (panel_data->use_ext_te)
-		gpio_free(panel_data->ext_te_gpio);
-err_gpio:
 	if (bldev != NULL)
 		backlight_device_unregister(bldev);
 err_bl:
-	if (gpio_is_valid(panel_data->reset_gpio))
-		gpio_free(panel_data->reset_gpio);
-err_rst_gpio:
 	destroy_workqueue(td->workqueue);
-err_wq:
-	kfree(td);
-err:
 	return r;
 }
 
 static void __exit taal_remove(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	struct backlight_device *bldev;
 
 	dev_dbg(&dssdev->dev, "remove\n");
@@ -1023,12 +1004,6 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 	sysfs_remove_group(&dssdev->dev.kobj, &taal_attr_group);
 	omap_dsi_release_vc(dssdev, td->channel);
 
-	if (panel_data->use_ext_te) {
-		int gpio = panel_data->ext_te_gpio;
-		free_irq(gpio_to_irq(gpio), dssdev);
-		gpio_free(gpio);
-	}
-
 	bldev = td->bldev;
 	if (bldev != NULL) {
 		bldev->props.power = FB_BLANK_POWERDOWN;
@@ -1042,11 +1017,6 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 
 	/* reset, to be sure that the panel is in a valid state */
 	taal_hw_reset(dssdev);
-
-	if (gpio_is_valid(panel_data->reset_gpio))
-		gpio_free(panel_data->reset_gpio);
-
-	kfree(td);
 }
 
 static int taal_power_on(struct omap_dss_device *dssdev)
-- 
1.7.9.5

