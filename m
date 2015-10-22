From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: MUSB peripheral DMA regression caused by driver core runtime PM
 change
Date: Thu, 22 Oct 2015 11:02:16 -0700
Message-ID: <20151022180216.GT3078@atomide.com>
References: <20151021234134.GQ3078@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151021234134.GQ3078-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [151021 16:44]:
> Hi all,
> 
> I noticed a regresssino in v4.3-rc series to day with MUSB gadgets
> and DMA. Doing a git bisect between v4.2..v4.3-rc1 on it pointed to:
> 
> ddef08dd00f5 ("Driver core: wakeup the parent device before trying probe")
> 
> With the commit above reverted things work fine with DMA and USB gadgets.
> 
> This is on omap3 with CONFIG_USB_INVENTRA_DMA selected. Selecting
> CONFIG_MUSB_PIO_ONLY still works even without reverting ddef08dd00f5.
> 
> Anybody got ideas what might be wrong? Some wrong runtime PM usage
> under drivers/usb/musb?

Here's some more debug info on where things are different initializing
the USB gadgets. I added some printks and diffed the dmesg output. The
added calls from commit ddef08dd00f5 start with dd:


+dd __device_attach pm_runtime_put parent 480ab000.usb_otg_hs
+dd driver_probe_device pm_runtime_get_sync parent 0-0048
 twl4030_usb 48070000.i2c:twl@48:twl4030-usb: Initialized TWL4030 USB module
+dd driver_probe_device pm_runtime_put parent 0-0048
+dd __device_attach pm_runtime_get_sync parent 480ab000.usb_otg_hs
+dd driver_probe_device pm_runtime_get_sync parent 480ab000.usb_otg_hs
 musb musb-hdrc.0.auto _pm_runtime_get_sync
 musb musb-hdrc.0.auto _pm_runtime_get_sync
 musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
@@ -273,11 +695,24 @@
 usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
 usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb1: Product: MUSB HDRC host driver
-usb usb1: Manufacturer: Linux 4.3.0-rc6-00005-gb037ac9 musb-hcd
+usb usb1: Manufacturer: Linux 4.3.0-rc6-00005-g24b084c musb-hcd
 usb usb1: SerialNumber: musb-hdrc.0.auto
+dd __device_attach pm_runtime_get_sync parent musb-hdrc.0.auto
+dd driver_probe_device pm_runtime_get_sync parent musb-hdrc.0.auto
+dd __device_attach pm_runtime_get_sync parent usb1
+dd driver_probe_device pm_runtime_get_sync parent usb1
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 1 port detected
+dd driver_probe_device pm_runtime_put parent usb1
+dd __device_attach pm_runtime_put parent usb1
+dd driver_probe_device pm_runtime_put parent musb-hdrc.0.auto
+dd __device_attach pm_runtime_put parent musb-hdrc.0.auto
 musb musb-hdrc.0.auto _pm_runtime_put
+dd driver_probe_device pm_runtime_put parent 480ab000.usb_otg_hs
+dd __device_attach pm_runtime_put parent 480ab000.usb_otg_hs
 modprobe: module 'usb_core' not found
 userial_init: registered 4 ttyGS* devices
 Mass Storage Function, version: 2009/09/11

The musb driver is using autosuspend like Felipe pointed out offline,
so maybe that's where things go wrong with commit ddef08dd00f5?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
