From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 14/27] cbus: tahvo: usb: fix up to use threaded irqs
Date: Thu, 13 Oct 2011 11:34:49 +0300
Message-ID: <1318494902-13093-14-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36416 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753918Ab1JMIff (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:35 -0400
Received: by mail-bw0-f47.google.com with SMTP id t8so319428bka.20
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:34 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

fix up tahvo-usb to use threaded irqs and the
new IRQ chip.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo-usb.c |   35 +++++++++++++----------------------
 1 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index be0333f..10619a8 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -93,12 +93,13 @@ struct tahvo_usb {
 	struct platform_device *pt_dev;
 	struct otg_transceiver otg;
 	int vbus_state;
-	struct work_struct irq_work;
 	struct mutex serialize;
 #ifdef CONFIG_USB_OTG
 	int tahvo_mode;
 #endif
 	struct clk *ick;
+
+	int		irq;
 };
 static struct tahvo_usb *tahvo_usb_device;
 
@@ -523,23 +524,13 @@ static int tahvo_usb_set_peripheral(struct otg_transceiver *otg, struct usb_gadg
 	return 0;
 }
 
-static void tahvo_usb_irq_work(struct work_struct *work)
+static irqreturn_t tahvo_usb_vbus_interrupt(int irq, void *_tu)
 {
-	struct tahvo_usb *tu = container_of(work, struct tahvo_usb, irq_work);
+	struct tahvo_usb *tu = _tu;
 
-	mutex_lock(&tu->serialize);
 	check_vbus_state(tu);
-	mutex_unlock(&tu->serialize);
-}
 
-static void tahvo_usb_vbus_interrupt(unsigned long arg)
-{
-	struct tahvo_usb *tu = (struct tahvo_usb *) arg;
-
-	tahvo_ack_irq(TAHVO_INT_VBUSON);
-	/* Seems we need this to acknowledge the interrupt */
-	tahvo_read_reg(TAHVO_REG_IDSR);
-	schedule_work(&tu->irq_work);
+	return IRQ_HANDLED;
 }
 
 #ifdef CONFIG_USB_OTG
@@ -602,6 +593,7 @@ static int __init tahvo_usb_probe(struct platform_device *pdev)
 	struct tahvo_usb *tu;
 	struct device *dev = &pdev->dev;
 	int ret;
+	int irq;
 
 	ret = tahvo_get_status();
 	if (!ret)
@@ -625,7 +617,6 @@ static int __init tahvo_usb_probe(struct platform_device *pdev)
 #endif
 #endif
 
-	INIT_WORK(&tu->irq_work, tahvo_usb_irq_work);
 	mutex_init(&tu->serialize);
 
 	tu->ick = clk_get(NULL, "usb_l4_ick");
@@ -640,9 +631,12 @@ static int __init tahvo_usb_probe(struct platform_device *pdev)
 	 * state changes */
 	tu->vbus_state = tahvo_read_reg(TAHVO_REG_IDSR) & 0x01;
 
+	irq = platform_get_irq(pdev, 0);
+	tu->irq = irq;
+
 	/* We cannot enable interrupt until omap_udc is initialized */
-	ret = tahvo_request_irq(TAHVO_INT_VBUSON, tahvo_usb_vbus_interrupt,
-				(unsigned long) tu, "vbus_interrupt");
+	ret = request_threaded_irq(irq, NULL, tahvo_usb_vbus_interrupt,
+			IRQF_ONESHOT, "tahvo-vbus", tu);
 	if (ret != 0) {
 		printk(KERN_ERR "Could not register Tahvo interrupt for VBUS\n");
 		goto err_release_clk;
@@ -675,13 +669,10 @@ static int __init tahvo_usb_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, tu);
 
-	/* Act upon current vbus state once at startup. A vbus state irq may or
-	 * may not be generated in addition to this. */
-	schedule_work(&tu->irq_work);
 	return 0;
 
 err_free_irq:
-	tahvo_free_irq(TAHVO_INT_VBUSON);
+	free_irq(tu->irq, tu);
 err_release_clk:
 	clk_disable(tu->ick);
 	clk_put(tu->ick);
@@ -698,7 +689,7 @@ static int __exit tahvo_usb_remove(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "remove\n");
 
-	tahvo_free_irq(TAHVO_INT_VBUSON);
+	free_irq(tu->irq, tu);
 	flush_scheduled_work();
 	otg_set_transceiver(0);
 	device_remove_file(&pdev->dev, &dev_attr_vbus_state);
-- 
1.7.6.396.ge0613

