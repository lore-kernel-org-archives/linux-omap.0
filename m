From: Tony Lindgren <tony@atomide.com>
Subject: Re: USB Ethernet gadget on Nokia n900
Date: Mon, 27 Oct 2014 15:31:14 -0700
Message-ID: <20141027223114.GU2560@atomide.com>
References: <20141019090107.GA19132@amd>
 <201410262222.39892@pali>
 <20141026215548.GA9004@amd>
 <201410262323.17891@pali>
 <20141027195209.GP2560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141027195209.GP2560@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [141027 12:55]:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [141026 15:24]:
> > On Sunday 26 October 2014 22:55:48 Pavel Machek wrote:
> > > > > I have root prepared on /dev/mmcblk0p6. I tried 3.17 with
> > > > > rx51_defconfig, but no, it refuses to mount it.
> > > > >=20
> > > > > VFS: Cannot open root device "mmcblk0p6" or ....: error
> > > > > -19.
> > > > >=20
> > > > > And then it proceeds to list mmcblk0p6 as one of available
> > > > > options
> > > > >=20
> > > > > :-(.
> > > > >=20
> > > > > Ideas welcome.
> > > >=20
> > > > Try to add rootdelay=3D30 or rootwait to kernel cmdline.
> > >=20
> > > I had rootdelay=3D3. Will try rootwait... no change. This is
> > > v3.17 with rx51_defconfig. CONFIG_MACH_NOKIA_RX51=3Dy =3D> device
> > > tree will not be used AFAICT.
> > >=20
> > > Now I'm back at 3.14 without device tree; same setup works
> > > there. I tried disabling RX51 support in 3.14 (to make it
> > > boot using device tree) but that did not work.
> > > 								Pavel
> >=20
> > I remember that there was some problem with initializing mmc=20
> > device. Sometimes something failed and reading from eMMC was not=20
> > possible. Try to boot kernel from uboot. Maybe it can help.
>=20
> Would be nice to have both the USB and the MMC issues sorted
> out in the mainline kernel naturally and get rid of any bootloader
> dependencies.
>=20
> I think the USB issue because usb_gadget_probe_driver() bails
> out with -ENODEV before the USB controller is found. Felipe, got
> any ideas how to fix this to work with -EPROBE_DEFER? Should this
> get called only from the USB controller probe?

Here's a patch that should fix the issues for built-in USB
gadgets.

Pavel, care to see if this gets NFSroot over USB working again
for you?

Regards,

Tony

8< ---------------------
=46rom: Tony Lindgren <tony@atomide.com>
Date: Mon, 27 Oct 2014 14:42:42 -0700
Subject: [PATCH] usb: gadget: Fix regressions for initializing built-in=
 gadgets

Up to v3.14 we used to have built-in gadgets work just fine
because they got initialized in the Makefile order and the
dependencies were taken care of by the platform init code.

With device tree based booting, nothing currently assures the
USB controller is initialized by the time the gadgets probe.
This is because we may have GPIOs and PHYs on I2C bus that
cause EPROBE_DEFER to happen for the USB controller.

As the gadgets are not currently bound to any device, they
get initialized with just an initcall.

Let's fix the issue by adding delayed work for the gadgets
to try binding to the USB controller driver. And while at it,
let's make the subsys_initcall() into a late_initcall_sync()
as the gadget won't be able to do anything on it's own early
anyways.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -440,13 +440,20 @@ out:
 }
 EXPORT_SYMBOL_GPL(udc_attach_driver);
=20
-int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
+#define USB_GADGET_BIND_RETRIES		5
+#define USB_GADGET_BIND_TIMEOUT		(3 * HZ)
+static void usb_gadget_work(struct work_struct *work)
 {
+	struct usb_gadget_driver *driver =3D container_of(work,
+						struct usb_gadget_driver,
+						work.work);
 	struct usb_udc		*udc =3D NULL;
 	int			ret;
=20
-	if (!driver || !driver->bind || !driver->setup)
-		return -EINVAL;
+	if (driver->retries++ > USB_GADGET_BIND_RETRIES) {
+		pr_err("couldn't find an available UDC\n");
+		return;
+	}
=20
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list) {
@@ -455,13 +462,24 @@ int usb_gadget_probe_driver(struct usb_gadget_dri=
ver *driver)
 			goto found;
 	}
=20
-	pr_debug("couldn't find an available UDC\n");
 	mutex_unlock(&udc_lock);
-	return -ENODEV;
+	schedule_delayed_work(&driver->work, USB_GADGET_BIND_TIMEOUT);
+	return;
+
 found:
 	ret =3D udc_bind_to_driver(udc, driver);
 	mutex_unlock(&udc_lock);
-	return ret;
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
 }
 EXPORT_SYMBOL_GPL(usb_gadget_probe_driver);
=20
@@ -473,6 +491,8 @@ int usb_gadget_unregister_driver(struct usb_gadget_=
driver *driver)
 	if (!driver || !driver->unbind)
 		return -EINVAL;
=20
+	cancel_delayed_work(&driver->work);
+
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list)
 		if (udc->driver =3D=3D driver) {
@@ -621,7 +641,7 @@ static int __init usb_udc_init(void)
 	udc_class->dev_uevent =3D usb_udc_uevent;
 	return 0;
 }
-subsys_initcall(usb_udc_init);
+late_initcall_sync(usb_udc_init);
=20
 static void __exit usb_udc_exit(void)
 {
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -819,6 +819,8 @@ static inline int usb_gadget_disconnect(struct usb_=
gadget *gadget)
  * @resume: Invoked on USB resume.  May be called in_interrupt.
  * @reset: Invoked on USB bus reset. It is mandatory for all gadget dr=
ivers
  *	and should be called in_interrupt.
+ * @work: Gadget work used to bind to the USB controller.
+ * @retries: Gadget retries to bind to the USB controller.
  * @driver: Driver model state for this driver.
  *
  * Devices are disabled till a gadget driver successfully bind()s, whi=
ch
@@ -877,6 +879,8 @@ struct usb_gadget_driver {
 	void			(*suspend)(struct usb_gadget *);
 	void			(*resume)(struct usb_gadget *);
 	void			(*reset)(struct usb_gadget *);
+	struct delayed_work	work;
+	int			retries;
=20
 	/* FIXME support safe rmmod */
 	struct device_driver	driver;
