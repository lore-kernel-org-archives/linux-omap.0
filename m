From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] usb: phy: fix twl4030 build regression
Date: Tue, 11 Nov 2014 10:36:09 +0100
Message-ID: <7831012.jlbEUURqIo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Recent changes to the common OTG handling broke building the twl4030
OTG driver as found during an allmodconfig build of linux-next:

drivers/phy/phy-twl4030-usb.c: In function 'twl4030_set_peripheral':
drivers/phy/phy-twl4030-usb.c:609:11: error: 'struct phy' has no member named 'state'
drivers/phy/phy-twl4030-usb.c: In function 'twl4030_usb_probe':
drivers/phy/phy-twl4030-usb.c:679:12: warning: assignment from incompatible pointer type

This applies the same changes that were done to the other phy drivers
to get it to build cleanly.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Fixes: 19c1eac2685b6 ("usb: rename phy to usb_phy in OTG")
Fixes: e47d92545c297 ("usb: move the OTG state from the USB PHY to the OTG structure")
---

I have no idea if this is the correct fix, this is just a mechanical
conversion, so please review carefully.

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 7b04befd5271..e2698d29f436 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -606,7 +606,7 @@ static int twl4030_set_peripheral(struct usb_otg *otg,
 
 	otg->gadget = gadget;
 	if (!gadget)
-		otg->phy->state = OTG_STATE_UNDEFINED;
+		otg->state = OTG_STATE_UNDEFINED;
 
 	return 0;
 }
@@ -618,7 +618,7 @@ static int twl4030_set_host(struct usb_otg *otg, struct usb_bus *host)
 
 	otg->host = host;
 	if (!host)
-		otg->phy->state = OTG_STATE_UNDEFINED;
+		otg->state = OTG_STATE_UNDEFINED;
 
 	return 0;
 }
@@ -676,7 +676,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	twl->phy.otg		= otg;
 	twl->phy.type		= USB_PHY_TYPE_USB2;
 
-	otg->phy		= &twl->phy;
+	otg->usb_phy		= &twl->phy;
 	otg->set_host		= twl4030_set_host;
 	otg->set_peripheral	= twl4030_set_peripheral;
 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
