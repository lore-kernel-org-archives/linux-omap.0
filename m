From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 27/32] usb: renesas_usbhs: gadget: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 17:46:05 +0200
Message-ID: <1359042370-4358-28-git-send-email-balbi@ti.com>
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
 drivers/usb/renesas_usbhs/mod_gadget.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index dd41f61..b42d81d 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -981,15 +981,12 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 	/*
 	 * init gadget
 	 */
-	dev_set_name(&gpriv->gadget.dev, "gadget");
 	gpriv->gadget.dev.parent	= dev;
 	gpriv->gadget.dev.release	= usbhs_mod_gadget_release;
 	gpriv->gadget.name		= "renesas_usbhs_udc";
 	gpriv->gadget.ops		= &usbhsg_gadget_ops;
 	gpriv->gadget.max_speed		= USB_SPEED_HIGH;
-	ret = device_register(&gpriv->gadget.dev);
-	if (ret < 0)
-		goto err_add_udc;
+	gpriv->gadget.register_my_device = true;
 
 	INIT_LIST_HEAD(&gpriv->gadget.ep_list);
 
@@ -1018,15 +1015,13 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 
 	ret = usb_add_gadget_udc(dev, &gpriv->gadget);
 	if (ret)
-		goto err_register;
+		goto err_add_udc;
 
 
 	dev_info(dev, "gadget probed\n");
 
 	return 0;
 
-err_register:
-	device_unregister(&gpriv->gadget.dev);
 err_add_udc:
 	kfree(gpriv->uep);
 
@@ -1042,8 +1037,6 @@ void usbhs_mod_gadget_remove(struct usbhs_priv *priv)
 
 	usb_del_gadget_udc(&gpriv->gadget);
 
-	device_unregister(&gpriv->gadget.dev);
