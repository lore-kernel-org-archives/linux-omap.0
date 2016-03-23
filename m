From: Pavel Machek <pavel@ucw.cz>
Subject: Re: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
Date: Wed, 23 Mar 2016 13:21:43 +0100
Message-ID: <20160323122143.GB32031@amd>
References: <20160317212603.GA16651@amd>
 <CAB=otbSfj24nSUe1DyfVBDKD=trCp2-X-S-AcA1D+PTHZuP1Bg@mail.gmail.com>
 <20160318202041.GA20196@amd>
 <56EFE057.7070106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EFE057.7070106@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Ruslan Bilovol <ruslan.bilovol@gmail.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Peter Chen <peter.chen@freescale.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon 2016-03-21 12:51:51, Marek Szyprowski wrote:
> Hi
> 
> On 2016-03-18 21:20, Pavel Machek wrote:
> >Hi!
> >
> >>>USB gadget stops working for me on n900, if I merge
> >>Could you please give us more details?
> >>Which gadget driver do you use (g_nokia?)
> >Ok, so I could get it to work with v4.5, and this patch. I'm including
> >my config, too. No, I don't think I'm using g_nokia.
> 
> This shows that there are some serious problems, probably with your udc
> driver, which doesn't handle deferred probe properly. Your patch workaround
> it by waiting some predefined time before registering gadget driver, however
> this is not the proper way. Please try to isolate what exactly is needed to
> get the gadget driver registered properly in your system or at least please
> provide some logs from the failed case.

Well, Ruslan said he has n900 available, so I provided requested
information.

This is the dmesg with the hack:

[    0.623138] of_get_named_gpiod_flags: parsed 'ti,power-gpio'
property of node '/ocp/spi@480ba00
0/wl1251@0[0]' - status (0)
[    0.623565] wl1251: ERROR vio regulator missing: -517
[    0.624359] musb probe HACK cf9a9e00
[    0.624420] musb probe HACK/2 cf9a9e00
[    0.624511] musb probe HACK/3 cf9a9e00
[    0.624755] HS USB OTG: no transceiver configured
[    0.624847] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed
with status -517
[    0.626525] mousedev: PS/2 mouse device common for all mice
...
[    2.877441] ieee80211 phy1: Selected rate control algorithm
'minstrel'
[    2.879882] wl1251: loaded
[    2.889617] wl1251: initialized
[    2.897521] Two musb controllers?  HACK
[    2.904968] musb probe HACK cf9a9e00
[    2.912048] musb probe HACK/2 cf9a9e00
[    2.918823] musb probe HACK/3 cf9a9e00
[    2.928985] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk
combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
[    2.929016] musb-hdrc: MHDRC RTL version 1.400
[    2.929046] musb-hdrc: setup fifo_mode 4
[    2.929077] musb-hdrc: 28/31 max ep, 16384/16384 memory
[    2.930511] tsc2005 spi1.0: GPIO lookup for consumer reset
[    2.930541] tsc2005 spi1.0: using device tree for GPIO lookup

In the kernel without the hack, there'll be only the first part of the
dmesg, AFAICT.

If there's an interest, I can repeat the test without the hack.

Thanks,
									Pavel


> >diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> >index b86a6f0..bee109f 100644
> >--- a/drivers/usb/gadget/udc/udc-core.c
> >+++ b/drivers/usb/gadget/udc/udc-core.c
> >@@ -542,14 +542,37 @@ err1:
> >  	return ret;
> >  }
> >-int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
> >+int usb_udc_attach_driver(const char *name, struct usb_gadget_driver *driver)
> >+{
> >+	struct usb_udc *udc = NULL;
> >+	int ret = -ENODEV;
> >+
> >+	mutex_lock(&udc_lock);
> >+	list_for_each_entry(udc, &udc_list, list) {
> >+		ret = strcmp(name, dev_name(&udc->dev));
> >+		if (!ret)
> >+			break;
> >+	}
> >+	if (ret) {
> >+		ret = -ENODEV;
> >+		goto out;
> >+	}
> >+	if (udc->driver) {
> >+		ret = -EBUSY;
> >+		goto out;
> >+	}
> >+	ret = udc_bind_to_driver(udc, driver);
> >+out:
> >+	mutex_unlock(&udc_lock);
> >+	return ret;
> >+}
> >+EXPORT_SYMBOL_GPL(usb_udc_attach_driver);
> >+
> >+int __usb_gadget_probe_driver(struct usb_gadget_driver *driver)
> >  {
> >  	struct usb_udc		*udc = NULL;
> >  	int			ret = -ENODEV;
> >-	if (!driver || !driver->bind || !driver->setup)
> >-		return -EINVAL;
> >-
> >  	mutex_lock(&udc_lock);
> >  	if (driver->udc_name) {
> >  		list_for_each_entry(udc, &udc_list, list) {
> >@@ -567,16 +590,47 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
> >  		}
> >  	}
> >-	list_add_tail(&driver->pending, &gadget_driver_pending_list);
> >+//	list_add_tail(&driver->pending, &gadget_driver_pending_list); FIXME
> >  	pr_info("udc-core: couldn't find an available UDC - added [%s] to list of pending drivers\n",
> >  		driver->function);
> >+
> >  	mutex_unlock(&udc_lock);
> >-	return 0;
> >+	return ret;
> >  found:
> >  	ret = udc_bind_to_driver(udc, driver);
> >  	mutex_unlock(&udc_lock);
> >  	return ret;
> >  }
> >+
> >+#define USB_GADGET_BIND_RETRIES		5
> >+#define USB_GADGET_BIND_TIMEOUT		(3 * HZ)
> >+static void usb_gadget_work(struct work_struct *work)
> >+{
> >+	struct usb_gadget_driver *driver = container_of(work,
> >+						struct usb_gadget_driver,
> >+						work.work);
> >+	int res;
> >+	
> >+	if (driver->retries++ > USB_GADGET_BIND_RETRIES) {
> >+		pr_err("couldn't find an available UDC\n");
> >+		return;
> >+	}
> >+
> >+	res = __usb_gadget_probe_driver(driver);
> >+	if (res == -ENODEV)
> >+		schedule_delayed_work(&driver->work, USB_GADGET_BIND_TIMEOUT);
> >+}
> >+
> >+int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
> >+{
> >+	if (!driver || !driver->bind || !driver->setup)
> >+		return -EINVAL;
> >+
> >+	INIT_DELAYED_WORK(&driver->work, usb_gadget_work);
> >+	schedule_delayed_work(&driver->work, 0);
> >+
> >+	return 0;
> >+}
> >  EXPORT_SYMBOL_GPL(usb_gadget_probe_driver);
> >  int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
> >@@ -587,6 +641,8 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
> >  	if (!driver || !driver->unbind)
> >  		return -EINVAL;
> >+	cancel_delayed_work(&driver->work);
> >+
> >  	mutex_lock(&udc_lock);
> >  	list_for_each_entry(udc, &udc_list, list)
> >  		if (udc->driver == driver) {
> >@@ -747,7 +803,7 @@ static int __init usb_udc_init(void)
> >  	udc_class->dev_uevent = usb_udc_uevent;
> >  	return 0;
> >  }
> >-subsys_initcall(usb_udc_init);
> >+late_initcall_sync(usb_udc_init);
> >  static void __exit usb_udc_exit(void)
> >  {
> >diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> >index d82d006..adb1e68 100644
> >--- a/include/linux/usb/gadget.h
> >+++ b/include/linux/usb/gadget.h
> >@@ -1014,6 +1014,8 @@ static inline int usb_gadget_activate(struct usb_gadget *gadget)
> >   * @resume: Invoked on USB resume.  May be called in_interrupt.
> >   * @reset: Invoked on USB bus reset. It is mandatory for all gadget drivers
> >   *	and should be called in_interrupt.
> >+ * @work: Gadget work used to bind to the USB controller.
> >+ * @retries: Gadget retries to bind to the USB controller.
> >   * @driver: Driver model state for this driver.
> >   * @udc_name: A name of UDC this driver should be bound to. If udc_name is NULL,
> >   *	this driver will be bound to any available UDC.
> >@@ -1075,6 +1077,8 @@ struct usb_gadget_driver {
> >  	void			(*suspend)(struct usb_gadget *);
> >  	void			(*resume)(struct usb_gadget *);
> >  	void			(*reset)(struct usb_gadget *);
> >+	struct delayed_work	work;
> >+	int			retries;
> >  	/* FIXME support safe rmmod */
> >  	struct device_driver	driver;
> >
> 
> Best regards

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
