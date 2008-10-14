From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 1/7] input: lm8323: get rid of global pdata pointer
Date: Wed, 15 Oct 2008 00:39:51 +0300
Message-ID: <1224020397-2842-2-git-send-email-me@felipebalbi.com>
References: <1224020397-2842-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47933 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbYJNVkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 17:40:20 -0400
In-Reply-To: <1224020397-2842-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

pdata is only used during probe to initialize a few fields
from lm8323 device structure. Moving pdata pointer to probe
won't harm anybody.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/input/keyboard/lm8323.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 72bb587..b6f464c 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -184,9 +184,6 @@ static struct lm8323_chip *pwm_to_lm8323(struct lm8323_pwm *pwm)
 	}
 }
 
-static struct lm8323_platform_data *lm8323_pdata;
-
-
 #define LM8323_MAX_DATA 8
 
 /*
@@ -673,6 +670,7 @@ static DEVICE_ATTR(disable_kp, 0644, lm8323_show_disable, lm8323_set_disable);
 static int lm8323_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
+	struct lm8323_platform_data *lm8323_pdata;
 	struct input_dev *idev;
 	struct lm8323_chip *lm;
 	int i, err = 0;
-- 
1.6.0.2.307.gc427

