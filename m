From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] usb: musb: core: Fix handling of the phy notifications
Date: Mon, 30 Nov 2015 21:37:12 -0800
Message-ID: <1448948233-31804-2-git-send-email-tony@atomide.com>
References: <1448948233-31804-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448948233-31804-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We currently can't unload omap2430 MUSB platform glue driver module and
this cause issues for fixing the MUSB code further. The reason we can't
remove omap2430 is because it uses the PHY functions and also exports the
omap_musb_mailbox function that some PHY drivers are using.

Let's fix the issue by exporting a more generic musb_mailbox function
from the MUSB core and allow platform glue layers to register phy_callback
function as needed.

And now we can now also get rid of the include/linux/musb-omap.h.

Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

---

Probably best that Felipe merges this patch via the USB tree after
comments if that works for Kishon? I have another two fixes for the
phy-twl4030-usb.c coming after this series but they can be merged
separately and won't conflict with this patch.

---
 drivers/phy/phy-twl4030-usb.c     | 32 ++++++++++++++++----------------
 drivers/usb/musb/musb_core.c      | 21 +++++++++++++++++++++
 drivers/usb/musb/musb_core.h      |  2 ++
 drivers/usb/musb/omap2430.c       | 27 ++++++++++++++-------------
 drivers/usb/phy/phy-twl6030-usb.c | 30 +++++++++++++++---------------
 include/linux/usb/musb-omap.h     | 30 ------------------------------
 include/linux/usb/musb.h          | 15 +++++++++++++++
 7 files changed, 83 insertions(+), 74 deletions(-)
 delete mode 100644 include/linux/usb/musb-omap.h

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 3a707dd..4a3fc6e 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -34,7 +34,7 @@
 #include <linux/usb/otg.h>
 #include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
-#include <linux/usb/musb-omap.h>
+#include <linux/usb/musb.h>
 #include <linux/usb/ulpi.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/consumer.h>
@@ -148,10 +148,10 @@
  * If VBUS is valid or ID is ground, then we know a
  * cable is present and we need to be runtime-enabled
  */
-static inline bool cable_present(enum omap_musb_vbus_id_status stat)
+static inline bool cable_present(enum musb_vbus_id_status stat)
 {
-	return stat == OMAP_MUSB_VBUS_VALID ||
-		stat == OMAP_MUSB_ID_GROUND;
+	return stat == MUSB_VBUS_VALID ||
+		stat == MUSB_ID_GROUND;
 }
 
 struct twl4030_usb {
@@ -170,7 +170,7 @@ struct twl4030_usb {
 	enum twl4030_usb_mode	usb_mode;
 
 	int			irq;
-	enum omap_musb_vbus_id_status linkstat;
+	enum musb_vbus_id_status linkstat;
 	bool			vbus_supplied;
 
 	struct delayed_work	id_workaround_work;
@@ -276,11 +276,11 @@ static bool twl4030_is_driving_vbus(struct twl4030_usb *twl)
 	return (ret & (ULPI_OTG_DRVVBUS | ULPI_OTG_CHRGVBUS)) ? true : false;
 }
 
-static enum omap_musb_vbus_id_status
+static enum musb_vbus_id_status
 	twl4030_usb_linkstat(struct twl4030_usb *twl)
 {
 	int	status;
-	enum omap_musb_vbus_id_status linkstat = OMAP_MUSB_UNKNOWN;
+	enum musb_vbus_id_status linkstat = MUSB_UNKNOWN;
 
 	twl->vbus_supplied = false;
 
@@ -306,14 +306,14 @@ static enum omap_musb_vbus_id_status
 		}
 
 		if (status & BIT(2))
-			linkstat = OMAP_MUSB_ID_GROUND;
+			linkstat = MUSB_ID_GROUND;
 		else if (status & BIT(7))
-			linkstat = OMAP_MUSB_VBUS_VALID;
+			linkstat = MUSB_VBUS_VALID;
 		else
-			linkstat = OMAP_MUSB_VBUS_OFF;
+			linkstat = MUSB_VBUS_OFF;
 	} else {
-		if (twl->linkstat != OMAP_MUSB_UNKNOWN)
-			linkstat = OMAP_MUSB_VBUS_OFF;
+		if (twl->linkstat != MUSB_UNKNOWN)
+			linkstat = MUSB_VBUS_OFF;
 	}
 
 	dev_dbg(twl->dev, "HW_CONDITIONS 0x%02x/%d; link %d\n",
@@ -535,7 +535,7 @@ static DEVICE_ATTR(vbus, 0444, twl4030_usb_vbus_show, NULL);
 static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	struct twl4030_usb *twl = _twl;
-	enum omap_musb_vbus_id_status status;
+	enum musb_vbus_id_status status;
 	bool status_changed = false;
 
 	status = twl4030_usb_linkstat(twl);
@@ -567,11 +567,11 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 			pm_runtime_mark_last_busy(twl->dev);
 			pm_runtime_put_autosuspend(twl->dev);
 		}
-		omap_musb_mailbox(status);
+		musb_mailbox(status);
 	}
 
 	/* don't schedule during sleep - irq works right then */
-	if (status == OMAP_MUSB_ID_GROUND && pm_runtime_active(twl->dev)) {
+	if (status == MUSB_ID_GROUND && pm_runtime_active(twl->dev)) {
 		cancel_delayed_work(&twl->id_workaround_work);
 		schedule_delayed_work(&twl->id_workaround_work, HZ);
 	}
@@ -670,7 +670,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	twl->dev		= &pdev->dev;
 	twl->irq		= platform_get_irq(pdev, 0);
 	twl->vbus_supplied	= false;
-	twl->linkstat		= OMAP_MUSB_UNKNOWN;
+	twl->linkstat		= MUSB_UNKNOWN;
 
 	twl->phy.dev		= twl->dev;
 	twl->phy.label		= "twl4030";
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 18cfc0a..a74bef1 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1705,6 +1705,23 @@ EXPORT_SYMBOL_GPL(musb_dma_completion);
 #define use_dma			0
 #endif
 
+static void (*musb_phy_callback)(enum musb_vbus_id_status status);
+
+/*
+ * musb_mailbox - optional phy notifier function
+ * @status phy state change
+ *
+ * Optionally gets called from the USB PHY. Note that the USB PHY must be
+ * disabled at the point the phy_callback is registered or unregistered.
+ */
+void musb_mailbox(enum musb_vbus_id_status status)
+{
+	if (musb_phy_callback)
+		musb_phy_callback(status);
+
+};
+EXPORT_SYMBOL_GPL(musb_mailbox);
+
 /*-------------------------------------------------------------------------*/
 
 static ssize_t
@@ -2117,6 +2134,9 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		musb->xceiv->io_ops = &musb_ulpi_access;
 	}
 
+	if (musb->ops->phy_callback)
+		musb_phy_callback = musb->ops->phy_callback;
+
 	pm_runtime_get_sync(musb->controller);
 
 	if (use_dma && dev->dma_mask) {
@@ -2289,6 +2309,7 @@ static int musb_remove(struct platform_device *pdev)
 	 */
 	musb_exit_debugfs(musb);
 	musb_shutdown(pdev);
+	musb_phy_callback = NULL;
 
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 2337d7a..fd215fb 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -168,6 +168,7 @@ struct musb_io;
  * @adjust_channel_params: pre check for standard dma channel_program func
  * @pre_root_reset_end: called before the root usb port reset flag gets cleared
  * @post_root_reset_end: called after the root usb port reset flag gets cleared
+ * @phy_callback: optional callback function for the phy to call
  */
 struct musb_platform_ops {
 
@@ -214,6 +215,7 @@ struct musb_platform_ops {
 				dma_addr_t *dma_addr, u32 *len);
 	void	(*pre_root_reset_end)(struct musb *musb);
 	void	(*post_root_reset_end)(struct musb *musb);
+	void	(*phy_callback)(enum musb_vbus_id_status status);
 };
 
 /*
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 1bd9232..bf05f80 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -36,7 +36,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/usb/musb-omap.h>
+#include <linux/usb/musb.h>
 #include <linux/phy/omap_control_phy.h>
 #include <linux/of_platform.h>
 
@@ -46,7 +46,7 @@
 struct omap2430_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
-	enum omap_musb_vbus_id_status status;
+	enum musb_vbus_id_status status;
 	struct work_struct	omap_musb_mailbox_work;
 	struct device		*control_otghs;
 };
@@ -234,7 +234,7 @@ static inline void omap2430_low_level_init(struct musb *musb)
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 }
 
-void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
+static void omap2430_musb_mailbox(enum musb_vbus_id_status status)
 {
 	struct omap2430_glue	*glue = _glue;
 
@@ -251,7 +251,6 @@ void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
 
 	schedule_work(&glue->omap_musb_mailbox_work);
 }
-EXPORT_SYMBOL_GPL(omap_musb_mailbox);
 
 static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 {
@@ -262,7 +261,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 	struct usb_otg *otg = musb->xceiv->otg;
 
 	switch (glue->status) {
-	case OMAP_MUSB_ID_GROUND:
+	case MUSB_ID_GROUND:
 		dev_dbg(dev, "ID GND\n");
 
 		otg->default_a = true;
@@ -276,7 +275,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		}
 		break;
 
-	case OMAP_MUSB_VBUS_VALID:
+	case MUSB_VBUS_VALID:
 		dev_dbg(dev, "VBUS Connect\n");
 
 		otg->default_a = false;
@@ -287,8 +286,8 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_DEVICE);
 		break;
 
-	case OMAP_MUSB_ID_FLOAT:
-	case OMAP_MUSB_VBUS_OFF:
+	case MUSB_ID_FLOAT:
+	case MUSB_VBUS_OFF:
 		dev_dbg(dev, "VBUS Disconnect\n");
 
 		musb->xceiv->last_event = USB_EVENT_NONE;
@@ -430,7 +429,7 @@ static int omap2430_musb_init(struct musb *musb)
 
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
-	if (glue->status != OMAP_MUSB_UNKNOWN)
+	if (glue->status != MUSB_UNKNOWN)
 		omap_musb_set_mailbox(glue);
 
 	phy_init(musb->phy);
@@ -455,7 +454,7 @@ static void omap2430_musb_enable(struct musb *musb)
 
 	switch (glue->status) {
 
-	case OMAP_MUSB_ID_GROUND:
+	case MUSB_ID_GROUND:
 		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_HOST);
 		if (data->interface_type != MUSB_INTERFACE_UTMI)
 			break;
@@ -474,7 +473,7 @@ static void omap2430_musb_enable(struct musb *musb)
 		}
 		break;
 
-	case OMAP_MUSB_VBUS_VALID:
+	case MUSB_VBUS_VALID:
 		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_DEVICE);
 		break;
 
@@ -488,7 +487,7 @@ static void omap2430_musb_disable(struct musb *musb)
 	struct device *dev = musb->controller;
 	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
 
-	if (glue->status != OMAP_MUSB_UNKNOWN)
+	if (glue->status != MUSB_UNKNOWN)
 		omap_control_usb_set_mode(glue->control_otghs,
 			USB_MODE_DISCONNECT);
 }
@@ -520,6 +519,8 @@ static const struct musb_platform_ops omap2430_ops = {
 
 	.enable		= omap2430_musb_enable,
 	.disable	= omap2430_musb_disable,
+
+	.phy_callback	= omap2430_musb_mailbox,
 };
 
 static u64 omap2430_dmamask = DMA_BIT_MASK(32);
@@ -551,7 +552,7 @@ static int omap2430_probe(struct platform_device *pdev)
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
-	glue->status			= OMAP_MUSB_UNKNOWN;
+	glue->status			= MUSB_UNKNOWN;
 	glue->control_otghs = ERR_PTR(-ENODEV);
 
 	if (np) {
diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index 1274185..014dbbd7 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -25,7 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/usb/musb-omap.h>
+#include <linux/usb/musb.h>
 #include <linux/usb/phy_companion.h>
 #include <linux/phy/omap_usb.h>
 #include <linux/i2c/twl.h>
@@ -102,7 +102,7 @@ struct twl6030_usb {
 
 	int			irq1;
 	int			irq2;
-	enum omap_musb_vbus_id_status linkstat;
+	enum musb_vbus_id_status linkstat;
 	u8			asleep;
 	bool			vbus_enable;
 	const char		*regulator;
@@ -189,13 +189,13 @@ static ssize_t twl6030_usb_vbus_show(struct device *dev,
 	spin_lock_irqsave(&twl->lock, flags);
 
 	switch (twl->linkstat) {
-	case OMAP_MUSB_VBUS_VALID:
+	case MUSB_VBUS_VALID:
 	       ret = snprintf(buf, PAGE_SIZE, "vbus\n");
 	       break;
-	case OMAP_MUSB_ID_GROUND:
+	case MUSB_ID_GROUND:
 	       ret = snprintf(buf, PAGE_SIZE, "id\n");
 	       break;
-	case OMAP_MUSB_VBUS_OFF:
+	case MUSB_VBUS_OFF:
 	       ret = snprintf(buf, PAGE_SIZE, "none\n");
 	       break;
 	default:
@@ -210,7 +210,7 @@ static DEVICE_ATTR(vbus, 0444, twl6030_usb_vbus_show, NULL);
 static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 {
 	struct twl6030_usb *twl = _twl;
-	enum omap_musb_vbus_id_status status = OMAP_MUSB_UNKNOWN;
+	enum musb_vbus_id_status status = MUSB_UNKNOWN;
 	u8 vbus_state, hw_state;
 	int ret;
 
@@ -225,14 +225,14 @@ static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 				dev_err(twl->dev, "Failed to enable usb3v3\n");
 
 			twl->asleep = 1;
-			status = OMAP_MUSB_VBUS_VALID;
+			status = MUSB_VBUS_VALID;
 			twl->linkstat = status;
-			omap_musb_mailbox(status);
+			musb_mailbox(status);
 		} else {
-			if (twl->linkstat != OMAP_MUSB_UNKNOWN) {
-				status = OMAP_MUSB_VBUS_OFF;
+			if (twl->linkstat != MUSB_UNKNOWN) {
+				status = MUSB_VBUS_OFF;
 				twl->linkstat = status;
-				omap_musb_mailbox(status);
+				musb_mailbox(status);
 				if (twl->asleep) {
 					regulator_disable(twl->usb3v3);
 					twl->asleep = 0;
@@ -248,7 +248,7 @@ static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
 {
 	struct twl6030_usb *twl = _twl;
-	enum omap_musb_vbus_id_status status = OMAP_MUSB_UNKNOWN;
+	enum musb_vbus_id_status status = MUSB_UNKNOWN;
 	u8 hw_state;
 	int ret;
 
@@ -262,9 +262,9 @@ static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
 		twl->asleep = 1;
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x1, USB_ID_INT_EN_HI_CLR);
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x10, USB_ID_INT_EN_HI_SET);
-		status = OMAP_MUSB_ID_GROUND;
+		status = MUSB_ID_GROUND;
 		twl->linkstat = status;
-		omap_musb_mailbox(status);
+		musb_mailbox(status);
 	} else  {
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x10, USB_ID_INT_EN_HI_CLR);
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x1, USB_ID_INT_EN_HI_SET);
@@ -334,7 +334,7 @@ static int twl6030_usb_probe(struct platform_device *pdev)
 	twl->dev		= &pdev->dev;
 	twl->irq1		= platform_get_irq(pdev, 0);
 	twl->irq2		= platform_get_irq(pdev, 1);
-	twl->linkstat		= OMAP_MUSB_UNKNOWN;
+	twl->linkstat		= MUSB_UNKNOWN;
 
 	twl->comparator.set_vbus	= twl6030_set_vbus;
 	twl->comparator.start_srp	= twl6030_start_srp;
diff --git a/include/linux/usb/musb-omap.h b/include/linux/usb/musb-omap.h
deleted file mode 100644
index 7774c59..0000000
--- a/include/linux/usb/musb-omap.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2011-2012 by Texas Instruments
- *
- * The Inventra Controller Driver for Linux is free software; you
- * can redistribute it and/or modify it under the terms of the GNU
- * General Public License version 2 as published by the Free Software
- * Foundation.
- */
-
-#ifndef __MUSB_OMAP_H__
-#define __MUSB_OMAP_H__
-
-enum omap_musb_vbus_id_status {
-	OMAP_MUSB_UNKNOWN = 0,
-	OMAP_MUSB_ID_GROUND,
-	OMAP_MUSB_ID_FLOAT,
-	OMAP_MUSB_VBUS_VALID,
-	OMAP_MUSB_VBUS_OFF,
-};
-
-#if (defined(CONFIG_USB_MUSB_OMAP2PLUS) || \
-				defined(CONFIG_USB_MUSB_OMAP2PLUS_MODULE))
-void omap_musb_mailbox(enum omap_musb_vbus_id_status status);
-#else
-static inline void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
-{
-}
-#endif
-
-#endif	/* __MUSB_OMAP_H__ */
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index fa6dc13..96ddfb7 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -133,6 +133,21 @@ struct musb_hdrc_platform_data {
 	const void	*platform_ops;
 };
 
+enum musb_vbus_id_status {
+	MUSB_UNKNOWN = 0,
+	MUSB_ID_GROUND,
+	MUSB_ID_FLOAT,
+	MUSB_VBUS_VALID,
+	MUSB_VBUS_OFF,
+};
+
+#if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
+void musb_mailbox(enum musb_vbus_id_status status);
+#else
+static inline void musb_mailbox(enum musb_vbus_id_status status)
+{
+}
+#endif
 
 /* TUSB 6010 support */
 
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
