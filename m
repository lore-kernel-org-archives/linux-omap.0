From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [5/7 v2] usb: otg: TWL6030: Introduce the twl6030_phy_suspend function.
Date: Tue, 15 Feb 2011 15:12:36 +0530
Message-ID: <1297762958-26199-5-git-send-email-hemahk@ti.com>
References: <1297762958-26199-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297762958-26199-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>

Introduce the twl6030_phy_suspend function and assign to otg.set_suspend
function pointer.
This function is used by the musb-omap2430 platform driver
during suspend/resume.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

---
drivers/usb/otg/twl6030-usb.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

Index: linux-2.6/drivers/usb/otg/twl6030-usb.c
===================================================================
--- linux-2.6.orig/drivers/usb/otg/twl6030-usb.c
+++ linux-2.6/drivers/usb/otg/twl6030-usb.c
@@ -177,6 +177,20 @@ static void twl6030_phy_shutdown(struct 
 	pdata->phy_power(twl->dev, 0, 0);
 }
 
+static int twl6030_phy_suspend(struct otg_transceiver *x, int suspend)
+{
+	struct twl6030_usb *twl;
+	struct device *dev;
+	struct twl4030_usb_data *pdata;
+
+	twl = xceiv_to_twl(x);
+	dev  = twl->dev;
+	pdata = dev->platform_data;
+	pdata->phy_suspend(twl->dev, suspend);
+
+	return 0;
+}
+
 static int twl6030_usb_ldo_init(struct twl6030_usb *twl)
 {
 
@@ -388,6 +402,7 @@ static int __devinit twl6030_usb_probe(s
 	twl->otg.set_vbus	= twl6030_set_vbus;
 	twl->otg.init		= twl6030_phy_init;
 	twl->otg.shutdown	= twl6030_phy_shutdown;
+	twl->otg.set_suspend	= twl6030_phy_suspend;
 
 	/* init spinlock for workqueue */
 	spin_lock_init(&twl->lock);
@@ -432,6 +447,7 @@ static int __devinit twl6030_usb_probe(s
 
 	twl->asleep = 0;
 	pdata->phy_init(dev);
+	twl6030_phy_suspend(&twl->otg, 0);
 	twl6030_enable_irq(&twl->otg);
 	dev_info(&pdev->dev, "Initialized TWL6030 USB module\n");
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
