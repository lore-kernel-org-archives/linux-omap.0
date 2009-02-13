From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 4/6] i2c: lp5521: move to LED framework
Date: Fri, 13 Feb 2009 14:43:50 +0200
Message-ID: <1234529032-25354-5-git-send-email-felipe.balbi@nokia.com>
References: <bdea5f5962eebe1bd420f184ebc7b32c@felipebalbi.com>
 <1234529032-25354-1-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-2-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-3-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-4-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19164 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbZBMM6r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 07:58:47 -0500
In-Reply-To: <1234529032-25354-4-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

Register three separate leds for lp5521 and allow
them to be controlled separately while keeping
backwards compatibility with userspace programs
based on old implementation.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/lp5521.c |  172 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/i2c/lp5521.h |   43 +++++++++++
 2 files changed, 203 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/i2c/lp5521.h

diff --git a/drivers/i2c/chips/lp5521.c b/drivers/i2c/chips/lp5521.c
index 9e94ff8..b3ba52a 100644
--- a/drivers/i2c/chips/lp5521.c
+++ b/drivers/i2c/chips/lp5521.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2007 Nokia Corporation
  *
  * Written by Mathias Nyman <mathias.nyman@nokia.com>
+ * Updated by Felipe Balbi <felipe.balbi@nokia.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -23,7 +24,10 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/leds.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <linux/i2c/lp5521.h>
 
 #define LP5521_DRIVER_NAME		"lp5521"
 
@@ -65,17 +69,21 @@
 
 #define LP5521_PROGRAM_LENGTH		32	/* in bytes */
 
-enum lp5521_mode {
-	LP5521_MODE_LOAD,
-	LP5521_MODE_RUN,
-	LP5521_MODE_DIRECT_CONTROL,
-};
-
 struct lp5521_chip {
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
@@ -489,6 +497,87 @@ static int lp5521_set_mode(struct lp5521_chip *chip, enum lp5521_mode mode)
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
@@ -496,9 +585,16 @@ static int lp5521_set_mode(struct lp5521_chip *chip, enum lp5521_mode mode)
 static int __init lp5521_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
+	struct lp5521_platform_data *pdata = client->dev.platform_data;
 	struct lp5521_chip *chip;
+	char name[16];
 	int ret = 0;
 
+	if (!pdata) {
+		dev_err(&client->dev, "platform_data is missing\n");
+		return -EINVAL;
+	}
+
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
@@ -509,6 +605,10 @@ static int __init lp5521_probe(struct i2c_client *client,
 
 	mutex_init(&chip->lock);
 
+	INIT_WORK(&chip->red_work, lp5521_red_work);
+	INIT_WORK(&chip->green_work, lp5521_green_work);
+	INIT_WORK(&chip->blue_work, lp5521_blue_work);
+
 	ret = lp5521_configure(client);
 	if (ret < 0) {
 		dev_err(&client->dev, "lp5521 error configuring chip \n");
@@ -516,19 +616,61 @@ static int __init lp5521_probe(struct i2c_client *client,
 	}
 
 	/* Set default values */
-	chip->mode	= LP5521_MODE_DIRECT_CONTROL;
-	chip->red	= 1;
-	chip->green	= 1;
-	chip->blue	= 1;
+	chip->mode	= pdata->mode;
+	chip->red	= pdata->red_present;
+	chip->green	= pdata->green_present;
+	chip->blue	= pdata->blue_present;
+
+	chip->ledr.brightness_set = lp5521_red_set;
+	chip->ledr.default_trigger = NULL;
+	snprintf(name, sizeof(name), "%s::red", pdata->label);
+	chip->ledr.name = name;
+	ret = led_classdev_register(&client->dev, &chip->ledr);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "failed to register led %s, %d\n",
+				chip->ledb.name, ret);
+		goto fail1;
+	}
+
+	chip->ledg.brightness_set = lp5521_green_set;
+	chip->ledg.default_trigger = NULL;
+	snprintf(name, sizeof(name), "%s::green", pdata->label);
+	chip->ledg.name = name;
+	ret = led_classdev_register(&client->dev, &chip->ledg);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "failed to register led %s, %d\n",
+				chip->ledb.name, ret);
+		goto fail2;
+	}
+
+	chip->ledb.brightness_set = lp5521_blue_set;
+	chip->ledb.default_trigger = NULL;
+	snprintf(name, sizeof(name), "%s::blue", pdata->label);
+	chip->ledb.name = name;
+	ret = led_classdev_register(&client->dev, &chip->ledb);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "failed to register led %s, %d\n", chip->ledb.name, ret);
+		goto fail3;
+	}
 
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
 
@@ -537,6 +679,12 @@ static int __exit lp5521_remove(struct i2c_client *client)
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
diff --git a/include/linux/i2c/lp5521.h b/include/linux/i2c/lp5521.h
new file mode 100644
index 0000000..070e8be
--- /dev/null
+++ b/include/linux/i2c/lp5521.h
@@ -0,0 +1,43 @@
+/*
+ * lp5521.h - header for LP5521 LED driver
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ *
+ * Contact: Felipe Balbi <felipe.balbi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#ifndef __LP5521_H_
+#define __LP5521_H_
+
+enum lp5521_mode {
+	LP5521_MODE_LOAD,
+	LP5521_MODE_RUN,
+	LP5521_MODE_DIRECT_CONTROL,
+};
+
+struct lp5521_platform_data {
+	enum lp5521_mode	mode;
+
+	unsigned		red_present:1;
+	unsigned		green_present:1;
+	unsigned		blue_present:1;
+
+	const char		*label;
+};
+
+#endif /* End of __LP5521_H */
-- 
1.6.1.265.g9a013

