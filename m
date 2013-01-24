From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 29/32] usb: gadget: pxa27x_udc: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:46:07 +0200
Message-ID: <1359042370-4358-30-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44863 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab3AXPrs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 10:47:48 -0500
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, leoli@freescale.com, eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, ben-linux@fluff.org, kgene.kim@samsung.com, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/pxa27x_udc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index f7d2579..23a3eed 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -1814,11 +1814,6 @@ static int pxa27x_udc_start(struct usb_gadget *g,
 	udc->gadget.dev.driver = &driver->driver;
 	dplus_pullup(udc, 1);
 
-	retval = device_add(&udc->gadget.dev);
-	if (retval) {
-		dev_err(udc->dev, "device_add error %d\n", retval);
-		goto fail;
-	}
 	if (!IS_ERR_OR_NULL(udc->transceiver)) {
 		retval = otg_set_peripheral(udc->transceiver->otg,
 						&udc->gadget);
@@ -1876,8 +1871,6 @@ static int pxa27x_udc_stop(struct usb_gadget *g,
 
 	udc->driver = NULL;
 
-	device_del(&udc->gadget.dev);
-
 	if (!IS_ERR_OR_NULL(udc->transceiver))
 		return otg_set_peripheral(udc->transceiver->otg, NULL);
 	return 0;
@@ -2462,9 +2455,9 @@ static int __init pxa_udc_probe(struct platform_device *pdev)
 		goto err_map;
 	}
 
-	device_initialize(&udc->gadget.dev);
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = NULL;
+	udc->gadget.register_my_device = true;
 	udc->vbus_sensed = 0;
 
 	the_controller = udc;
-- 
1.8.1.rc1.5.g7e0651a

