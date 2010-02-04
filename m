From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 2/3] twl4030: keypad: Hooks for board specific suspend-resume
Date: Thu,  4 Feb 2010 21:36:49 +0530
Message-ID: <1265299609-30087-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33754 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758122Ab0BDQGx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 11:06:53 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o14G6oaq023659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 4 Feb 2010 10:06:52 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds hooks to support board specific
implementation during the suspend and resume operations.

The TWL4030 can be connected to multiple boards. Without
these hooks, board specific macros will be required in a
generic driver.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 drivers/input/keyboard/twl4030_keypad.c |   10 ++++++++++
 include/linux/i2c/twl.h                 |   12 ++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index af0651d..9950d7e 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -442,11 +442,21 @@ static int __devexit twl4030_kp_remove(struct platform_device *pdev)
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
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index bf1c5be..eefabf2 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -487,6 +487,18 @@ struct twl4030_keypad_data {
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

