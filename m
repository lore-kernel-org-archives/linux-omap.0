From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 02/22] cbus: tahvo: move to __devinit/__devexit sections
Date: Mon, 11 Jul 2011 14:17:15 +0300
Message-ID: <1310383055-20211-3-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:37114 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752716Ab1GKLRz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:17:55 -0400
Received: by mail-gx0-f179.google.com with SMTP id 1so1540307gxk.38
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:17:54 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

while at that, also remove a few annoying and pretty
much useless comments.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   36 +++---------------------------------
 1 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index bc3ca6d..0da156e 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -108,9 +108,6 @@ void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 	mutex_unlock(&tahvo_lock);
 }
 
-/*
- * Disable given TAHVO interrupt
- */
 void tahvo_disable_irq(int id)
 {
 	u16 mask;
@@ -123,9 +120,6 @@ void tahvo_disable_irq(int id)
 }
 EXPORT_SYMBOL(tahvo_disable_irq);
 
-/*
- * Enable given TAHVO interrupt
- */
 void tahvo_enable_irq(int id)
 {
 	u16 mask;
@@ -138,9 +132,6 @@ void tahvo_enable_irq(int id)
 }
 EXPORT_SYMBOL(tahvo_enable_irq);
 
-/*
- * Acknowledge given TAHVO interrupt
- */
 void tahvo_ack_irq(int id)
 {
 	tahvo_write_reg(TAHVO_REG_IDR, 1 << id);
@@ -181,18 +172,12 @@ void tahvo_set_backlight_level(int level)
 }
 EXPORT_SYMBOL(tahvo_set_backlight_level);
 
-/*
- * TAHVO interrupt handler. Only schedules the tasklet.
- */
 static irqreturn_t tahvo_irq_handler(int irq, void *dev_id)
 {
 	tasklet_schedule(&tahvo_tasklet);
 	return IRQ_HANDLED;
 }
 
-/*
- * Tasklet handler
- */
 static void tahvo_tasklet_handler(unsigned long data)
 {
 	struct tahvo_irq_handler_desc *hnd;
@@ -283,14 +268,7 @@ void tahvo_free_irq(int id)
 }
 EXPORT_SYMBOL(tahvo_free_irq);
 
-/**
- * tahvo_probe - Probe for Tahvo ASIC
- * @dev: the Tahvo device
- *
- * Probe for the Tahvo ASIC and allocate memory
- * for its device-struct if found
- */
-static int __init tahvo_probe(struct platform_device *pdev)
+static int __devinit tahvo_probe(struct platform_device *pdev)
 {
 	int rev, id, ret;
 	int irq;
@@ -334,7 +312,7 @@ static int __init tahvo_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __exit tahvo_remove(struct platform_device *pdev)
+static int __devexit tahvo_remove(struct platform_device *pdev)
 {
 	int irq;
 
@@ -350,25 +328,17 @@ static int __exit tahvo_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver tahvo_driver = {
-	.remove		= __exit_p(tahvo_remove),
+	.remove		= __devexit_p(tahvo_remove),
 	.driver		= {
 		.name	= "tahvo",
 	},
 };
 
-/**
- * tahvo_init - initialise Tahvo driver
- *
- * Initialise the Tahvo driver and return 0 if everything worked ok
- */
 static int __init tahvo_init(void)
 {
 	return platform_driver_probe(&tahvo_driver, tahvo_probe);
 }
 
-/*
- * Cleanup
- */
 static void __exit tahvo_exit(void)
 {
 	platform_driver_unregister(&tahvo_driver);
-- 
1.7.6

