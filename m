From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 12/12] usb: otg: notifier: switch to atomic notifier
Date: Thu, 17 Feb 2011 14:38:49 +0200
Message-ID: <1297946329-9353-13-git-send-email-balbi@ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297946329-9353-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

most of our notifications, will be called from IRQ
context, so an atomic notifier suits the job better.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/ab8500-usb.c    |    6 +++---
 drivers/usb/otg/nop-usb-xceiv.c |    2 +-
 drivers/usb/otg/twl4030-usb.c   |    6 +++---
 drivers/usb/otg/twl6030-usb.c   |    8 ++++----
 include/linux/usb/otg.h         |    6 +++---
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/otg/ab8500-usb.c b/drivers/usb/otg/ab8500-usb.c
index d14736b..07ccea9 100644
--- a/drivers/usb/otg/ab8500-usb.c
+++ b/drivers/usb/otg/ab8500-usb.c
@@ -212,7 +212,7 @@ static int ab8500_usb_link_status_update(struct ab8500_usb *ab)
 		break;
 	}
 
-	blocking_notifier_call_chain(&ab->otg.notifier, event, v);
+	atomic_notifier_call_chain(&ab->otg.notifier, event, v);
 
 	return 0;
 }
@@ -281,7 +281,7 @@ static int ab8500_usb_set_power(struct otg_transceiver *otg, unsigned mA)
 	ab->vbus_draw = mA;
 
 	if (mA)
-		blocking_notifier_call_chain(&ab->otg.notifier,
+		atomic_notifier_call_chain(&ab->otg.notifier,
 				USB_EVENT_ENUMERATED, ab->otg.gadget);
 	return 0;
 }
@@ -500,7 +500,7 @@ static int __devinit ab8500_usb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ab);
 
-	BLOCKING_INIT_NOTIFIER_HEAD(&ab->otg.notifier);
+	ATOMIC_INIT_NOTIFIER_HEAD(&ab->otg.notifier);
 
 	/* v1: Wait for link status to become stable.
 	 * all: Updates form set_host and set_peripheral as they are atomic.
diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index 8acf165..c1e3600 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -132,7 +132,7 @@ static int __devinit nop_usb_xceiv_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, nop);
 
-	BLOCKING_INIT_NOTIFIER_HEAD(&nop->otg.notifier);
+	ATOMIC_INIT_NOTIFIER_HEAD(&nop->otg.notifier);
 
 	return 0;
 exit:
diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 6ca505f..2362d83 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -512,7 +512,7 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 		else
 			twl4030_phy_resume(twl);
 
-		blocking_notifier_call_chain(&twl->otg.notifier, status,
+		atomic_notifier_call_chain(&twl->otg.notifier, status,
 				twl->otg.gadget);
 	}
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
@@ -534,7 +534,7 @@ static void twl4030_usb_phy_init(struct twl4030_usb *twl)
 			twl->asleep = 0;
 		}
 
-		blocking_notifier_call_chain(&twl->otg.notifier, status,
+		atomic_notifier_call_chain(&twl->otg.notifier, status,
 				twl->otg.gadget);
 	}
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
@@ -623,7 +623,7 @@ static int __devinit twl4030_usb_probe(struct platform_device *pdev)
 	if (device_create_file(&pdev->dev, &dev_attr_vbus))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
-	BLOCKING_INIT_NOTIFIER_HEAD(&twl->otg.notifier);
+	ATOMIC_INIT_NOTIFIER_HEAD(&twl->otg.notifier);
 
 	/* Our job is to use irqs and status from the power module
 	 * to keep the transceiver disabled when nothing's connected.
diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/otg/twl6030-usb.c
index 05f17b7..8a91b4b 100644
--- a/drivers/usb/otg/twl6030-usb.c
+++ b/drivers/usb/otg/twl6030-usb.c
@@ -263,13 +263,13 @@ static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 			twl->otg.state = OTG_STATE_B_IDLE;
 			twl->linkstat = status;
 			twl->otg.last_event = status;
-			blocking_notifier_call_chain(&twl->otg.notifier,
+			atomic_notifier_call_chain(&twl->otg.notifier,
 						status, twl->otg.gadget);
 		} else {
 			status = USB_EVENT_NONE;
 			twl->linkstat = status;
 			twl->otg.last_event = status;
-			blocking_notifier_call_chain(&twl->otg.notifier,
+			atomic_notifier_call_chain(&twl->otg.notifier,
 						status, twl->otg.gadget);
 			if (twl->asleep) {
 				regulator_disable(twl->usb3v3);
@@ -302,7 +302,7 @@ static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
 		twl->otg.state = OTG_STATE_A_IDLE;
 		twl->linkstat = status;
 		twl->otg.last_event = status;
-		blocking_notifier_call_chain(&twl->otg.notifier, status,
+		atomic_notifier_call_chain(&twl->otg.notifier, status,
 							twl->otg.gadget);
 	} else  {
 		twl6030_writeb(twl, TWL_MODULE_USB, USB_ID_INT_EN_HI_CLR,
@@ -419,7 +419,7 @@ static int __devinit twl6030_usb_probe(struct platform_device *pdev)
 	if (device_create_file(&pdev->dev, &dev_attr_vbus))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
-	BLOCKING_INIT_NOTIFIER_HEAD(&twl->otg.notifier);
+	ATOMIC_INIT_NOTIFIER_HEAD(&twl->otg.notifier);
 
 	twl->irq_enabled = true;
 	status = request_threaded_irq(twl->irq1, NULL, twl6030_usbotg_irq,
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index da511ee..6e40718 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -75,7 +75,7 @@ struct otg_transceiver {
 	void __iomem			*io_priv;
 
 	/* for notification of usb_xceiv_events */
-	struct blocking_notifier_head	notifier;
+	struct atomic_notifier_head	notifier;
 
 	/* to pass extra port status to the root hub */
 	u16			port_status;
@@ -235,13 +235,13 @@ otg_start_srp(struct otg_transceiver *otg)
 static inline int
 otg_register_notifier(struct otg_transceiver *otg, struct notifier_block *nb)
 {
-	return blocking_notifier_chain_register(&otg->notifier, nb);
+	return atomic_notifier_chain_register(&otg->notifier, nb);
 }
 
 static inline void
 otg_unregister_notifier(struct otg_transceiver *otg, struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&otg->notifier, nb);
+	atomic_notifier_chain_unregister(&otg->notifier, nb);
 }
 
 /* for OTG controller drivers (and maybe other stuff) */
-- 
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
