From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 2/5] input: lm8323: get rid of useless debug macro
Date: Thu, 19 Feb 2009 14:29:40 +0200
Message-ID: <1235046583-29696-3-git-send-email-me@felipebalbi.com>
References: <1235046583-29696-1-git-send-email-me@felipebalbi.com>
 <1235046583-29696-2-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55982 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbZBSMaA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 07:30:00 -0500
In-Reply-To: <1235046583-29696-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

we can use dev_vdbg() which is only true when VERBOSE is
enabled.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/input/keyboard/lm8323.c |   28 +++++++++++-----------------
 1 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 60abe61..0812bef 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -33,12 +33,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/irq.h>
 
-#ifdef VERBOSE
-#define debug dev_dbg
-#else
-#define debug(...)
-#endif
-
 /* Commands to send to the chip. */
 #define LM8323_CMD_READ_ID		0x80 /* Read chip ID. */
 #define LM8323_CMD_WRITE_CFG		0x81 /* Set configuration item. */
@@ -303,7 +297,7 @@ static void process_keys(struct lm8323_chip *lm)
 		s16 keycode = lm->keymap[key];
 
 		if (likely(keycode > 0)) {
-			debug(&lm->client->dev, "key 0x%02x %s\n", key,
+			dev_vdbg(&lm->client->dev, "key 0x%02x %s\n", key,
 			      isdown ? "down" : "up");
 			if (likely(lm->kp_enabled)) {
 				input_report_key(lm->idev, keycode, isdown);
@@ -337,13 +331,13 @@ static void lm8323_process_error(struct lm8323_chip *lm)
 
 	if (lm8323_read(lm, LM8323_CMD_READ_ERR, &error, 1) == 1) {
 		if (error & ERR_FIFOOVER)
-			debug(&lm->client->dev, "fifo overflow!\n");
+			dev_vdbg(&lm->client->dev, "fifo overflow!\n");
 		if (error & ERR_KEYOVR)
-			debug(&lm->client->dev, "more than two keys pressed\n");
+			dev_vdbg(&lm->client->dev, "more than two keys pressed\n");
 		if (error & ERR_CMDUNK)
-			debug(&lm->client->dev, "unknown command submitted\n");
+			dev_vdbg(&lm->client->dev, "unknown command submitted\n");
 		if (error & ERR_BADPAR)
-			debug(&lm->client->dev, "bad command parameter\n");
+			dev_vdbg(&lm->client->dev, "bad command parameter\n");
 	}
 }
 
@@ -408,10 +402,10 @@ static void lm8323_work(struct work_struct *work)
 			process_keys(lm);
 		if (ints & INT_ROTATOR) {
 			/* We don't currently support the rotator. */
-			debug(&lm->client->dev, "rotator fired\n");
+			dev_vdbg(&lm->client->dev, "rotator fired\n");
 		}
 		if (ints & INT_ERROR) {
-			debug(&lm->client->dev, "error!\n");
+			dev_vdbg(&lm->client->dev, "error!\n");
 			lm8323_process_error(lm);
 		}
 		if (ints & INT_NOINIT) {
@@ -420,15 +414,15 @@ static void lm8323_work(struct work_struct *work)
 			lm8323_configure(lm);
 		}
 		if (ints & INT_PWM1) {
-			debug(&lm->client->dev, "pwm1 engine completed\n");
+			dev_vdbg(&lm->client->dev, "pwm1 engine completed\n");
 			pwm_done(&lm->pwm1);
 		}
 		if (ints & INT_PWM2) {
-			debug(&lm->client->dev, "pwm2 engine completed\n");
+			dev_vdbg(&lm->client->dev, "pwm2 engine completed\n");
 			pwm_done(&lm->pwm2);
 		}
 		if (ints & INT_PWM3) {
-			debug(&lm->client->dev, "pwm3 engine completed\n");
+			dev_vdbg(&lm->client->dev, "pwm3 engine completed\n");
 			pwm_done(&lm->pwm3);
 		}
 	}
@@ -714,7 +708,7 @@ static int lm8323_probe(struct i2c_client *client,
 		lm->size_x = 12;
 	}
 
-	debug(&c->dev, "Keypad size: %d x %d\n", lm->size_x, lm->size_y);
+	dev_vdbg(&client->dev, "Keypad size: %d x %d\n", lm->size_x, lm->size_y);
 
 	lm->debounce_time = pdata->debounce_time;
 	if (lm->debounce_time == 0) /* Default. */
-- 
1.6.1.3

