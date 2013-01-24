From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 10/32] usb: gadget: fsl_qe_udc: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:45:48 +0200
Message-ID: <1359042370-4358-11-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/fsl_qe_udc.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index ec50f18..08c8432 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2523,13 +2523,9 @@ static int qe_udc_probe(struct platform_device *ofdev)
 
 	/* name: Identifies the controller hardware type. */
 	udc->gadget.name = driver_name;
-
-	device_initialize(&udc->gadget.dev);
-
-	dev_set_name(&udc->gadget.dev, "gadget");
-
 	udc->gadget.dev.release = qe_udc_release;
 	udc->gadget.dev.parent = &ofdev->dev;
+	udc->gadget.register_my_device = true;
 
 	/* initialize qe_ep struct */
 	for (i = 0; i < USB_MAX_ENDPOINTS ; i++) {
@@ -2592,13 +2588,9 @@ static int qe_udc_probe(struct platform_device *ofdev)
 		goto err5;
 	}
 
-	ret = device_add(&udc->gadget.dev);
-	if (ret)
-		goto err6;
-
 	ret = usb_add_gadget_udc(&ofdev->dev, &udc->gadget);
 	if (ret)
-		goto err7;
+		goto err6;
 
 	dev_set_drvdata(&ofdev->dev, udc);
 	dev_info(udc->dev,
@@ -2606,8 +2598,6 @@ static int qe_udc_probe(struct platform_device *ofdev)
 			(udc->soc_type == PORT_QE) ? "QE" : "CPM");
 	return 0;
 
-err7:
-	device_unregister(&udc->gadget.dev);
 err6:
 	free_irq(udc->usb_irq, udc);
 err5:
@@ -2702,7 +2692,6 @@ static int qe_udc_remove(struct platform_device *ofdev)
 
 	iounmap(udc->usb_regs);
 
-	device_unregister(&udc->gadget.dev);
 	/* wait for release() of gadget.dev to free udc */
 	wait_for_completion(&done);
 
-- 
1.8.1.rc1.5.g7e0651a

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
