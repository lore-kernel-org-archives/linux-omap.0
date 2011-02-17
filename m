From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 09/12] usb: otg: TWL6030: Introduce the twl6030_phy_suspend function.
Date: Thu, 17 Feb 2011 14:38:46 +0200
Message-ID: <1297946329-9353-10-git-send-email-balbi@ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297946329-9353-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>

Introduce the twl6030_phy_suspend function and assign to otg.set_suspend
function pointer.
This function is used by the musb-omap2430 platform driver
during suspend/resume.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/twl6030-usb.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/otg/twl6030-usb.c
index 88989e6..b4eda02 100644
--- a/drivers/usb/otg/twl6030-usb.c
+++ b/drivers/usb/otg/twl6030-usb.c
@@ -177,6 +177,17 @@ static void twl6030_phy_shutdown(struct otg_transceiver *x)
 	pdata->phy_power(twl->dev, 0, 0);
 }
 
+static int twl6030_phy_suspend(struct otg_transceiver *x, int suspend)
+{
+	struct twl6030_usb *twl = xceiv_to_twl(x);
+	struct device *dev = twl->dev;
+	struct twl4030_usb_data *pdata = dev->platform_data;
+
+	pdata->phy_suspend(dev, suspend);
+
+	return 0;
+}
+
 static int twl6030_usb_ldo_init(struct twl6030_usb *twl)
 {
 
@@ -388,6 +399,7 @@ static int __devinit twl6030_usb_probe(struct platform_device *pdev)
 	twl->otg.set_vbus	= twl6030_set_vbus;
 	twl->otg.init		= twl6030_phy_init;
 	twl->otg.shutdown	= twl6030_phy_shutdown;
+	twl->otg.set_suspend	= twl6030_phy_suspend;
 
 	/* init spinlock for workqueue */
 	spin_lock_init(&twl->lock);
@@ -432,6 +444,7 @@ static int __devinit twl6030_usb_probe(struct platform_device *pdev)
 
 	twl->asleep = 0;
 	pdata->phy_init(dev);
+	twl6030_phy_suspend(&twl->otg, 0);
 	twl6030_enable_irq(&twl->otg);
 	dev_info(&pdev->dev, "Initialized TWL6030 USB module\n");
 
-- 
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
