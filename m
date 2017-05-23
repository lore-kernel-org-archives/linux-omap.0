From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 3/3] usb: host: ohci-omap3: Remove driver in favor of
 ohci-platform
Date: Tue, 23 May 2017 10:58:01 +0200
Message-ID: <20170523085801.cmpluek2byid4nli@earth>
References: <20170522160007.9264-1-tony@atomide.com>
 <20170522160007.9264-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ao4gtl2o5lhpihbc"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170522160007.9264-4-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--ao4gtl2o5lhpihbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 22, 2017 at 09:00:07AM -0700, Tony Lindgren wrote:
> This driver is no longer needed and can be removed. The reason why
> it's safe to remove this driver is that most omap devices don't have a
> USB low-speed or full-speed compatible PHY installed and configured
> with drivers/mfd/omap-usb-host.c. This means that devices like
> beagleboard and pandaboard need to use a high-speed USB hub in order
> to use devices like keyboard and mice.
>=20
> Currently the only known configured for a full-speed PHY is the
> mdm6600 modem on droid 4 and I've verified it works just fine with
> ohci-platform.
>=20
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

-- Sebastian

> ---
>  drivers/usb/host/Kconfig      |   6 +-
>  drivers/usb/host/Makefile     |   1 -
>  drivers/usb/host/ohci-omap3.c | 211 ------------------------------------=
------
>  3 files changed, 5 insertions(+), 213 deletions(-)
>  delete mode 100644 drivers/usb/host/ohci-omap3.c
>=20
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -473,8 +473,12 @@ config USB_OHCI_HCD_AT91
>  config USB_OHCI_HCD_OMAP3
>  	tristate "OHCI support for OMAP3 and later chips"
>  	depends on (ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5)
> +	select USB_OHCI_HCD_PLATFORM
>  	default y
> -	---help---
> +	help
> +	  This option is deprecated now and the driver was removed, use
> +	  USB_OHCI_HCD_PLATFORM instead.
> +
>  	  Enables support for the on-chip OHCI controller on
>  	  OMAP3 and later chips.
> =20
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -52,7 +52,6 @@ obj-$(CONFIG_USB_OHCI_HCD_PCI)	+=3D ohci-pci.o
>  obj-$(CONFIG_USB_OHCI_HCD_PLATFORM)	+=3D ohci-platform.o
>  obj-$(CONFIG_USB_OHCI_EXYNOS)	+=3D ohci-exynos.o
>  obj-$(CONFIG_USB_OHCI_HCD_OMAP1)	+=3D ohci-omap.o
> -obj-$(CONFIG_USB_OHCI_HCD_OMAP3)	+=3D ohci-omap3.o
>  obj-$(CONFIG_USB_OHCI_HCD_SPEAR)	+=3D ohci-spear.o
>  obj-$(CONFIG_USB_OHCI_HCD_STI)	+=3D ohci-st.o
>  obj-$(CONFIG_USB_OHCI_HCD_AT91)	+=3D ohci-at91.o
> diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
> deleted file mode 100644
> --- a/drivers/usb/host/ohci-omap3.c
> +++ /dev/null
> @@ -1,211 +0,0 @@
> -/*
> - * ohci-omap3.c - driver for OHCI on OMAP3 and later processors
> - *
> - * Bus Glue for OMAP3 USBHOST 3 port OHCI controller
> - * This controller is also used in later OMAPs and AM35x chips
> - *
> - * Copyright (C) 2007-2010 Texas Instruments, Inc.
> - * Author: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> - * Author: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> - * Author: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> - *
> - * Based on ehci-omap.c and some other ohci glue layers
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
USA
> - *
> - * TODO (last updated Feb 27, 2011):
> - *	- add kernel-doc
> - */
> -
> -#include <linux/dma-mapping.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/usb/otg.h>
> -#include <linux/platform_device.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/usb.h>
> -#include <linux/usb/hcd.h>
> -
> -#include "ohci.h"
> -
> -#define DRIVER_DESC "OHCI OMAP3 driver"
> -
> -static const char hcd_name[] =3D "ohci-omap3";
> -static struct hc_driver __read_mostly ohci_omap3_hc_driver;
> -
> -/*
> - * configure so an HC device and id are always provided
> - * always called with process context; sleeping is OK
> - */
> -
> -/**
> - * ohci_hcd_omap3_probe - initialize OMAP-based HCDs
> - *
> - * Allocates basic resources for this USB host controller, and
> - * then invokes the start() method for the HCD associated with it
> - * through the hotplug entry's driver_data.
> - */
> -static int ohci_hcd_omap3_probe(struct platform_device *pdev)
> -{
> -	struct device		*dev =3D &pdev->dev;
> -	struct ohci_hcd		*ohci;
> -	struct usb_hcd		*hcd =3D NULL;
> -	void __iomem		*regs =3D NULL;
> -	struct resource		*res;
> -	int			ret;
> -	int			irq;
> -
> -	if (usb_disabled())
> -		return -ENODEV;
> -
> -	if (!dev->parent) {
> -		dev_err(dev, "Missing parent device\n");
> -		return -ENODEV;
> -	}
> -
> -	irq =3D platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "OHCI irq failed\n");
> -		return -ENODEV;
> -	}
> -
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(dev, "UHH OHCI get resource failed\n");
> -		return -ENOMEM;
> -	}
> -
> -	regs =3D ioremap(res->start, resource_size(res));
> -	if (!regs) {
> -		dev_err(dev, "UHH OHCI ioremap failed\n");
> -		return -ENOMEM;
> -	}
> -
> -	/*
> -	 * Right now device-tree probed devices don't get dma_mask set.
> -	 * Since shared usb code relies on it, set it here for now.
> -	 * Once we have dma capability bindings this can go away.
> -	 */
> -	ret =3D dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		goto err_io;
> -
> -	ret =3D -ENODEV;
> -	hcd =3D usb_create_hcd(&ohci_omap3_hc_driver, dev,
> -			dev_name(dev));
> -	if (!hcd) {
> -		dev_err(dev, "usb_create_hcd failed\n");
> -		goto err_io;
> -	}
> -
> -	hcd->rsrc_start =3D res->start;
> -	hcd->rsrc_len =3D resource_size(res);
> -	hcd->regs =3D  regs;
> -
> -	pm_runtime_enable(dev);
> -	pm_runtime_get_sync(dev);
> -
> -	ohci =3D hcd_to_ohci(hcd);
> -	/*
> -	 * RemoteWakeupConnected has to be set explicitly before
> -	 * calling ohci_run. The reset value of RWC is 0.
> -	 */
> -	ohci->hc_control =3D OHCI_CTRL_RWC;
> -
> -	ret =3D usb_add_hcd(hcd, irq, 0);
> -	if (ret) {
> -		dev_dbg(dev, "failed to add hcd with err %d\n", ret);
> -		goto err_add_hcd;
> -	}
> -	device_wakeup_enable(hcd->self.controller);
> -
> -	return 0;
> -
> -err_add_hcd:
> -	pm_runtime_put_sync(dev);
> -	usb_put_hcd(hcd);
> -
> -err_io:
> -	iounmap(regs);
> -
> -	return ret;
> -}
> -
> -/*
> - * may be called without controller electrically present
> - * may be called with controller, bus, and devices active
> - */
> -
> -/**
> - * ohci_hcd_omap3_remove - shutdown processing for OHCI HCDs
> - * @pdev: USB Host Controller being removed
> - *
> - * Reverses the effect of ohci_hcd_omap3_probe(), first invoking
> - * the HCD's stop() method.  It is always called from a thread
> - * context, normally "rmmod", "apmd", or something similar.
> - */
> -static int ohci_hcd_omap3_remove(struct platform_device *pdev)
> -{
> -	struct device *dev	=3D &pdev->dev;
> -	struct usb_hcd *hcd	=3D dev_get_drvdata(dev);
> -
> -	iounmap(hcd->regs);
> -	usb_remove_hcd(hcd);
> -	pm_runtime_put_sync(dev);
> -	pm_runtime_disable(dev);
> -	usb_put_hcd(hcd);
> -	return 0;
> -}
> -
> -static const struct of_device_id omap_ohci_dt_ids[] =3D {
> -	{ .compatible =3D "ti,ohci-omap3" },
> -	{ }
> -};
> -
> -MODULE_DEVICE_TABLE(of, omap_ohci_dt_ids);
> -
> -static struct platform_driver ohci_hcd_omap3_driver =3D {
> -	.probe		=3D ohci_hcd_omap3_probe,
> -	.remove		=3D ohci_hcd_omap3_remove,
> -	.shutdown	=3D usb_hcd_platform_shutdown,
> -	.driver		=3D {
> -		.name	=3D "ohci-omap3",
> -		.of_match_table =3D omap_ohci_dt_ids,
> -	},
> -};
> -
> -static int __init ohci_omap3_init(void)
> -{
> -	if (usb_disabled())
> -		return -ENODEV;
> -
> -	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> -
> -	ohci_init_driver(&ohci_omap3_hc_driver, NULL);
> -	return platform_driver_register(&ohci_hcd_omap3_driver);
> -}
> -module_init(ohci_omap3_init);
> -
> -static void __exit ohci_omap3_cleanup(void)
> -{
> -	platform_driver_unregister(&ohci_hcd_omap3_driver);
> -}
> -module_exit(ohci_omap3_cleanup);
> -
> -MODULE_DESCRIPTION(DRIVER_DESC);
> -MODULE_ALIAS("platform:ohci-omap3");
> -MODULE_AUTHOR("Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>");
> -MODULE_LICENSE("GPL");
> --=20
> 2.13.0

--ao4gtl2o5lhpihbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkj+ZcACgkQ2O7X88g7
+pqDEA/6AyLc6yNKgpc/GBMDlAN3pAXONnsEmVfHoBqrT+eC5g8kzPviPU6Ob8Ra
6RK39I5xhuRDv5N6s0jtclSMP4QLTojWjUQHK+jr3rkSrYwQzbgTev0bjKgFooO2
22aUsuMnl50rRYBU37Y7N+AwKUIiEO0sh0BonY9YPzP7MJghyJ5VhQXI7mfOFUJ/
OLVObbodFuS/se9Nppo/lFHoKCil+6jw5bw+7skXfCupyNqfdSPWBaaPRkmKYVZi
iMb0EwS3qKJROzx6URN2MkP8FT+xbgU2NfDvPUq1Xp5fML4tmMRC8YFKLHEA2Y7y
XCGTr4GlniFiBgZKjQc3C8JHI9eK+P1OsERUsOWMfNvT9Joje6BXvZAodojF6d7o
nDqS0o4ghD9W1XYnzcVWIuhDdksXd2jIqQDce3rCyaUBsFaSde2+7BCkVh6PHdAq
n81mqR2P57DMY63u7KmHq085FkxcHtSB7rdLfoPLK/Rb+iafb0RkEL37y6Hj4+KI
0/v05RzCIfvbY2Rp5TFY4HWMY6Gp01oZ2P8jFv0F3wjsA0eUZTEc+PxzFtZe5Goh
FXsdG39c1MZtqlADWHyM2QLcdidG/FHQnnMBWVLZ9ILOg8UGjYoD2C2bB2pKTxhz
aHMFk0kQ/owEzQhdCQaoDCk0RwZmAUysFRQbI7cK45o37WKLi+c=
=B6Dm
-----END PGP SIGNATURE-----

--ao4gtl2o5lhpihbc--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
