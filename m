From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 01/10] usb: phy: Fix initial state for twl6030
Date: Thu, 28 Apr 2016 10:33:11 -0700
Message-ID: <1461864800-29979-2-git-send-email-tony@atomide.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461864800-29979-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We need to check the state for the PHY with delayed_work so
as otherwise MUSB will get confused and idles immediately.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/phy/phy-twl6030-usb.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index 014dbbd7..8696736 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -97,6 +97,9 @@ struct twl6030_usb {
 
 	struct regulator		*usb3v3;
 
+	/* used to check initial cable status after probe */
+	struct delayed_work	get_status_work;
+
 	/* used to set vbus, in atomic path */
 	struct work_struct	set_vbus_work;
 
@@ -274,6 +277,15 @@ static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
 	return IRQ_HANDLED;
 }
 
+static void twl6030_status_work(struct work_struct *work)
+{
+	struct twl6030_usb *twl = container_of(work, struct twl6030_usb,
+					       get_status_work.work);
+
+	twl6030_usb_irq(twl->irq2, twl);
+	twl6030_usbotg_irq(twl->irq1, twl);
+}
+
 static int twl6030_enable_irq(struct twl6030_usb *twl)
 {
 	twl6030_writeb(twl, TWL_MODULE_USB, 0x1, USB_ID_INT_EN_HI_SET);
@@ -284,8 +296,6 @@ static int twl6030_enable_irq(struct twl6030_usb *twl)
 				REG_INT_MSK_LINE_C);
 	twl6030_interrupt_unmask(TWL6030_CHARGER_CTRL_INT_MASK,
 				REG_INT_MSK_STS_C);
-	twl6030_usb_irq(twl->irq2, twl);
-	twl6030_usbotg_irq(twl->irq1, twl);
 
 	return 0;
 }
@@ -371,6 +381,7 @@ static int twl6030_usb_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
 	INIT_WORK(&twl->set_vbus_work, otg_set_vbus_work);
+	INIT_DELAYED_WORK(&twl->get_status_work, twl6030_status_work);
 
 	status = request_threaded_irq(twl->irq1, NULL, twl6030_usbotg_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -395,6 +406,7 @@ static int twl6030_usb_probe(struct platform_device *pdev)
 
 	twl->asleep = 0;
 	twl6030_enable_irq(twl);
+	schedule_delayed_work(&twl->get_status_work, HZ);
 	dev_info(&pdev->dev, "Initialized TWL6030 USB module\n");
 
 	return 0;
@@ -404,6 +416,7 @@ static int twl6030_usb_remove(struct platform_device *pdev)
 {
 	struct twl6030_usb *twl = platform_get_drvdata(pdev);
 
+	cancel_delayed_work(&twl->get_status_work);
 	twl6030_interrupt_mask(TWL6030_USBOTG_INT_MASK,
 		REG_INT_MSK_LINE_C);
 	twl6030_interrupt_mask(TWL6030_USBOTG_INT_MASK,
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
