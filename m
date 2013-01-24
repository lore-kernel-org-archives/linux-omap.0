From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 09/32] usb: gadget: dummy_hcd: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:45:47 +0200
Message-ID: <1359042370-4358-10-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37608 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab3AXPrV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 10:47:21 -0500
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, leoli@freescale.com, eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, ben-linux@fluff.org, kgene.kim@samsung.com, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/dummy_hcd.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
index 95d584d..8155d4a 100644
--- a/drivers/usb/gadget/dummy_hcd.c
+++ b/drivers/usb/gadget/dummy_hcd.c
@@ -982,16 +982,10 @@ static int dummy_udc_probe(struct platform_device *pdev)
 	dum->gadget.name = gadget_name;
 	dum->gadget.ops = &dummy_ops;
 	dum->gadget.max_speed = USB_SPEED_SUPER;
+	dum->gadget.register_my_device = true;
 
-	dev_set_name(&dum->gadget.dev, "gadget");
 	dum->gadget.dev.parent = &pdev->dev;
 	dum->gadget.dev.release = dummy_gadget_release;
-	rc = device_register(&dum->gadget.dev);
-	if (rc < 0) {
-		put_device(&dum->gadget.dev);
-		return rc;
-	}
-
 	init_dummy_udc_hw(dum);
 
 	rc = usb_add_gadget_udc(&pdev->dev, &dum->gadget);
@@ -1007,7 +1001,6 @@ static int dummy_udc_probe(struct platform_device *pdev)
 err_dev:
 	usb_del_gadget_udc(&dum->gadget);
 err_udc:
-	device_unregister(&dum->gadget.dev);
 	return rc;
 }
 
@@ -1018,7 +1011,6 @@ static int dummy_udc_remove(struct platform_device *pdev)
 	usb_del_gadget_udc(&dum->gadget);
 	platform_set_drvdata(pdev, NULL);
 	device_remove_file(&dum->gadget.dev, &dev_attr_function);
-	device_unregister(&dum->gadget.dev);
 	return 0;
 }
 
-- 
1.8.1.rc1.5.g7e0651a

