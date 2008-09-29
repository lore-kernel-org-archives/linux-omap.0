From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 18/22] i2c: minor cleanups to twl4030-pwrbutton.c
Date: Mon, 29 Sep 2008 16:14:35 +0300
Message-ID: <1222694079-16289-19-git-send-email-felipe.balbi@nokia.com>
References: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-2-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-3-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-4-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-5-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-6-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-7-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-8-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-9-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-10-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-11-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-12-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-13-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-14-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-15-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-16-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-17-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-18-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52199 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbYI2NPR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:15:17 -0400
In-Reply-To: <1222694079-16289-18-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

Trivial brainless fixes, a few unused headers removed,
changed one printk to pr_err() and removed one comment.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-pwrbutton.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-pwrbutton.c b/drivers/i2c/chips/twl4030-pwrbutton.c
index d86d489..9a361b3 100644
--- a/drivers/i2c/chips/twl4030-pwrbutton.c
+++ b/drivers/i2c/chips/twl4030-pwrbutton.c
@@ -26,9 +26,6 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/input.h>
-#include <linux/timer.h>
-#include <linux/jiffies.h>
-#include <linux/kthread.h>
 #include <linux/interrupt.h>
 #include <linux/i2c/twl4030.h>
 
@@ -47,11 +44,6 @@
 
 static struct input_dev *powerbutton_dev;
 
-/*
- * Note : the following function runs in kernel thread context
- * with IRQs enabled
- */
-
 static irqreturn_t powerbutton_irq(int irq, void *dev_id)
 {
 	int err;
@@ -63,7 +55,7 @@ static irqreturn_t powerbutton_irq(int irq, void *dev_id)
 		input_report_key(powerbutton_dev, KEY_POWER,
 				 value & PWR_PWRON_IRQ);
 	} else {
-		printk(KERN_WARNING "I2C error %d while reading TWL4030"
+		pr_err("twl4030: i2c error %d while reading TWL4030"
 			" PM_MASTER STS_HW_CONDITIONS register\n", err);
 	}
 
-- 
1.6.0.2.307.gc427

