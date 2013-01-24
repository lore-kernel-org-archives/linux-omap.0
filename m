From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 19/32] usb: gadget: mv_udc_core: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:45:57 +0200
Message-ID: <1359042370-4358-20-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359042370-4358-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dahlmann.thomas-KvP5wT2u2U0@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-geode-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/gadget/mv_udc_core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index 67d72f9..60741af 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -2138,8 +2138,6 @@ static int mv_udc_remove(struct platform_device *pdev)
 
 	mv_udc_disable(udc);
 
-	device_unregister(&udc->gadget.dev);
-
 	/* free dev, wait for the release() finished */
 	wait_for_completion(udc->done);
 
@@ -2311,15 +2309,11 @@ static int mv_udc_probe(struct platform_device *pdev)
 	udc->gadget.max_speed = USB_SPEED_HIGH;	/* support dual speed */
 
 	/* the "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&udc->gadget.dev, "gadget");
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	udc->gadget.dev.release = gadget_release;
 	udc->gadget.name = driver_name;		/* gadget name */
-
-	retval = device_register(&udc->gadget.dev);
-	if (retval)
-		goto err_destroy_dma;
+	udc->gadget.register_my_device = true;
 
 	eps_init(udc);
 
@@ -2342,7 +2336,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 		if (!udc->qwork) {
 			dev_err(&pdev->dev, "cannot create workqueue\n");
 			retval = -ENOMEM;
-			goto err_unregister;
+			goto err_destroy_dma;
 		}
 
 		INIT_WORK(&udc->vbus_work, mv_udc_vbus_work);
@@ -2370,8 +2364,6 @@ static int mv_udc_probe(struct platform_device *pdev)
 
 err_create_workqueue:
 	destroy_workqueue(udc->qwork);
-err_unregister:
-	device_unregister(&udc->gadget.dev);
 err_destroy_dma:
 	dma_pool_destroy(udc->dtd_pool);
 err_free_dma:
-- 
1.8.1.rc1.5.g7e0651a

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
