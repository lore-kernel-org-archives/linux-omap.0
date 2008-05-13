From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 4/4] I2C: Get rid of warnings
Date: Tue, 13 May 2008 15:22:10 +0300
Message-ID: <1210681330-1442-5-git-send-email-felipe.balbi@nokia.com>
References: <1210681330-1442-1-git-send-email-felipe.balbi@nokia.com>
 <1210681330-1442-2-git-send-email-felipe.balbi@nokia.com>
 <1210681330-1442-3-git-send-email-felipe.balbi@nokia.com>
 <1210681330-1442-4-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52407 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbYEMMXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 08:23:25 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DCN7PK006748
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 15:23:23 +0300
In-Reply-To: <1210681330-1442-4-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Remove warnings from three i2c drivers.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/lp5521.c          |    2 +-
 drivers/i2c/chips/tsl2563.c         |    2 +-
 drivers/input/keyboard/lm8323.c     |    2 +-
 drivers/media/radio/radio-tea5761.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/chips/lp5521.c b/drivers/i2c/chips/lp5521.c
index 4d869f9..254d555 100644
--- a/drivers/i2c/chips/lp5521.c
+++ b/drivers/i2c/chips/lp5521.c
@@ -563,7 +563,7 @@ static struct i2c_driver lp5521_driver = {
 		.name	= LP5521_DRIVER_NAME,
 	},
 	.probe		= lp5521_probe,
-	.remove		= __exit_p(lp5521_remove),
+	.remove		= __devexit_p(lp5521_remove),
 };
 
 static int __init lp5521_init(void)
diff --git a/drivers/i2c/chips/tsl2563.c b/drivers/i2c/chips/tsl2563.c
index b39b65c..bc58106 100644
--- a/drivers/i2c/chips/tsl2563.c
+++ b/drivers/i2c/chips/tsl2563.c
@@ -717,7 +717,7 @@ static struct i2c_driver tsl2563_i2c_driver = {
 	.suspend	= tsl2563_suspend,
 	.resume		= tsl2563_resume,
 	.probe		= tsl2563_probe,
-	.remove		= __exit_p(tsl2563_remove),
+	.remove		= __devexit_p(tsl2563_remove),
 };
 
 static int __init tsl2563_init(void)
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index d345a3a..e793ae7 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -894,7 +894,7 @@ static struct i2c_driver lm8323_i2c_driver = {
 		.name	 = DRIVER_NAME,
 	},
 	.probe		= lm8323_probe,
-	.remove		= __exit_p(lm8323_remove),
+	.remove		= __devexit_p(lm8323_remove),
 	.suspend	= lm8323_suspend,
 	.resume		= lm8323_resume,
 	.id_table	= lm8323_id,
diff --git a/drivers/media/radio/radio-tea5761.c b/drivers/media/radio/radio-tea5761.c
index 8a0cf42..34fcd3a 100644
--- a/drivers/media/radio/radio-tea5761.c
+++ b/drivers/media/radio/radio-tea5761.c
@@ -484,7 +484,7 @@ static struct i2c_driver tea5761_driver = {
 		.name	= DRIVER_NAME,
 	},
 	.probe	= tea5761_i2c_driver_probe,
-	.remove = tea5761_i2c_driver_remove,
+	.remove = __devexit_p(tea5761_i2c_driver_remove),
 };
 
 static int __init tea5761_init(void)
-- 
1.5.5.1.125.gc697a

