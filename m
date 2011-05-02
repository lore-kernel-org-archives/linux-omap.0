From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH v2 4/7] OMAP: DSS: Add i2c client driver for picodlp
Date: Mon,  2 May 2011 20:22:48 +0530
Message-ID: <1304347971-1504-5-git-send-email-mayur@ti.com>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55984 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759846Ab1EBOjU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 10:39:20 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p42EdH4S020667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 2 May 2011 09:39:17 -0500
In-Reply-To: <1304347971-1504-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mayuresh Janorkar <mayur@ti.com>, Mythri P K <mythripk@ti.com>

The configurations and data transfer with picodlp panel happens through i2c.
An i2c client with name "picodlp_i2c_driver" is registered inside panel.

dpp2600 requires 4 gpio lines for interfacing it with any processor,
phy_reset, ready_reset, park, display_select

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
Signed-off-by: Mythri P K <mythripk@ti.com>
---
Changes since v2:
	1. Removed unused variable picodlp_i2c_data
	2. Removed msleep

checkpatch.pl warning:
WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt

But I think this can be ignored.

 drivers/video/omap2/displays/panel-picodlp.c |  126 +++++++++++++++++++++++++-
 1 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index e83e399..fdbfdcf 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -1,8 +1,10 @@
 /*
  * picodlp panel driver
+ * picodlp_i2c_driver: i2c_client driver
  *
  * Copyright (C) 2009-2011 Texas Instruments
  * Author: Mythri P K <mythripk@ti.com>
+ * Mayuresh Janorkar <mayur@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
@@ -23,13 +25,29 @@
 #include <linux/firmware.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 
 #include <plat/display.h>
 #include <plat/panel-picodlp.h>
 
+#define DRIVER_NAME	"picodlp_i2c_driver"
 struct picodlp_data {
 	struct mutex lock;
+	struct i2c_client *picodlp_i2c_client;
+};
+
+static struct i2c_board_info picodlp_i2c_board_info = {
+	I2C_BOARD_INFO("picodlp_i2c_driver", 0x1b),
+};
+
+struct picodlp_i2c_data {
+	struct mutex xfer_lock;
+};
+
+struct i2c_device_id picodlp_i2c_id[] = {
+	{ "picodlp_i2c_driver", 0 },
 };
 
 static struct omap_video_timings pico_ls_timings = {
@@ -46,9 +64,56 @@ static struct omap_video_timings pico_ls_timings = {
 	.vbp		= 14,
 };
 
+static inline struct picodlp_panel_data
+		*get_panel_data(const struct omap_dss_device *dssdev)
+{
+	return (struct picodlp_panel_data *) dssdev->data;
+}
+
+static int picodlp_i2c_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct picodlp_i2c_data *picodlp_i2c_data;
+
+	picodlp_i2c_data = kzalloc(sizeof(struct picodlp_i2c_data), GFP_KERNEL);
+
+	if (!picodlp_i2c_data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, picodlp_i2c_data);
+
+	return 0;
+}
+
+static int picodlp_i2c_remove(struct i2c_client *client)
+{
+	struct picodlp_i2c_data *picodlp_i2c_data =
+					i2c_get_clientdata(client);
+
+	kfree(picodlp_i2c_data);
+	i2c_unregister_device(client);
+	return 0;
+}
+
+static struct i2c_driver picodlp_i2c_driver = {
+	.driver = {
+		.name	= "picodlp_i2c_driver",
+	},
+	.probe		= picodlp_i2c_probe,
+	.remove		= picodlp_i2c_remove,
+	.id_table	= picodlp_i2c_id,
+};
+
 static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 {
-	int r;
+	int r = 0;
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+	struct picodlp_panel_data *picodlp_pdata;
+
+	picodlp_pdata = get_panel_data(dssdev);
+	gpio_set_value(picodlp_pdata->display_sel_gpio, 1);
+	gpio_set_value(picodlp_pdata->park_gpio, 1);
+	gpio_set_value(picodlp_pdata->phy_reset_gpio, 1);
 
 	if (dssdev->platform_enable) {
 		r = dssdev->platform_enable(dssdev);
@@ -63,8 +128,7 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 	}
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
-	return 0;
-
+	return r;
 err:
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
@@ -83,6 +147,11 @@ static void picodlp_panel_power_off(struct omap_dss_device *dssdev)
 static int picodlp_panel_probe(struct omap_dss_device *dssdev)
 {
 	struct picodlp_data *picod;
+	struct picodlp_panel_data *picodlp_pdata;
+	struct i2c_adapter *adapter;
+	struct i2c_client *picodlp_i2c_client;
+	struct picodlp_i2c_data *picodlp_i2c_data;
+	int r = 0, picodlp_adapter_id;
 
 	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_ONOFF |
 				OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IVS;
@@ -94,8 +163,36 @@ static int picodlp_panel_probe(struct omap_dss_device *dssdev)
 		return -ENOMEM;
 
 	mutex_init(&picod->lock);
+
+	picodlp_pdata = get_panel_data(dssdev);
+	picodlp_adapter_id = picodlp_pdata->picodlp_adapter_id;
+
+	adapter = i2c_get_adapter(picodlp_adapter_id);
+	if (!adapter) {
+		dev_err(&dssdev->dev, "can't get i2c adapter\n");
+		r = -ENODEV;
+		goto err;
+	}
+
+	picodlp_i2c_client = i2c_new_device(adapter, &picodlp_i2c_board_info);
+	if (!picodlp_i2c_client) {
+		dev_err(&dssdev->dev, "can't add i2c device::"
+					 " picodlp_i2c_client is NULL\n");
+		r = -ENODEV;
+		goto err;
+	}
+
+	picod->picodlp_i2c_client = picodlp_i2c_client;
+
+	picodlp_i2c_data =
+		i2c_get_clientdata(picod->picodlp_i2c_client);
+
+	mutex_init(&picodlp_i2c_data->xfer_lock);
 	dev_set_drvdata(&dssdev->dev, picod);
-	return 0;
+	return r;
+err:
+	kfree(picod);
+	return r;
 }
 
 static void picodlp_panel_remove(struct omap_dss_device *dssdev)
@@ -129,6 +226,11 @@ static int picodlp_panel_enable(struct omap_dss_device *dssdev)
 static void picodlp_panel_disable(struct omap_dss_device *dssdev)
 {
 	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+	struct picodlp_panel_data *picodlp_pdata;
+
+	picodlp_pdata = get_panel_data(dssdev);
+	gpio_set_value(picodlp_pdata->phy_reset_gpio, 0);
+	gpio_set_value(picodlp_pdata->park_gpio, 0);
 
 	mutex_lock(&picod->lock);
 	/* Turn off DLP Power */
@@ -210,11 +312,25 @@ static struct omap_dss_driver picodlp_driver = {
 
 static int __init picodlp_init(void)
 {
-	return omap_dss_register_driver(&picodlp_driver);
+	int r = 0;
+
+	r = i2c_add_driver(&picodlp_i2c_driver);
+	if (r < 0) {
+		printk(KERN_WARNING DRIVER_NAME
+			" driver registration failed\n");
+		return r;
+	}
+
+	r = omap_dss_register_driver(&picodlp_driver);
+	if (r)
+		i2c_del_driver(&picodlp_i2c_driver);
+
+	return r;
 }
 
 static void __exit picodlp_exit(void)
 {
+	i2c_del_driver(&picodlp_i2c_driver);
 	omap_dss_unregister_driver(&picodlp_driver);
 }
 
-- 
1.7.1

