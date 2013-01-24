From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 20/32] usb: gadget: net2272: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:45:58 +0200
Message-ID: <1359042370-4358-21-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/net2272.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/net2272.c b/drivers/usb/gadget/net2272.c
index d226058..635248f 100644
--- a/drivers/usb/gadget/net2272.c
+++ b/drivers/usb/gadget/net2272.c
@@ -2209,7 +2209,6 @@ net2272_remove(struct net2272 *dev)
 	free_irq(dev->irq, dev);
 	iounmap(dev->base_addr);
 
-	device_unregister(&dev->gadget.dev);
 	device_remove_file(dev->dev, &dev_attr_registers);
 
 	dev_info(dev->dev, "unbind\n");
@@ -2236,11 +2235,11 @@ static struct net2272 *net2272_probe_init(struct device *dev, unsigned int irq)
 	ret->gadget.max_speed = USB_SPEED_HIGH;
 
 	/* the "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&ret->gadget.dev, "gadget");
 	ret->gadget.dev.parent = dev;
 	ret->gadget.dev.dma_mask = dev->dma_mask;
 	ret->gadget.dev.release = net2272_gadget_release;
 	ret->gadget.name = driver_name;
+	ret->gadget.register_my_device = true;
 
 	return ret;
 }
@@ -2275,12 +2274,9 @@ net2272_probe_fin(struct net2272 *dev, unsigned int irqflags)
 		dma_mode_string());
 	dev_info(dev->dev, "version: %s\n", driver_vers);
 
-	ret = device_register(&dev->gadget.dev);
-	if (ret)
-		goto err_irq;
 	ret = device_create_file(dev->dev, &dev_attr_registers);
 	if (ret)
-		goto err_dev_reg;
+		goto err_irq;
 
 	ret = usb_add_gadget_udc(dev->dev, &dev->gadget);
 	if (ret)
@@ -2290,8 +2286,6 @@ net2272_probe_fin(struct net2272 *dev, unsigned int irqflags)
 
 err_add_udc:
 	device_remove_file(dev->dev, &dev_attr_registers);
- err_dev_reg:
-	device_unregister(&dev->gadget.dev);
  err_irq:
 	free_irq(dev->irq, dev);
  err:
-- 
1.8.1.rc1.5.g7e0651a

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
