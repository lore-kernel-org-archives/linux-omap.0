From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 1/5] input: lm8323: get rid of global pdata pointer
Date: Thu, 19 Feb 2009 14:29:39 +0200
Message-ID: <1235046583-29696-2-git-send-email-me@felipebalbi.com>
References: <1235046583-29696-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55977 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZBSM37 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 07:29:59 -0500
In-Reply-To: <1235046583-29696-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

pdata is only used during probe to initialize a few fields
from lm8323 device structure. Moving pdata pointer to probe
won't harm anybody.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/input/keyboard/lm8323.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 342ef6a..60abe61 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -186,9 +186,6 @@ static struct lm8323_chip *pwm_to_lm8323(struct lm8323_pwm *pwm)
 	}
 }
 
-static struct lm8323_platform_data *lm8323_pdata;
-
-
 #define LM8323_MAX_DATA 8
 
 /*
@@ -682,6 +679,7 @@ static DEVICE_ATTR(disable_kp, 0644, lm8323_show_disable, lm8323_set_disable);
 static int lm8323_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
+	struct lm8323_platform_data *pdata;
 	struct input_dev *idev;
 	struct lm8323_chip *lm;
 	int i, err = 0;
@@ -694,11 +692,11 @@ static int lm8323_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, lm);
 	lm->client = client;
-	lm8323_pdata = client->dev.platform_data;
-	if (!lm8323_pdata)
+	pdata = client->dev.platform_data;
+	if (!pdata)
 		return -EINVAL; /* ? */
 
-	lm->size_x = lm8323_pdata->size_x;
+	lm->size_x = pdata->size_x;
 	if (lm->size_x == 0) {
 		lm->size_x = 8;
 	} else if (lm->size_x > 8) {
@@ -707,7 +705,7 @@ static int lm8323_probe(struct i2c_client *client,
 		lm->size_x = 8;
 	}
 
-	lm->size_y = lm8323_pdata->size_y;
+	lm->size_y = pdata->size_y;
 	if (lm->size_y == 0) {
 		lm->size_y = 12;
 	} else if (lm->size_y > 12) {
@@ -718,13 +716,13 @@ static int lm8323_probe(struct i2c_client *client,
 
 	debug(&c->dev, "Keypad size: %d x %d\n", lm->size_x, lm->size_y);
 
-	lm->debounce_time = lm8323_pdata->debounce_time;
+	lm->debounce_time = pdata->debounce_time;
 	if (lm->debounce_time == 0) /* Default. */
 		lm->debounce_time = 12;
 	else if (lm->debounce_time == -1) /* Disable debounce. */
 		lm->debounce_time = 0;
 
-	lm->active_time = lm8323_pdata->active_time;
+	lm->active_time = pdata->active_time;
 	if (lm->active_time == 0) /* Default. */
 		lm->active_time = 500;
 	else if (lm->active_time == -1) /* Disable sleep. */
@@ -756,11 +754,11 @@ static int lm8323_probe(struct i2c_client *client,
 		goto fail2;
 	}
 
-	if (init_pwm(lm, 1, &client->dev, lm8323_pdata->pwm1_name) < 0)
+	if (init_pwm(lm, 1, &client->dev, pdata->pwm1_name) < 0)
 		goto fail3;
-	if (init_pwm(lm, 2, &client->dev, lm8323_pdata->pwm2_name) < 0)
+	if (init_pwm(lm, 2, &client->dev, pdata->pwm2_name) < 0)
 		goto fail4;
-	if (init_pwm(lm, 3, &client->dev, lm8323_pdata->pwm3_name) < 0)
+	if (init_pwm(lm, 3, &client->dev, pdata->pwm3_name) < 0)
 		goto fail5;
 
 	mutex_init(&lm->lock);
@@ -787,8 +785,8 @@ static int lm8323_probe(struct i2c_client *client,
 		goto fail8;
 	}
 
-	if (lm8323_pdata->name)
-		idev->name = lm8323_pdata->name;
+	if (pdata->name)
+		idev->name = pdata->name;
 	else
 		idev->name = "LM8323 keypad";
 	snprintf(lm->phys, sizeof(lm->phys), "%s/input-kp", client->dev.bus_id);
@@ -797,13 +795,13 @@ static int lm8323_probe(struct i2c_client *client,
 	lm->keys_down = 0;
 	idev->evbit[0] = BIT(EV_KEY);
 	for (i = 0; i < LM8323_KEYMAP_SIZE; i++) {
-		if (lm8323_pdata->keymap[i] > 0)
-			set_bit(lm8323_pdata->keymap[i], idev->keybit);
+		if (pdata->keymap[i] > 0)
+			set_bit(pdata->keymap[i], idev->keybit);
 
-		lm->keymap[i] = lm8323_pdata->keymap[i];
+		lm->keymap[i] = pdata->keymap[i];
 	}
 
-	if (lm8323_pdata->repeat)
+	if (pdata->repeat)
 		set_bit(EV_REP, idev->evbit);
 
 	lm->idev = idev;
-- 
1.6.1.3

