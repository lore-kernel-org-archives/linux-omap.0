From: Pavel Machek <pavel@ucw.cz>
Subject: Re: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
Date: Fri, 25 Mar 2016 22:30:01 +0100
Message-ID: <20160325213001.GB11978@amd>
References: <20160317212603.GA16651@amd>
 <CAB=otbSfj24nSUe1DyfVBDKD=trCp2-X-S-AcA1D+PTHZuP1Bg@mail.gmail.com>
 <20160318202041.GA20196@amd>
 <56EFE057.7070106@samsung.com>
 <20160323122143.GB32031@amd>
 <CAB=otbT2VsZ8Rhc-jbKwtRAssn01ecVFyTyAp+5hS=d40AsGKA@mail.gmail.com>
 <CAB=otbQdpEtsXg2etX+3YYjrTfPYGtdKJo_V_rtfNb+VNV7g-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAB=otbQdpEtsXg2etX+3YYjrTfPYGtdKJo_V_rtfNb+VNV7g-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, serge@hallyn.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Peter Chen <peter.chen@freescale.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> OK, so at last I finished charging of my N900; found 1.8V USB
> to UART adapter and soldered it to the phone.
> 
> I managed to boot N900 with working USB gadget (builtin g_ether)
> in boardfile mode, can ping it from PC and transfer data. I don't
> see any issue (except of musb name issue in twl phy driver, I've
> already sent a fix for that: https://lkml.org/lkml/2016/3/24/670 )
> 
> Pavel, I still don't see how you've got your issue, please share
> more detials

And for completenes, this is (reverted) patch that fixes the issue for
me. Hmm. That looks a bit too big.

Doing the revert, and PC is happy: first we boot from NOLO, then Linux
boots and we detect USB gadget.

Best regards,
								Pavel

[258134.206143] usb 1-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=5
[258134.206149] usb 1-1: Product: Nokia N900 (Update mode)
[258134.206154] usb 1-1: Manufacturer: Nokia
[258134.206158] usb 1-1: SerialNumber: 4D554D333032393332
[258135.695868] usb 1-1: USB disconnect, device number 97
[258144.192099] usb 1-1: new high-speed USB device number 98 using
ehci-pci
[258144.326465] usb 1-1: New USB device found, idVendor=0421,
idProduct=01c7
[258144.326474] usb 1-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[258144.326479] usb 1-1: Product: N900 (Storage Mode)
[258144.326482] usb 1-1: Manufacturer: Nokia
[258144.326486] usb 1-1: SerialNumber: 372041756775
[258144.330518] usb-storage 1-1:1.0: USB Mass Storage device detected
[258144.331737] scsi host14: usb-storage 1-1:1.0
[258145.333287] scsi 14:0:0:0: Direct-Access     Nokia    N900
031 PQ: 0 ANSI: 2
[258145.337226] sd 14:0:0:0: Attached scsi generic sg1 type 0
[258145.343359] sd 14:0:0:0: [sdb] Attached SCSI removable disk
[258145.343717] scsi 14:0:0:1: Direct-Access     Nokia    N900
031 PQ: 0 ANSI: 2
[258145.347245] sd 14:0:0:1: Attached scsi generic sg2 type 0
[258145.352379] sd 14:0:0:1: [sdc] Attached SCSI removable disk
pavel@duo:/data/l/linux-n900$



Best regards,
								Pavel

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 9708cf5..ce18f57 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -34,7 +34,7 @@
 #include <linux/usb/otg.h>
 #include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
-#include <linux/usb/musb.h>
+#include <linux/usb/musb-omap.h>
 #include <linux/usb/ulpi.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/consumer.h>
@@ -148,10 +148,10 @@
  * If VBUS is valid or ID is ground, then we know a
  * cable is present and we need to be runtime-enabled
  */
-static inline bool cable_present(enum musb_vbus_id_status stat)
+static inline bool cable_present(enum omap_musb_vbus_id_status stat)
 {
-	return stat == MUSB_VBUS_VALID ||
-		stat == MUSB_ID_GROUND;
+	return stat == OMAP_MUSB_VBUS_VALID ||
+		stat == OMAP_MUSB_ID_GROUND;
 }
 
 struct twl4030_usb {
@@ -170,7 +170,7 @@ struct twl4030_usb {
 	enum twl4030_usb_mode	usb_mode;
 
 	int			irq;
-	enum musb_vbus_id_status linkstat;
+	enum omap_musb_vbus_id_status linkstat;
 	bool			vbus_supplied;
 
 	struct delayed_work	id_workaround_work;
@@ -276,11 +276,11 @@ static bool twl4030_is_driving_vbus(struct twl4030_usb *twl)
 	return (ret & (ULPI_OTG_DRVVBUS | ULPI_OTG_CHRGVBUS)) ? true : false;
 }
 
-static enum musb_vbus_id_status
+static enum omap_musb_vbus_id_status
 	twl4030_usb_linkstat(struct twl4030_usb *twl)
 {
 	int	status;
-	enum musb_vbus_id_status linkstat = MUSB_UNKNOWN;
+	enum omap_musb_vbus_id_status linkstat = OMAP_MUSB_UNKNOWN;
 
 	twl->vbus_supplied = false;
 
@@ -306,14 +306,14 @@ static enum musb_vbus_id_status
 		}
 
 		if (status & BIT(2))
-			linkstat = MUSB_ID_GROUND;
+			linkstat = OMAP_MUSB_ID_GROUND;
 		else if (status & BIT(7))
-			linkstat = MUSB_VBUS_VALID;
+			linkstat = OMAP_MUSB_VBUS_VALID;
 		else
-			linkstat = MUSB_VBUS_OFF;
+			linkstat = OMAP_MUSB_VBUS_OFF;
 	} else {
-		if (twl->linkstat != MUSB_UNKNOWN)
-			linkstat = MUSB_VBUS_OFF;
+		if (twl->linkstat != OMAP_MUSB_UNKNOWN)
+			linkstat = OMAP_MUSB_VBUS_OFF;
 	}
 
 	dev_dbg(twl->dev, "HW_CONDITIONS 0x%02x/%d; link %d\n",
@@ -532,47 +532,10 @@ static ssize_t twl4030_usb_vbus_show(struct device *dev,
 }
 static DEVICE_ATTR(vbus, 0444, twl4030_usb_vbus_show, NULL);
 
-static ssize_t twl4030_test_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct twl4030_usb *twl = dev_get_drvdata(dev);
-	int ret = -EINVAL;
-
-	mutex_lock(&twl->lock);
-	ret = sprintf(buf, "%s\n", "hello, world");
-	mutex_unlock(&twl->lock);
-
-	return ret;
-}
-
-static int twl4030_shutdown(struct twl4030_usb *twl);
-
-static ssize_t twl4030_test_store(struct device *dev,
-		 struct device_attribute *attr, const char *buf, size_t count)
-{
-	unsigned long tmp;
-
-	struct twl4030_usb *twl = dev_get_drvdata(dev);
-
-	mutex_lock(&twl->lock);
-	sscanf(buf, "%lX", &tmp);
-	printk("TWL HACK: tmp = 0x%lX\n", tmp);
-	mutex_unlock(&twl->lock);
-
-	if (tmp == 0xdead) {
-		printk("TWL HACK: killing hardware\n");
-		printk("TWL HACK: killing hardware = %d\n", twl4030_shutdown(twl));
-	}
-	
-	return strnlen(buf, count);
-}
-
-static DEVICE_ATTR(test, 0664, twl4030_test_show, twl4030_test_store);
-
 static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	struct twl4030_usb *twl = _twl;
-	enum musb_vbus_id_status status;
+	enum omap_musb_vbus_id_status status;
 	bool status_changed = false;
 
 	status = twl4030_usb_linkstat(twl);
@@ -604,11 +567,11 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 			pm_runtime_mark_last_busy(twl->dev);
 			pm_runtime_put_autosuspend(twl->dev);
 		}
-		musb_mailbox(status);
+		omap_musb_mailbox(status);
 	}
 
 	/* don't schedule during sleep - irq works right then */
-	if (status == MUSB_ID_GROUND && pm_runtime_active(twl->dev)) {
+	if (status == OMAP_MUSB_ID_GROUND && pm_runtime_active(twl->dev)) {
 		cancel_delayed_work(&twl->id_workaround_work);
 		schedule_delayed_work(&twl->id_workaround_work, HZ);
 	}
@@ -707,7 +670,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	twl->dev		= &pdev->dev;
 	twl->irq		= platform_get_irq(pdev, 0);
 	twl->vbus_supplied	= false;
-	twl->linkstat		= MUSB_UNKNOWN;
+	twl->linkstat		= OMAP_MUSB_UNKNOWN;
 
 	twl->phy.dev		= twl->dev;
 	twl->phy.label		= "twl4030";
@@ -747,15 +710,11 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	if (device_create_file(&pdev->dev, &dev_attr_vbus))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
-	if (device_create_file(&pdev->dev, &dev_attr_test))
-		dev_warn(&pdev->dev, "could not create sysfs file #2\n");
-	
 	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
 
 	/* Our job is to use irqs and status from the power module
 	 * to keep the transceiver disabled when nothing's connected.
@@ -775,7 +734,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	}
 
 	if (pdata)
-		err = phy_create_lookup(phy, "usb", "musb-hdrc.0");
+		err = phy_create_lookup(phy, "usb", "musb-hdrc.0.auto");
 	if (err)
 		return err;
 
@@ -786,24 +745,18 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int twl4030_shutdown(struct twl4030_usb *twl)
+static int twl4030_usb_remove(struct platform_device *pdev)
 {
+	struct twl4030_usb *twl = platform_get_drvdata(pdev);
 	int val;
 
-	usb_remove_phy(&twl->phy);
 	pm_runtime_get_sync(twl->dev);
 	cancel_delayed_work(&twl->id_workaround_work);
+	device_remove_file(twl->dev, &dev_attr_vbus);
 
 	/* set transceiver mode to power on defaults */
 	twl4030_usb_set_mode(twl, -1);
 
-	/* idle ulpi before powering off */
-	if (cable_present(twl->linkstat))
-	pm_runtime_put_noidle(twl->dev);
-	pm_runtime_mark_last_busy(twl->dev);
-	pm_runtime_put_sync_suspend(twl->dev);
-	pm_runtime_disable(twl->dev);
-
 	/* autogate 60MHz ULPI clock,
 	 * clear dpll clock request for i2c access,
 	 * disable 32KHz
@@ -818,18 +771,12 @@ static int twl4030_shutdown(struct twl4030_usb *twl)
 	/* disable complete OTG block */
 	twl4030_usb_clear_bits(twl, POWER_CTRL, POWER_CTRL_OTG_ENAB);
 
-	return 0;
-}
-
-
-static int twl4030_usb_remove(struct platform_device *pdev)
-{
-	struct twl4030_usb *twl = platform_get_drvdata(pdev);
+	if (cable_present(twl->linkstat))
+		pm_runtime_put_noidle(twl->dev);
+	pm_runtime_mark_last_busy(twl->dev);
+	pm_runtime_put(twl->dev);
 
-	device_remove_file(twl->dev, &dev_attr_vbus);
-	device_remove_file(twl->dev, &dev_attr_test);
-	
-	return twl4030_shutdown(twl);
+	return 0;
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index bf90753..5c0adb9 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -269,7 +269,6 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	}
 
 	dwc3_data->dr_mode = usb_get_dr_mode(&child_pdev->dev);
-	of_node_put(child);	
 
 	/*
 	 * Configure the USB port as device or host according to the static
diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 4589621..f660afb 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -546,11 +546,14 @@ out:
 }
 EXPORT_SYMBOL_GPL(usb_udc_attach_driver);
 
-int __usb_gadget_probe_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 {
 	struct usb_udc		*udc = NULL;
 	int			ret;
 
+	if (!driver || !driver->bind || !driver->setup)
+		return -EINVAL;
+
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list) {
 		/* For now we take the first one */
@@ -558,6 +561,7 @@ int __usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 			goto found;
 	}
 
+	pr_debug("couldn't find an available UDC\n");
 	mutex_unlock(&udc_lock);
 	return -ENODEV;
 found:
@@ -565,36 +569,6 @@ found:
 	mutex_unlock(&udc_lock);
 	return ret;
 }
-
-#define USB_GADGET_BIND_RETRIES		5
-#define USB_GADGET_BIND_TIMEOUT		(3 * HZ)
-static void usb_gadget_work(struct work_struct *work)
-{
-	struct usb_gadget_driver *driver = container_of(work,
-						struct usb_gadget_driver,
-						work.work);
-	int res;
-	
-	if (driver->retries++ > USB_GADGET_BIND_RETRIES) {
-		pr_err("couldn't find an available UDC\n");
-		return;
-	}
-
-	res = __usb_gadget_probe_driver(driver);
-	if (res == -ENODEV)
-		schedule_delayed_work(&driver->work, USB_GADGET_BIND_TIMEOUT);
-}
-
-int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
-{
-	if (!driver || !driver->bind || !driver->setup)
-		return -EINVAL;
-
-	INIT_DELAYED_WORK(&driver->work, usb_gadget_work);
-	schedule_delayed_work(&driver->work, 0);
-
-	return 0;
-}
 EXPORT_SYMBOL_GPL(usb_gadget_probe_driver);
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
@@ -605,8 +579,6 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	if (!driver || !driver->unbind)
 		return -EINVAL;
 
-	cancel_delayed_work(&driver->work);
-
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list)
 		if (udc->driver == driver) {
@@ -763,7 +735,7 @@ static int __init usb_udc_init(void)
 	udc_class->dev_uevent = usb_udc_uevent;
 	return 0;
 }
-late_initcall_sync(usb_udc_init);
+subsys_initcall(usb_udc_init);
 
 static void __exit usb_udc_exit(void)
 {
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index dd120ec..ee9ff70 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1705,23 +1705,6 @@ EXPORT_SYMBOL_GPL(musb_dma_completion);
 #define use_dma			0
 #endif
 
-static void (*musb_phy_callback)(enum musb_vbus_id_status status);
-
-/*
- * musb_mailbox - optional phy notifier function
- * @status phy state change
- *
- * Optionally gets called from the USB PHY. Note that the USB PHY must be
- * disabled at the point the phy_callback is registered or unregistered.
- */
-void musb_mailbox(enum musb_vbus_id_status status)
-{
-	if (musb_phy_callback)
-		musb_phy_callback(status);
-
-};
-EXPORT_SYMBOL_GPL(musb_mailbox);
-
 /*-------------------------------------------------------------------------*/
 
 static ssize_t
@@ -2134,9 +2117,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		musb->xceiv->io_ops = &musb_ulpi_access;
 	}
 
-	if (musb->ops->phy_callback)
-		musb_phy_callback = musb->ops->phy_callback;
-
 	pm_runtime_get_sync(musb->controller);
 
 	if (use_dma && dev->dma_mask) {
@@ -2315,7 +2295,6 @@ static int musb_remove(struct platform_device *pdev)
 	 */
 	musb_exit_debugfs(musb);
 	musb_shutdown(pdev);
-	musb_phy_callback = NULL;
 
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index fd215fb..2337d7a 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -168,7 +168,6 @@ struct musb_io;
  * @adjust_channel_params: pre check for standard dma channel_program func
  * @pre_root_reset_end: called before the root usb port reset flag gets cleared
  * @post_root_reset_end: called after the root usb port reset flag gets cleared
- * @phy_callback: optional callback function for the phy to call
  */
 struct musb_platform_ops {
 
@@ -215,7 +214,6 @@ struct musb_platform_ops {
 				dma_addr_t *dma_addr, u32 *len);
 	void	(*pre_root_reset_end)(struct musb *musb);
 	void	(*post_root_reset_end)(struct musb *musb);
-	void	(*phy_callback)(enum musb_vbus_id_status status);
 };
 
 /*
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index c84e0322..1bd9232 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -36,7 +36,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/usb/musb.h>
+#include <linux/usb/musb-omap.h>
 #include <linux/phy/omap_control_phy.h>
 #include <linux/of_platform.h>
 
@@ -46,7 +46,7 @@
 struct omap2430_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
-	enum musb_vbus_id_status status;
+	enum omap_musb_vbus_id_status status;
 	struct work_struct	omap_musb_mailbox_work;
 	struct device		*control_otghs;
 };
@@ -234,7 +234,7 @@ static inline void omap2430_low_level_init(struct musb *musb)
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 }
 
-static void omap2430_musb_mailbox(enum musb_vbus_id_status status)
+void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
 {
 	struct omap2430_glue	*glue = _glue;
 
@@ -251,6 +251,7 @@ static void omap2430_musb_mailbox(enum musb_vbus_id_status status)
 
 	schedule_work(&glue->omap_musb_mailbox_work);
 }
+EXPORT_SYMBOL_GPL(omap_musb_mailbox);
 
 static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 {
@@ -261,7 +262,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 	struct usb_otg *otg = musb->xceiv->otg;
 
 	switch (glue->status) {
-	case MUSB_ID_GROUND:
+	case OMAP_MUSB_ID_GROUND:
 		dev_dbg(dev, "ID GND\n");
 
 		otg->default_a = true;
@@ -275,7 +276,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		}
 		break;
 
-	case MUSB_VBUS_VALID:
+	case OMAP_MUSB_VBUS_VALID:
 		dev_dbg(dev, "VBUS Connect\n");
 
 		otg->default_a = false;
@@ -286,8 +287,8 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_DEVICE);
 		break;
 
-	case MUSB_ID_FLOAT:
-	case MUSB_VBUS_OFF:
+	case OMAP_MUSB_ID_FLOAT:
+	case OMAP_MUSB_VBUS_OFF:
 		dev_dbg(dev, "VBUS Disconnect\n");
 
 		musb->xceiv->last_event = USB_EVENT_NONE;
@@ -429,7 +430,7 @@ static int omap2430_musb_init(struct musb *musb)
 
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
-	if (glue->status != MUSB_UNKNOWN)
+	if (glue->status != OMAP_MUSB_UNKNOWN)
 		omap_musb_set_mailbox(glue);
 
 	phy_init(musb->phy);
@@ -454,7 +455,7 @@ static void omap2430_musb_enable(struct musb *musb)
 
 	switch (glue->status) {
 
-	case MUSB_ID_GROUND:
+	case OMAP_MUSB_ID_GROUND:
 		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_HOST);
 		if (data->interface_type != MUSB_INTERFACE_UTMI)
 			break;
@@ -473,7 +474,7 @@ static void omap2430_musb_enable(struct musb *musb)
 		}
 		break;
 
-	case MUSB_VBUS_VALID:
+	case OMAP_MUSB_VBUS_VALID:
 		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_DEVICE);
 		break;
 
@@ -487,7 +488,7 @@ static void omap2430_musb_disable(struct musb *musb)
 	struct device *dev = musb->controller;
 	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
 
-	if (glue->status != MUSB_UNKNOWN)
+	if (glue->status != OMAP_MUSB_UNKNOWN)
 		omap_control_usb_set_mode(glue->control_otghs,
 			USB_MODE_DISCONNECT);
 }
@@ -519,8 +520,6 @@ static const struct musb_platform_ops omap2430_ops = {
 
 	.enable		= omap2430_musb_enable,
 	.disable	= omap2430_musb_disable,
-
-	.phy_callback	= omap2430_musb_mailbox,
 };
 
 static u64 omap2430_dmamask = DMA_BIT_MASK(32);
@@ -552,7 +551,7 @@ static int omap2430_probe(struct platform_device *pdev)
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
-	glue->status			= MUSB_UNKNOWN;
+	glue->status			= OMAP_MUSB_UNKNOWN;
 	glue->control_otghs = ERR_PTR(-ENODEV);
 
 	if (np) {
@@ -664,11 +663,8 @@ static int omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue		*glue = platform_get_drvdata(pdev);
 
-	pm_runtime_get_sync(glue->dev);
 	cancel_work_sync(&glue->omap_musb_mailbox_work);
 	platform_device_unregister(glue->musb);
-	pm_runtime_put_sync(glue->dev);
-	pm_runtime_disable(glue->dev);
 
 	return 0;
 }
diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index 014dbbd7..1274185 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -25,7 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/usb/musb.h>
+#include <linux/usb/musb-omap.h>
 #include <linux/usb/phy_companion.h>
 #include <linux/phy/omap_usb.h>
 #include <linux/i2c/twl.h>
@@ -102,7 +102,7 @@ struct twl6030_usb {
 
 	int			irq1;
 	int			irq2;
-	enum musb_vbus_id_status linkstat;
+	enum omap_musb_vbus_id_status linkstat;
 	u8			asleep;
 	bool			vbus_enable;
 	const char		*regulator;
@@ -189,13 +189,13 @@ static ssize_t twl6030_usb_vbus_show(struct device *dev,
 	spin_lock_irqsave(&twl->lock, flags);
 
 	switch (twl->linkstat) {
-	case MUSB_VBUS_VALID:
+	case OMAP_MUSB_VBUS_VALID:
 	       ret = snprintf(buf, PAGE_SIZE, "vbus\n");
 	       break;
-	case MUSB_ID_GROUND:
+	case OMAP_MUSB_ID_GROUND:
 	       ret = snprintf(buf, PAGE_SIZE, "id\n");
 	       break;
-	case MUSB_VBUS_OFF:
+	case OMAP_MUSB_VBUS_OFF:
 	       ret = snprintf(buf, PAGE_SIZE, "none\n");
 	       break;
 	default:
@@ -210,7 +210,7 @@ static DEVICE_ATTR(vbus, 0444, twl6030_usb_vbus_show, NULL);
 static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 {
 	struct twl6030_usb *twl = _twl;
-	enum musb_vbus_id_status status = MUSB_UNKNOWN;
+	enum omap_musb_vbus_id_status status = OMAP_MUSB_UNKNOWN;
 	u8 vbus_state, hw_state;
 	int ret;
 
@@ -225,14 +225,14 @@ static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 				dev_err(twl->dev, "Failed to enable usb3v3\n");
 
 			twl->asleep = 1;
-			status = MUSB_VBUS_VALID;
+			status = OMAP_MUSB_VBUS_VALID;
 			twl->linkstat = status;
-			musb_mailbox(status);
+			omap_musb_mailbox(status);
 		} else {
-			if (twl->linkstat != MUSB_UNKNOWN) {
-				status = MUSB_VBUS_OFF;
+			if (twl->linkstat != OMAP_MUSB_UNKNOWN) {
+				status = OMAP_MUSB_VBUS_OFF;
 				twl->linkstat = status;
-				musb_mailbox(status);
+				omap_musb_mailbox(status);
 				if (twl->asleep) {
 					regulator_disable(twl->usb3v3);
 					twl->asleep = 0;
@@ -248,7 +248,7 @@ static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
 {
 	struct twl6030_usb *twl = _twl;
-	enum musb_vbus_id_status status = MUSB_UNKNOWN;
+	enum omap_musb_vbus_id_status status = OMAP_MUSB_UNKNOWN;
 	u8 hw_state;
 	int ret;
 
@@ -262,9 +262,9 @@ static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
 		twl->asleep = 1;
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x1, USB_ID_INT_EN_HI_CLR);
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x10, USB_ID_INT_EN_HI_SET);
-		status = MUSB_ID_GROUND;
+		status = OMAP_MUSB_ID_GROUND;
 		twl->linkstat = status;
-		musb_mailbox(status);
+		omap_musb_mailbox(status);
 	} else  {
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x10, USB_ID_INT_EN_HI_CLR);
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x1, USB_ID_INT_EN_HI_SET);
@@ -334,7 +334,7 @@ static int twl6030_usb_probe(struct platform_device *pdev)
 	twl->dev		= &pdev->dev;
 	twl->irq1		= platform_get_irq(pdev, 0);
 	twl->irq2		= platform_get_irq(pdev, 1);
-	twl->linkstat		= MUSB_UNKNOWN;
+	twl->linkstat		= OMAP_MUSB_UNKNOWN;
 
 	twl->comparator.set_vbus	= twl6030_set_vbus;
 	twl->comparator.start_srp	= twl6030_start_srp;
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e5af629..3d583a1 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1011,8 +1011,6 @@ static inline int usb_gadget_activate(struct usb_gadget *gadget)
  * @resume: Invoked on USB resume.  May be called in_interrupt.
  * @reset: Invoked on USB bus reset. It is mandatory for all gadget drivers
  *	and should be called in_interrupt.
- * @work: Gadget work used to bind to the USB controller.
- * @retries: Gadget retries to bind to the USB controller.
  * @driver: Driver model state for this driver.
  *
  * Devices are disabled till a gadget driver successfully bind()s, which
@@ -1071,8 +1069,6 @@ struct usb_gadget_driver {
 	void			(*suspend)(struct usb_gadget *);
 	void			(*resume)(struct usb_gadget *);
 	void			(*reset)(struct usb_gadget *);
-	struct delayed_work	work;
-	int			retries;
 
 	/* FIXME support safe rmmod */
 	struct device_driver	driver;
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index 96ddfb7..fa6dc13 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -133,21 +133,6 @@ struct musb_hdrc_platform_data {
 	const void	*platform_ops;
 };
 
-enum musb_vbus_id_status {
-	MUSB_UNKNOWN = 0,
-	MUSB_ID_GROUND,
-	MUSB_ID_FLOAT,
-	MUSB_VBUS_VALID,
-	MUSB_VBUS_OFF,
-};
-
-#if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
-void musb_mailbox(enum musb_vbus_id_status status);
-#else
-static inline void musb_mailbox(enum musb_vbus_id_status status)
-{
-}
-#endif
 
 /* TUSB 6010 support */
 




diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 9708cf5..ce18f57 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -34,7 +34,7 @@
 #include <linux/usb/otg.h>
 #include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
-#include <linux/usb/musb.h>
+#include <linux/usb/musb-omap.h>
 #include <linux/usb/ulpi.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/consumer.h>
@@ -148,10 +148,10 @@
  * If VBUS is valid or ID is ground, then we know a
  * cable is present and we need to be runtime-enabled
  */
-static inline bool cable_present(enum musb_vbus_id_status stat)
+static inline bool cable_present(enum omap_musb_vbus_id_status stat)
 {
-	return stat == MUSB_VBUS_VALID ||
-		stat == MUSB_ID_GROUND;
+	return stat == OMAP_MUSB_VBUS_VALID ||
+		stat == OMAP_MUSB_ID_GROUND;
 }
 
 struct twl4030_usb {
@@ -170,7 +170,7 @@ struct twl4030_usb {
 	enum twl4030_usb_mode	usb_mode;
 
 	int			irq;
-	enum musb_vbus_id_status linkstat;
+	enum omap_musb_vbus_id_status linkstat;
 	bool			vbus_supplied;
 
 	struct delayed_work	id_workaround_work;
@@ -276,11 +276,11 @@ static bool twl4030_is_driving_vbus(struct twl4030_usb *twl)
 	return (ret & (ULPI_OTG_DRVVBUS | ULPI_OTG_CHRGVBUS)) ? true : false;
 }
 
-static enum musb_vbus_id_status
+static enum omap_musb_vbus_id_status
 	twl4030_usb_linkstat(struct twl4030_usb *twl)
 {
 	int	status;
-	enum musb_vbus_id_status linkstat = MUSB_UNKNOWN;
+	enum omap_musb_vbus_id_status linkstat = OMAP_MUSB_UNKNOWN;
 
 	twl->vbus_supplied = false;
 
@@ -306,14 +306,14 @@ static enum musb_vbus_id_status
 		}
 
 		if (status & BIT(2))
-			linkstat = MUSB_ID_GROUND;
+			linkstat = OMAP_MUSB_ID_GROUND;
 		else if (status & BIT(7))
-			linkstat = MUSB_VBUS_VALID;
+			linkstat = OMAP_MUSB_VBUS_VALID;
 		else
-			linkstat = MUSB_VBUS_OFF;
+			linkstat = OMAP_MUSB_VBUS_OFF;
 	} else {
-		if (twl->linkstat != MUSB_UNKNOWN)
-			linkstat = MUSB_VBUS_OFF;
+		if (twl->linkstat != OMAP_MUSB_UNKNOWN)
+			linkstat = OMAP_MUSB_VBUS_OFF;
 	}
 
 	dev_dbg(twl->dev, "HW_CONDITIONS 0x%02x/%d; link %d\n",
@@ -532,47 +532,10 @@ static ssize_t twl4030_usb_vbus_show(struct device *dev,
 }
 static DEVICE_ATTR(vbus, 0444, twl4030_usb_vbus_show, NULL);
 
-static ssize_t twl4030_test_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct twl4030_usb *twl = dev_get_drvdata(dev);
-	int ret = -EINVAL;
-
-	mutex_lock(&twl->lock);
-	ret = sprintf(buf, "%s\n", "hello, world");
-	mutex_unlock(&twl->lock);
-
-	return ret;
-}
-
-static int twl4030_shutdown(struct twl4030_usb *twl);
-
-static ssize_t twl4030_test_store(struct device *dev,
-		 struct device_attribute *attr, const char *buf, size_t count)
-{
-	unsigned long tmp;
-
-	struct twl4030_usb *twl = dev_get_drvdata(dev);
-
-	mutex_lock(&twl->lock);
-	sscanf(buf, "%lX", &tmp);
-	printk("TWL HACK: tmp = 0x%lX\n", tmp);
-	mutex_unlock(&twl->lock);
-
-	if (tmp == 0xdead) {
-		printk("TWL HACK: killing hardware\n");
-		printk("TWL HACK: killing hardware = %d\n", twl4030_shutdown(twl));
-	}
-	
-	return strnlen(buf, count);
-}
-
-static DEVICE_ATTR(test, 0664, twl4030_test_show, twl4030_test_store);
-
 static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	struct twl4030_usb *twl = _twl;
-	enum musb_vbus_id_status status;
+	enum omap_musb_vbus_id_status status;
 	bool status_changed = false;
 
 	status = twl4030_usb_linkstat(twl);
@@ -604,11 +567,11 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 			pm_runtime_mark_last_busy(twl->dev);
 			pm_runtime_put_autosuspend(twl->dev);
 		}
-		musb_mailbox(status);
+		omap_musb_mailbox(status);
 	}
 
 	/* don't schedule during sleep - irq works right then */
-	if (status == MUSB_ID_GROUND && pm_runtime_active(twl->dev)) {
+	if (status == OMAP_MUSB_ID_GROUND && pm_runtime_active(twl->dev)) {
 		cancel_delayed_work(&twl->id_workaround_work);
 		schedule_delayed_work(&twl->id_workaround_work, HZ);
 	}
@@ -707,7 +670,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	twl->dev		= &pdev->dev;
 	twl->irq		= platform_get_irq(pdev, 0);
 	twl->vbus_supplied	= false;
-	twl->linkstat		= MUSB_UNKNOWN;
+	twl->linkstat		= OMAP_MUSB_UNKNOWN;
 
 	twl->phy.dev		= twl->dev;
 	twl->phy.label		= "twl4030";
@@ -747,15 +710,11 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	if (device_create_file(&pdev->dev, &dev_attr_vbus))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
-	if (device_create_file(&pdev->dev, &dev_attr_test))
-		dev_warn(&pdev->dev, "could not create sysfs file #2\n");
-	
 	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
 
 	/* Our job is to use irqs and status from the power module
 	 * to keep the transceiver disabled when nothing's connected.
@@ -775,7 +734,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	}
 
 	if (pdata)
-		err = phy_create_lookup(phy, "usb", "musb-hdrc.0");
+		err = phy_create_lookup(phy, "usb", "musb-hdrc.0.auto");
 	if (err)
 		return err;
 
@@ -786,24 +745,18 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int twl4030_shutdown(struct twl4030_usb *twl)
+static int twl4030_usb_remove(struct platform_device *pdev)
 {
+	struct twl4030_usb *twl = platform_get_drvdata(pdev);
 	int val;
 
-	usb_remove_phy(&twl->phy);
 	pm_runtime_get_sync(twl->dev);
 	cancel_delayed_work(&twl->id_workaround_work);
+	device_remove_file(twl->dev, &dev_attr_vbus);
 
 	/* set transceiver mode to power on defaults */
 	twl4030_usb_set_mode(twl, -1);
 
-	/* idle ulpi before powering off */
-	if (cable_present(twl->linkstat))
-	pm_runtime_put_noidle(twl->dev);
-	pm_runtime_mark_last_busy(twl->dev);
-	pm_runtime_put_sync_suspend(twl->dev);
-	pm_runtime_disable(twl->dev);
-
 	/* autogate 60MHz ULPI clock,
 	 * clear dpll clock request for i2c access,
 	 * disable 32KHz
@@ -818,18 +771,12 @@ static int twl4030_shutdown(struct twl4030_usb *twl)
 	/* disable complete OTG block */
 	twl4030_usb_clear_bits(twl, POWER_CTRL, POWER_CTRL_OTG_ENAB);
 
-	return 0;
-}
-
-
-static int twl4030_usb_remove(struct platform_device *pdev)
-{
-	struct twl4030_usb *twl = platform_get_drvdata(pdev);
+	if (cable_present(twl->linkstat))
+		pm_runtime_put_noidle(twl->dev);
+	pm_runtime_mark_last_busy(twl->dev);
+	pm_runtime_put(twl->dev);
 
-	device_remove_file(twl->dev, &dev_attr_vbus);
-	device_remove_file(twl->dev, &dev_attr_test);
-	
-	return twl4030_shutdown(twl);
+	return 0;
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index bf90753..5c0adb9 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -269,7 +269,6 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	}
 
 	dwc3_data->dr_mode = usb_get_dr_mode(&child_pdev->dev);
-	of_node_put(child);	
 
 	/*
 	 * Configure the USB port as device or host according to the static
diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 4589621..f660afb 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -546,11 +546,14 @@ out:
 }
 EXPORT_SYMBOL_GPL(usb_udc_attach_driver);
 
-int __usb_gadget_probe_driver(struct usb_gadget_driver *driver)
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 {
 	struct usb_udc		*udc = NULL;
 	int			ret;
 
+	if (!driver || !driver->bind || !driver->setup)
+		return -EINVAL;
+
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list) {
 		/* For now we take the first one */
@@ -558,6 +561,7 @@ int __usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 			goto found;
 	}
 
+	pr_debug("couldn't find an available UDC\n");
 	mutex_unlock(&udc_lock);
 	return -ENODEV;
 found:
@@ -565,36 +569,6 @@ found:
 	mutex_unlock(&udc_lock);
 	return ret;
 }
-
-#define USB_GADGET_BIND_RETRIES		5
-#define USB_GADGET_BIND_TIMEOUT		(3 * HZ)
-static void usb_gadget_work(struct work_struct *work)
-{
-	struct usb_gadget_driver *driver = container_of(work,
-						struct usb_gadget_driver,
-						work.work);
-	int res;
-	
-	if (driver->retries++ > USB_GADGET_BIND_RETRIES) {
-		pr_err("couldn't find an available UDC\n");
-		return;
-	}
-
-	res = __usb_gadget_probe_driver(driver);
-	if (res == -ENODEV)
-		schedule_delayed_work(&driver->work, USB_GADGET_BIND_TIMEOUT);
-}
-
-int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
-{
-	if (!driver || !driver->bind || !driver->setup)
-		return -EINVAL;
-
-	INIT_DELAYED_WORK(&driver->work, usb_gadget_work);
-	schedule_delayed_work(&driver->work, 0);
-
-	return 0;
-}
 EXPORT_SYMBOL_GPL(usb_gadget_probe_driver);
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
@@ -605,8 +579,6 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	if (!driver || !driver->unbind)
 		return -EINVAL;
 
-	cancel_delayed_work(&driver->work);
-
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list)
 		if (udc->driver == driver) {
@@ -763,7 +735,7 @@ static int __init usb_udc_init(void)
 	udc_class->dev_uevent = usb_udc_uevent;
 	return 0;
 }
-late_initcall_sync(usb_udc_init);
+subsys_initcall(usb_udc_init);
 
 static void __exit usb_udc_exit(void)
 {
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index dd120ec..ee9ff70 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1705,23 +1705,6 @@ EXPORT_SYMBOL_GPL(musb_dma_completion);
 #define use_dma			0
 #endif
 
-static void (*musb_phy_callback)(enum musb_vbus_id_status status);
-
-/*
- * musb_mailbox - optional phy notifier function
- * @status phy state change
- *
- * Optionally gets called from the USB PHY. Note that the USB PHY must be
- * disabled at the point the phy_callback is registered or unregistered.
- */
-void musb_mailbox(enum musb_vbus_id_status status)
-{
-	if (musb_phy_callback)
-		musb_phy_callback(status);
-
-};
-EXPORT_SYMBOL_GPL(musb_mailbox);
-
 /*-------------------------------------------------------------------------*/
 
 static ssize_t
@@ -2134,9 +2117,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		musb->xceiv->io_ops = &musb_ulpi_access;
 	}
 
-	if (musb->ops->phy_callback)
-		musb_phy_callback = musb->ops->phy_callback;
-
 	pm_runtime_get_sync(musb->controller);
 
 	if (use_dma && dev->dma_mask) {
@@ -2315,7 +2295,6 @@ static int musb_remove(struct platform_device *pdev)
 	 */
 	musb_exit_debugfs(musb);
 	musb_shutdown(pdev);
-	musb_phy_callback = NULL;
 
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index fd215fb..2337d7a 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -168,7 +168,6 @@ struct musb_io;
  * @adjust_channel_params: pre check for standard dma channel_program func
  * @pre_root_reset_end: called before the root usb port reset flag gets cleared
  * @post_root_reset_end: called after the root usb port reset flag gets cleared
- * @phy_callback: optional callback function for the phy to call
  */
 struct musb_platform_ops {
 
@@ -215,7 +214,6 @@ struct musb_platform_ops {
 				dma_addr_t *dma_addr, u32 *len);
 	void	(*pre_root_reset_end)(struct musb *musb);
 	void	(*post_root_reset_end)(struct musb *musb);
-	void	(*phy_callback)(enum musb_vbus_id_status status);
 };
 
 /*
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index c84e0322..1bd9232 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -36,7 +36,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/usb/musb.h>
+#include <linux/usb/musb-omap.h>
 #include <linux/phy/omap_control_phy.h>
 #include <linux/of_platform.h>
 
@@ -46,7 +46,7 @@
 struct omap2430_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
-	enum musb_vbus_id_status status;
+	enum omap_musb_vbus_id_status status;
 	struct work_struct	omap_musb_mailbox_work;
 	struct device		*control_otghs;
 };
@@ -234,7 +234,7 @@ static inline void omap2430_low_level_init(struct musb *musb)
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 }
 
-static void omap2430_musb_mailbox(enum musb_vbus_id_status status)
+void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
 {
 	struct omap2430_glue	*glue = _glue;
 
@@ -251,6 +251,7 @@ static void omap2430_musb_mailbox(enum musb_vbus_id_status status)
 
 	schedule_work(&glue->omap_musb_mailbox_work);
 }
+EXPORT_SYMBOL_GPL(omap_musb_mailbox);
 
 static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 {
@@ -261,7 +262,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 	struct usb_otg *otg = musb->xceiv->otg;
 
 	switch (glue->status) {
-	case MUSB_ID_GROUND:
+	case OMAP_MUSB_ID_GROUND:
 		dev_dbg(dev, "ID GND\n");
 
 		otg->default_a = true;
@@ -275,7 +276,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		}
 		break;
 
-	case MUSB_VBUS_VALID:
+	case OMAP_MUSB_VBUS_VALID:
 		dev_dbg(dev, "VBUS Connect\n");
 
 		otg->default_a = false;
@@ -286,8 +287,8 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_DEVICE);
 		break;
 
-	case MUSB_ID_FLOAT:
-	case MUSB_VBUS_OFF:
+	case OMAP_MUSB_ID_FLOAT:
+	case OMAP_MUSB_VBUS_OFF:
 		dev_dbg(dev, "VBUS Disconnect\n");
 
 		musb->xceiv->last_event = USB_EVENT_NONE;
@@ -429,7 +430,7 @@ static int omap2430_musb_init(struct musb *musb)
 
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
-	if (glue->status != MUSB_UNKNOWN)
+	if (glue->status != OMAP_MUSB_UNKNOWN)
 		omap_musb_set_mailbox(glue);
 
 	phy_init(musb->phy);
@@ -454,7 +455,7 @@ static void omap2430_musb_enable(struct musb *musb)
 
 	switch (glue->status) {
 
-	case MUSB_ID_GROUND:
+	case OMAP_MUSB_ID_GROUND:
 		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_HOST);
 		if (data->interface_type != MUSB_INTERFACE_UTMI)
 			break;
@@ -473,7 +474,7 @@ static void omap2430_musb_enable(struct musb *musb)
 		}
 		break;
 
-	case MUSB_VBUS_VALID:
+	case OMAP_MUSB_VBUS_VALID:
 		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_DEVICE);
 		break;
 
@@ -487,7 +488,7 @@ static void omap2430_musb_disable(struct musb *musb)
 	struct device *dev = musb->controller;
 	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
 
-	if (glue->status != MUSB_UNKNOWN)
+	if (glue->status != OMAP_MUSB_UNKNOWN)
 		omap_control_usb_set_mode(glue->control_otghs,
 			USB_MODE_DISCONNECT);
 }
@@ -519,8 +520,6 @@ static const struct musb_platform_ops omap2430_ops = {
 
 	.enable		= omap2430_musb_enable,
 	.disable	= omap2430_musb_disable,
-
-	.phy_callback	= omap2430_musb_mailbox,
 };
 
 static u64 omap2430_dmamask = DMA_BIT_MASK(32);
@@ -552,7 +551,7 @@ static int omap2430_probe(struct platform_device *pdev)
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
-	glue->status			= MUSB_UNKNOWN;
+	glue->status			= OMAP_MUSB_UNKNOWN;
 	glue->control_otghs = ERR_PTR(-ENODEV);
 
 	if (np) {
@@ -664,11 +663,8 @@ static int omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue		*glue = platform_get_drvdata(pdev);
 
-	pm_runtime_get_sync(glue->dev);
 	cancel_work_sync(&glue->omap_musb_mailbox_work);
 	platform_device_unregister(glue->musb);
-	pm_runtime_put_sync(glue->dev);
-	pm_runtime_disable(glue->dev);
 
 	return 0;
 }
diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index 014dbbd7..1274185 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -25,7 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/usb/musb.h>
+#include <linux/usb/musb-omap.h>
 #include <linux/usb/phy_companion.h>
 #include <linux/phy/omap_usb.h>
 #include <linux/i2c/twl.h>
@@ -102,7 +102,7 @@ struct twl6030_usb {
 
 	int			irq1;
 	int			irq2;
-	enum musb_vbus_id_status linkstat;
+	enum omap_musb_vbus_id_status linkstat;
 	u8			asleep;
 	bool			vbus_enable;
 	const char		*regulator;
@@ -189,13 +189,13 @@ static ssize_t twl6030_usb_vbus_show(struct device *dev,
 	spin_lock_irqsave(&twl->lock, flags);
 
 	switch (twl->linkstat) {
-	case MUSB_VBUS_VALID:
+	case OMAP_MUSB_VBUS_VALID:
 	       ret = snprintf(buf, PAGE_SIZE, "vbus\n");
 	       break;
-	case MUSB_ID_GROUND:
+	case OMAP_MUSB_ID_GROUND:
 	       ret = snprintf(buf, PAGE_SIZE, "id\n");
 	       break;
-	case MUSB_VBUS_OFF:
+	case OMAP_MUSB_VBUS_OFF:
 	       ret = snprintf(buf, PAGE_SIZE, "none\n");
 	       break;
 	default:
@@ -210,7 +210,7 @@ static DEVICE_ATTR(vbus, 0444, twl6030_usb_vbus_show, NULL);
 static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 {
 	struct twl6030_usb *twl = _twl;
-	enum musb_vbus_id_status status = MUSB_UNKNOWN;
+	enum omap_musb_vbus_id_status status = OMAP_MUSB_UNKNOWN;
 	u8 vbus_state, hw_state;
 	int ret;
 
@@ -225,14 +225,14 @@ static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 				dev_err(twl->dev, "Failed to enable usb3v3\n");
 
 			twl->asleep = 1;
-			status = MUSB_VBUS_VALID;
+			status = OMAP_MUSB_VBUS_VALID;
 			twl->linkstat = status;
-			musb_mailbox(status);
+			omap_musb_mailbox(status);
 		} else {
-			if (twl->linkstat != MUSB_UNKNOWN) {
-				status = MUSB_VBUS_OFF;
+			if (twl->linkstat != OMAP_MUSB_UNKNOWN) {
+				status = OMAP_MUSB_VBUS_OFF;
 				twl->linkstat = status;
-				musb_mailbox(status);
+				omap_musb_mailbox(status);
 				if (twl->asleep) {
 					regulator_disable(twl->usb3v3);
 					twl->asleep = 0;
@@ -248,7 +248,7 @@ static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
 static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
 {
 	struct twl6030_usb *twl = _twl;
-	enum musb_vbus_id_status status = MUSB_UNKNOWN;
+	enum omap_musb_vbus_id_status status = OMAP_MUSB_UNKNOWN;
 	u8 hw_state;
 	int ret;
 
@@ -262,9 +262,9 @@ static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
 		twl->asleep = 1;
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x1, USB_ID_INT_EN_HI_CLR);
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x10, USB_ID_INT_EN_HI_SET);
-		status = MUSB_ID_GROUND;
+		status = OMAP_MUSB_ID_GROUND;
 		twl->linkstat = status;
-		musb_mailbox(status);
+		omap_musb_mailbox(status);
 	} else  {
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x10, USB_ID_INT_EN_HI_CLR);
 		twl6030_writeb(twl, TWL_MODULE_USB, 0x1, USB_ID_INT_EN_HI_SET);
@@ -334,7 +334,7 @@ static int twl6030_usb_probe(struct platform_device *pdev)
 	twl->dev		= &pdev->dev;
 	twl->irq1		= platform_get_irq(pdev, 0);
 	twl->irq2		= platform_get_irq(pdev, 1);
-	twl->linkstat		= MUSB_UNKNOWN;
+	twl->linkstat		= OMAP_MUSB_UNKNOWN;
 
 	twl->comparator.set_vbus	= twl6030_set_vbus;
 	twl->comparator.start_srp	= twl6030_start_srp;
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e5af629..3d583a1 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1011,8 +1011,6 @@ static inline int usb_gadget_activate(struct usb_gadget *gadget)
  * @resume: Invoked on USB resume.  May be called in_interrupt.
  * @reset: Invoked on USB bus reset. It is mandatory for all gadget drivers
  *	and should be called in_interrupt.
- * @work: Gadget work used to bind to the USB controller.
- * @retries: Gadget retries to bind to the USB controller.
  * @driver: Driver model state for this driver.
  *
  * Devices are disabled till a gadget driver successfully bind()s, which
@@ -1071,8 +1069,6 @@ struct usb_gadget_driver {
 	void			(*suspend)(struct usb_gadget *);
 	void			(*resume)(struct usb_gadget *);
 	void			(*reset)(struct usb_gadget *);
-	struct delayed_work	work;
-	int			retries;
 
 	/* FIXME support safe rmmod */
 	struct device_driver	driver;
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index 96ddfb7..fa6dc13 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -133,21 +133,6 @@ struct musb_hdrc_platform_data {
 	const void	*platform_ops;
 };
 
-enum musb_vbus_id_status {
-	MUSB_UNKNOWN = 0,
-	MUSB_ID_GROUND,
-	MUSB_ID_FLOAT,
-	MUSB_VBUS_VALID,
-	MUSB_VBUS_OFF,
-};
-
-#if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
-void musb_mailbox(enum musb_vbus_id_status status);
-#else
-static inline void musb_mailbox(enum musb_vbus_id_status status)
-{
-}
-#endif
 
 /* TUSB 6010 support */
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
