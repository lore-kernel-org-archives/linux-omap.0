From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] input: keypad: lm8323: convert to threaded IRQ
Date: Tue, 14 Jun 2011 00:16:52 +0300
Message-ID: <1307999812-3802-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:53071 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752193Ab1FMVRG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 17:17:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

there's no need for that workqueue anymore.
Get rid of it and move to threaded IRQs
instead.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

compile tested only. I need someone to reply with
a Tested-by tag.

 drivers/input/keyboard/lm8323.c |   23 ++++-------------------
 1 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 71f744a8..3b21f42 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -146,7 +146,6 @@ struct lm8323_chip {
 	/* device lock */
 	struct mutex		lock;
 	struct i2c_client	*client;
-	struct work_struct	work;
 	struct input_dev	*idev;
 	bool			kp_enabled;
 	bool			pm_suspend;
@@ -162,7 +161,6 @@ struct lm8323_chip {
 
 #define client_to_lm8323(c)	container_of(c, struct lm8323_chip, client)
 #define dev_to_lm8323(d)	container_of(d, struct lm8323_chip, client->dev)
-#define work_to_lm8323(w)	container_of(w, struct lm8323_chip, work)
 #define cdev_to_pwm(c)		container_of(c, struct lm8323_pwm, cdev)
 #define work_to_pwm(w)		container_of(w, struct lm8323_pwm, work)
 
@@ -375,9 +373,9 @@ static void pwm_done(struct lm8323_pwm *pwm)
  * Bottom half: handle the interrupt by posting key events, or dealing with
  * errors appropriately.
  */
-static void lm8323_work(struct work_struct *work)
+static irqreturn_t lm8323_irq(int irq, void *_lm)
 {
-	struct lm8323_chip *lm = work_to_lm8323(work);
+	struct lm8323_chip *lm = _lm;
 	u8 ints;
 	int i;
 
@@ -409,16 +407,6 @@ static void lm8323_work(struct work_struct *work)
 	}
 
 	mutex_unlock(&lm->lock);
-}
-
-/*
- * We cannot use I2C in interrupt context, so we just schedule work.
- */
-static irqreturn_t lm8323_irq(int irq, void *data)
-{
-	struct lm8323_chip *lm = data;
-
-	schedule_work(&lm->work);
 
 	return IRQ_HANDLED;
 }
@@ -675,7 +663,6 @@ static int __devinit lm8323_probe(struct i2c_client *client,
 	lm->client = client;
 	lm->idev = idev;
 	mutex_init(&lm->lock);
-	INIT_WORK(&lm->work, lm8323_work);
 
 	lm->size_x = pdata->size_x;
 	lm->size_y = pdata->size_y;
@@ -746,9 +733,8 @@ static int __devinit lm8323_probe(struct i2c_client *client,
 		goto fail3;
 	}
 
-	err = request_irq(client->irq, lm8323_irq,
-			  IRQF_TRIGGER_FALLING | IRQF_DISABLED,
-			  "lm8323", lm);
+	err = request_threaded_irq(client->irq, NULL, lm8323_irq,
+			  IRQF_TRIGGER_FALLING, "lm8323", lm);
 	if (err) {
 		dev_err(&client->dev, "could not get IRQ %d\n", client->irq);
 		goto fail4;
@@ -783,7 +769,6 @@ static int __devexit lm8323_remove(struct i2c_client *client)
 
 	disable_irq_wake(client->irq);
 	free_irq(client->irq, lm);
-	cancel_work_sync(&lm->work);
 
 	input_unregister_device(lm->idev);
 
-- 
1.7.6.rc1

