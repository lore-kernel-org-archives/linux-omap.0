From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [1/7 v4] usb: otg: enable regulator only on cable/device connect
Date: Thu, 17 Feb 2011 12:06:04 +0530
Message-ID: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>

Remove the regulator enable while driver loading and enable it only when
the cable/device is connected and disable it when disconnected.

Remove the configuration of config_state and config_trans register
configuration as these registers are programmed when regulator 
enable/disable is called.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
drivers/usb/otg/twl6030-usb.c |   27 ++++++++++++---------------
 drivers/usb/otg/twl6030-usb.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

Index: linux-2.6/drivers/usb/otg/twl6030-usb.c
===================================================================
--- linux-2.6.orig/drivers/usb/otg/twl6030-usb.c
+++ linux-2.6/drivers/usb/otg/twl6030-usb.c
@@ -158,8 +158,6 @@ static int twl6030_phy_init(struct otg_t
 	dev  = twl->dev;
 	pdata = dev->platform_data;
 
-	regulator_enable(twl->usb3v3);
-
 	hw_state = twl6030_readb(twl, TWL6030_MODULE_ID0, STS_HW_CONDITIONS);
 
 	if (hw_state & STS_USB_ID)
@@ -180,7 +178,6 @@ static void twl6030_phy_shutdown(struct 
 	dev  = twl->dev;
 	pdata = dev->platform_data;
 	pdata->phy_power(twl->dev, 0, 0);
-	regulator_disable(twl->usb3v3);
 }
 
 static int twl6030_usb_ldo_init(struct twl6030_usb *twl)
@@ -199,16 +196,6 @@ static int twl6030_usb_ldo_init(struct t
 	if (IS_ERR(twl->usb3v3))
 		return -ENODEV;
 
-	regulator_enable(twl->usb3v3);
-
-	/* Program the VUSB_CFG_TRANS for ACTIVE state. */
-	twl6030_writeb(twl, TWL_MODULE_PM_RECEIVER, 0x3F,
-						VUSB_CFG_TRANS);
-
-	/* Program the VUSB_CFG_STATE register to ON on all groups. */
-	twl6030_writeb(twl, TWL_MODULE_PM_RECEIVER, 0xE1,
-						VUSB_CFG_STATE);
-
 	/* Program the USB_VBUS_CTRL_SET and set VBUS_ACT_COMP bit */
 	twl6030_writeb(twl, TWL_MODULE_USB, 0x4, USB_VBUS_CTRL_SET);
 
@@ -261,16 +248,23 @@ static irqreturn_t twl6030_usb_irq(int i
 						CONTROLLER_STAT1);
 	if (!(hw_state & STS_USB_ID)) {
 		if (vbus_state & VBUS_DET) {
+			regulator_enable(twl->usb3v3);
+			twl->asleep = 1;
 			status = USB_EVENT_VBUS;
 			twl->otg.default_a = false;
 			twl->otg.state = OTG_STATE_B_IDLE;
+			twl->linkstat = status;
+			blocking_notifier_call_chain(&twl->otg.notifier,
+						status, twl->otg.gadget);
 		} else {
 			status = USB_EVENT_NONE;
-		}
-		if (status >= 0) {
 			twl->linkstat = status;
 			blocking_notifier_call_chain(&twl->otg.notifier,
 						status, twl->otg.gadget);
+			if (twl->asleep) {
+				regulator_disable(twl->usb3v3);
+				twl->asleep = 0;
+			}
 		}
 	}
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
@@ -288,6 +282,8 @@ static irqreturn_t twl6030_usbotg_irq(in
 
 	if (hw_state & STS_USB_ID) {
 
+		regulator_enable(twl->usb3v3);
+		twl->asleep = 1;
 		twl6030_writeb(twl, TWL_MODULE_USB, USB_ID_INT_EN_HI_CLR, 0x1);
 		twl6030_writeb(twl, TWL_MODULE_USB, USB_ID_INT_EN_HI_SET,
 								0x10);
@@ -437,6 +433,7 @@ static int __devinit twl6030_usb_probe(s
 		return status;
 	}
 
+	twl->asleep = 0;
 	pdata->phy_init(dev);
 	twl6030_enable_irq(&twl->otg);
 	dev_info(&pdev->dev, "Initialized TWL6030 USB module\n");
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
