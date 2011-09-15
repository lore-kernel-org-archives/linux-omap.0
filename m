From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 6/6] twl6030: set charger current to be used by battery charging module
Date: Thu, 15 Sep 2011 19:50:03 +0530
Message-ID: <1316096403-6013-7-git-send-email-kishon@ti.com>
References: <1316096403-6013-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316096403-6013-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org
Cc: p-basak2-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, x0153364-l0cyMroinI0@public.gmane.org, m-sonasath-l0cyMroinI0@public.gmane.org, vishp-l0cyMroinI0@public.gmane.org, hemahk-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>

Set the current supplied by dedicated charging port to 1800mV(according to
battery charging specification). Also added a callback function for set_power
to dynamically set the current to be supplied based on the state of the system.

Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/twl6030-usb.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/otg/twl6030-usb.c
index 6cb28ea..1f22c10 100644
--- a/drivers/usb/otg/twl6030-usb.c
+++ b/drivers/usb/otg/twl6030-usb.c
@@ -102,6 +102,7 @@ struct twl6030_usb {
 
 	int			irq1;
 	int			irq2;
+	unsigned int		usb_cinlimit_mA;
 	u8			linkstat;
 	u8			asleep;
 	u8			prev_vbus;
@@ -305,6 +306,7 @@ static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 			regulator_disable(twl->usb3v3);
 			status = USB_EVENT_CHARGER;
 			twl->xceiv.last_event = status;
+			twl->usb_cinlimit_mA = 1800;
 		} else {
 			regulator_disable(twl->usb3v3);
 			goto vbus_notify;
@@ -435,6 +437,16 @@ static int twl6030_set_host(struct usb_otg *otg, struct usb_bus *host)
 	return 0;
 }
 
+static int twl6030_set_power(struct usb_phy *x, unsigned int mA)
+{
+	struct twl6030_usb *twl = xceiv_to_twl(x);
+
+	twl->usb_cinlimit_mA = mA;
+	atomic_notifier_call_chain(&twl->xceiv.notifier, USB_EVENT_ENUMERATED,
+				&twl->usb_cinlimit_mA);
+	return 0;
+}
+
 static int __devinit twl6030_usb_probe(struct platform_device *pdev)
 {
 	struct twl6030_usb	*twl;
@@ -463,6 +475,7 @@ static int __devinit twl6030_usb_probe(struct platform_device *pdev)
 	twl->xceiv.label	= "twl6030";
 	twl->xceiv.otg		= otg;
 	twl->xceiv.init		= twl6030_phy_init;
+	twl->xceiv.set_power	= twl6030_set_power;
 	twl->xceiv.shutdown	= twl6030_phy_shutdown;
 	twl->xceiv.set_suspend	= twl6030_phy_suspend;
 
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
