From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH] The fix prevents kernel crash caused by twl4030 power button malfunction.
Date: Tue, 17 Jun 2008 16:48:06 +0300
Message-ID: <1213710486-19986-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19339 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbYFQNtl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 09:49:41 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5HDbDsk032451
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 08:49:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>

If i2c connection is broken the twl4030 power button driver is unregistered.
The function input_free_device has to be called only when
input_register_device failed. Otherwise input_unregister_device is used.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 drivers/i2c/chips/twl4030-pwrbutton.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-pwrbutton.c b/drivers/i2c/chips/twl4030-pwrbutton.c
index cbc31aa..a8258df 100644
--- a/drivers/i2c/chips/twl4030-pwrbutton.c
+++ b/drivers/i2c/chips/twl4030-pwrbutton.c
@@ -95,8 +95,10 @@ static int __init twl4030_pwrbutton_init(void)
 	powerbutton_dev->name = "triton2-pwrbutton";
 
 	err = input_register_device(powerbutton_dev);
-	if (err)
-		goto free_input_dev;
+	if (err) {
+		input_free_device(powerbutton_dev);
+		goto free_irq_and_out;
+	}
 
 	err = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &value, PWR_IMR1);
 	if (err) {
@@ -122,7 +124,7 @@ static int __init twl4030_pwrbutton_init(void)
 	}
 
 	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
-				   value | PWR_PWRON_BOTH , PWR_EDR1);
+				   value | PWR_PWRON_BOTH, PWR_EDR1);
 
 	if (err) {
 		printk(KERN_WARNING "I2C error %d while writing TWL4030"
@@ -136,7 +138,7 @@ static int __init twl4030_pwrbutton_init(void)
 
 
 free_input_dev:
-	input_free_device(powerbutton_dev);
+	input_unregister_device(powerbutton_dev);
 free_irq_and_out:
 	free_irq(TWL4030_PWRIRQ_PWRBTN, NULL);
 out:
-- 
1.5.5.1

