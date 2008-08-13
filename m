From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 3/3] input: add more error checks to lm8323 driver
Date: Wed, 13 Aug 2008 20:36:17 +0300
Message-ID: <1218648977-5685-4-git-send-email-felipe.balbi@nokia.com>
References: <1218648977-5685-1-git-send-email-felipe.balbi@nokia.com>
 <1218648977-5685-2-git-send-email-felipe.balbi@nokia.com>
 <1218648977-5685-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33728 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbYHMRgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 13:36:12 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7DHZt3u023783
	for <linux-omap@vger.kernel.org>; Wed, 13 Aug 2008 12:36:08 -0500
In-Reply-To: <1218648977-5685-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

If we can't reach the driver, we stop trying to probe
it. Useful when building kernel for n800 and n810.

n800 doesn't have lm8323, so that driver shouldn't probe
there.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/input/keyboard/lm8323.c |   42 +++++++++++++++++++++++++++++---------
 1 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 72bb587..3d10a0f 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -348,10 +348,10 @@ static void lm8323_process_error(struct lm8323_chip *lm)
 	}
 }
 
-static void lm8323_reset(struct lm8323_chip *lm)
+static int lm8323_reset(struct lm8323_chip *lm)
 {
 	/* The docs say we must pass 0xAA as the data byte. */
-	lm8323_write(lm, 2, LM8323_CMD_RESET, 0xAA);
+	return lm8323_write(lm, 2, LM8323_CMD_RESET, 0xAA);
 }
 
 static int lm8323_configure(struct lm8323_chip *lm)
@@ -360,6 +360,7 @@ static int lm8323_configure(struct lm8323_chip *lm)
 	int clock = (CLK_SLOWCLKEN | CLK_RCPWM_EXTERNAL);
 	int debounce = lm->debounce_time >> 2;
 	int active = lm->active_time >> 2;
+	int ret;
 
 	/*
 	 * Active time must be greater than the debounce time: if it's
@@ -368,13 +369,25 @@ static int lm8323_configure(struct lm8323_chip *lm)
 	if (debounce >= active)
 		active = debounce + 3;
 
-	lm8323_write(lm, 2, LM8323_CMD_WRITE_CFG, 0);
-	lm8323_write(lm, 2, LM8323_CMD_WRITE_CLOCK, clock);
-	lm8323_write(lm, 2, LM8323_CMD_SET_KEY_SIZE, keysize);
+	ret = lm8323_write(lm, 2, LM8323_CMD_WRITE_CFG, 0);
+	if (ret)
+		goto err;
+	ret = lm8323_write(lm, 2, LM8323_CMD_WRITE_CLOCK, clock);
+	if (ret)
+		goto err;
+	ret = lm8323_write(lm, 2, LM8323_CMD_SET_KEY_SIZE, keysize);
+	if (ret)
+		goto err;
 	lm8323_set_active_time(lm, lm->active_time);
-	lm8323_write(lm, 2, LM8323_CMD_SET_DEBOUNCE, debounce);
-	lm8323_write(lm, 3, LM8323_CMD_WRITE_PORT_STATE, 0xff, 0xff);
-	lm8323_write(lm, 3, LM8323_CMD_WRITE_PORT_SEL, 0, 0);
+	ret = lm8323_write(lm, 2, LM8323_CMD_SET_DEBOUNCE, debounce);
+	if (ret)
+		goto err;
+	ret = lm8323_write(lm, 3, LM8323_CMD_WRITE_PORT_STATE, 0xff, 0xff);
+	if (ret)
+		goto err;
+	ret = lm8323_write(lm, 3, LM8323_CMD_WRITE_PORT_SEL, 0, 0);
+	if (ret)
+		goto err;
 
 	/*
 	 * Not much we can do about errors at this point, so just hope
@@ -382,6 +395,11 @@ static int lm8323_configure(struct lm8323_chip *lm)
 	 */
 
 	return 0;
+
+err:
+	dev_err(&lm->client->dev, "failed to configure lm8323\n");
+
+	return ret;
 }
 
 /*
@@ -721,7 +739,9 @@ static int lm8323_probe(struct i2c_client *client,
 	else if (lm->active_time == -1) /* Disable sleep. */
 		lm->active_time = 0;
 
-	lm8323_reset(lm);
+	err = lm8323_reset(lm);
+	if (err)
+		goto fail2;
 
 	/* Nothing's set up to service the IRQ yet, so just spin for max.
 	 * 100ms until we can configure. */
@@ -738,7 +758,9 @@ static int lm8323_probe(struct i2c_client *client,
 
 		msleep(1);
 	}
-	lm8323_configure(lm);
+	err = lm8323_configure(lm);
+	if (err)
+		goto fail2;
 
 	/* If a true probe check the device */
 	if (lm8323_read_id(lm, data) != 0) {
-- 
1.6.0.rc1.71.gfba5

