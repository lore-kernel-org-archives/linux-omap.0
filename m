From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 16/32] usb: gadget: m66592-udc: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:45:54 +0200
Message-ID: <1359042370-4358-17-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, leoli@freescale.com, eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, ben-linux@fluff.org, kgene.kim@samsung.com, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/m66592-udc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/m66592-udc.c b/drivers/usb/gadget/m66592-udc.c
index 0a35db1..c5d1b39 100644
--- a/drivers/usb/gadget/m66592-udc.c
+++ b/drivers/usb/gadget/m66592-udc.c
@@ -1538,7 +1538,6 @@ static int __exit m66592_remove(struct platform_device *pdev)
 	struct m66592		*m66592 = dev_get_drvdata(&pdev->dev);
 
 	usb_del_gadget_udc(&m66592->gadget);
-	device_del(&m66592->gadget.dev);
 
 	del_timer_sync(&m66592->timer);
 	iounmap(m66592->reg);
@@ -1608,13 +1607,12 @@ static int __init m66592_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, m66592);
 
 	m66592->gadget.ops = &m66592_gadget_ops;
-	device_initialize(&m66592->gadget.dev);
-	dev_set_name(&m66592->gadget.dev, "gadget");
 	m66592->gadget.max_speed = USB_SPEED_HIGH;
 	m66592->gadget.dev.parent = &pdev->dev;
 	m66592->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	m66592->gadget.dev.release = pdev->dev.release;
 	m66592->gadget.name = udc_name;
+	m66592->gadget.register_my_device = true;
 
 	init_timer(&m66592->timer);
 	m66592->timer.function = m66592_timer;
@@ -1674,12 +1672,6 @@ static int __init m66592_probe(struct platform_device *pdev)
 
 	init_controller(m66592);
 
-	ret = device_add(&m66592->gadget.dev);
-	if (ret) {
-		pr_err("device_add error (%d)\n", ret);
-		goto err_device_add;
-	}
-
 	ret = usb_add_gadget_udc(&pdev->dev, &m66592->gadget);
 	if (ret)
 		goto err_add_udc;
@@ -1688,9 +1680,6 @@ static int __init m66592_probe(struct platform_device *pdev)
 	return 0;
 
 err_add_udc:
-	device_del(&m66592->gadget.dev);
-
-err_device_add:
 	m66592_free_request(&m66592->ep[0].ep, m66592->ep0_req);
 
 clean_up3:
-- 
1.8.1.rc1.5.g7e0651a
