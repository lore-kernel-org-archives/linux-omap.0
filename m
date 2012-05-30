From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 1/3] drivers: usb: otg: add a new driver for omap usb2 phy
Date: Wed, 30 May 2012 20:35:00 +0530
Message-ID: <CAMQu2gz6cFnwBYAut0TNArLCK7zXggqbywjB1VKLyRzhOxAcBA@mail.gmail.com>
References: <1338388466-3565-1-git-send-email-kishon@ti.com> <1338388466-3565-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1338388466-3565-2-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, May 30, 2012 at 8:04 PM, Kishon Vijay Abraham I <kishon@ti.com>=
 wrote:
> All phy related programming like enabling/disabling the clocks, power=
ing
> on/off the phy is taken care of by this driver. It is also used for O=
TG
> related functionality like srp.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> =A0drivers/usb/otg/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 17 ++-
> =A0drivers/usb/otg/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/usb/otg/omap-usb2.c =A0 =A0 =A0 | =A0232 +++++++++++++++++=
++++++++++++++++++++
> =A0include/linux/usb/omap_usb.h =A0 =A0 =A0| =A0 47 ++++++++
> =A0include/linux/usb/phy_companion.h | =A0 34 ++++++
> =A05 files changed, 327 insertions(+), 4 deletions(-)
> =A0create mode 100644 drivers/usb/otg/omap-usb2.c
> =A0create mode 100644 include/linux/usb/omap_usb.h
> =A0create mode 100644 include/linux/usb/phy_companion.h
>

[...]

> diff --git a/drivers/usb/otg/omap-usb2.c b/drivers/usb/otg/omap-usb2.=
c
> new file mode 100644
> index 0000000..ccd74b6
> --- /dev/null
> +++ b/drivers/usb/otg/omap-usb2.c
> @@ -0,0 +1,232 @@
> +/*
> + * omap-usb2.c - USB PHY, talking to musb controller in OMAP.
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti=
=2Ecom
s/2011/2012
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/usb/omap_usb.h>
> +#include <linux/usb/phy_companion.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/delay.h>
Do you need it ?

> +#include <linux/mfd/omap_control.h>
> +#include <linux/usb/omap4_usb_phy.h>
> +
> +/**
> + * omap_usb2_set_comparator - links the comparator present in the sy=
tem with
> + * =A0 =A0 this phy
> + * @comparator - the companion phy(comparator) for this phy
> + *
> + * The phy companion driver should call this API passing the phy_com=
panion
> + * filled with set_vbus and start_srp to be used by usb phy.
> + *
> + * For use by phy companion driver
> + */
> +void omap_usb2_set_comparator(struct phy_companion *comparator)
> +{
> + =A0 =A0 =A0 struct usb_phy =A0*x =3D usb_get_phy(USB_PHY_TYPE_USB2)=
;
> + =A0 =A0 =A0 struct omap_usb *phy =3D phy_to_omapusb(x);
> +
> + =A0 =A0 =A0 phy->comparator =3D comparator;
> +}
> +EXPORT_SYMBOL_GPL(omap_usb2_set_comparator);
> +
> +static int omap_usb_set_vbus(struct usb_otg *otg, bool enabled)
> +{
> + =A0 =A0 =A0 struct omap_usb *phy =3D phy_to_omapusb(otg->phy);
> +
> + =A0 =A0 =A0 if (!phy->comparator)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 return phy->comparator->set_vbus(phy->comparator, enabl=
ed);
> +}
> +
> +static int omap_usb_start_srp(struct usb_otg *otg)
> +{
> + =A0 =A0 =A0 struct omap_usb *phy =3D phy_to_omapusb(otg->phy);
> +
> + =A0 =A0 =A0 if (!phy->comparator)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 return phy->comparator->start_srp(phy->comparator);
> +}
> +
> +static int omap_usb_set_host(struct usb_otg *otg, struct usb_bus *ho=
st)
> +{
> + =A0 =A0 =A0 struct usb_phy =A0*phy =3D otg->phy;
> +
> + =A0 =A0 =A0 otg->host =3D host;
> + =A0 =A0 =A0 if (!host)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy->state =3D OTG_STATE_UNDEFINED;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int omap_usb_set_peripheral(struct usb_otg *otg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct usb_gadget *gadget)
> +{
> + =A0 =A0 =A0 struct usb_phy =A0*phy =3D otg->phy;
> +
> + =A0 =A0 =A0 otg->gadget =3D gadget;
> + =A0 =A0 =A0 if (!gadget)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy->state =3D OTG_STATE_UNDEFINED;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int omap_usb2_suspend(struct usb_phy *x, int suspend)
> +{
> + =A0 =A0 =A0 struct omap_usb *phy =3D phy_to_omapusb(x);
> +
> + =A0 =A0 =A0 if (suspend && !phy->is_suspended) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(phy->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy->is_suspended =3D 1;
> + =A0 =A0 =A0 } else if (!suspend && phy->is_suspended) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(phy->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy->is_suspended =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __devinit omap_usb2_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct omap_usb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *phy;
> + =A0 =A0 =A0 struct usb_otg =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*otg;
> +
> + =A0 =A0 =A0 phy =3D devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERN=
EL);
> + =A0 =A0 =A0 if (!phy) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "unable to allocate=
 memory for USB2 PHY\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 otg =3D devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERN=
EL);
> + =A0 =A0 =A0 if (!otg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "unable to allocate=
 memory for USB OTG\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 phy->dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &pdev->dev;
> +
> + =A0 =A0 =A0 phy->phy.dev =A0 =A0 =A0 =A0 =A0 =A0=3D phy->dev;
> + =A0 =A0 =A0 phy->phy.label =A0 =A0 =A0 =A0 =A0=3D "omap-usb2";
> + =A0 =A0 =A0 phy->phy.set_suspend =A0 =A0=3D omap_usb2_suspend;
> + =A0 =A0 =A0 phy->phy.otg =A0 =A0 =A0 =A0 =A0 =A0=3D otg;
> +
> + =A0 =A0 =A0 phy->control_dev =A0 =A0 =A0 =A0=3D omap_control_get();
> + =A0 =A0 =A0 if (IS_ERR(phy->control_dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no control device =
present in system\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(phy->control_dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 phy->is_suspended =A0 =A0 =A0 =3D 1;
> + =A0 =A0 =A0 omap4_usb_phy_power(phy->control_dev, 0);
> +
> + =A0 =A0 =A0 otg->set_host =A0 =A0 =A0 =A0 =A0 =3D omap_usb_set_host=
;
> + =A0 =A0 =A0 otg->set_peripheral =A0 =A0 =3D omap_usb_set_peripheral=
;
> + =A0 =A0 =A0 otg->set_vbus =A0 =A0 =A0 =A0 =A0 =3D omap_usb_set_vbus=
;
> + =A0 =A0 =A0 otg->start_srp =A0 =A0 =A0 =A0 =A0=3D omap_usb_start_sr=
p;
> + =A0 =A0 =A0 otg->phy =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &phy->phy;
> +
> + =A0 =A0 =A0 phy->wkupclk =3D clk_get(phy->dev, "usb_phy_cm_clk32k")=
;
Error check missing here.

> +
> + =A0 =A0 =A0 usb_add_phy(&phy->phy, USB_PHY_TYPE_USB2);
> +
unnecessary extra line
> + =A0 =A0 =A0 platform_set_drvdata(pdev, phy);
> +
this one too
> + =A0 =A0 =A0 pm_runtime_enable(phy->dev);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __devexit omap_usb2_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct omap_usb *phy =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 usb_remove_phy(&phy->phy);
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM
s/ CONFIG_PM/CONFIG_SUSPEND
otherwise you will get build warning with !CONFIG_SUSPEND

> +
> +static int omap_usb2_runtime_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct platform_device =A0*pdev =3D to_platform_device(=
dev);
> + =A0 =A0 =A0 struct omap_usb *phy =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 clk_disable(phy->wkupclk);
> + =A0 =A0 =A0 omap4_usb_phy_power(phy->control_dev, 0);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int omap_usb2_runtime_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct platform_device =A0*pdev =3D to_platform_device(=
dev);
> + =A0 =A0 =A0 struct omap_usb *phy =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 omap4_usb_phy_power(phy->control_dev, 1);
> + =A0 =A0 =A0 clk_enable(phy->wkupclk);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct dev_pm_ops omap_usb2_pm_ops =3D {
> + =A0 =A0 =A0 SET_RUNTIME_PM_OPS(omap_usb2_runtime_suspend, omap_usb2=
_runtime_resume,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL)
> +};
> +
> +#define DEV_PM_OPS =A0 =A0 (&omap_usb2_pm_ops)
> +#else
> +#define DEV_PM_OPS =A0 =A0 NULL
> +#endif
> +
> +static struct platform_driver omap_usb2_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D omap_usb2_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(omap_usb2_remov=
e),
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap-usb2",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D DEV_PM_OPS,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init usb2_omap_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&omap_usb2_driver);
> +}
> +arch_initcall(usb2_omap_init);
> +
> +static void __exit usb2_omap_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&omap_usb2_driver);
> +}
> +module_exit(usb2_omap_exit);
> +
> +MODULE_ALIAS("platform: omap_usb2");
> +MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
> +MODULE_DESCRIPTION("OMAP USB2 PHY DRIVER");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/usb/omap_usb.h b/include/linux/usb/omap_us=
b.h
> new file mode 100644
> index 0000000..8d781df
> --- /dev/null
> +++ b/include/linux/usb/omap_usb.h
> @@ -0,0 +1,47 @@
> +/*
> + * omap_usb.h -- omap usb2 phy header file
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti=
=2Ecom
s/2011/2012

> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#ifndef __DRIVERS_OMAP_USB2_H
> +#define __DRIVERS_OMAP_USB2_H
> +
> +#include <linux/usb/otg.h>
> +
> +struct omap_usb {
> + =A0 =A0 =A0 struct usb_phy =A0 =A0 =A0 =A0 =A0phy;
> + =A0 =A0 =A0 struct phy_companion =A0 =A0*comparator;
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *control_dev;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*wkupclk;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_suspen=
ded:1;
> +};
> +
> +#define =A0 =A0 =A0 =A0phy_to_omapusb(x) =A0 =A0 =A0 container_of((x=
), struct omap_usb, phy)
> +
> +#if defined(CONFIG_OMAP_USB2) || defined(CONFIG_OMAP_USB2_MODULE)
> +void omap_usb2_set_comparator(struct phy_companion *comparator);
> +#else
> +static inline void omap_usb2_set_comparator(struct phy_companion *co=
mparator)
> +{
> +}
> +#endif
> +
> +#endif /* __DRIVERS_OMAP_USB_H */
> diff --git a/include/linux/usb/phy_companion.h b/include/linux/usb/ph=
y_companion.h
> new file mode 100644
> index 0000000..321290f
> --- /dev/null
> +++ b/include/linux/usb/phy_companion.h
> @@ -0,0 +1,34 @@
> +/*
> + * phy-companion.h -- phy companion to indicate the comparator part =
of PHY
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti=
=2Ecom
Here too..

Regards
Santosh
