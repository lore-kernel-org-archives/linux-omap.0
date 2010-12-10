From: Hema HK <hemahk@ti.com>
Subject: [PATCH 6/7 V2] usb: musb: Adding musb support for OMAP4430
Date: Fri, 10 Dec 2010 12:35:23 +0530
Message-ID: <1291964723-7233-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43157 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab0LJHF3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 02:05:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>

OMAP4430 supports UTMI and ULPI types of transceiver interface.

In UTMI mode: The PHY is embedded within OMAP4430. The transceiver functionality
is split between the twl6030 PMIC chip and OMAP4430. The VBUS, ID pin 
sensing and OTG SRP generation part is integrated in TWL6030 and UTMI PHY
functionality is embedded within the OMAP4430.

There is no direct interactions between the MUSB controller and TWL6030
chip to communicate the session-valid, session-end and ID-GND events.
It has to be done through a software by setting/resetting bits in
one of the control module register of OMAP4430 which in turn toggles
the appropriate signals to MUSB controller.

musb driver is register for blocking notifications from the transceiver
driver to get the event notifications for connect/disconnect and ID-GND.
Based on these events call the transceiver init/shutdown function to
configure the transceiver to toggle the VBUS valid, session end and ID_GND
signals to musb and power on/off the internal PHY.

For ID_GND event notifications, toggle the ID_GND signal and then wait for
musb to be configured as "A" device, and then call the transceiver function
to set the VBUS.

In OTG mode and musb as a host, When the Micro A connector used, VBUS is turned on
and session bit set. When the device is connected, enumeration goes through.
When the device disconnected from the other end of the connector(ID is still grounded),
link will detect the disconnect and end the session. When the device is connected back,
there are no events generated in the TWL6030-usb, and link is already down.
So the device is not detected. Removed the session bit disable code which
will recognize the connect of the device.

Limitation: In OTG host mode, if device is connected during boot, it does not get 
detected. If disconnect and connect it back or connect after boot only it works.
Fix for this, I will submit seperate patch later.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>

---
 drivers/usb/musb/musb_core.h |    1 
 drivers/usb/musb/omap2430.c  |  105 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 96 insertions(+), 10 deletions(-)

Index: usb/drivers/usb/musb/musb_core.h
===================================================================
--- usb.orig/drivers/usb/musb/musb_core.h
+++ usb/drivers/usb/musb/musb_core.h
@@ -411,6 +411,7 @@ struct musb {
 
 	struct timer_list	otg_timer;
 #endif
+	struct notifier_block	nb;
 
 	struct dma_controller	*dma_controller;
 
Index: usb/drivers/usb/musb/omap2430.c
===================================================================
--- usb.orig/drivers/usb/musb/omap2430.c
+++ usb/drivers/usb/musb/omap2430.c
@@ -57,12 +57,8 @@ static void musb_do_idle(unsigned long _
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
-
 	switch (musb->xceiv->state) {
 	case OTG_STATE_A_WAIT_BCON:
-		devctl &= ~MUSB_DEVCTL_SESSION;
-		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
 
 		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 		if (devctl & MUSB_DEVCTL_BDEVICE) {
@@ -142,6 +138,8 @@ static void omap2430_musb_try_idle(struc
 static void omap2430_musb_set_vbus(struct musb *musb, int is_on)
 {
 	u8		devctl;
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+	int ret = 1;
 	/* HDRC controls CPEN, but beware current surges during device
 	 * connect.  They can trigger transient overcurrent conditions
 	 * that must be ignored.
@@ -150,12 +148,35 @@ static void omap2430_musb_set_vbus(struc
 	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 
 	if (is_on) {
-		musb->is_active = 1;
-		musb->xceiv->default_a = 1;
-		musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
-		devctl |= MUSB_DEVCTL_SESSION;
+		if (musb->xceiv->state == OTG_STATE_A_IDLE) {
+			/* start the session */
+			devctl |= MUSB_DEVCTL_SESSION;
+			musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+			/*
+			 * Wait for the musb to set as A device to enable the
+			 * VBUS
+			 */
+			while (musb_readb(musb->mregs, MUSB_DEVCTL) & 0x80) {
+
+				cpu_relax();
+
+				if (time_after(jiffies, timeout)) {
+					dev_err(musb->controller,
+					"configured as A device timeout");
+					ret = -EINVAL;
+					break;
+				}
+			}
 
-		MUSB_HST_MODE(musb);
+			if (ret && musb->xceiv->set_vbus)
+				otg_set_vbus(musb->xceiv, 1);
+		} else {
+			musb->is_active = 1;
+			musb->xceiv->default_a = 1;
+			musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
+			devctl |= MUSB_DEVCTL_SESSION;
+			MUSB_HST_MODE(musb);
+		}
 	} else {
 		musb->is_active = 0;
 
@@ -214,9 +235,62 @@ static inline void omap2430_low_level_in
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 }
 
+/* blocking notifier support */
+static int musb_otg_notifications(struct notifier_block *nb,
+		unsigned long event, void *unused)
+{
+	struct musb	*musb = container_of(nb, struct musb, nb);
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *pdata = dev->platform_data;
+	struct omap_musb_board_data *data = pdata->board_data;
+
+	switch (event) {
+	case USB_EVENT_ID:
+		DBG(4, "ID GND\n");
+
+		if (is_otg_enabled(musb)) {
+			if (musb->gadget_driver) {
+				otg_init(musb->xceiv);
+
+				if (data->interface_type ==
+						MUSB_INTERFACE_UTMI)
+					omap2430_musb_set_vbus(musb, 1);
+
+			}
+		} else {
+			otg_init(musb->xceiv);
+			if (data->interface_type ==
+					MUSB_INTERFACE_UTMI)
+				omap2430_musb_set_vbus(musb, 1);
+		}
+		break;
+
+	case USB_EVENT_VBUS:
+		DBG(4, "VBUS Connect\n");
+
+		otg_init(musb->xceiv);
+		break;
+
+	case USB_EVENT_NONE:
+		DBG(4, "VBUS Disconnect\n");
+
+		if (data->interface_type == MUSB_INTERFACE_UTMI) {
+			if (musb->xceiv->set_vbus)
+				otg_set_vbus(musb->xceiv, 0);
+		}
+		otg_shutdown(musb->xceiv);
+		break;
+	default:
+		DBG(4, "ID float\n");
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
 static int omap2430_musb_init(struct musb *musb)
 {
-	u32 l;
+	u32 l, status = 0;
 	struct device *dev = musb->controller;
 	struct musb_hdrc_platform_data *plat = dev->platform_data;
 	struct omap_musb_board_data *data = plat->board_data;
@@ -268,6 +342,17 @@ static int omap2430_musb_init(struct mus
 			musb_readl(musb->mregs, OTG_INTERFSEL),
 			musb_readl(musb->mregs, OTG_SIMENABLE));
 
+	musb->nb.notifier_call = musb_otg_notifications;
+	status = otg_register_notifier(musb->xceiv, &musb->nb);
+
+	if (status)
+		DBG(1, "notification register failed\n");
+
+	/* check whether cable is already connected */
+	if (musb->xceiv->state ==OTG_STATE_B_IDLE)
+		musb_otg_notifications(&musb->nb, 1,
+					musb->xceiv->gadget);
+
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
 	return 0;
