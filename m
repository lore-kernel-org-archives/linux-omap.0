From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] I2C: i2c subsystem should print error messages
Date: Thu, 17 Apr 2008 15:29:01 +0300
Message-ID: <1208435341-14830-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28742 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763729AbYDQMas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 08:30:48 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3HCUOeL031192
	for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 15:30:45 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

We don't have to print any error message if i2c_add_driver
fails since i2c subsystem already does it.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/isp1301_omap.c |   10 +---------
 drivers/i2c/chips/menelaus.c     |   10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index 6ebff9c..09f9662 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -1606,15 +1606,7 @@ static struct i2c_driver isp1301_driver = {
 
 static int __init isp_init(void)
 {
-	int	status = -ENODEV;
-
-	printk(KERN_INFO "%s: version %s\n", DRIVER_NAME, DRIVER_VERSION);
-
-	status = i2c_add_driver(&isp1301_driver);
-	if (status)
-		printk(KERN_ERR "%s failed to probe\n", DRIVER_NAME);
-
-	return status;
+	return i2c_add_driver(&isp1301_driver);
 }
 module_init(isp_init);
 
diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
index 1d7482a..d4d1ccc 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -1281,15 +1281,7 @@ static struct i2c_driver menelaus_i2c_driver = {
 
 static int __init menelaus_init(void)
 {
-	int res;
-
-	res = i2c_add_driver(&menelaus_i2c_driver);
-	if (res < 0) {
-		dev_err(&the_menelaus->client->dev, "driver registration failed\n");
-		return res;
-	}
-
-	return 0;
+	return i2c_add_driver(&menelaus_i2c_driver);
 }
 
 static void __exit menelaus_exit(void)
-- 
1.5.5.49.gf43e2

