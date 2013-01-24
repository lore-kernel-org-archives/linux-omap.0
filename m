From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 05/32] usb: gadget: amd5536udc: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:45:43 +0200
Message-ID: <1359042370-4358-6-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43815 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754050Ab3AXPrP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 10:47:15 -0500
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, leoli@freescale.com, eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, ben-linux@fluff.org, kgene.kim@samsung.com, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>

By simply setting a flag, we drop some boilerplate
code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/amd5536udc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/amd5536udc.c b/drivers/usb/gadget/amd5536udc.c
index 3dac001..1827d4c 100644
--- a/drivers/usb/gadget/amd5536udc.c
+++ b/drivers/usb/gadget/amd5536udc.c
@@ -3080,7 +3080,6 @@ static void udc_pci_remove(struct pci_dev *pdev)
 	if (dev->active)
 		pci_disable_device(pdev);
 
-	device_unregister(&dev->gadget.dev);
 	pci_set_drvdata(pdev, NULL);
 
 	udc_remove(dev);
@@ -3276,6 +3275,7 @@ static int udc_probe(struct udc *dev)
 	dev->gadget.dev.release = gadget_release;
 	dev->gadget.name = name;
 	dev->gadget.max_speed = USB_SPEED_HIGH;
+	dev->gadget.register_my_device = true;
 
 	/* init registers, interrupts, ... */
 	startup_registers(dev);
@@ -3301,13 +3301,6 @@ static int udc_probe(struct udc *dev)
 	if (retval)
 		goto finished;
 
-	retval = device_register(&dev->gadget.dev);
-	if (retval) {
-		usb_del_gadget_udc(&dev->gadget);
-		put_device(&dev->gadget.dev);
-		goto finished;
-	}
-
 	/* timer init */
 	init_timer(&udc_timer);
 	udc_timer.function = udc_timer_function;
-- 
1.8.1.rc1.5.g7e0651a

