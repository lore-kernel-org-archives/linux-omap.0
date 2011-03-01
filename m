From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 03/19] usb: musb: Idle path retention and offmode support for OMAP3
Date: Tue,  1 Mar 2011 17:15:24 +0200
Message-ID: <1298992540-5984-4-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:39870 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755100Ab1CAPQO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 10:16:14 -0500
In-Reply-To: <1298992540-5984-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>

From: Hema HK <hemahk@ti.com>

This patch supports the retention and offmode support in the idle path for
musb driver using runtime pm APIs.

This is restricted to support offmode and retention only when device not
connected.When device/cable connected with gadget driver loaded,configured
to no idle/standby which will not allow the core transition to retention
or off.

There is no context save/restore done by hardware for musb in OMAP3
and OMAP4,driver has to take care of saving and restoring the context
during offmode.

Musb has a requirement of configuring sysconfig register to force
idle/standby mode and set the ENFORCE bit in module STANDBY register
for retention and offmode support.

Runtime pm and hwmod frameworks will take care of configuring to force
idle/standby when pm_runtime_put_sync is called and back to no
idle/standby when pm_runeime_get_sync is called.

Compile, boot tested and also tested the retention in the idle path on
OMAP3630Zoom3. And tested the global suspend/resume with offmode enabled.
Usb basic functionality tested on OMAP4430SDP.

There is some problem with idle path offmode in mainline, I could not test
with offmode. But I have tested this patch with resetting the controller
in the idle path when wakeup from retention just to make sure that the
context is lost, and restore path is working fine.

Removed .suspend/.resume fnction pointers and functions because there
is no need of having these functions as all required work is done
at runtime in the driver.

There is no need to call the runtime pm api with glue driver device
as glue layer device is the parent of musb core device, when runtime apis
are called for the child, parent device runtime functionality
will be invoked.

Design overview:

pm_runtime_get_sync: When called with musb core device takes care of
enabling the clock, calling runtime callback function of omap2430 glue
layer, runtime call back of musb driver and configure the musb sysconfig
to no idle/standby

pm_runtime_put: Takes care of calling runtime callback function of omap2430
glue layer, runtime call back of musb driver, Configure the musb sysconfig
to force idle/standby and disable the clock.

During musb driver load: Call pm_runtime_get_sync.

End of musb driver load: Call pm_runtime_put

During gadget driver load: Call pm_runtime_get_sync,
End of gadget driver load: Call pm_runtime_put if there is no device
or cable is connected.

During unload of the gadget driver:Call pm_runtime_get_sync if cable/device
is not connected.
End of the gadget driver unload : pm_runtime_put

During unload of musb driver : Call pm_runtime_get_sync
End of unload: Call pm_runtime_put

On connect of usb cable/device -> transceiver notification(VBUS and ID-GND):
pm_runtime_get_sync only if the gadget driver loaded.

On disconnect of the cable/device -> Disconnect Notification:
pm_runtime_put if the gadget driver is loaded.

Signed-off-by: Hema HK <hemahk@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_core.c   |   40 ++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_gadget.c |   11 +++++++++
 drivers/usb/musb/omap2430.c    |   49 ++++++++++++++++++++++------------------
 3 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index bc29655..36376d2 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1956,6 +1956,10 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		goto fail0;
 	}
 
+	pm_runtime_use_autosuspend(musb->controller);
+	pm_runtime_set_autosuspend_delay(musb->controller, 200);
+	pm_runtime_enable(musb->controller);
+
 	spin_lock_init(&musb->lock);
 	musb->board_mode = plat->mode;
 	musb->board_set_power = plat->set_power;
@@ -2091,6 +2095,8 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (status < 0)
 		goto fail3;
 
+	pm_runtime_put(musb->controller);
+
 	status = musb_init_debugfs(musb);
 	if (status < 0)
 		goto fail4;
@@ -2190,9 +2196,11 @@ static int __exit musb_remove(struct platform_device *pdev)
 	 *  - Peripheral mode: peripheral is deactivated (or never-activated)
 	 *  - OTG mode: both roles are deactivated (or never-activated)
 	 */
+	pm_runtime_get_sync(musb->controller);
 	musb_exit_debugfs(musb);
 	musb_shutdown(pdev);
 
+	pm_runtime_put(musb->controller);
 	musb_free(musb);
 	iounmap(ctrl_base);
 	device_init_wakeup(&pdev->dev, 0);
@@ -2378,9 +2386,41 @@ static int musb_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static int musb_runtime_suspend(struct device *dev)
+{
+	struct musb	*musb = dev_to_musb(dev);
+
+	musb_save_context(musb);
+
+	return 0;
+}
+
+static int musb_runtime_resume(struct device *dev)
+{
+	struct musb	*musb = dev_to_musb(dev);
+	static int	first = 1;
+
+	/*
+	 * When pm_runtime_get_sync called for the first time in driver
+	 * init,  some of the structure is still not initialized which is
+	 * used in restore function. But clock needs to be
+	 * enabled before any register access, so
+	 * pm_runtime_get_sync has to be called.
+	 * Also context restore without save does not make
+	 * any sense
+	 */
+	if (!first)
+		musb_restore_context(musb);
+	first = 0;
+
+	return 0;
+}
+
 static const struct dev_pm_ops musb_dev_pm_ops = {
 	.suspend	= musb_suspend,
 	.resume_noirq	= musb_resume_noirq,
+	.runtime_suspend = musb_runtime_suspend,
+	.runtime_resume = musb_runtime_resume,
 };
 
 #define MUSB_DEV_PM_OPS (&musb_dev_pm_ops)
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 2a3aee4..5c7b321 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1821,6 +1821,8 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
 		goto err0;
 	}
 
+	pm_runtime_get_sync(musb->controller);
+
 	DBG(3, "registering driver %s\n", driver->function);
 
 	if (musb->gadget_driver) {
@@ -1885,6 +1887,10 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
 		}
 
 		hcd->self.uses_pio_for_control = 1;
+
+		if (musb->xceiv->last_event == USB_EVENT_NONE)
+			pm_runtime_put(musb->controller);
+
 	}
 
 	return 0;
@@ -1961,6 +1967,9 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	if (!musb->gadget_driver)
 		return -EINVAL;
 
+	if (musb->xceiv->last_event == USB_EVENT_NONE)
+		pm_runtime_get_sync(musb->controller);
+
 	/*
 	 * REVISIT always use otg_set_peripheral() here too;
 	 * this needs to shut down the OTG engine.
@@ -2002,6 +2011,8 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	if (!is_otg_enabled(musb))
 		musb_stop(musb);
 
+	pm_runtime_put(musb->controller);
+
 	return 0;
 }
 EXPORT_SYMBOL(usb_gadget_unregister_driver);
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index b6dcc7e..4726798 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -244,6 +244,7 @@ static int musb_otg_notifications(struct notifier_block *nb,
 		if (is_otg_enabled(musb)) {
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 			if (musb->gadget_driver) {
+				pm_runtime_get_sync(musb->controller);
 				otg_init(musb->xceiv);
 
 				if (data->interface_type ==
@@ -253,6 +254,7 @@ static int musb_otg_notifications(struct notifier_block *nb,
 			}
 #endif
 		} else {
+			pm_runtime_get_sync(musb->controller);
 			otg_init(musb->xceiv);
 			if (data->interface_type ==
 					MUSB_INTERFACE_UTMI)
@@ -263,12 +265,24 @@ static int musb_otg_notifications(struct notifier_block *nb,
 	case USB_EVENT_VBUS:
 		DBG(4, "VBUS Connect\n");
 
+		if (musb->gadget_driver)
+			pm_runtime_get_sync(musb->controller);
+
 		otg_init(musb->xceiv);
 		break;
 
 	case USB_EVENT_NONE:
 		DBG(4, "VBUS Disconnect\n");
 
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
+		if (is_otg_enabled(musb))
+			if (musb->gadget_driver)
+#endif
+			{
+				pm_runtime_mark_last_busy(musb->controller);
+				pm_runtime_put_autosuspend(musb->controller);
+			}
+
 		if (data->interface_type == MUSB_INTERFACE_UTMI) {
 			if (musb->xceiv->set_vbus)
 				otg_set_vbus(musb->xceiv, 0);
@@ -300,7 +314,11 @@ static int omap2430_musb_init(struct musb *musb)
 		return -ENODEV;
 	}
 
-	omap2430_low_level_init(musb);
+	status = pm_runtime_get_sync(dev);
+	if (status < 0) {
+		dev_err(dev, "pm_runtime_get_sync FAILED");
+		goto err1;
+	}
 
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 
@@ -331,6 +349,10 @@ static int omap2430_musb_init(struct musb *musb)
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
 	return 0;
+
+err1:
+	pm_runtime_disable(dev);
+	return status;
 }
 
 static void omap2430_musb_enable(struct musb *musb)
@@ -407,8 +429,6 @@ static int __init omap2430_probe(struct platform_device *pdev)
 	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
 	struct platform_device		*musb;
 	struct omap2430_glue		*glue;
-	int				status = 0;
-
 	int				ret = -ENOMEM;
 
 	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
@@ -454,16 +474,9 @@ static int __init omap2430_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(&pdev->dev);
-	status = pm_runtime_get_sync(&pdev->dev);
-	if (status < 0) {
-		dev_err(&pdev->dev, "pm_runtime_get_sync FAILED");
-		goto err3;
-	}
 
 	return 0;
 
-err3:
-	pm_runtime_disable(&pdev->dev);
 err2:
 	platform_device_put(musb);
 
@@ -489,7 +502,7 @@ static int __exit omap2430_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_PM
 
-static int omap2430_suspend(struct device *dev)
+static int omap2430_runtime_suspend(struct device *dev)
 {
 	struct omap2430_glue		*glue = dev_get_drvdata(dev);
 	struct musb			*musb = glue_to_musb(glue);
@@ -497,22 +510,14 @@ static int omap2430_suspend(struct device *dev)
 	omap2430_low_level_exit(musb);
 	otg_set_suspend(musb->xceiv, 1);
 
-	if (!pm_runtime_suspended(dev) && dev->bus && dev->bus->pm &&
-			dev->bus->pm->runtime_suspend)
-		dev->bus->pm->runtime_suspend(dev);
-
 	return 0;
 }
 
-static int omap2430_resume(struct device *dev)
+static int omap2430_runtime_resume(struct device *dev)
 {
 	struct omap2430_glue		*glue = dev_get_drvdata(dev);
 	struct musb			*musb = glue_to_musb(glue);
 
-	if (!pm_runtime_suspended(dev) && dev->bus && dev->bus->pm &&
-			dev->bus->pm->runtime_resume)
-		dev->bus->pm->runtime_resume(dev);
-
 	omap2430_low_level_init(musb);
 	otg_set_suspend(musb->xceiv, 0);
 
@@ -520,8 +525,8 @@ static int omap2430_resume(struct device *dev)
 }
 
 static struct dev_pm_ops omap2430_pm_ops = {
-	.suspend	= omap2430_suspend,
-	.resume		= omap2430_resume,
+	.runtime_suspend = omap2430_runtime_suspend,
+	.runtime_resume = omap2430_runtime_resume,
 };
 
 #define DEV_PM_OPS	(&omap2430_pm_ops)
-- 
1.7.4.rc2

