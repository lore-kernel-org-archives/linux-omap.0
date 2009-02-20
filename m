From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] input: lm8323: apply comments from mainline
Date: Sat, 21 Feb 2009 00:30:37 +0200
Message-ID: <20090220223036.GW32564@gandalf>
References: <1235168494-20304-1-git-send-email-me@felipebalbi.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44896 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbZBTWan (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 17:30:43 -0500
Content-Disposition: inline
In-Reply-To: <1235168494-20304-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sat, Feb 21, 2009 at 12:21:34AM +0200, Felipe Balbi wrote:
> In order to avoid conflicts later, let's sync omap
> version with the version accepted by mainline after
> fixing a few comments.
> 
> Signed-off-by: Felipe Balbi <me@felipebalbi.com>

Wait a minute, I forgot one hunk, here's an updated version:

========== cut here ==========

>From 370931163e963de1b3cd38d25c1233adebabd103 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <me@felipebalbi.com>
Date: Thu, 19 Feb 2009 19:53:59 +0200
Subject: [PATCH] input: lm8323: apply comments from mainline

In order to avoid conflicts later, let's sync omap
version with the version accepted by mainline after
fixing a few comments.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/input/keyboard/Kconfig  |    1 +
 drivers/input/keyboard/lm8323.c |   47 +++++++++++++++++++++++++-------------
 include/linux/i2c/lm8323.h      |   17 +++++++++++--
 3 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4d64652..2c5b7bc 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -289,6 +289,7 @@ config KEYBOARD_TSC2301
 config KEYBOARD_LM8323
 	tristate "LM8323 keypad chip"
 	depends on I2C
+	depends on LEDS
 	help
 	  If you say yes here you get support for the National Semiconductor
 	  LM8323 keypad controller.
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 27da93c..a796680 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -1,11 +1,13 @@
 /*
  * drivers/i2c/chips/lm8323.c
  *
- * Copyright (C) 2007 Nokia Corporation
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Daniel Stone <daniel.stone@nokia.com>
  *            Timo O. Karjalainen <timo.o.karjalainen@nokia.com>
  *
+ * Updated by Felipe Balbi <felipe.balbi@nokia.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation (version 2 of the License only).
@@ -131,18 +133,20 @@ struct lm8323_pwm {
 	int			brightness;
 	int			desired_brightness;
 	int			running;
+	/* pwm lock */
 	struct mutex		lock;
 	struct work_struct	work;
 	struct led_classdev	cdev;
 };
 
 struct lm8323_chip {
+	/* device lock */
 	struct mutex		lock;
 	struct i2c_client	*client;
 	struct work_struct	work;
 	struct input_dev	*idev;
-	unsigned		kp_enabled : 1;
-	unsigned		pm_suspend : 1;
+	unsigned		kp_enabled:1;
+	unsigned		pm_suspend:1;
 	unsigned		keys_down;
 	char			phys[32];
 	s16			keymap[LM8323_KEYMAP_SIZE];
@@ -328,9 +332,11 @@ static void lm8323_process_error(struct lm8323_chip *lm)
 		if (error & ERR_FIFOOVER)
 			dev_vdbg(&lm->client->dev, "fifo overflow!\n");
 		if (error & ERR_KEYOVR)
-			dev_vdbg(&lm->client->dev, "more than two keys pressed\n");
+			dev_vdbg(&lm->client->dev,
+					"more than two keys pressed\n");
 		if (error & ERR_CMDUNK)
-			dev_vdbg(&lm->client->dev, "unknown command submitted\n");
+			dev_vdbg(&lm->client->dev,
+					"unknown command submitted\n");
 		if (error & ERR_BADPAR)
 			dev_vdbg(&lm->client->dev, "bad command parameter\n");
 	}
@@ -510,8 +516,7 @@ static void lm8323_pwm_work(struct work_struct *work)
 	if ((pwm->fade_time / steps) > (32768 / 512)) {
 		div512 = 1;
 		hz = 32768 / 512;
-	}
-	else {
+	} else {
 		div512 = 0;
 		hz = 32768 / 16;
 	}
@@ -579,7 +584,7 @@ static ssize_t lm8323_pwm_store_time(struct device *dev,
 	int ret;
 	int time;
 
-	ret = sscanf(buf, "%d", &time);
+	ret = strict_strtoul(buf, 10, &time);
 	/* Numbers only, please. */
 	if (ret)
 		return -EINVAL;
@@ -655,7 +660,7 @@ static ssize_t lm8323_set_disable(struct device *dev,
 	int ret;
 	int i;
 
-	i = sscanf(buf, "%d", &ret);
+	ret = strict_strtoul(buf, 10, &i);
 
 	mutex_lock(&lm->lock);
 	lm->kp_enabled = !i;
@@ -704,7 +709,8 @@ static int lm8323_probe(struct i2c_client *client,
 		goto fail2;
 	}
 
-	dev_vdbg(&client->dev, "Keypad size: %d x %d\n", lm->size_x, lm->size_y);
+	dev_vdbg(&client->dev, "Keypad size: %d x %d\n",
+			lm->size_x, lm->size_y);
 
 	lm->debounce_time = pdata->debounce_time;
 	lm->active_time = pdata->active_time;
@@ -746,14 +752,15 @@ static int lm8323_probe(struct i2c_client *client,
 	INIT_WORK(&lm->work, lm8323_work);
 
 	err = request_irq(client->irq, lm8323_irq,
-			  IRQF_TRIGGER_FALLING | IRQF_DISABLED |
-			  IRQF_SAMPLE_RANDOM, "lm8323", lm);
+			  IRQF_TRIGGER_FALLING | IRQF_DISABLED,
+			  "lm8323", lm);
 	if (err) {
 		dev_err(&client->dev, "could not get IRQ %d\n", client->irq);
 		goto fail6;
 	}
 
-	set_irq_wake(client->irq, 1);
+	device_init_wakeup(&client->dev, 1);
+	enable_irq_wake(client->irq);
 
 	lm->kp_enabled = 1;
 	err = device_create_file(&client->dev, &dev_attr_disable_kp);
@@ -777,13 +784,13 @@ static int lm8323_probe(struct i2c_client *client,
 	idev->evbit[0] = BIT(EV_KEY);
 	for (i = 0; i < LM8323_KEYMAP_SIZE; i++) {
 		if (pdata->keymap[i] > 0)
-			set_bit(pdata->keymap[i], idev->keybit);
+			__set_bit(pdata->keymap[i], idev->keybit);
 
 		lm->keymap[i] = pdata->keymap[i];
 	}
 
 	if (pdata->repeat)
-		set_bit(EV_REP, idev->evbit);
+		__set_bit(EV_REP, idev->evbit);
 
 	lm->idev = idev;
 	err = input_register_device(idev);
@@ -817,6 +824,7 @@ static int lm8323_remove(struct i2c_client *client)
 {
 	struct lm8323_chip *lm = i2c_get_clientdata(client);
 
+	disable_irq_wake(client->irq);
 	free_irq(client->irq, lm);
 	cancel_work_sync(&lm->work);
 	input_unregister_device(lm->idev);
@@ -832,6 +840,7 @@ static int lm8323_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 /*
  * We don't need to explicitly suspend the chip, as it already switches off
  * when there's no activity.
@@ -877,6 +886,10 @@ static int lm8323_resume(struct i2c_client *client)
 
 	return 0;
 }
+#else
+#define lm8323_suspend	NULL
+#define lm8323_resume	NULL
+#endif
 
 static const struct i2c_device_id lm8323_id[] = {
 	{ "lm8323", 0 },
@@ -907,7 +920,9 @@ static void __exit lm8323_exit(void)
 }
 module_exit(lm8323_exit);
 
-MODULE_AUTHOR("Timo O. Karjalainen <timo.o.karjalainen@nokia.com>, Daniel Stone");
+MODULE_AUTHOR("Timo O. Karjalainen <timo.o.karjalainen@nokia.com>");
+MODULE_AUTHOR("Daniel Stone");
+MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
 MODULE_DESCRIPTION("LM8323 keypad driver");
 MODULE_LICENSE("GPL");
 
diff --git a/include/linux/i2c/lm8323.h b/include/linux/i2c/lm8323.h
index 5eae5cc..67e82bc 100644
--- a/include/linux/i2c/lm8323.h
+++ b/include/linux/i2c/lm8323.h
@@ -1,7 +1,18 @@
 /*
- * include/lm8323.h
+ * lm8323.h - Configuration for LM8323 keypad driver.
  *
- * Configuration for LM8323 keypad driver.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License only).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #ifndef __LINUX_LM8323_H
@@ -22,7 +33,7 @@ struct lm8323_platform_data {
 
 	int size_x;
 	int size_y;
-	int repeat : 1;
+	int repeat:1;
 	const s16 *keymap;
 
 	char *pwm1_name; /* Device name for PWM1. */
-- 
1.6.1.3

-- 
balbi
