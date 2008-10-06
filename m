From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/3] i2c: lp5521: remove dead code
Date: Mon,  6 Oct 2008 12:11:29 +0300
Message-ID: <1223284291-7675-2-git-send-email-felipe.balbi@nokia.com>
References: <1223284291-7675-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42054 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbYJFJMH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 05:12:07 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m969BxGA032311
	for <linux-omap@vger.kernel.org>; Mon, 6 Oct 2008 12:12:05 +0300
In-Reply-To: <1223284291-7675-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

That LED_CONNECTED_WRONG was never defined so removing.
If someone needs those hooks, add back via proper
platform_data instead of nasty ifdefery.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/lp5521.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/chips/lp5521.c b/drivers/i2c/chips/lp5521.c
index c0862d9..7fb8091 100644
--- a/drivers/i2c/chips/lp5521.c
+++ b/drivers/i2c/chips/lp5521.c
@@ -28,13 +28,8 @@
 
 #define LP5521_DRIVER_NAME		"lp5521"
 
-#ifdef LED_CONNECTED_WRONG
-#define LP5521_REG_R_PWM		0x04
-#define LP5521_REG_B_PWM		0x02
-#else
 #define LP5521_REG_R_PWM		0x02
 #define LP5521_REG_B_PWM		0x04
-#endif
 #define LP5521_REG_ENABLE		0x00
 #define LP5521_REG_OP_MODE		0x01
 #define LP5521_REG_G_PWM		0x03
@@ -200,22 +195,12 @@ static ssize_t show_active_channels(struct device *dev,
 	char channels[4];
 	int pos = 0;
 
-#ifdef LED_CONNECTED_WRONG
-	if (chip->blue)
-		pos += sprintf(channels + pos, "r");
-	if (chip->green)
-		pos += sprintf(channels + pos, "g");
-	if (chip->red)
-		pos += sprintf(channels + pos, "b");
-
-#else
 	if (chip->red)
 		pos += sprintf(channels + pos, "r");
 	if (chip->green)
 		pos += sprintf(channels + pos, "g");
 	if (chip->blue)
 		pos += sprintf(channels + pos, "b");
-#endif
 
 	channels[pos] = '\0';
 
@@ -232,17 +217,10 @@ static ssize_t store_active_channels(struct device *dev,
 	chip->green = 0;
 	chip->blue = 0;
 
-#ifdef LED_CONNECTED_WRONG
-	if (strchr(buf, 'r') != NULL)
-		chip->blue = 1;
-	if (strchr(buf, 'b') != NULL)
-		chip->red = 1;
-#else
 	if (strchr(buf, 'r') != NULL)
 		chip->red = 1;
 	if (strchr(buf, 'b') != NULL)
 		chip->blue = 1;
-#endif
 	if (strchr(buf, 'g') != NULL)
 		chip->green = 1;
 
-- 
1.6.0.2.307.gc427

