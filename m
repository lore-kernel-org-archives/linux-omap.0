From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 3/8] usb: otg: palmas-usb: remove compiler warning
Date: Fri, 25 Jan 2013 08:42:26 +0530
Message-ID: <1359083551-8524-4-git-send-email-kishon@ti.com>
References: <1359083551-8524-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35887 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754745Ab3AYDMw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 22:12:52 -0500
In-Reply-To: <1359083551-8524-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, rob@landley.net, balbi@ti.com, sameo@linux.intel.com, gg@slimlogic.co.uk, s-guiriec@ti.com, broonie@opensource.wolfsonmicro.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, gregkh@linuxfoundation.org, kishon@ti.com

commit 696c5c04 (USB: Palmas OTG Transceiver Driver) introduced empty
palmas_vbus_irq/palmas_id_irq with only *palmas_usb* declaration.
Removed these unnecessary functions.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/otg/palmas-usb.c |   38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/usb/otg/palmas-usb.c b/drivers/usb/otg/palmas-usb.c
index f063350..be9d81c 100644
--- a/drivers/usb/otg/palmas-usb.c
+++ b/drivers/usb/otg/palmas-usb.c
@@ -103,15 +103,6 @@ static ssize_t palmas_usb_vbus_show(struct device *dev,
 }
 static DEVICE_ATTR(vbus, 0444, palmas_usb_vbus_show, NULL);
 
-static irqreturn_t palmas_vbus_irq(int irq, void *_palmas_usb)
-{
-	struct palmas_usb *palmas_usb = _palmas_usb;
-
-	/* TODO: Do we need to do any work here? */
-
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t palmas_vbus_wakeup_irq(int irq, void *_palmas_usb)
 {
 	struct palmas_usb *palmas_usb = _palmas_usb;
@@ -138,15 +129,6 @@ static irqreturn_t palmas_vbus_wakeup_irq(int irq, void *_palmas_usb)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t palmas_id_irq(int irq, void *_palmas_usb)
-{
-	struct palmas_usb *palmas_usb = _palmas_usb;
-
-	/* TODO: Do we need to do any work here? */
-
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t palmas_id_wakeup_irq(int irq, void *_palmas_usb)
 {
 	int			status = 0;
@@ -329,16 +311,6 @@ static int palmas_usb_probe(struct platform_device *pdev)
 
 	INIT_WORK(&palmas_usb->set_vbus_work, palmas_set_vbus_work);
 
-	status = devm_request_threaded_irq(palmas_usb->dev, palmas_usb->irq1,
-				NULL, palmas_id_irq,
-				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-				"palmas_usb", palmas_usb);
-	if (status < 0) {
-		dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
-					palmas_usb->irq1, status);
-		goto fail_irq;
-	}
-
 	status = devm_request_threaded_irq(palmas_usb->dev, palmas_usb->irq2,
 			NULL, palmas_id_wakeup_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
@@ -349,16 +321,6 @@ static int palmas_usb_probe(struct platform_device *pdev)
 		goto fail_irq;
 	}
 
-	status = devm_request_threaded_irq(palmas_usb->dev, palmas_usb->irq3,
-			NULL, palmas_vbus_irq,
-			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-			"palmas_usb", palmas_usb);
-	if (status < 0) {
-		dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
-					palmas_usb->irq3, status);
-		goto fail_irq;
-	}
-
 	status = devm_request_threaded_irq(palmas_usb->dev, palmas_usb->irq4,
 			NULL, palmas_vbus_wakeup_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-- 
1.7.9.5

