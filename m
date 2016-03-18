From: Pavel Machek <pavel@ucw.cz>
Subject: Re: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
Date: Fri, 18 Mar 2016 21:20:41 +0100
Message-ID: <20160318202041.GA20196@amd>
References: <20160317212603.GA16651@amd>
 <CAB=otbSfj24nSUe1DyfVBDKD=trCp2-X-S-AcA1D+PTHZuP1Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAB=otbSfj24nSUe1DyfVBDKD=trCp2-X-S-AcA1D+PTHZuP1Bg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Peter Chen <peter.chen@freescale.com>, "Balbi, Felipe" <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> > USB gadget stops working for me on n900, if I merge
> 
> Could you please give us more details?
> Which gadget driver do you use (g_nokia?)

Ok, so I could get it to work with v4.5, and this patch. I'm including
my config, too. No, I don't think I'm using g_nokia.

Best regards,
								Pavel

diff --git a/.config b/.config
new file mode 100644
index 0000000..a504a94
--- /dev/null
+++ b/.config
...
+# CONFIG_USB_SWITCH_FSA9480 is not set
+# CONFIG_LATTICE_ECP3_CONFIG is not set
+# CONFIG_SRAM is not set
+# CONFIG_C2PORT is not set
+
+CONFIG_NET_VENDOR_WIZNET=y
+# CONFIG_WIZNET_W5100 is not set
+# CONFIG_WIZNET_W5300 is not set
+# CONFIG_PHYLIB is not set
+# CONFIG_MICREL_KS8995MA is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+CONFIG_USB_NET_DRIVERS=y
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_RTL8152 is not set
+# CONFIG_USB_LAN78XX is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_USB_IPHETH is not set
+CONFIG_WLAN=y
+# CONFIG_WLAN_VENDOR_ADMTEK is not set
+# CONFIG_WLAN_VENDOR_ATH is not set
+# CONFIG_WLAN_VENDOR_ATMEL is not set
+# CONFIG_WLAN_VENDOR_BROADCOM is not set
+# CONFIG_WLAN_VENDOR_CISCO is not set
+# CONFIG_WLAN_VENDOR_INTEL is not set
+# CONFIG_WLAN_VENDOR_INTERSIL is not set
+# CONFIG_WLAN_VENDOR_MARVELL is not set
+
+#
+# USB HID support
+#
+CONFIG_USB_HID=y
+# CONFIG_HID_PID is not set
+# CONFIG_USB_HIDDEV is not set
+
+#
+# I2C HID support
+#
+# CONFIG_I2C_HID is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_COMMON=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEFAULT_PERSIST=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_ULPI_BUS is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB_CBAF is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_XHCI_HCD is not set
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+# CONFIG_USB_FOTG210_HCD is not set
+# CONFIG_USB_MAX3421_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HCD_TEST_MODE is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
+#
+
+#
+# also be needed; see USB_STORAGE Help for more info
+#
+# CONFIG_USB_STORAGE is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+# CONFIG_USBIP_CORE is not set
+CONFIG_USB_MUSB_HDRC=y
+# CONFIG_USB_MUSB_HOST is not set
+CONFIG_USB_MUSB_GADGET=y
+# CONFIG_USB_MUSB_DUAL_ROLE is not set
+
+#
+# Platform Glue Layer
+#
+# CONFIG_USB_MUSB_TUSB6010 is not set
+CONFIG_USB_MUSB_OMAP2PLUS=y
+# CONFIG_USB_MUSB_AM35X is not set
+# CONFIG_USB_MUSB_DSPS is not set
+
+#
+# MUSB DMA mode
+#
+CONFIG_MUSB_PIO_ONLY=y
+# CONFIG_USB_DWC3 is not set
+# CONFIG_USB_DWC2 is not set
+# CONFIG_USB_CHIPIDEA is not set
+# CONFIG_USB_ISP1760 is not set
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
+
diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index b86a6f0..bee109f 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -542,14 +542,37 @@ err1:
 	return ret;
 }
 
-int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
+int usb_udc_attach_driver(const char *name, struct usb_gadget_driver *driver)
+{
+	struct usb_udc *udc = NULL;
+	int ret = -ENODEV;
+
+	mutex_lock(&udc_lock);
+	list_for_each_entry(udc, &udc_list, list) {
+		ret = strcmp(name, dev_name(&udc->dev));
+		if (!ret)
+			break;
+	}
+	if (ret) {
+		ret = -ENODEV;
+		goto out;
+	}
+	if (udc->driver) {
+		ret = -EBUSY;
+		goto out;
+	}
+	ret = udc_bind_to_driver(udc, driver);
+out:
+	mutex_unlock(&udc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_udc_attach_driver);
+
+int __usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 {
 	struct usb_udc		*udc = NULL;
 	int			ret = -ENODEV;
 
-	if (!driver || !driver->bind || !driver->setup)
-		return -EINVAL;
-
 	mutex_lock(&udc_lock);
 	if (driver->udc_name) {
 		list_for_each_entry(udc, &udc_list, list) {
@@ -567,16 +590,47 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 		}
 	}
 
-	list_add_tail(&driver->pending, &gadget_driver_pending_list);
+//	list_add_tail(&driver->pending, &gadget_driver_pending_list); FIXME
 	pr_info("udc-core: couldn't find an available UDC - added [%s] to list of pending drivers\n",
 		driver->function);
+
 	mutex_unlock(&udc_lock);
-	return 0;
+	return ret;
 found:
 	ret = udc_bind_to_driver(udc, driver);
 	mutex_unlock(&udc_lock);
 	return ret;
 }
+
+#define USB_GADGET_BIND_RETRIES		5
+#define USB_GADGET_BIND_TIMEOUT		(3 * HZ)
+static void usb_gadget_work(struct work_struct *work)
+{
+	struct usb_gadget_driver *driver = container_of(work,
+						struct usb_gadget_driver,
+						work.work);
+	int res;
+	
+	if (driver->retries++ > USB_GADGET_BIND_RETRIES) {
+		pr_err("couldn't find an available UDC\n");
+		return;
+	}
+
+	res = __usb_gadget_probe_driver(driver);
+	if (res == -ENODEV)
+		schedule_delayed_work(&driver->work, USB_GADGET_BIND_TIMEOUT);
+}
+
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
+{
+	if (!driver || !driver->bind || !driver->setup)
+		return -EINVAL;
+
+	INIT_DELAYED_WORK(&driver->work, usb_gadget_work);
+	schedule_delayed_work(&driver->work, 0);
+
+	return 0;
+}
 EXPORT_SYMBOL_GPL(usb_gadget_probe_driver);
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
@@ -587,6 +641,8 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	if (!driver || !driver->unbind)
 		return -EINVAL;
 
+	cancel_delayed_work(&driver->work);
+
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list)
 		if (udc->driver == driver) {
@@ -747,7 +803,7 @@ static int __init usb_udc_init(void)
 	udc_class->dev_uevent = usb_udc_uevent;
 	return 0;
 }
-subsys_initcall(usb_udc_init);
+late_initcall_sync(usb_udc_init);
 
 static void __exit usb_udc_exit(void)
 {
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index d82d006..adb1e68 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1014,6 +1014,8 @@ static inline int usb_gadget_activate(struct usb_gadget *gadget)
  * @resume: Invoked on USB resume.  May be called in_interrupt.
  * @reset: Invoked on USB bus reset. It is mandatory for all gadget drivers
  *	and should be called in_interrupt.
+ * @work: Gadget work used to bind to the USB controller.
+ * @retries: Gadget retries to bind to the USB controller.
  * @driver: Driver model state for this driver.
  * @udc_name: A name of UDC this driver should be bound to. If udc_name is NULL,
  *	this driver will be bound to any available UDC.
@@ -1075,6 +1077,8 @@ struct usb_gadget_driver {
 	void			(*suspend)(struct usb_gadget *);
 	void			(*resume)(struct usb_gadget *);
 	void			(*reset)(struct usb_gadget *);
+	struct delayed_work	work;
+	int			retries;
 
 	/* FIXME support safe rmmod */
 	struct device_driver	driver;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
