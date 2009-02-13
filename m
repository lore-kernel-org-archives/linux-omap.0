From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 5/6] leds: lp5521: move to drivers/leds
Date: Fri, 13 Feb 2009 14:43:51 +0200
Message-ID: <1234529032-25354-6-git-send-email-felipe.balbi@nokia.com>
References: <bdea5f5962eebe1bd420f184ebc7b32c@felipebalbi.com>
 <1234529032-25354-1-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-2-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-3-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-4-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-5-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19198 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbZBMM7C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 07:59:02 -0500
In-Reply-To: <1234529032-25354-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

This driver should be sitting together with the other
led drivers.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Kconfig  |    7 -
 drivers/i2c/chips/Makefile |    1 -
 drivers/i2c/chips/lp5521.c |  722 --------------------------------------------
 drivers/leds/Kconfig       |   10 +
 drivers/leds/Makefile      |    1 +
 drivers/leds/leds-lp5521.c |  722 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 733 insertions(+), 730 deletions(-)
 delete mode 100644 drivers/i2c/chips/lp5521.c
 create mode 100644 drivers/leds/leds-lp5521.c

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index bb95b3e..e4831e1 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -141,13 +141,6 @@ config SENSORS_TSL2563
          This driver can also be built as a module.  If so, the module
          will be called tsl2563.
 
-config LP5521
-	tristate "LP5521 LED driver chip"
-	depends on I2C
-	help
-	  If you say yes here you get support for the National Semiconductor
-	  LP5521 LED driver.
-
 config MENELAUS
 	bool "TWL92330/Menelaus PM chip"
 	depends on I2C=y && ARCH_OMAP24XX
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 32a395f..1c94712 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
 obj-$(CONFIG_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_TWL4030_MADC)	+= twl4030-madc.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
-obj-$(CONFIG_LP5521)		+= lp5521.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/i2c/chips/lp5521.c b/drivers/i2c/chips/lp5521.c
deleted file mode 100644
index b3ba52a..0000000
--- a/drivers/i2c/chips/lp5521.c
+++ /dev/null
@@ -1,722 +0,0 @@
-/*
- * lp5521.c - LP5521 LED Driver
- *
- * Copyright (C) 2007 Nokia Corporation
- *
- * Written by Mathias Nyman <mathias.nyman@nokia.com>
- * Updated by Felipe Balbi <felipe.balbi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/i2c.h>
-#include <linux/leds.h>
-#include <linux/mutex.h>
-#include <linux/workqueue.h>
-#include <linux/i2c/lp5521.h>
-
-#define LP5521_DRIVER_NAME		"lp5521"
-
-#define LP5521_REG_R_PWM		0x02
-#define LP5521_REG_B_PWM		0x04
-#define LP5521_REG_ENABLE		0x00
-#define LP5521_REG_OP_MODE		0x01
-#define LP5521_REG_G_PWM		0x03
-#define LP5521_REG_R_CNTRL		0x05
-#define LP5521_REG_G_CNTRL		0x06
-#define LP5521_REG_B_CNTRL		0x07
-#define LP5521_REG_MISC			0x08
-#define LP5521_REG_R_CHANNEL_PC		0x09
-#define LP5521_REG_G_CHANNEL_PC		0x0a
-#define LP5521_REG_B_CHANNEL_PC		0x0b
-#define LP5521_REG_STATUS		0x0c
-#define LP5521_REG_RESET		0x0d
-#define LP5521_REG_GPO			0x0e
-#define LP5521_REG_R_PROG_MEM		0x10
-#define LP5521_REG_G_PROG_MEM		0x30
-#define LP5521_REG_B_PROG_MEM		0x50
-
-#define LP5521_CURRENT_1m5		0x0f
-#define LP5521_CURRENT_3m1		0x1f
-#define LP5521_CURRENT_4m7		0x2f
-#define LP5521_CURRENT_6m3		0x3f
-#define LP5521_CURRENT_7m9		0x4f
-#define LP5521_CURRENT_9m5		0x5f
-#define LP5521_CURRENT_11m1		0x6f
-#define LP5521_CURRENT_12m7		0x7f
-#define LP5521_CURRENT_14m3		0x8f
-#define LP5521_CURRENT_15m9		0x9f
-#define LP5521_CURRENT_17m5		0xaf
-#define LP5521_CURRENT_19m1		0xbf
-#define LP5521_CURRENT_20m7		0xcf
-#define LP5521_CURRENT_22m3		0xdf
-#define LP5521_CURRENT_23m9		0xef
-#define LP5521_CURRENT_25m5		0xff
-
-#define LP5521_PROGRAM_LENGTH		32	/* in bytes */
-
-struct lp5521_chip {
-	/* device lock */
-	struct mutex		lock;
-	struct i2c_client	*client;
-
-	struct work_struct	red_work;
-	struct work_struct	green_work;
-	struct work_struct	blue_work;
-
-	struct led_classdev	ledr;
-	struct led_classdev	ledg;
-	struct led_classdev	ledb;
-
-	enum lp5521_mode	mode;
-
-	int			red;
-	int			green;
-	int			blue;
-};
-
-static int lp5521_set_mode(struct lp5521_chip *chip, enum lp5521_mode mode);
-
-static inline int lp5521_write(struct i2c_client *client, u8 reg, u8 value)
-{
-	return i2c_smbus_write_byte_data(client, reg, value);
-}
-
-static inline int lp5521_read(struct i2c_client *client, u8 reg)
-{
-	return i2c_smbus_read_byte_data(client, reg);
-}
-
-static int lp5521_configure(struct i2c_client *client)
-{
-	int ret = 0;
-
-	/* Enable chip and set light to logarithmic mode*/
-	ret |= lp5521_write(client, LP5521_REG_ENABLE, 0xc0);
-
-	/* setting all color pwms to direct control mode */
-	ret |= lp5521_write(client, LP5521_REG_OP_MODE, 0x3f);
-
-	/* setting current to 4.7 mA for all channels */
-	ret |= lp5521_write(client, LP5521_REG_R_CNTRL, LP5521_CURRENT_4m7);
-	ret |= lp5521_write(client, LP5521_REG_G_CNTRL, LP5521_CURRENT_4m7);
-	ret |= lp5521_write(client, LP5521_REG_B_CNTRL, LP5521_CURRENT_4m7);
-
-	/* Enable auto-powersave, set charge pump to auto, red to battery */
-	ret |= lp5521_write(client, LP5521_REG_MISC, 0x3c);
-
-	/* initialize all channels pwm to zero */
-	ret |= lp5521_write(client, LP5521_REG_R_PWM, 0);
-	ret |= lp5521_write(client, LP5521_REG_G_PWM, 0);
-	ret |= lp5521_write(client, LP5521_REG_B_PWM, 0);
-
-	/* Not much can be done about errors at this point */
-	return ret;
-}
-
-static int lp5521_load_program(struct lp5521_chip *chip, u8 *pattern)
-{
-	struct i2c_client *client = chip->client;
-	int ret = 0;
-
-	/* Enter load program mode for all led channels */
-	ret |= lp5521_write(client, LP5521_REG_OP_MODE, 0x15); /* 0001 0101 */
-	if (ret)
-		return ret;
-
-	if (chip->red)
-		ret |= i2c_smbus_write_i2c_block_data(client,
-				LP5521_REG_R_PROG_MEM,
-				LP5521_PROGRAM_LENGTH,
-				pattern);
-	if (chip->green)
-		ret |= i2c_smbus_write_i2c_block_data(client,
-				LP5521_REG_G_PROG_MEM,
-				LP5521_PROGRAM_LENGTH,
-				pattern);
-	if (chip->blue)
-		ret |= i2c_smbus_write_i2c_block_data(client,
-				LP5521_REG_B_PROG_MEM,
-				LP5521_PROGRAM_LENGTH,
-				pattern);
-
-	return ret;
-}
-
-static int lp5521_run_program(struct lp5521_chip *chip)
-{
-	struct i2c_client *client = chip->client;
-	int reg;
-	u8 mask = 0xc0;
-	u8 exec_state = 0;
-
-	reg = lp5521_read(client, LP5521_REG_ENABLE);
-	if (reg < 0)
-		return reg;
-
-	reg &= mask;
-
-	/* set all active channels exec state to countinous run*/
-	exec_state |= (chip->red << 5);
-	exec_state |= (chip->green << 3);
-	exec_state |= (chip->blue << 1);
-
-	reg |= exec_state;
-
-	if (lp5521_write(client, LP5521_REG_ENABLE, reg))
-		dev_dbg(&client->dev, "failed writing to register %02x\n",
-				LP5521_REG_ENABLE);
-
-	/* set op-mode to run for active channels, disabled for others */
-	if (lp5521_write(client, LP5521_REG_OP_MODE, exec_state))
-		dev_dbg(&client->dev, "failed writing to register %02x\n",
-				LP5521_REG_OP_MODE);
-
-	return 0;
-}
-
-/*--------------------------------------------------------------*/
-/*			Sysfs interface				*/
-/*--------------------------------------------------------------*/
-
-static ssize_t show_active_channels(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct lp5521_chip *chip = dev_get_drvdata(dev);
-	char channels[4];
-	int pos = 0;
-
-	if (chip->red)
-		pos += sprintf(channels + pos, "r");
-	if (chip->green)
-		pos += sprintf(channels + pos, "g");
-	if (chip->blue)
-		pos += sprintf(channels + pos, "b");
-
-	channels[pos] = '\0';
-
-	return sprintf(buf, "%s\n", channels);
-}
-
-static ssize_t store_active_channels(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	struct lp5521_chip *chip = dev_get_drvdata(dev);
-
-	chip->red = 0;
-	chip->green = 0;
-	chip->blue = 0;
-
-	if (strchr(buf, 'r') != NULL)
-		chip->red = 1;
-	if (strchr(buf, 'b') != NULL)
-		chip->blue = 1;
-	if (strchr(buf, 'g') != NULL)
-		chip->green = 1;
-
-	return len;
-}
-
-static ssize_t show_color(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	int r, g, b;
-
-	r = lp5521_read(client, LP5521_REG_R_PWM);
-	g = lp5521_read(client, LP5521_REG_G_PWM);
-	b = lp5521_read(client, LP5521_REG_B_PWM);
-
-	if (r < 0 || g < 0 || b < 0)
-		return -EINVAL;
-
-	return sprintf(buf, "%.2x:%.2x:%.2x\n", r, g, b);
-}
-
-static ssize_t store_color(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lp5521_chip *chip = i2c_get_clientdata(client);
-	int ret;
-	unsigned r, g, b;
-
-
-	ret = sscanf(buf, "%2x:%2x:%2x", &r, &g, &b);
-	if (ret != 3)
-		return  -EINVAL;
-
-	mutex_lock(&chip->lock);
-
-	ret = lp5521_write(client, LP5521_REG_R_PWM, (u8)r);
-	ret = lp5521_write(client, LP5521_REG_G_PWM, (u8)g);
-	ret = lp5521_write(client, LP5521_REG_B_PWM, (u8)b);
-
-	mutex_unlock(&chip->lock);
-
-	return len;
-}
-
-static ssize_t store_load(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	struct lp5521_chip *chip = dev_get_drvdata(dev);
-	int  ret, nrchars, offset = 0, i = 0;
-	char c[3];
-	unsigned cmd;
-	u8 pattern[LP5521_PROGRAM_LENGTH] = {0};
-
-	while ((offset < len - 1) && (i < LP5521_PROGRAM_LENGTH)) {
-
-		/* separate sscanfs because length is working only for %s */
-		ret = sscanf(buf + offset, "%2s%n ", c, &nrchars);
-		ret = sscanf(c, "%2x", &cmd);
-		if (ret != 1)
-			goto fail;
-		pattern[i] = (u8)cmd;
-
-		offset += nrchars;
-		i++;
-	}
-
-	/* pattern commands are always two bytes long */
-	if (i % 2)
-		goto fail;
-
-	mutex_lock(&chip->lock);
-
-	ret = lp5521_load_program(chip, pattern);
-	mutex_unlock(&chip->lock);
-
-	if (ret) {
-		dev_err(dev, "lp5521 failed loading pattern\n");
-		return ret;
-	}
-
-	return len;
-fail:
-	dev_err(dev, "lp5521 wrong pattern format\n");
-	return -EINVAL;
-}
-
-static ssize_t show_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct lp5521_chip *chip = dev_get_drvdata(dev);
-	char *mode;
-
-	mutex_lock(&chip->lock);
-	switch (chip->mode) {
-	case LP5521_MODE_RUN:
-		mode = "run";
-		break;
-	case LP5521_MODE_LOAD:
-		mode = "load";
-		break;
-	case LP5521_MODE_DIRECT_CONTROL:
-		mode = "direct";
-		break;
-	default:
-		mode = "undefined";
-	}
-	mutex_unlock(&chip->lock);
-
-	return sprintf(buf, "%s\n", mode);
-}
-
-static ssize_t store_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	struct lp5521_chip *chip = dev_get_drvdata(dev);
-
-	mutex_lock(&chip->lock);
-
-	if (!strncmp(buf, "run", 3))
-		lp5521_set_mode(chip, LP5521_MODE_RUN);
-	else if (!strncmp(buf, "load", 4))
-		lp5521_set_mode(chip, LP5521_MODE_LOAD);
-	else if (!strncmp(buf, "direct", 6))
-		lp5521_set_mode(chip, LP5521_MODE_DIRECT_CONTROL);
-
-	mutex_unlock(&chip->lock);
-
-	return len;
-}
-
-static ssize_t show_current(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	int r, g, b;
-
-	r = lp5521_read(client, LP5521_REG_R_CNTRL);
-	g = lp5521_read(client, LP5521_REG_G_CNTRL);
-	b = lp5521_read(client, LP5521_REG_B_CNTRL);
-
-	if (r < 0 || g < 0 || b < 0)
-		return -EINVAL;
-
-	r >>= 4;
-	g >>= 4;
-	b >>= 4;
-
-	return sprintf(buf, "%x %x %x\n", r, g, b);
-}
-
-static ssize_t store_current(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	struct lp5521_chip *chip = dev_get_drvdata(dev);
-	struct i2c_client *client = chip->client;
-	int ret;
-	unsigned curr;
-
-	ret = sscanf(buf, "%1x", &curr);
-	if (ret != 1)
-		return  -EINVAL;
-
-	/* current level is determined by the 4 upper bits, rest is ones */
-	curr = (curr << 4) | 0x0f;
-
-	mutex_lock(&chip->lock);
-
-	ret |= lp5521_write(client, LP5521_REG_R_CNTRL, (u8)curr);
-	ret |= lp5521_write(client, LP5521_REG_G_CNTRL, (u8)curr);
-	ret |= lp5521_write(client, LP5521_REG_B_CNTRL, (u8)curr);
-
-	mutex_unlock(&chip->lock);
-
-	return len;
-}
-
-static DEVICE_ATTR(color, S_IRUGO | S_IWUGO, show_color, store_color);
-static DEVICE_ATTR(load, S_IWUGO, NULL, store_load);
-static DEVICE_ATTR(mode, S_IRUGO | S_IWUGO, show_mode, store_mode);
-static DEVICE_ATTR(active_channels, S_IRUGO | S_IWUGO,
-		show_active_channels, store_active_channels);
-static DEVICE_ATTR(led_current, S_IRUGO | S_IWUGO, show_current, store_current);
-
-static int lp5521_register_sysfs(struct i2c_client *client)
-{
-	struct device *dev = &client->dev;
-	int ret;
-
-	ret = device_create_file(dev, &dev_attr_color);
-	if (ret)
-		goto fail1;
-	ret = device_create_file(dev, &dev_attr_load);
-	if (ret)
-		goto fail2;
-	ret = device_create_file(dev, &dev_attr_active_channels);
-	if (ret)
-		goto fail3;
-	ret = device_create_file(dev, &dev_attr_mode);
-	if (ret)
-		goto fail4;
-	ret = device_create_file(dev, &dev_attr_led_current);
-	if (ret)
-		goto fail5;
-
-	return 0;
-
-fail5:
-	device_remove_file(dev, &dev_attr_mode);
-fail4:
-	device_remove_file(dev, &dev_attr_active_channels);
-fail3:
-	device_remove_file(dev, &dev_attr_load);
-fail2:
-	device_remove_file(dev, &dev_attr_color);
-fail1:
-	return ret;
-}
-
-static void lp5521_unregister_sysfs(struct i2c_client *client)
-{
-	struct device *dev = &client->dev;
-
-	device_remove_file(dev, &dev_attr_led_current);
-	device_remove_file(dev, &dev_attr_mode);
-	device_remove_file(dev, &dev_attr_active_channels);
-	device_remove_file(dev, &dev_attr_color);
-	device_remove_file(dev, &dev_attr_load);
-}
-
-/*--------------------------------------------------------------*/
-/*			Set chip operating mode			*/
-/*--------------------------------------------------------------*/
-
-static int lp5521_set_mode(struct lp5521_chip *chip, enum lp5521_mode mode)
-{
-	struct i2c_client *client = chip->client ;
-	int ret = 0;
-
-	/* if in that mode already do nothing, except for run */
-	if (chip->mode == mode && mode != LP5521_MODE_RUN)
-		return 0;
-
-	switch (mode) {
-	case LP5521_MODE_RUN:
-		ret = lp5521_run_program(chip);
-		break;
-	case LP5521_MODE_LOAD:
-		ret |= lp5521_write(client, LP5521_REG_OP_MODE, 0x15);
-		break;
-	case LP5521_MODE_DIRECT_CONTROL:
-		ret |= lp5521_write(client, LP5521_REG_OP_MODE, 0x3F);
-		break;
-	default:
-		dev_dbg(&client->dev, "unsupported mode %d\n", mode);
-	}
-
-	chip->mode = mode;
-
-	return ret;
-}
-
-static void lp5521_red_work(struct work_struct *work)
-{
-	struct lp5521_chip *chip = container_of(work, struct lp5521_chip, red_work);
-	int ret;
-
-	ret = lp5521_configure(chip->client);
-	if (ret) {
-		dev_dbg(&chip->client->dev, "could not configure lp5521, %d\n",
-				ret);
-		return;
-	}
-
-	ret = lp5521_write(chip->client, LP5521_REG_R_PWM, chip->red);
-	if (ret)
-		dev_dbg(&chip->client->dev, "could not set brightness, %d\n",
-				ret);
-}
-
-static void lp5521_red_set(struct led_classdev *led,
-		enum led_brightness value)
-{
-	struct lp5521_chip *chip = container_of(led, struct lp5521_chip, ledr);
-
-	chip->red = value;
-	schedule_work(&chip->red_work);
-}
-
-static void lp5521_green_work(struct work_struct *work)
-{
-	struct lp5521_chip *chip = container_of(work, struct lp5521_chip, green_work);
-	int ret;
-
-	ret = lp5521_configure(chip->client);
-	if (ret) {
-		dev_dbg(&chip->client->dev, "could not configure lp5521, %d\n",
-				ret);
-		return;
-	}
-
-	ret = lp5521_write(chip->client, LP5521_REG_G_PWM, chip->green);
-	if (ret)
-		dev_dbg(&chip->client->dev, "could not set brightness, %d\n",
-				ret);
-}
-
-static void lp5521_green_set(struct led_classdev *led,
-		enum led_brightness value)
-{
-	struct lp5521_chip *chip = container_of(led, struct lp5521_chip, ledg);
-
-	chip->green = value;
-	schedule_work(&chip->green_work);
-}
-
-static void lp5521_blue_work(struct work_struct *work)
-{
-	struct lp5521_chip *chip = container_of(work, struct lp5521_chip, blue_work);
-	int ret;
-
-	ret = lp5521_configure(chip->client);
-	if (ret) {
-		dev_dbg(&chip->client->dev, "could not configure lp5521, %d\n",
-				ret);
-		return;
-	}
-
-	ret = lp5521_write(chip->client, LP5521_REG_B_PWM, chip->blue);
-	if (ret)
-		dev_dbg(&chip->client->dev, "could not set brightness, %d\n",
-				ret);
-}
-
-static void lp5521_blue_set(struct led_classdev *led,
-		enum led_brightness value)
-{
-	struct lp5521_chip *chip = container_of(led, struct lp5521_chip, ledb);
-
-	chip->blue = value;
-	schedule_work(&chip->blue_work);
-}
-
-/*--------------------------------------------------------------*/
-/*			Probe, Attach, Remove			*/
-/*--------------------------------------------------------------*/
-
-static int __init lp5521_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
-{
-	struct lp5521_platform_data *pdata = client->dev.platform_data;
-	struct lp5521_chip *chip;
-	char name[16];
-	int ret = 0;
-
-	if (!pdata) {
-		dev_err(&client->dev, "platform_data is missing\n");
-		return -EINVAL;
-	}
-
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-
-	chip->client = client;
-	strncpy(client->name, LP5521_DRIVER_NAME, I2C_NAME_SIZE);
-	i2c_set_clientdata(client, chip);
-
-	mutex_init(&chip->lock);
-
-	INIT_WORK(&chip->red_work, lp5521_red_work);
-	INIT_WORK(&chip->green_work, lp5521_green_work);
-	INIT_WORK(&chip->blue_work, lp5521_blue_work);
-
-	ret = lp5521_configure(client);
-	if (ret < 0) {
-		dev_err(&client->dev, "lp5521 error configuring chip \n");
-		goto fail1;
-	}
-
-	/* Set default values */
-	chip->mode	= pdata->mode;
-	chip->red	= pdata->red_present;
-	chip->green	= pdata->green_present;
-	chip->blue	= pdata->blue_present;
-
-	chip->ledr.brightness_set = lp5521_red_set;
-	chip->ledr.default_trigger = NULL;
-	snprintf(name, sizeof(name), "%s::red", pdata->label);
-	chip->ledr.name = name;
-	ret = led_classdev_register(&client->dev, &chip->ledr);
-	if (ret < 0) {
-		dev_dbg(&client->dev, "failed to register led %s, %d\n",
-				chip->ledb.name, ret);
-		goto fail1;
-	}
-
-	chip->ledg.brightness_set = lp5521_green_set;
-	chip->ledg.default_trigger = NULL;
-	snprintf(name, sizeof(name), "%s::green", pdata->label);
-	chip->ledg.name = name;
-	ret = led_classdev_register(&client->dev, &chip->ledg);
-	if (ret < 0) {
-		dev_dbg(&client->dev, "failed to register led %s, %d\n",
-				chip->ledb.name, ret);
-		goto fail2;
-	}
-
-	chip->ledb.brightness_set = lp5521_blue_set;
-	chip->ledb.default_trigger = NULL;
-	snprintf(name, sizeof(name), "%s::blue", pdata->label);
-	chip->ledb.name = name;
-	ret = led_classdev_register(&client->dev, &chip->ledb);
-	if (ret < 0) {
-		dev_dbg(&client->dev, "failed to register led %s, %d\n", chip->ledb.name, ret);
-		goto fail3;
-	}
-
-	ret = lp5521_register_sysfs(client);
-	if (ret) {
-		dev_err(&client->dev, "lp5521 registering sysfs failed \n");
-		goto fail4;
-	}
-
-	return 0;
-
-fail4:
-	led_classdev_unregister(&chip->ledb);
-fail3:
-	led_classdev_unregister(&chip->ledg);
-fail2:
-	led_classdev_unregister(&chip->ledr);
-fail1:
-	i2c_set_clientdata(client, NULL);
-	kfree(chip);
-
-	return ret;
-}
-
-static int __exit lp5521_remove(struct i2c_client *client)
-{
-	struct lp5521_chip *chip = i2c_get_clientdata(client);
-
-	lp5521_unregister_sysfs(client);
-	i2c_set_clientdata(client, NULL);
-
-	led_classdev_unregister(&chip->ledb);
-	led_classdev_unregister(&chip->ledg);
-	led_classdev_unregister(&chip->ledr);
-
-	kfree(chip);
-
-	return 0;
-}
-
-static const struct i2c_device_id lp5521_id[] = {
-	{ LP5521_DRIVER_NAME, 0},
-	{ },
-};
-MODULE_DEVICE_TABLE(i2c, lp5521_id);
-
-static struct i2c_driver lp5521_driver = {
-	.driver		= {
-		.name	= LP5521_DRIVER_NAME,
-	},
-	.probe		= lp5521_probe,
-	.remove		= __exit_p(lp5521_remove),
-	.id_table	= lp5521_id,
-};
-
-static int __init lp5521_init(void)
-{
-	return i2c_add_driver(&lp5521_driver);
-}
-module_init(lp5521_init);
-
-static void __exit lp5521_exit(void)
-{
-	i2c_del_driver(&lp5521_driver);
-}
-module_exit(lp5521_exit);
-
-MODULE_AUTHOR("Mathias Nyman <mathias.nyman@nokia.com>");
-MODULE_DESCRIPTION("lp5521 LED driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 4d4ff64..8d0f37e 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -134,6 +134,16 @@ config LEDS_GPIO
 	  outputs. To be useful the particular board must have LEDs
 	  and they must be connected to the GPIO lines.
 
+config LEDS_LP5521
+	tristate "LED Support for the LP5521 LEDs"
+	depends on LEDS_CLASS && I2C
+	help
+	  If you say 'Y' here you get support for the National Semiconductor
+	  LP5521 LED driver used in n8x0 boards.
+
+	  This driver can be built as a module by choosing 'M'. The module
+	  will be called leds-lp5521.
+
 config LEDS_CLEVO_MAIL
 	tristate "Mail LED on Clevo notebook (EXPERIMENTAL)"
 	depends on LEDS_CLASS && X86 && SERIO_I8042 && DMI && EXPERIMENTAL
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 7ac6ad3..4ab09e8 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_LEDS_COBALT_RAQ)		+= leds-cobalt-raq.o
 obj-$(CONFIG_LEDS_SUNFIRE)		+= leds-sunfire.o
 obj-$(CONFIG_LEDS_PCA9532)		+= leds-pca9532.o
 obj-$(CONFIG_LEDS_GPIO)			+= leds-gpio.o
+obj-$(CONFIG_LEDS_LP5521)		+= leds-lp5521.o
 obj-$(CONFIG_LEDS_CLEVO_MAIL)		+= leds-clevo-mail.o
 obj-$(CONFIG_LEDS_HP6XX)		+= leds-hp6xx.o
 obj-$(CONFIG_LEDS_FSG)			+= leds-fsg.o
diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
new file mode 100644
index 0000000..b3ba52a
--- /dev/null
+++ b/drivers/leds/leds-lp5521.c
@@ -0,0 +1,722 @@
+/*
+ * lp5521.c - LP5521 LED Driver
+ *
+ * Copyright (C) 2007 Nokia Corporation
+ *
+ * Written by Mathias Nyman <mathias.nyman@nokia.com>
+ * Updated by Felipe Balbi <felipe.balbi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <linux/i2c/lp5521.h>
+
+#define LP5521_DRIVER_NAME		"lp5521"
+
+#define LP5521_REG_R_PWM		0x02
+#define LP5521_REG_B_PWM		0x04
+#define LP5521_REG_ENABLE		0x00
+#define LP5521_REG_OP_MODE		0x01
+#define LP5521_REG_G_PWM		0x03
+#define LP5521_REG_R_CNTRL		0x05
+#define LP5521_REG_G_CNTRL		0x06
+#define LP5521_REG_B_CNTRL		0x07
+#define LP5521_REG_MISC			0x08
+#define LP5521_REG_R_CHANNEL_PC		0x09
+#define LP5521_REG_G_CHANNEL_PC		0x0a
+#define LP5521_REG_B_CHANNEL_PC		0x0b
+#define LP5521_REG_STATUS		0x0c
+#define LP5521_REG_RESET		0x0d
+#define LP5521_REG_GPO			0x0e
+#define LP5521_REG_R_PROG_MEM		0x10
+#define LP5521_REG_G_PROG_MEM		0x30
+#define LP5521_REG_B_PROG_MEM		0x50
+
+#define LP5521_CURRENT_1m5		0x0f
+#define LP5521_CURRENT_3m1		0x1f
+#define LP5521_CURRENT_4m7		0x2f
+#define LP5521_CURRENT_6m3		0x3f
+#define LP5521_CURRENT_7m9		0x4f
+#define LP5521_CURRENT_9m5		0x5f
+#define LP5521_CURRENT_11m1		0x6f
+#define LP5521_CURRENT_12m7		0x7f
+#define LP5521_CURRENT_14m3		0x8f
+#define LP5521_CURRENT_15m9		0x9f
+#define LP5521_CURRENT_17m5		0xaf
+#define LP5521_CURRENT_19m1		0xbf
+#define LP5521_CURRENT_20m7		0xcf
+#define LP5521_CURRENT_22m3		0xdf
+#define LP5521_CURRENT_23m9		0xef
+#define LP5521_CURRENT_25m5		0xff
+
+#define LP5521_PROGRAM_LENGTH		32	/* in bytes */
+
+struct lp5521_chip {
+	/* device lock */
+	struct mutex		lock;
+	struct i2c_client	*client;
+
+	struct work_struct	red_work;
+	struct work_struct	green_work;
+	struct work_struct	blue_work;
+
+	struct led_classdev	ledr;
+	struct led_classdev	ledg;
+	struct led_classdev	ledb;
+
+	enum lp5521_mode	mode;
+
+	int			red;
+	int			green;
+	int			blue;
+};
+
+static int lp5521_set_mode(struct lp5521_chip *chip, enum lp5521_mode mode);
+
+static inline int lp5521_write(struct i2c_client *client, u8 reg, u8 value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+static inline int lp5521_read(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int lp5521_configure(struct i2c_client *client)
+{
+	int ret = 0;
+
+	/* Enable chip and set light to logarithmic mode*/
+	ret |= lp5521_write(client, LP5521_REG_ENABLE, 0xc0);
+
+	/* setting all color pwms to direct control mode */
+	ret |= lp5521_write(client, LP5521_REG_OP_MODE, 0x3f);
+
+	/* setting current to 4.7 mA for all channels */
+	ret |= lp5521_write(client, LP5521_REG_R_CNTRL, LP5521_CURRENT_4m7);
+	ret |= lp5521_write(client, LP5521_REG_G_CNTRL, LP5521_CURRENT_4m7);
+	ret |= lp5521_write(client, LP5521_REG_B_CNTRL, LP5521_CURRENT_4m7);
+
+	/* Enable auto-powersave, set charge pump to auto, red to battery */
+	ret |= lp5521_write(client, LP5521_REG_MISC, 0x3c);
+
+	/* initialize all channels pwm to zero */
+	ret |= lp5521_write(client, LP5521_REG_R_PWM, 0);
+	ret |= lp5521_write(client, LP5521_REG_G_PWM, 0);
+	ret |= lp5521_write(client, LP5521_REG_B_PWM, 0);
+
+	/* Not much can be done about errors at this point */
+	return ret;
+}
+
+static int lp5521_load_program(struct lp5521_chip *chip, u8 *pattern)
+{
+	struct i2c_client *client = chip->client;
+	int ret = 0;
+
+	/* Enter load program mode for all led channels */
+	ret |= lp5521_write(client, LP5521_REG_OP_MODE, 0x15); /* 0001 0101 */
+	if (ret)
+		return ret;
+
+	if (chip->red)
+		ret |= i2c_smbus_write_i2c_block_data(client,
+				LP5521_REG_R_PROG_MEM,
+				LP5521_PROGRAM_LENGTH,
+				pattern);
+	if (chip->green)
+		ret |= i2c_smbus_write_i2c_block_data(client,
+				LP5521_REG_G_PROG_MEM,
+				LP5521_PROGRAM_LENGTH,
+				pattern);
+	if (chip->blue)
+		ret |= i2c_smbus_write_i2c_block_data(client,
+				LP5521_REG_B_PROG_MEM,
+				LP5521_PROGRAM_LENGTH,
+				pattern);
+
+	return ret;
+}
+
+static int lp5521_run_program(struct lp5521_chip *chip)
+{
+	struct i2c_client *client = chip->client;
+	int reg;
+	u8 mask = 0xc0;
+	u8 exec_state = 0;
+
+	reg = lp5521_read(client, LP5521_REG_ENABLE);
+	if (reg < 0)
+		return reg;
+
+	reg &= mask;
+
+	/* set all active channels exec state to countinous run*/
+	exec_state |= (chip->red << 5);
+	exec_state |= (chip->green << 3);
+	exec_state |= (chip->blue << 1);
+
+	reg |= exec_state;
+
+	if (lp5521_write(client, LP5521_REG_ENABLE, reg))
+		dev_dbg(&client->dev, "failed writing to register %02x\n",
+				LP5521_REG_ENABLE);
+
+	/* set op-mode to run for active channels, disabled for others */
+	if (lp5521_write(client, LP5521_REG_OP_MODE, exec_state))
+		dev_dbg(&client->dev, "failed writing to register %02x\n",
+				LP5521_REG_OP_MODE);
+
+	return 0;
+}
+
+/*--------------------------------------------------------------*/
+/*			Sysfs interface				*/
+/*--------------------------------------------------------------*/
+
+static ssize_t show_active_channels(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct lp5521_chip *chip = dev_get_drvdata(dev);
+	char channels[4];
+	int pos = 0;
+
+	if (chip->red)
+		pos += sprintf(channels + pos, "r");
+	if (chip->green)
+		pos += sprintf(channels + pos, "g");
+	if (chip->blue)
+		pos += sprintf(channels + pos, "b");
+
+	channels[pos] = '\0';
+
+	return sprintf(buf, "%s\n", channels);
+}
+
+static ssize_t store_active_channels(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct lp5521_chip *chip = dev_get_drvdata(dev);
+
+	chip->red = 0;
+	chip->green = 0;
+	chip->blue = 0;
+
+	if (strchr(buf, 'r') != NULL)
+		chip->red = 1;
+	if (strchr(buf, 'b') != NULL)
+		chip->blue = 1;
+	if (strchr(buf, 'g') != NULL)
+		chip->green = 1;
+
+	return len;
+}
+
+static ssize_t show_color(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int r, g, b;
+
+	r = lp5521_read(client, LP5521_REG_R_PWM);
+	g = lp5521_read(client, LP5521_REG_G_PWM);
+	b = lp5521_read(client, LP5521_REG_B_PWM);
+
+	if (r < 0 || g < 0 || b < 0)
+		return -EINVAL;
+
+	return sprintf(buf, "%.2x:%.2x:%.2x\n", r, g, b);
+}
+
+static ssize_t store_color(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lp5521_chip *chip = i2c_get_clientdata(client);
+	int ret;
+	unsigned r, g, b;
+
+
+	ret = sscanf(buf, "%2x:%2x:%2x", &r, &g, &b);
+	if (ret != 3)
+		return  -EINVAL;
+
+	mutex_lock(&chip->lock);
+
+	ret = lp5521_write(client, LP5521_REG_R_PWM, (u8)r);
+	ret = lp5521_write(client, LP5521_REG_G_PWM, (u8)g);
+	ret = lp5521_write(client, LP5521_REG_B_PWM, (u8)b);
+
+	mutex_unlock(&chip->lock);
+
+	return len;
+}
+
+static ssize_t store_load(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct lp5521_chip *chip = dev_get_drvdata(dev);
+	int  ret, nrchars, offset = 0, i = 0;
+	char c[3];
+	unsigned cmd;
+	u8 pattern[LP5521_PROGRAM_LENGTH] = {0};
+
+	while ((offset < len - 1) && (i < LP5521_PROGRAM_LENGTH)) {
+
+		/* separate sscanfs because length is working only for %s */
+		ret = sscanf(buf + offset, "%2s%n ", c, &nrchars);
+		ret = sscanf(c, "%2x", &cmd);
+		if (ret != 1)
+			goto fail;
+		pattern[i] = (u8)cmd;
+
+		offset += nrchars;
+		i++;
+	}
+
+	/* pattern commands are always two bytes long */
+	if (i % 2)
+		goto fail;
+
+	mutex_lock(&chip->lock);
+
+	ret = lp5521_load_program(chip, pattern);
+	mutex_unlock(&chip->lock);
+
+	if (ret) {
+		dev_err(dev, "lp5521 failed loading pattern\n");
+		return ret;
+	}
+
+	return len;
+fail:
+	dev_err(dev, "lp5521 wrong pattern format\n");
+	return -EINVAL;
+}
+
+static ssize_t show_mode(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct lp5521_chip *chip = dev_get_drvdata(dev);
+	char *mode;
+
+	mutex_lock(&chip->lock);
+	switch (chip->mode) {
+	case LP5521_MODE_RUN:
+		mode = "run";
+		break;
+	case LP5521_MODE_LOAD:
+		mode = "load";
+		break;
+	case LP5521_MODE_DIRECT_CONTROL:
+		mode = "direct";
+		break;
+	default:
+		mode = "undefined";
+	}
+	mutex_unlock(&chip->lock);
+
+	return sprintf(buf, "%s\n", mode);
+}
+
+static ssize_t store_mode(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct lp5521_chip *chip = dev_get_drvdata(dev);
+
+	mutex_lock(&chip->lock);
+
+	if (!strncmp(buf, "run", 3))
+		lp5521_set_mode(chip, LP5521_MODE_RUN);
+	else if (!strncmp(buf, "load", 4))
+		lp5521_set_mode(chip, LP5521_MODE_LOAD);
+	else if (!strncmp(buf, "direct", 6))
+		lp5521_set_mode(chip, LP5521_MODE_DIRECT_CONTROL);
+
+	mutex_unlock(&chip->lock);
+
+	return len;
+}
+
+static ssize_t show_current(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int r, g, b;
+
+	r = lp5521_read(client, LP5521_REG_R_CNTRL);
+	g = lp5521_read(client, LP5521_REG_G_CNTRL);
+	b = lp5521_read(client, LP5521_REG_B_CNTRL);
+
+	if (r < 0 || g < 0 || b < 0)
+		return -EINVAL;
+
+	r >>= 4;
+	g >>= 4;
+	b >>= 4;
+
+	return sprintf(buf, "%x %x %x\n", r, g, b);
+}
+
+static ssize_t store_current(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct lp5521_chip *chip = dev_get_drvdata(dev);
+	struct i2c_client *client = chip->client;
+	int ret;
+	unsigned curr;
+
+	ret = sscanf(buf, "%1x", &curr);
+	if (ret != 1)
+		return  -EINVAL;
+
+	/* current level is determined by the 4 upper bits, rest is ones */
+	curr = (curr << 4) | 0x0f;
+
+	mutex_lock(&chip->lock);
+
+	ret |= lp5521_write(client, LP5521_REG_R_CNTRL, (u8)curr);
+	ret |= lp5521_write(client, LP5521_REG_G_CNTRL, (u8)curr);
+	ret |= lp5521_write(client, LP5521_REG_B_CNTRL, (u8)curr);
+
+	mutex_unlock(&chip->lock);
+
+	return len;
+}
+
+static DEVICE_ATTR(color, S_IRUGO | S_IWUGO, show_color, store_color);
+static DEVICE_ATTR(load, S_IWUGO, NULL, store_load);
+static DEVICE_ATTR(mode, S_IRUGO | S_IWUGO, show_mode, store_mode);
+static DEVICE_ATTR(active_channels, S_IRUGO | S_IWUGO,
+		show_active_channels, store_active_channels);
+static DEVICE_ATTR(led_current, S_IRUGO | S_IWUGO, show_current, store_current);
+
+static int lp5521_register_sysfs(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	int ret;
+
+	ret = device_create_file(dev, &dev_attr_color);
+	if (ret)
+		goto fail1;
+	ret = device_create_file(dev, &dev_attr_load);
+	if (ret)
+		goto fail2;
+	ret = device_create_file(dev, &dev_attr_active_channels);
+	if (ret)
+		goto fail3;
+	ret = device_create_file(dev, &dev_attr_mode);
+	if (ret)
+		goto fail4;
+	ret = device_create_file(dev, &dev_attr_led_current);
+	if (ret)
+		goto fail5;
+
+	return 0;
+
+fail5:
+	device_remove_file(dev, &dev_attr_mode);
+fail4:
+	device_remove_file(dev, &dev_attr_active_channels);
+fail3:
+	device_remove_file(dev, &dev_attr_load);
+fail2:
+	device_remove_file(dev, &dev_attr_color);
+fail1:
+	return ret;
+}
+
+static void lp5521_unregister_sysfs(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+
+	device_remove_file(dev, &dev_attr_led_current);
+	device_remove_file(dev, &dev_attr_mode);
+	device_remove_file(dev, &dev_attr_active_channels);
+	device_remove_file(dev, &dev_attr_color);
+	device_remove_file(dev, &dev_attr_load);
+}
+
+/*--------------------------------------------------------------*/
+/*			Set chip operating mode			*/
+/*--------------------------------------------------------------*/
+
+static int lp5521_set_mode(struct lp5521_chip *chip, enum lp5521_mode mode)
+{
+	struct i2c_client *client = chip->client ;
+	int ret = 0;
+
+	/* if in that mode already do nothing, except for run */
+	if (chip->mode == mode && mode != LP5521_MODE_RUN)
+		return 0;
+
+	switch (mode) {
+	case LP5521_MODE_RUN:
+		ret = lp5521_run_program(chip);
+		break;
+	case LP5521_MODE_LOAD:
+		ret |= lp5521_write(client, LP5521_REG_OP_MODE, 0x15);
+		break;
+	case LP5521_MODE_DIRECT_CONTROL:
+		ret |= lp5521_write(client, LP5521_REG_OP_MODE, 0x3F);
+		break;
+	default:
+		dev_dbg(&client->dev, "unsupported mode %d\n", mode);
+	}
+
+	chip->mode = mode;
+
+	return ret;
+}
+
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
+/*--------------------------------------------------------------*/
+/*			Probe, Attach, Remove			*/
+/*--------------------------------------------------------------*/
+
+static int __init lp5521_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct lp5521_platform_data *pdata = client->dev.platform_data;
+	struct lp5521_chip *chip;
+	char name[16];
+	int ret = 0;
+
+	if (!pdata) {
+		dev_err(&client->dev, "platform_data is missing\n");
+		return -EINVAL;
+	}
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->client = client;
+	strncpy(client->name, LP5521_DRIVER_NAME, I2C_NAME_SIZE);
+	i2c_set_clientdata(client, chip);
+
+	mutex_init(&chip->lock);
+
+	INIT_WORK(&chip->red_work, lp5521_red_work);
+	INIT_WORK(&chip->green_work, lp5521_green_work);
+	INIT_WORK(&chip->blue_work, lp5521_blue_work);
+
+	ret = lp5521_configure(client);
+	if (ret < 0) {
+		dev_err(&client->dev, "lp5521 error configuring chip \n");
+		goto fail1;
+	}
+
+	/* Set default values */
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
+
+	ret = lp5521_register_sysfs(client);
+	if (ret) {
+		dev_err(&client->dev, "lp5521 registering sysfs failed \n");
+		goto fail4;
+	}
+
+	return 0;
+
+fail4:
+	led_classdev_unregister(&chip->ledb);
+fail3:
+	led_classdev_unregister(&chip->ledg);
+fail2:
+	led_classdev_unregister(&chip->ledr);
+fail1:
+	i2c_set_clientdata(client, NULL);
+	kfree(chip);
+
+	return ret;
+}
+
+static int __exit lp5521_remove(struct i2c_client *client)
+{
+	struct lp5521_chip *chip = i2c_get_clientdata(client);
+
+	lp5521_unregister_sysfs(client);
+	i2c_set_clientdata(client, NULL);
+
+	led_classdev_unregister(&chip->ledb);
+	led_classdev_unregister(&chip->ledg);
+	led_classdev_unregister(&chip->ledr);
+
+	kfree(chip);
+
+	return 0;
+}
+
+static const struct i2c_device_id lp5521_id[] = {
+	{ LP5521_DRIVER_NAME, 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, lp5521_id);
+
+static struct i2c_driver lp5521_driver = {
+	.driver		= {
+		.name	= LP5521_DRIVER_NAME,
+	},
+	.probe		= lp5521_probe,
+	.remove		= __exit_p(lp5521_remove),
+	.id_table	= lp5521_id,
+};
+
+static int __init lp5521_init(void)
+{
+	return i2c_add_driver(&lp5521_driver);
+}
+module_init(lp5521_init);
+
+static void __exit lp5521_exit(void)
+{
+	i2c_del_driver(&lp5521_driver);
+}
+module_exit(lp5521_exit);
+
+MODULE_AUTHOR("Mathias Nyman <mathias.nyman@nokia.com>");
+MODULE_DESCRIPTION("lp5521 LED driver");
+MODULE_LICENSE("GPL");
-- 
1.6.1.265.g9a013

