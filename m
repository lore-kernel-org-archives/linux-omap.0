From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 05/22] cbus: tahvo: drop the tasklet
Date: Mon, 11 Jul 2011 14:17:18 +0300
Message-ID: <1310383055-20211-6-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51659 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754788Ab1GKLSK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:18:10 -0400
Received: by mail-yi0-f46.google.com with SMTP id 27so1882406yia.33
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:18:09 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

by moving to threaded IRQ.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 0e28208..4b062de 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -43,7 +43,6 @@
 static int tahvo_initialized;
 static int tahvo_is_betty;
 
-static struct tasklet_struct tahvo_tasklet;
 static struct mutex tahvo_lock;
 
 static struct device *the_dev;
@@ -174,12 +173,6 @@ EXPORT_SYMBOL(tahvo_set_backlight_level);
 
 static irqreturn_t tahvo_irq_handler(int irq, void *dev_id)
 {
-	tasklet_schedule(&tahvo_tasklet);
-	return IRQ_HANDLED;
-}
-
-static void tahvo_tasklet_handler(unsigned long data)
-{
 	struct tahvo_irq_handler_desc *hnd;
 	u16 id;
 	u16 im;
@@ -212,6 +205,8 @@ static void tahvo_tasklet_handler(unsigned long data)
 			 */
 		}
 	}
+
+	return IRQ_HANDLED;
 }
 
 /*
@@ -276,9 +271,6 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 	mutex_init(&tahvo_lock);
 	the_dev = &pdev->dev;
 
-	/* Prepare tasklet */
-	tasklet_init(&tahvo_tasklet, tahvo_tasklet_handler, 0);
-
 	tahvo_initialized = 1;
 
 	rev = tahvo_read_reg(TAHVO_REG_ASICR);
@@ -308,7 +300,8 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 	/* Mask all TAHVO interrupts */
 	tahvo_write_reg(TAHVO_REG_IMR, 0xffff);
 
-	ret = request_irq(irq, tahvo_irq_handler, IRQF_TRIGGER_RISING,
+	ret = request_threaded_irq(irq, NULL, tahvo_irq_handler,
+			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 			"tahvo", 0);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
@@ -326,7 +319,6 @@ static int __devexit tahvo_remove(struct platform_device *pdev)
 	/* Mask all TAHVO interrupts */
 	tahvo_write_reg(TAHVO_REG_IMR, 0xffff);
 	free_irq(irq, 0);
-	tasklet_kill(&tahvo_tasklet);
 	the_dev = NULL;
 
 	return 0;
-- 
1.7.6

