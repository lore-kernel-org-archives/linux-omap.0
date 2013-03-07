From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 06/10] usb: power: pda_power: check against CONFIG_USB_PHY
Date: Thu, 7 Mar 2013 11:36:05 +0200
Message-ID: <1362648969-13737-7-git-send-email-balbi@ti.com>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362648969-13737-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

CONFIG_USB_OTG_UTILS will be removed very
soon, so we should check CONFIG_USB_PHY
instead.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/power/pda_power.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/pda_power.c b/drivers/power/pda_power.c
index 7df7c5f..0c52e2a 100644
--- a/drivers/power/pda_power.c
+++ b/drivers/power/pda_power.c
@@ -35,7 +35,7 @@ static struct timer_list supply_timer;
 static struct timer_list polling_timer;
 static int polling;
 
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 static struct usb_phy *transceiver;
 static struct notifier_block otg_nb;
 #endif
@@ -218,7 +218,7 @@ static void polling_timer_func(unsigned long unused)
 		  jiffies + msecs_to_jiffies(pdata->polling_interval));
 }
 
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 static int otg_is_usb_online(void)
 {
 	return (transceiver->last_event == USB_EVENT_VBUS ||
@@ -315,7 +315,7 @@ static int pda_power_probe(struct platform_device *pdev)
 		pda_psy_usb.num_supplicants = pdata->num_supplicants;
 	}
 
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 	transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (!IS_ERR_OR_NULL(transceiver)) {
 		if (!pdata->is_usb_online)
@@ -367,7 +367,7 @@ static int pda_power_probe(struct platform_device *pdev)
 		}
 	}
 
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 	if (!IS_ERR_OR_NULL(transceiver) && pdata->use_otg_notifier) {
 		otg_nb.notifier_call = otg_handle_notification;
 		ret = usb_register_notifier(transceiver, &otg_nb);
@@ -391,7 +391,7 @@ static int pda_power_probe(struct platform_device *pdev)
 
 	return 0;
 
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 otg_reg_notifier_failed:
 	if (pdata->is_usb_online && usb_irq)
 		free_irq(usb_irq->start, &pda_psy_usb);
@@ -402,7 +402,7 @@ usb_irq_failed:
 usb_supply_failed:
 	if (pdata->is_ac_online && ac_irq)
 		free_irq(ac_irq->start, &pda_psy_ac);
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 	if (!IS_ERR_OR_NULL(transceiver))
 		usb_put_phy(transceiver);
 #endif
@@ -437,7 +437,7 @@ static int pda_power_remove(struct platform_device *pdev)
 		power_supply_unregister(&pda_psy_usb);
 	if (pdata->is_ac_online)
 		power_supply_unregister(&pda_psy_ac);
-#ifdef CONFIG_USB_OTG_UTILS
+#if IS_ENABLED(CONFIG_USB_PHY)
 	if (!IS_ERR_OR_NULL(transceiver))
 		usb_put_phy(transceiver);
 #endif
-- 
1.8.1.rc1.5.g7e0651a

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
