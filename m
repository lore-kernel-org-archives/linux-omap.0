From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 08/32] usb: gadget: bcm63xx_udc: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:45:46 +0200
Message-ID: <1359042370-4358-9-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/bcm63xx_udc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63xx_udc.c
index 47a4993..10b0475 100644
--- a/drivers/usb/gadget/bcm63xx_udc.c
+++ b/drivers/usb/gadget/bcm63xx_udc.c
@@ -2367,13 +2367,13 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&udc->lock);
 	INIT_WORK(&udc->ep0_wq, bcm63xx_ep0_process);
-	dev_set_name(&udc->gadget.dev, "gadget");
 
 	udc->gadget.ops = &bcm63xx_udc_ops;
 	udc->gadget.name = dev_name(dev);
 	udc->gadget.dev.parent = dev;
 	udc->gadget.dev.release = bcm63xx_udc_gadget_release;
 	udc->gadget.dev.dma_mask = dev->dma_mask;
+	udc->gadget.register_my_device = true;
 
 	if (!pd->use_fullspeed && !use_fullspeed)
 		udc->gadget.max_speed = USB_SPEED_HIGH;
@@ -2413,10 +2413,6 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 		}
 	}
 
-	rc = device_register(&udc->gadget.dev);
-	if (rc)
-		goto out_uninit;
-
 	bcm63xx_udc_init_debugfs(udc);
 	rc = usb_add_gadget_udc(dev, &udc->gadget);
 	if (!rc)
@@ -2439,7 +2435,6 @@ static int bcm63xx_udc_remove(struct platform_device *pdev)
 
 	bcm63xx_udc_cleanup_debugfs(udc);
 	usb_del_gadget_udc(&udc->gadget);
-	device_unregister(&udc->gadget.dev);
 	BUG_ON(udc->driver);
 
 	platform_set_drvdata(pdev, NULL);
-- 
1.8.1.rc1.5.g7e0651a
