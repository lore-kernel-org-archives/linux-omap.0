From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 2/4] OMAP3: PM: T2 keypad: Add board specific suspend-resume functions
Date: Mon,  9 Nov 2009 22:10:09 +0530
Message-ID: <1257784809-20353-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53253 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbZKIQkI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Nov 2009 11:40:08 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA9GeAxA032229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 9 Nov 2009 10:40:13 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds hooks to support board specific implementation
during the suspend and resume operations.

The TWL4030 can be connected to multiple boards. Without
these hooks, board specific macros will be required in a
generic driver.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 drivers/input/keyboard/twl4030_keypad.c |   10 ++++++++++
 include/linux/i2c/twl4030.h             |   12 ++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 01f2ddd..f58f3cf 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -449,11 +449,21 @@ static int __devexit twl4030_kp_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int twl4030_kp_suspend(struct platform_device *pdev, pm_message_t state)
 {
+	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
+
+	if (pdata->on_suspend)
+		pdata->on_suspend(pdata->pm_state);
+
 	return 0;
 }
 
 static int twl4030_kp_resume(struct platform_device *pdev)
 {
+	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
+
+	if (pdata->on_resume)
+		pdata->on_resume(pdata->pm_state);
+
 	return 0;
 }
 #else
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 508824e..dcd633a 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -360,6 +360,18 @@ struct twl4030_keypad_data {
 	unsigned rows;
 	unsigned cols;
 	bool rep;
+#ifdef CONFIG_PM
+	/*
+	 * Board specific information required during suspend, resume.
+	 * E.g. configuration as wake-up source.
+	 */
+	void *pm_state;
+	/*
+	 * Hooks for board specific execution during suspend, resume.
+	 */
+	void (*on_suspend)(void *pstate);
+	void (*on_resume)(void *pstate);
+#endif
 };
 
 enum twl4030_usb_mode {
-- 
1.6.2.2

