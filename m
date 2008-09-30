From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 17/23] i2c: minor cleanups to twl4030-pwrbutton.c
Date: Tue, 30 Sep 2008 13:05:54 +0300
Message-ID: <1222769160-31615-18-git-send-email-felipe.balbi@nokia.com>
References: <1222769160-31615-1-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-2-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-3-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-4-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-5-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-6-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-7-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-8-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-9-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-10-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-11-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-12-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-13-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-14-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-15-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-16-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-17-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34599 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbYI3KHA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 06:07:00 -0400
In-Reply-To: <1222769160-31615-17-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

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

