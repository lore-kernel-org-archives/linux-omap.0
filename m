From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/4] OMAP3: PM: Add suspend-resume to TWL4030 keypad
Date: Mon,  9 Nov 2009 22:10:02 +0530
Message-ID: <1257784802-20050-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48489 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZKIQkA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 11:40:00 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA9Ge3Fa025142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 9 Nov 2009 10:40:05 -0600
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
index 9a2977c..01f2ddd 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -446,6 +446,22 @@ static int __devexit twl4030_kp_remove(struct platform_device *pdev)
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
@@ -455,6 +471,8 @@ static int __devexit twl4030_kp_remove(struct platform_device *pdev)
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

