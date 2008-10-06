From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/3] i2c: lp5521: cosmetic fixes
Date: Mon,  6 Oct 2008 12:11:30 +0300
Message-ID: <1223284291-7675-3-git-send-email-felipe.balbi@nokia.com>
References: <1223284291-7675-1-git-send-email-felipe.balbi@nokia.com>
 <1223284291-7675-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41975 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbYJFJMU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 05:12:20 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m969C8v0007321
	for <linux-omap@vger.kernel.org>; Mon, 6 Oct 2008 12:12:17 +0300
In-Reply-To: <1223284291-7675-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

General cleanup to the code. Preparing to send it to
mainline.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/lp5521.c |  159 ++++++++++++++++++++------------------------
 1 files changed, 73 insertions(+), 86 deletions(-)

diff --git a/drivers/i2c/chips/lp5521.c b/drivers/i2c/chips/lp5521.c
index 7fb8091..e040c4d 100644
--- a/drivers/i2c/chips/lp5521.c
+++ b/drivers/i2c/chips/lp5521.c
@@ -1,5 +1,5 @@
 /*
- * drivers/i2c/chips/lp5521.c
+ * lp5521.c - LP5521 LED Driver
  *
  * Copyright (C) 2007 Nokia Corporation
  *
@@ -24,7 +24,6 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
-#include <mach/gpio.h>
 
 #define LP5521_DRIVER_NAME		"lp5521"
 
@@ -71,6 +70,7 @@
 #define LP5521_PROGRAM_LENGTH		32	/* in bytes */
 
 struct lp5521_chip {
+	/* device lock */
 	struct mutex		lock;
 	struct i2c_client	*client;
 	char			*mode;
@@ -81,20 +81,14 @@ struct lp5521_chip {
 
 static int lp5521_set_mode(struct lp5521_chip *chip, char *mode);
 
-static int lp5521_write(struct i2c_client *client, u8 reg, u8 value)
+static inline int lp5521_write(struct i2c_client *client, u8 reg, u8 value)
 {
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-static int lp5521_read(struct i2c_client *client, u8 reg, u8 *buf)
+static inline int lp5521_read(struct i2c_client *client, u8 reg)
 {
-	s32 ret = i2c_smbus_read_byte_data(client, reg);
-
-	if (ret < 0)
-		return -EIO;
-
-	*buf = ret;
-	return 0;
+	return i2c_smbus_read_byte_data(client, reg);
 }
 
 static int lp5521_configure(struct i2c_client *client)
@@ -136,19 +130,19 @@ static int lp5521_load_program(struct lp5521_chip *chip, u8 *pattern)
 
 	if (chip->red)
 		ret |= i2c_smbus_write_i2c_block_data(client,
-						      LP5521_REG_R_PROG_MEM,
-						      LP5521_PROGRAM_LENGTH,
-						      pattern);
+				LP5521_REG_R_PROG_MEM,
+				LP5521_PROGRAM_LENGTH,
+				pattern);
 	if (chip->green)
 		ret |= i2c_smbus_write_i2c_block_data(client,
-						      LP5521_REG_G_PROG_MEM,
-						      LP5521_PROGRAM_LENGTH,
-						      pattern);
+				LP5521_REG_G_PROG_MEM,
+				LP5521_PROGRAM_LENGTH,
+				pattern);
 	if (chip->blue)
 		ret |= i2c_smbus_write_i2c_block_data(client,
-						      LP5521_REG_B_PROG_MEM,
-						      LP5521_PROGRAM_LENGTH,
-						      pattern);
+				LP5521_REG_B_PROG_MEM,
+				LP5521_PROGRAM_LENGTH,
+				pattern);
 
 	return ret;
 }
@@ -156,31 +150,33 @@ static int lp5521_load_program(struct lp5521_chip *chip, u8 *pattern)
 static int lp5521_run_program(struct lp5521_chip *chip)
 {
 	struct i2c_client *client = chip->client;
-	int ret;
+	int reg;
 	u8 mask = 0xc0;
 	u8 exec_state = 0;
-	u8 enable_reg;
 
-	ret = lp5521_read(client, LP5521_REG_ENABLE, &enable_reg);
-	if (ret)
-		goto fail;
+	reg = lp5521_read(client, LP5521_REG_ENABLE);
+	if (reg < 0)
+		return reg;
 
-	enable_reg &= mask;
+	reg &= mask;
 
 	/* set all active channels exec state to countinous run*/
-	exec_state |= (chip->red   << 5);
+	exec_state |= (chip->red << 5);
 	exec_state |= (chip->green << 3);
-	exec_state |= (chip->blue  << 1);
+	exec_state |= (chip->blue << 1);
 
-	enable_reg |= exec_state;
+	reg |= exec_state;
 
-	ret |= lp5521_write(client, LP5521_REG_ENABLE, enable_reg);
+	if (lp5521_write(client, LP5521_REG_ENABLE, reg))
+		dev_dbg(&client->dev, "failed writing to register %02x\n",
+				LP5521_REG_ENABLE);
 
 	/* set op-mode to run for active channels, disabled for others */
-	ret |= lp5521_write(client, LP5521_REG_OP_MODE, exec_state);
+	if (lp5521_write(client, LP5521_REG_OP_MODE, exec_state))
+		dev_dbg(&client->dev, "failed writing to register %02x\n",
+				LP5521_REG_OP_MODE);
 
-fail:
-	return ret;
+	return 0;
 }
 
 /*--------------------------------------------------------------*/
@@ -188,8 +184,8 @@ fail:
 /*--------------------------------------------------------------*/
 
 static ssize_t show_active_channels(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf)
+		struct device_attribute *attr,
+		char *buf)
 {
 	struct lp5521_chip *chip = dev_get_drvdata(dev);
 	char channels[4];
@@ -208,8 +204,8 @@ static ssize_t show_active_channels(struct device *dev,
 }
 
 static ssize_t store_active_channels(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t len)
+		struct device_attribute *attr,
+		const char *buf, size_t len)
 {
 	struct lp5521_chip *chip = dev_get_drvdata(dev);
 
@@ -228,26 +224,25 @@ static ssize_t store_active_channels(struct device *dev,
 }
 
 static ssize_t show_color(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf)
+		struct device_attribute *attr,
+		char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	int ret = 0;
-	u8 r, g, b;
+	int r, g, b;
 
-	ret |= lp5521_read(client, LP5521_REG_R_PWM, &r);
-	ret |= lp5521_read(client, LP5521_REG_G_PWM, &g);
-	ret |= lp5521_read(client, LP5521_REG_B_PWM, &b);
+	r = lp5521_read(client, LP5521_REG_R_PWM);
+	g = lp5521_read(client, LP5521_REG_G_PWM);
+	b = lp5521_read(client, LP5521_REG_B_PWM);
 
-	if (ret)
-		return ret;
+	if (r < 0 || g < 0 || b < 0)
+		return -EINVAL;
 
 	return sprintf(buf, "%.2x:%.2x:%.2x\n", r, g, b);
 }
 
 static ssize_t store_color(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t len)
+		struct device_attribute *attr,
+		const char *buf, size_t len)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lp5521_chip *chip = i2c_get_clientdata(client);
@@ -271,8 +266,8 @@ static ssize_t store_color(struct device *dev,
 }
 
 static ssize_t store_load(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t len)
+		struct device_attribute *attr,
+		const char *buf, size_t len)
 {
 	struct lp5521_chip *chip = dev_get_drvdata(dev);
 	int  ret, nrchars, offset = 0, i = 0;
@@ -314,8 +309,8 @@ fail:
 }
 
 static ssize_t show_mode(struct device *dev,
-			 struct device_attribute *attr,
-			 char *buf)
+		struct device_attribute *attr,
+		char *buf)
 {
 	struct lp5521_chip *chip = dev_get_drvdata(dev);
 
@@ -323,8 +318,8 @@ static ssize_t show_mode(struct device *dev,
 }
 
 static ssize_t store_mode(struct device *dev,
-			  struct device_attribute *attr,
-			  const char *buf, size_t len)
+		struct device_attribute *attr,
+		const char *buf, size_t len)
 {
 	struct lp5521_chip *chip = dev_get_drvdata(dev);
 
@@ -343,33 +338,29 @@ static ssize_t store_mode(struct device *dev,
 }
 
 static ssize_t show_current(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf)
+		struct device_attribute *attr,
+		char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	int ret = 0;
-	u8 r_curr, g_curr, b_curr;
+	int r, g, b;
 
-	ret |= lp5521_read(client, LP5521_REG_R_CNTRL, &r_curr);
-	ret |= lp5521_read(client, LP5521_REG_G_CNTRL, &g_curr);
-	ret |= lp5521_read(client, LP5521_REG_B_CNTRL, &b_curr);
+	r = lp5521_read(client, LP5521_REG_R_CNTRL);
+	g = lp5521_read(client, LP5521_REG_G_CNTRL);
+	b = lp5521_read(client, LP5521_REG_B_CNTRL);
 
-	if (ret)
-		return ret;
+	if (r < 0 || g < 0 || b < 0)
+		return -EINVAL;
 
-	r_curr = r_curr >> 4;
-	g_curr = g_curr >> 4;
-	b_curr = b_curr >> 4;
+	r >>= 4;
+	g >>= 4;
+	b >>= 4;
 
-	if (r_curr == g_curr && g_curr == b_curr)
-		return sprintf(buf, "%x\n", r_curr);
-	else
-		return sprintf(buf, "%x %x %x\n", r_curr, g_curr, b_curr);
+	return sprintf(buf, "%x %x %x\n", r, g, b);
 }
 
 static ssize_t store_current(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t len)
+		struct device_attribute *attr,
+		const char *buf, size_t len)
 {
 	struct lp5521_chip *chip = dev_get_drvdata(dev);
 	struct i2c_client *client = chip->client;
@@ -398,7 +389,7 @@ static DEVICE_ATTR(color, S_IRUGO | S_IWUGO, show_color, store_color);
 static DEVICE_ATTR(load, S_IWUGO, NULL, store_load);
 static DEVICE_ATTR(mode, S_IRUGO | S_IWUGO, show_mode, store_mode);
 static DEVICE_ATTR(active_channels, S_IRUGO | S_IWUGO,
-		   show_active_channels, store_active_channels);
+		show_active_channels, store_active_channels);
 static DEVICE_ATTR(led_current, S_IRUGO | S_IWUGO, show_current, store_current);
 
 static int lp5521_register_sysfs(struct i2c_client *client)
@@ -421,6 +412,7 @@ static int lp5521_register_sysfs(struct i2c_client *client)
 	ret = device_create_file(dev, &dev_attr_led_current);
 	if (ret)
 		goto fail5;
+
 	return 0;
 
 fail5:
@@ -437,16 +429,13 @@ fail1:
 
 static void lp5521_unregister_sysfs(struct i2c_client *client)
 {
-	struct lp5521_chip *chip = i2c_get_clientdata(client);
 	struct device *dev = &client->dev;
 
 	device_remove_file(dev, &dev_attr_led_current);
 	device_remove_file(dev, &dev_attr_mode);
 	device_remove_file(dev, &dev_attr_active_channels);
 	device_remove_file(dev, &dev_attr_color);
-
-	if (!strcmp(chip->mode, LP5521_MODE_LOAD))
-		device_remove_file(dev, &dev_attr_load);
+	device_remove_file(dev, &dev_attr_load);
 }
 
 /*--------------------------------------------------------------*/
@@ -479,9 +468,8 @@ static int lp5521_set_mode(struct lp5521_chip *chip, char *mode)
 /*--------------------------------------------------------------*/
 /*			Probe, Attach, Remove			*/
 /*--------------------------------------------------------------*/
-static struct i2c_driver lp5521_driver;
 
-static int lp5521_probe(struct i2c_client *client,
+static int __init lp5521_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct lp5521_chip *chip;
@@ -491,7 +479,7 @@ static int lp5521_probe(struct i2c_client *client,
 	if (!chip)
 		return -ENOMEM;
 
-	chip->client	= client;
+	chip->client = client;
 	strncpy(client->name, LP5521_DRIVER_NAME, I2C_NAME_SIZE);
 	i2c_set_clientdata(client, chip);
 
@@ -520,7 +508,7 @@ fail1:
 	return ret;
 }
 
-static int lp5521_remove(struct i2c_client *client)
+static int __exit lp5521_remove(struct i2c_client *client)
 {
 	struct lp5521_chip *chip = i2c_get_clientdata(client);
 
@@ -537,11 +525,11 @@ static const struct i2c_device_id lp5521_id[] = {
 MODULE_DEVICE_TABLE(i2c, lp5521_id);
 
 static struct i2c_driver lp5521_driver = {
-	.driver = {
+	.driver		= {
 		.name	= LP5521_DRIVER_NAME,
 	},
 	.probe		= lp5521_probe,
-	.remove		= __devexit_p(lp5521_remove),
+	.remove		= __exit_p(lp5521_remove),
 	.id_table	= lp5521_id,
 };
 
@@ -549,15 +537,14 @@ static int __init lp5521_init(void)
 {
 	return i2c_add_driver(&lp5521_driver);
 }
+module_init(lp5521_init);
 
 static void __exit lp5521_exit(void)
 {
 	i2c_del_driver(&lp5521_driver);
 }
+module_exit(lp5521_exit);
 
 MODULE_AUTHOR("Mathias Nyman <mathias.nyman@nokia.com>");
 MODULE_DESCRIPTION("lp5521 LED driver");
 MODULE_LICENSE("GPL");
-
-module_init(lp5521_init);
-module_exit(lp5521_exit);
-- 
1.6.0.2.307.gc427

