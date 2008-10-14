From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 5/8] leds: lp5521: register separate leds
Date: Tue, 14 Oct 2008 16:01:37 +0300
Message-ID: <1223989300-27294-6-git-send-email-felipe.balbi@nokia.com>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com>
 <1223989300-27294-2-git-send-email-felipe.balbi@nokia.com>
 <1223989300-27294-3-git-send-email-felipe.balbi@nokia.com>
 <1223989300-27294-4-git-send-email-felipe.balbi@nokia.com>
 <1223989300-27294-5-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48386 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbYJNNCX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 09:02:23 -0400
In-Reply-To: <1223989300-27294-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Richard Purdie <rpurdie@rpsys.net>

Register three separate leds for lp5521 and allow
them to be controlled separately while keeping
backwards compatibility with userspace programs
based on old implementation.

Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/leds/leds-lp5521.c |  146 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index 9e94ff8..a5c3425 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2007 Nokia Corporation
  *
  * Written by Mathias Nyman <mathias.nyman@nokia.com>
+ * Updated by Felipe Balbi <felipe.balbi@nokia.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -23,7 +24,9 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/leds.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 #define LP5521_DRIVER_NAME		"lp5521"
 
@@ -75,7 +78,17 @@ struct lp5521_chip {
 	/* device lock */
 	struct mutex		lock;
 	struct i2c_client	*client;
+
+	struct work_struct	red_work;
+	struct work_struct	green_work;
+	struct work_struct	blue_work;
+
+	struct led_classdev	ledr;
+	struct led_classdev	ledg;
+	struct led_classdev	ledb;
+
 	enum lp5521_mode	mode;
+
 	int			red;
 	int			green;
 	int			blue;
@@ -489,6 +502,87 @@ static int lp5521_set_mode(struct lp5521_chip *chip, enum lp5521_mode mode)
 	return ret;
 }
 
+static void lp5521_red_work(struct work_struct *work)
+{
+	struct lp5521_chip *chip = container_of(work, struct lp5521_chip, red_work);
+	int ret;
+
+	ret = lp5521_configure(chip->client);
+	if (ret) {
+		dev_dbg(&chip->client->dev, "could not configure lp5521, %d\n",
+				ret);
+		return;
+	}
+
+	ret = lp5521_write(chip->client, LP5521_REG_R_PWM, chip->red);
+	if (ret)
+		dev_dbg(&chip->client->dev, "could not set brightness, %d\n",
+				ret);
+}
+
+static void lp5521_red_set(struct led_classdev *led,
+		enum led_brightness value)
+{
+	struct lp5521_chip *chip = container_of(led, struct lp5521_chip, ledr);
+
+	chip->red = value;
+	schedule_work(&chip->red_work);
+}
+
+static void lp5521_green_work(struct work_struct *work)
+{
+	struct lp5521_chip *chip = container_of(work, struct lp5521_chip, green_work);
+	int ret;
+
+	ret = lp5521_configure(chip->client);
+	if (ret) {
+		dev_dbg(&chip->client->dev, "could not configure lp5521, %d\n",
+				ret);
+		return;
+	}
+
+	ret = lp5521_write(chip->client, LP5521_REG_G_PWM, chip->green);
+	if (ret)
+		dev_dbg(&chip->client->dev, "could not set brightness, %d\n",
+				ret);
+}
+
+static void lp5521_green_set(struct led_classdev *led,
+		enum led_brightness value)
+{
+	struct lp5521_chip *chip = container_of(led, struct lp5521_chip, ledg);
+
+	chip->green = value;
+	schedule_work(&chip->green_work);
+}
+
+static void lp5521_blue_work(struct work_struct *work)
+{
+	struct lp5521_chip *chip = container_of(work, struct lp5521_chip, blue_work);
+	int ret;
+
+	ret = lp5521_configure(chip->client);
+	if (ret) {
+		dev_dbg(&chip->client->dev, "could not configure lp5521, %d\n",
+				ret);
+		return;
+	}
+
+	ret = lp5521_write(chip->client, LP5521_REG_B_PWM, chip->blue);
+	if (ret)
+		dev_dbg(&chip->client->dev, "could not set brightness, %d\n",
+				ret);
+}
+
+static void lp5521_blue_set(struct led_classdev *led,
+		enum led_brightness value)
+{
+	struct lp5521_chip *chip = container_of(led, struct lp5521_chip, ledb);
+
+	chip->blue = value;
+	schedule_work(&chip->blue_work);
+}
+
 /*--------------------------------------------------------------*/
 /*			Probe, Attach, Remove			*/
 /*--------------------------------------------------------------*/
@@ -509,6 +603,10 @@ static int __init lp5521_probe(struct i2c_client *client,
 
 	mutex_init(&chip->lock);
 
+	INIT_WORK(&chip->red_work, lp5521_red_work);
+	INIT_WORK(&chip->green_work, lp5521_green_work);
+	INIT_WORK(&chip->blue_work, lp5521_blue_work);
+
 	ret = lp5521_configure(client);
 	if (ret < 0) {
 		dev_err(&client->dev, "lp5521 error configuring chip \n");
@@ -521,14 +619,52 @@ static int __init lp5521_probe(struct i2c_client *client,
 	chip->green	= 1;
 	chip->blue	= 1;
 
+	chip->ledr.brightness_set = lp5521_red_set;
+	chip->ledr.default_trigger = NULL;
+	chip->ledr.name = "lp5521:red";
+	ret = led_classdev_register(&client->dev, &chip->ledr);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "failed to register red led, %d\n", ret);
+		goto fail1;
+	}
+
+	chip->ledg.brightness_set = lp5521_green_set;
+	chip->ledg.default_trigger = NULL;
+	chip->ledg.name = "lp5521:green";
+	ret = led_classdev_register(&client->dev, &chip->ledg);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "failed to register green led, %d\n",
+				ret);
+		goto fail2;
+	}
+
+	chip->ledb.brightness_set = lp5521_blue_set;
+	chip->ledb.default_trigger = NULL;
+	chip->ledb.name = "lp5521:blue";
+	ret = led_classdev_register(&client->dev, &chip->ledb);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "failed to register blue led, %d\n", ret);
+		goto fail3;
+	}
+
 	ret = lp5521_register_sysfs(client);
-	if (ret)
+	if (ret) {
 		dev_err(&client->dev, "lp5521 registering sysfs failed \n");
+		goto fail4;
+	}
 
-	return ret;
+	return 0;
 
+fail4:
+	led_classdev_unregister(&chip->ledb);
+fail3:
+	led_classdev_unregister(&chip->ledg);
+fail2:
+	led_classdev_unregister(&chip->ledr);
 fail1:
+	i2c_set_clientdata(client, NULL);
 	kfree(chip);
+
 	return ret;
 }
 
@@ -537,6 +673,12 @@ static int __exit lp5521_remove(struct i2c_client *client)
 	struct lp5521_chip *chip = i2c_get_clientdata(client);
 
 	lp5521_unregister_sysfs(client);
+	i2c_set_clientdata(client, NULL);
+
+	led_classdev_unregister(&chip->ledb);
+	led_classdev_unregister(&chip->ledg);
+	led_classdev_unregister(&chip->ledr);
+
 	kfree(chip);
 
 	return 0;
-- 
1.6.0.2.307.gc427

