From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/3] twl4030: keypad: Add suspend-resume functions
Date: Thu,  4 Feb 2010 21:36:41 +0530
Message-ID: <1265299601-30045-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40716 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758122Ab0BDQGp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 11:06:45 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o14G6gap023473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 4 Feb 2010 10:06:44 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds suspend, resume functions to the
TWL4030 keypad driver when CONFIG_PM is selected.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 drivers/input/keyboard/twl4030_keypad.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 21d6184..af0651d 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -439,6 +439,22 @@ static int __devexit twl4030_kp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int twl4030_kp_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	return 0;
+}
+
+static int twl4030_kp_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+#else
+#define twl4030_kp_suspend	NULL
+#define twl4030_kp_resume	NULL
+#endif
+
+
 /*
  * NOTE: twl4030 are multi-function devices connected via I2C.
  * So this device is a child of an I2C parent, thus it needs to
@@ -448,6 +464,8 @@ static int __devexit twl4030_kp_remove(struct platform_device *pdev)
 static struct platform_driver twl4030_kp_driver = {
 	.probe		= twl4030_kp_probe,
 	.remove		= __devexit_p(twl4030_kp_remove),
+	.suspend        = twl4030_kp_suspend,
+	.resume         = twl4030_kp_resume,
 	.driver		= {
 		.name	= "twl4030_keypad",
 		.owner	= THIS_MODULE,
-- 
1.6.2.2

