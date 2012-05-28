From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 05/11] mfd: omap: control: core system
	control driver
Date: Mon, 28 May 2012 15:24:01 +0530
Message-ID: <CAMQu2gy_rgLidHWy7xxZBiVD4wfFuTvA+wC7joogrcFptwsx8w@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-6-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1337934361-1606-6-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, J Keerthy <j-keerthy@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> This patch introduces a MFD core device driver for
> OMAP system control module.
>
> The control module allows software control of
> various static modes supported by the device. It is
> composed of two control submodules: general control
> module and device (padconfiguration) control
> module.
>
> In this patch, the children defined are for:
> . USB-phy pin control
> . Bangap temperature sensor
>
> Device driver is probed with postcore_initcall.
> However, as some of the APIs exposed by this driver
> may be needed in very early init phase, an early init
> class is also available: "early_omap_control".
>
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---

[..]
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index ad95c7a..222dbad 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -5,6 +5,9 @@ menu "TI OMAP Common Features"
> =A0config ARCH_OMAP_OTG
> =A0 =A0 =A0 =A0bool
>
> +config ARCH_HAS_CONTROL_MODULE
> + =A0 =A0 =A0 bool
> +
Thanks for getting rid of OMAP CONFIG here.

> =A0choice
> =A0 =A0 =A0 =A0prompt "OMAP System Type"
> =A0 =A0 =A0 =A0default ARCH_OMAP2PLUS
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 11e4438..25a66d8 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -795,6 +795,15 @@ config MFD_WL1273_CORE
> =A0 =A0 =A0 =A0 =A0driver connects the radio-wl1273 V4L2 module and the w=
l1273
> =A0 =A0 =A0 =A0 =A0audio codec.
>
> +config MFD_OMAP_CONTROL
> + =A0 =A0 =A0 bool "Texas Instruments OMAP System control module"
> + =A0 =A0 =A0 depends on ARCH_HAS_CONTROL_MODULE
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This is the core driver for system control module. This=
 driver
> + =A0 =A0 =A0 =A0 is responsible for creating the control module mfd chil=
d,
> + =A0 =A0 =A0 =A0 like USB-pin control, pin muxing, MMC-pbias and DDR IO =
dynamic
> + =A0 =A0 =A0 =A0 change for off mode.
> +
> =A0config MFD_OMAP_USB_HOST
> =A0 =A0 =A0 =A0bool "Support OMAP USBHS core driver"
> =A0 =A0 =A0 =A0depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 05fa538..00f99d6 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -106,6 +106,7 @@ obj-$(CONFIG_MFD_TPS6586X) =A0+=3D tps6586x.o
> =A0obj-$(CONFIG_MFD_VX855) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D vx855.o
> =A0obj-$(CONFIG_MFD_WL1273_CORE) =A0+=3D wl1273-core.o
> =A0obj-$(CONFIG_MFD_CS5535) =A0 =A0 =A0 +=3D cs5535-mfd.o
> +obj-$(CONFIG_MFD_OMAP_CONTROL) +=3D omap-control-core.o
> =A0obj-$(CONFIG_MFD_OMAP_USB_HOST) =A0 =A0 =A0 =A0+=3D omap-usb-host.o
> =A0obj-$(CONFIG_MFD_PM8921_CORE) =A0+=3D pm8921-core.o
> =A0obj-$(CONFIG_MFD_PM8XXX_IRQ) =A0 +=3D pm8xxx-irq.o
> diff --git a/drivers/mfd/omap-control-core.c b/drivers/mfd/omap-control-c=
ore.c
> new file mode 100644
> index 0000000..7d8d408
> --- /dev/null
> +++ b/drivers/mfd/omap-control-core.c
> @@ -0,0 +1,211 @@
> +/*
> + * OMAP system control module driver file
> + *
> + * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.t=
i.com/
> + * Contacts:
> + * Based on original code written by:
> + * =A0 =A0J Keerthy <j-keerthy@ti.com>
> + * =A0 =A0Moiz Sonasath <m-sonasath@ti.com>
> + * MFD clean up and re-factoring:
> + * =A0 =A0Eduardo Valentin <eduardo.valentin@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU
> + * General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/export.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/omap_control.h>
> +
> +static struct omap_control *omap_control_module;
> +
> +/**
> + * omap_control_readl: Read a single omap control module register.
> + *
> + * @dev: device to read from.
> + * @reg: register to read.
> + * @val: output with register value.
> + *
> + * returns 0 on success or -EINVAL in case struct device is invalid.
> + */
> +int omap_control_readl(struct device *dev, u32 reg, u32 *val)
> +{
> + =A0 =A0 =A0 struct omap_control *omap_control =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 if (!omap_control)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 *val =3D readl(omap_control->base + reg);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(omap_control_readl);
> +
I might have missed in the last scan, but can you let
function return the register value.

I am guessing, you did this for error case handling. You might
want to stick to read API semantic and just have WARN_ON()
to take care of error case.

> +/**
> + * omap_control_writel: Write a single omap control module register.
> + *
> + * @dev: device to read from.
> + * @val: value to write.
> + * @reg: register to write to.
> + *
> + * returns 0 on success or -EINVAL in case struct device is invalid.
> + */
> +int omap_control_writel(struct device *dev, u32 val, u32 reg)
> +{
> + =A0 =A0 =A0 struct omap_control *omap_control =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (!omap_control)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&omap_control->reg_lock, flags);
> + =A0 =A0 =A0 writel(val, omap_control->base + reg);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&omap_control->reg_lock, flags);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(omap_control_writel);
> +
> +/**
> + * omap_control_get: returns the control module device pinter
> + *
> + * The modules which has to use control module API's to read or write sh=
ould
> + * call this API to get the control module device pointer.
> + */
> +struct device *omap_control_get(void)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (!omap_control_module)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENODEV);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&omap_control_module->reg_lock, flags);
> + =A0 =A0 =A0 omap_control_module->use_count++;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&omap_control_module->reg_lock, flag=
s);
> +
> + =A0 =A0 =A0 return omap_control_module->dev;
> +}
> +EXPORT_SYMBOL_GPL(omap_control_get);
> +
> +/**
> + * omap_control_put: returns the control module device pinter
> + *
> + * The modules which has to use control module API's to read or write sh=
ould
> + * call this API to get the control module device pointer.
> + */
> +void omap_control_put(struct device *dev)
> +{
> + =A0 =A0 =A0 struct omap_control *omap_control =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (!omap_control)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&omap_control->reg_lock, flags);
> + =A0 =A0 =A0 omap_control->use_count--;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&omap_control_module->reg_lock, flag=
s);
> +}
> +EXPORT_SYMBOL_GPL(omap_control_put);
> +
> +static const struct of_device_id of_omap_control_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "ti,omap3-control", },
> + =A0 =A0 =A0 { .compatible =3D "ti,omap4-control", },
> + =A0 =A0 =A0 { .compatible =3D "ti,omap5-control", },
> + =A0 =A0 =A0 { },
> +};
> +
> +static int __devinit omap_control_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 void __iomem *base;
> + =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
> + =A0 =A0 =A0 struct device_node *np =3D dev->of_node;
> + =A0 =A0 =A0 struct omap_control *omap_control;
> +
> + =A0 =A0 =A0 omap_control =3D devm_kzalloc(dev, sizeof(*omap_control), G=
FP_KERNEL);
> + =A0 =A0 =A0 if (!omap_control) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "not enough memory for omap_co=
ntrol\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "missing memory base resource\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 base =3D devm_request_and_ioremap(dev, res);
> + =A0 =A0 =A0 if (!base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "ioremap failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EADDRNOTAVAIL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 omap_control->base =3D base;
> + =A0 =A0 =A0 omap_control->dev =3D dev;
> + =A0 =A0 =A0 spin_lock_init(&omap_control->reg_lock);
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, omap_control);
> + =A0 =A0 =A0 omap_control_module =3D omap_control;
> +
> + =A0 =A0 =A0 return of_platform_populate(np, of_omap_control_match, NULL=
, dev);
> +}
> +

Will the probe get called on multiple devices and race ?

> +static int __devexit omap_control_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct omap_control *omap_control =3D platform_get_drvdata(=
pdev);
> +
> + =A0 =A0 =A0 spin_lock(&omap_control->reg_lock);
> + =A0 =A0 =A0 if (omap_control->use_count > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&omap_control->reg_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "device removed while s=
till being used\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock(&omap_control->reg_lock);
> +
Do you really need above lock where you are just doing the
register read. smp_rmb(), should be enough, I guess.

Regards
Santosh
