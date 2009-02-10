From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 8/8] input: lm8323: general clean up
Date: Tue, 10 Feb 2009 14:16:05 +0200
Message-ID: <1234268165-23573-9-git-send-email-felipe.balbi@nokia.com>
References: <1234268165-23573-1-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-2-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-3-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-4-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-5-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-6-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-7-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-8-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57872 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbZBJMaZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 07:30:25 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1ACTZcd018282
	for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2009 06:30:23 -0600
In-Reply-To: <1234268165-23573-8-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

This patch cleans up lm8323 driver a little bit:

- don't include <asm/mach-types.h> nor <asm/mach/irq.h>
- remove #define DRIVER_NAME
- don't try to fix pdata if it comes wrong, return -errno
- add __devexit to remove() call
- move module_init() and module_exit() closer to their arguments
- add missing fields to n800's lm8323's pdata

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-n800.c |   14 ++++++---
 drivers/input/keyboard/lm8323.c  |   51 ++++++++++++++-----------------------
 2 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index b38b295..fe6e5c9 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -111,12 +111,16 @@ static s16 rx44_keymap[LM8323_KEYMAP_SIZE] = {
 };
 
 static struct lm8323_platform_data lm8323_pdata = {
-	.repeat = 0, /* Repeat is handled in userspace for now. */
-	.keymap = rx44_keymap,
-
-	.name = "Internal keyboard",
-	.pwm1_name = "keyboard",
-	.pwm2_name = "cover",
+	.repeat		= 0, /* Repeat is handled in userspace for now. */
+	.keymap		= rx44_keymap,
+	.size_x		= 8,
+	.size_y		= 8,
+	.debounce_time	= 12,
+	.active_time	= 500,
+
+	.name		= "Internal keyboard",
+	.pwm1_name	= "keyboard",
+	.pwm2_name	= "cover",
 };
 #endif
 
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 0812bef..4df16d9 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -30,9 +30,6 @@
 #include <linux/leds.h>
 #include <linux/i2c/lm8323.h>
 
-#include <asm/mach-types.h>
-#include <asm/mach/irq.h>
-
 /* Commands to send to the chip. */
 #define LM8323_CMD_READ_ID		0x80 /* Read chip ID. */
 #define LM8323_CMD_WRITE_CFG		0x81 /* Set configuration item. */
@@ -127,8 +124,6 @@
 /* Send trigger.  Argument is same as PWM_WAIT_TRIG. */
 #define PWM_SEND_TRIG(chans)		(0xe000 | ((chans) & 0x7))
 
-#define DRIVER_NAME  "lm8323"
-
 struct lm8323_pwm {
 	int			id;
 	int			enabled;
@@ -671,7 +666,7 @@ static ssize_t lm8323_set_disable(struct device *dev,
 static DEVICE_ATTR(disable_kp, 0644, lm8323_show_disable, lm8323_set_disable);
 
 static int lm8323_probe(struct i2c_client *client,
-					const struct i2c_device_id *id)
+		const struct i2c_device_id *id)
 {
 	struct lm8323_platform_data *pdata;
 	struct input_dev *idev;
@@ -687,40 +682,32 @@ static int lm8323_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, lm);
 	lm->client = client;
 	pdata = client->dev.platform_data;
-	if (!pdata)
-		return -EINVAL; /* ? */
+	if (!pdata || !pdata->size_x || !pdata->size_y) {
+		dev_err(&client->dev, "missing platform_data\n");
+		err = -EINVAL;
+		goto fail2;
+	}
 
 	lm->size_x = pdata->size_x;
-	if (lm->size_x == 0) {
-		lm->size_x = 8;
-	} else if (lm->size_x > 8) {
+	if (lm->size_x > 8) {
 		dev_err(&client->dev, "invalid x size %d specified\n",
 				lm->size_x);
-		lm->size_x = 8;
+		err = -EINVAL;
+		goto fail2;
 	}
 
 	lm->size_y = pdata->size_y;
-	if (lm->size_y == 0) {
-		lm->size_y = 12;
-	} else if (lm->size_y > 12) {
+	if (lm->size_y > 12) {
 		dev_err(&client->dev, "invalid y size %d specified\n",
 				lm->size_y);
-		lm->size_x = 12;
+		err = -EINVAL;
+		goto fail2;
 	}
 
 	dev_vdbg(&client->dev, "Keypad size: %d x %d\n", lm->size_x, lm->size_y);
 
 	lm->debounce_time = pdata->debounce_time;
-	if (lm->debounce_time == 0) /* Default. */
-		lm->debounce_time = 12;
-	else if (lm->debounce_time == -1) /* Disable debounce. */
-		lm->debounce_time = 0;
-
 	lm->active_time = pdata->active_time;
-	if (lm->active_time == 0) /* Default. */
-		lm->active_time = 500;
-	else if (lm->active_time == -1) /* Disable sleep. */
-		lm->active_time = 0;
 
 	lm8323_reset(lm);
 
@@ -760,7 +747,7 @@ static int lm8323_probe(struct i2c_client *client,
 
 	err = request_irq(client->irq, lm8323_irq,
 			  IRQF_TRIGGER_FALLING | IRQF_DISABLED |
-			  IRQF_SAMPLE_RANDOM, DRIVER_NAME, lm);
+			  IRQF_SAMPLE_RANDOM, "lm8323", lm);
 	if (err) {
 		dev_err(&client->dev, "could not get IRQ %d\n", client->irq);
 		goto fail6;
@@ -774,7 +761,7 @@ static int lm8323_probe(struct i2c_client *client,
 		goto fail7;
 
 	idev = input_allocate_device();
-	if (idev == NULL) {
+	if (!idev) {
 		err = -ENOMEM;
 		goto fail8;
 	}
@@ -826,7 +813,7 @@ fail2:
 	return err;
 }
 
-static int lm8323_remove(struct i2c_client *client)
+static int __devexit lm8323_remove(struct i2c_client *client)
 {
 	struct lm8323_chip *lm = i2c_get_clientdata(client);
 
@@ -892,13 +879,13 @@ static int lm8323_resume(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm8323_id[] = {
-	{ DRIVER_NAME, 0 },
+	{ "lm8323", 0 },
 	{ }
 };
 
 static struct i2c_driver lm8323_i2c_driver = {
 	.driver = {
-		.name	 = DRIVER_NAME,
+		.name	 = "lm8323",
 	},
 	.probe		= lm8323_probe,
 	.remove		= __devexit_p(lm8323_remove),
@@ -912,15 +899,15 @@ static int __init lm8323_init(void)
 {
 	return i2c_add_driver(&lm8323_i2c_driver);
 }
+module_init(lm8323_init);
 
 static void __exit lm8323_exit(void)
 {
 	i2c_del_driver(&lm8323_i2c_driver);
 }
+module_exit(lm8323_exit);
 
 MODULE_AUTHOR("Timo O. Karjalainen <timo.o.karjalainen@nokia.com>, Daniel Stone");
 MODULE_DESCRIPTION("LM8323 keypad driver");
 MODULE_LICENSE("GPL");
 
-module_init(lm8323_init);
-module_exit(lm8323_exit);
-- 
1.6.1.265.g9a013

