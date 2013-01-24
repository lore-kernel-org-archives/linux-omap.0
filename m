From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 11/32] usb: gadget: fsl_udc_core: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:45:49 +0200
Message-ID: <1359042370-4358-12-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/fsl_udc_core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 49642d4..b78b734 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2526,9 +2526,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	udc_controller->gadget.dev.release = fsl_udc_release;
 	udc_controller->gadget.dev.parent = &pdev->dev;
 	udc_controller->gadget.dev.of_node = pdev->dev.of_node;
-	ret = device_register(&udc_controller->gadget.dev);
-	if (ret < 0)
-		goto err_free_irq;
+	udc_controller->gadget.register_my_device = true;
 
 	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
 		udc_controller->gadget.is_otg = 1;
@@ -2561,7 +2559,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 			DTD_ALIGNMENT, UDC_DMA_BOUNDARY);
 	if (udc_controller->td_pool == NULL) {
 		ret = -ENOMEM;
-		goto err_unregister;
+		goto err_free_irq;
 	}
 
 	ret = usb_add_gadget_udc(&pdev->dev, &udc_controller->gadget);
@@ -2573,8 +2571,6 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 
 err_del_udc:
 	dma_pool_destroy(udc_controller->td_pool);
-err_unregister:
-	device_unregister(&udc_controller->gadget.dev);
 err_free_irq:
 	free_irq(udc_controller->irq, udc_controller);
 err_iounmap:
@@ -2624,7 +2620,6 @@ static int __exit fsl_udc_remove(struct platform_device *pdev)
 	if (pdata->operating_mode == FSL_USB2_DR_DEVICE)
 		release_mem_region(res->start, resource_size(res));
 
-	device_unregister(&udc_controller->gadget.dev);
 	/* free udc --wait for the release() finished */
 	wait_for_completion(&done);
 
-- 
1.8.1.rc1.5.g7e0651a

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
