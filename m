From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [PATCH v3 2/7] mfd: omap: control: core system control driver
Date: Thu, 28 Jun 2012 12:49:48 +0300
Message-ID: <CAGF5oy9heLnjcHj4H=hMK9NAkrDoOocR-Lbv1Z4cQ4G1C5kSeQ@mail.gmail.com>
References: <4FEB4B46.9020904@dev.rtsoft.ru>
	<20120628045028.GC2471@besouro>
	<4FEC25CA.10105@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42011 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751396Ab2F1Jtu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 05:49:50 -0400
Received: by vcbgb30 with SMTP id gb30so2535856vcb.16
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 02:49:48 -0700 (PDT)
In-Reply-To: <4FEC25CA.10105@dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

Hello,

On Thu, Jun 28, 2012 at 12:37 PM, Konstantin Baydarov
<kbaidarov@dev.rtsoft.ru> wrote:
> =A0Hi.
>
> On 06/28/2012 08:50 AM, Eduardo Valentin wrote:
>> Hello,
>>
>> On Wed, Jun 27, 2012 at 10:04:54PM +0400, Konstantin Baydarov wrote:
>>> This patch introduces a MFD core device driver for OMAP system cont=
rol module.
>>>
>>> The control module allows software control of various static modes =
supported by the device.
>>> It is composed of two control submodules: general control module an=
d device (padconfiguration) control module.
>>>
>>> Changes since previous version:
>>> - omap-control-core: resources aren't hardcoded, they are specified=
 in dts file.
>>> - omap-control-core: Control module is a built-in driver - added co=
ntrol module select to ARCH_HAS_CONTROL_MODULE and ARCH_OMAP4.
>>> Probably, no configuration option is required!
>>> - omap-control-core: Added early init call that ioremaps control mo=
dule IOMEM window, this allows access of SCM registers very early, for =
example from omap_type()
>>> - omap-control-core: Removed device pointer from omap-control-core =
API arguments, becuase there can be only one instance control
>>> module device.
>>> - omap-control-core: removed omap_control_get, omap_control_readl, =
omap_control_writel
>>> - omap-control-core: added omap_control_status_read that is used ea=
rly in omap_type
>>>
>>> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
>>> Signed-off-by: J Keerthy <j-keerthy@ti.com>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>> ---
>>> =A0.../devicetree/bindings/mfd/omap_control.txt =A0 =A0 =A0 | =A0 4=
4 +++++++
>>> =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A01 +
>>> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A04 +
>>> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0| =A0 =A09 ++
>>> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 | =A0 =A01 +
>>> =A0drivers/mfd/omap-control-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0131 ++++++++++++++++++++
>>> =A0include/linux/mfd/omap_control.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 52 ++++++++
>>> =A07 files changed, 242 insertions(+), 0 deletions(-)
>>> =A0create mode 100644 Documentation/devicetree/bindings/mfd/omap_co=
ntrol.txt
>>> =A0create mode 100644 drivers/mfd/omap-control-core.c
>>> =A0create mode 100644 include/linux/mfd/omap_control.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/omap_control.txt=
 b/Documentation/devicetree/bindings/mfd/omap_control.txt
>>> new file mode 100644
>>> index 0000000..46d5e7e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/omap_control.txt
>>> @@ -0,0 +1,44 @@
>>> +* Texas Instrument OMAP System Control Module (SCM) bindings
>>> +
>>> +The control module allows software control of various static modes=
 supported by
>>> +the device. The control module controls the settings of various de=
vice =A0modules
>>> +through register configuration and internal signals. It also contr=
ols =A0the =A0pad
>>> +configuration, pin functional multiplexing, and the routing of int=
ernal signals
>>> +(such as PRCM =A0signals or DMA requests) =A0to output pins config=
ured for hardware
>>> +observability.
>>> +
>>> +Required properties:
>>> +- compatible : Should be:
>>> + =A0- "ti,omap3-control" for OMAP3 support
>>> + =A0- "ti,omap4-control" for OMAP4 support
>>> + =A0- "ti,omap5-control" for OMAP5 support
>>> +
>>> +OMAP specific properties:
>>> +- ti,hwmods: Name of the hwmod associated to the control module:
>>> + =A0Should be "ctrl_module_core";
>>> +
>>> +Sub-nodes:
>>> +- bandgap : contains the bandgap node
>>> +
>>> + =A0The bindings details of individual bandgap device can be found=
 in:
>>> + =A0Documentation/devicetree/bindings/thermal/omap_bandgap.txt
>>> +
>>> +- usb : contains the usb phy pin control node
>>> +
>>> + =A0The only required property for this child is:
>>> + =A0 =A0- compatible =3D "ti,omap4-control-usb";
>>> +
>>> +Examples:
>>> +
>>> +ctrl_module_core: ctrl_module_core@4a002000 {
>>> + =A0 =A0compatible =3D "ti,omap4-control";
>>> + =A0 =A0ti,hwmods =3D "ctrl_module_core";
>>> + =A0 =A0bandgap {
>>> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "ti,omap4460-bandgap";
>> You need to update the documentation if change the DT structure.
> Ok.
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <0 126 4>; /* talert */
>>> + =A0 =A0 =A0 =A0 =A0 =A0ti,tshut-gpio =3D <86>; /* tshut */
>>> + =A0 =A0};
>>> + =A0 =A0usb {
>>> + =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "ti,omap4-usb-phy";
>>> + =A0 =A0};
>>> +};
>>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kcon=
fig
>>> index 4cf5142..c2ef07c 100644
>>> --- a/arch/arm/mach-omap2/Kconfig
>>> +++ b/arch/arm/mach-omap2/Kconfig
>>> @@ -52,6 +52,7 @@ config ARCH_OMAP4
>>> =A0 =A0 =A0select PL310_ERRATA_727915
>>> =A0 =A0 =A0select ARM_ERRATA_720789
>>> =A0 =A0 =A0select ARCH_HAS_OPP
>>> + =A0 =A0select ARCH_HAS_CONTROL_MODULE
>>> =A0 =A0 =A0select PM_OPP if PM
>>> =A0 =A0 =A0select USB_ARCH_HAS_EHCI if USB_SUPPORT
>>> =A0 =A0 =A0select ARM_CPU_SUSPEND if PM
>>> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfi=
g
>>> index ad95c7a..0f9b575 100644
>>> --- a/arch/arm/plat-omap/Kconfig
>>> +++ b/arch/arm/plat-omap/Kconfig
>>> @@ -5,6 +5,10 @@ menu "TI OMAP Common Features"
>>> =A0config ARCH_OMAP_OTG
>>> =A0 =A0 =A0bool
>>>
>>> +config ARCH_HAS_CONTROL_MODULE
>>> + =A0 =A0bool
>>> + =A0 =A0select MFD_OMAP_CONTROL
>>> +
>> OK now I got what you meant in patch 0. Fine for me.
>>
>>> =A0choice
>>> =A0 =A0 =A0prompt "OMAP System Type"
>>> =A0 =A0 =A0default ARCH_OMAP2PLUS
>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>> index e129c82..d0c5456 100644
>>> --- a/drivers/mfd/Kconfig
>>> +++ b/drivers/mfd/Kconfig
>>> @@ -822,6 +822,15 @@ config MFD_WL1273_CORE
>>> =A0 =A0 =A0 =A0driver connects the radio-wl1273 V4L2 module and the=
 wl1273
>>> =A0 =A0 =A0 =A0audio codec.
>>>
>>> +config MFD_OMAP_CONTROL
>>> + =A0 =A0bool "Texas Instruments OMAP System control module"
>>> + =A0 =A0depends on ARCH_HAS_CONTROL_MODULE
>>> + =A0 =A0help
>>> + =A0 =A0 =A0This is the core driver for system control module. Thi=
s driver
>>> + =A0 =A0 =A0is responsible for creating the control module mfd chi=
ld,
>>> + =A0 =A0 =A0like USB-pin control, pin muxing, MMC-pbias and DDR IO=
 dynamic
>>> + =A0 =A0 =A0change for off mode.
>>> +
>>> =A0config MFD_OMAP_USB_HOST
>>> =A0 =A0 =A0bool "Support OMAP USBHS core driver"
>>> =A0 =A0 =A0depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>> index 75f6ed6..b037443 100644
>>> --- a/drivers/mfd/Makefile
>>> +++ b/drivers/mfd/Makefile
>>> @@ -107,6 +107,7 @@ obj-$(CONFIG_MFD_TPS6586X) =A0 =A0 =A0 +=3D tps=
6586x.o
>>> =A0obj-$(CONFIG_MFD_VX855) =A0 =A0 =A0 =A0 =A0 =A0 +=3D vx855.o
>>> =A0obj-$(CONFIG_MFD_WL1273_CORE) =A0 =A0 =A0 +=3D wl1273-core.o
>>> =A0obj-$(CONFIG_MFD_CS5535) =A0 =A0+=3D cs5535-mfd.o
>>> +obj-$(CONFIG_MFD_OMAP_CONTROL) =A0 =A0 =A0+=3D omap-control-core.o
>>> =A0obj-$(CONFIG_MFD_OMAP_USB_HOST) =A0 =A0 +=3D omap-usb-host.o
>>> =A0obj-$(CONFIG_MFD_PM8921_CORE) =A0 =A0 =A0 +=3D pm8921-core.o
>>> =A0obj-$(CONFIG_MFD_PM8XXX_IRQ) =A0 =A0 =A0 =A0+=3D pm8xxx-irq.o
>>> diff --git a/drivers/mfd/omap-control-core.c b/drivers/mfd/omap-con=
trol-core.c
>>> new file mode 100644
>>> index 0000000..724c51b
>>> --- /dev/null
>>> +++ b/drivers/mfd/omap-control-core.c
>>> @@ -0,0 +1,131 @@
>>> +/*
>>> + * OMAP system control module driver file
>>> + *
>>> + * Copyright (C) 2011-2012 Texas Instruments Incorporated - http:/=
/www.ti.com/
>>> + * Contacts:
>>> + * Based on original code written by:
>>> + * =A0 =A0J Keerthy <j-keerthy@ti.com>
>>> + * =A0 =A0Moiz Sonasath <m-sonasath@ti.com>
>>> + * MFD clean up and re-factoring:
>>> + * =A0 =A0Eduardo Valentin <eduardo.valentin@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,=
 but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the=
 GNU
>>> + * General Public License for more details.
>>> + *
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/export.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/io.h>
>>> +#include <linux/err.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/mfd/core.h>
>>> +#include <linux/mfd/omap_control.h>
>>> +
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +
>>> +void __iomem *omap_control_base;
>>> +
>>> +u32 omap_control_status_read(u16 offset)
>>> +{
>>> + =A0 =A0return __raw_readl(omap_control_base + (offset));
>>> +}
>>> +
>>> +static const struct of_device_id of_omap_control_match[] =3D {
>>> + =A0 =A0{ .compatible =3D "ti,omap3-control", },
>>> + =A0 =A0{ .compatible =3D "ti,omap4-control", },
>>> + =A0 =A0{ .compatible =3D "ti,omap5-control", },
>>> + =A0 =A0{ },
>>> +};
>>> +
>>> +static int __devinit omap_control_probe(struct platform_device *pd=
ev)
>>> +{
>>> + =A0 =A0struct device *dev =3D &pdev->dev;
>>> + =A0 =A0struct device_node *np =3D dev->of_node;
>>> +
>>> + =A0 =A0/*
>>> + =A0 =A0 * =A0Build child defvices of ctrl_module_core
>>> + =A0 =A0 */
>>> + =A0 =A0return of_platform_populate(np, of_omap_control_match, NUL=
L, dev);
>>> +}
>>> +
>>> +
>>> +static struct platform_driver omap_control_driver =3D {
>>> + =A0 =A0.probe =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D omap_control=
_probe,
>>> + =A0 =A0.driver =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "omap-contro=
l-core",
>>> + =A0 =A0 =A0 =A0 =A0 =A0.owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
>>> + =A0 =A0 =A0 =A0 =A0 =A0.of_match_table =3D of_omap_control_match,
>>> + =A0 =A0},
>>> +};
>>> +
>>> +int __init omap_control_of_init(struct device_node *node,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_nod=
e *parent)
>>> +{
>>> + =A0 =A0struct resource res;
>>> +
>>> + =A0 =A0if (WARN_ON(!node))
>>> + =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>>> +
>>> + =A0 =A0if (of_address_to_resource(node, 0, &res)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0WARN(1, "unable to get intc registers\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>> + =A0 =A0}
>>> +
>>> + =A0 =A0return 0;
>>> +}
>> The above function is used nowhere.
> Agree.
>>
>>> +
>>> +void __init of_omap_control_init(const struct of_device_id *matche=
s)
>>> +{
>>> + =A0 =A0struct device_node *np;
>>> + =A0 =A0struct property *pp =3D 0;
>>> + =A0 =A0unsigned long phys_base =3D 0;
>>> + =A0 =A0size_t mapsize =3D 0;
>>> +
>>> + =A0 =A0for_each_matching_node(np, matches) {
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0pp =3D of_find_property(np, "reg", NULL);
>>> + =A0 =A0 =A0 =A0 =A0 =A0if(pp) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phys_base =3D (unsigned lo=
ng)be32_to_cpup(pp->value);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mapsize =3D (size_t)be32_t=
o_cpup( (void*)((char*)pp->value + 4) );
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_control_base =3D iore=
map(phys_base, mapsize);
>> How the reservation is going to work?
> This can be done following way:
> - omap-control-core.c ioremaps and reserves SCM IOMEM window
> - omap-control-core.c exports omap_control_get_base(virtual base addr=
ess is returned) to use in bandgap and usb_phy driver.
> IIUC, this way was suggested by Tony.

how better is this way compared to having the access functions in the
core? This way we just replicate the access functions in every
children.

I believe the suggestion was to have the ioremap and request done in
chunks. So that children dont step into each other ioarea. But then
again that can be a bit painful as the children registers are not
contiguous.

>
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0}
>>> + =A0 =A0}
>>> +}
>>> +
>>> +static int __init
>>> +omap_control_early_initcall(void)
>>> +{
>>> + =A0 =A0of_omap_control_init(of_omap_control_match);
>>> +
>>> + =A0 =A0return 0;
>>> +}
>>> +early_initcall(omap_control_early_initcall);
>>> +
>>> +static int __init omap_control_init(void)
>>> +{
>>> + =A0 =A0return platform_driver_register(&omap_control_driver);
>>> +}
>>> +postcore_initcall_sync(omap_control_init);
>>> +
>>> +static void __exit omap_control_exit(void)
>>> +{
>>> + =A0 =A0platform_driver_unregister(&omap_control_driver);
>>> +}
>>> +module_exit(omap_control_exit);
>>> +early_platform_init("early_omap_control", &omap_control_driver);
>> early_platform_init is not needed as you are implementing the early =
reads in a different way.
> Right.
>>
>>> +
>>> +MODULE_DESCRIPTION("OMAP system control module driver");
>>> +MODULE_LICENSE("GPL v2");
>>> +MODULE_ALIAS("platform:omap-control-core");
>>> +MODULE_AUTHOR("Texas Instruments Inc.");
>>> diff --git a/include/linux/mfd/omap_control.h b/include/linux/mfd/o=
map_control.h
>>> new file mode 100644
>>> index 0000000..1795403
>>> --- /dev/null
>>> +++ b/include/linux/mfd/omap_control.h
>>> @@ -0,0 +1,52 @@
>>> +/*
>>> + * OMAP system control module header file
>>> + *
>>> + * Copyright (C) 2011-2012 Texas Instruments Incorporated - http:/=
/www.ti.com/
>>> + * Contact:
>>> + * =A0 J Keerthy <j-keerthy@ti.com>
>>> + * =A0 Moiz Sonasath <m-sonasath@ti.com>
>>> + * =A0 Abraham, Kishon Vijay <kishon@ti.com>
>>> + * =A0 Eduardo Valentin <eduardo.valentin@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,=
 but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the=
 GNU
>>> + * General Public License for more details.
>>> + *
>>> + */
>>> +
>>> +#ifndef __DRIVERS_OMAP_CONTROL_H
>>> +#define __DRIVERS_OMAP_CONTROL_H
>>> +
>>> +#include <linux/err.h>
>>> +
>>> +/**
>>> + * struct system control module - scm device structure
>>> + * @dev: device pointer
>>> + * @base: Base of the temp I/O
>>> + * @reg_lock: protect omap_control structure
>>> + * @use_count: track API users
>>> + */
>>> +struct omap_control {
>>> + =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 *dev;
>>> + =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0*base;
>>> + =A0 =A0/* protect this data structure and register access */
>>> + =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0reg_lock;
>>> + =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_count;
>> I suppose the reg_lock and the use_count are not needed in this desi=
gn?
> Right.
>>
>>> +};
>>> +
>>> +/* TODO: Add helpers for 16bit and byte access */
>>> +#ifdef CONFIG_MFD_OMAP_CONTROL
>>> +u32 omap_control_status_read(u16 offset);
>>> +#else
>>> +static inline u32 omap_control_status_read(u16 offset)
>>> +{
>>> + =A0 =A0return 0;
>>> +}
>>> +#endif
>>> +
>>> +#endif /* __DRIVERS_OMAP_CONTROL_H */
>>> --
>>> 1.7.7.6
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20

Eduardo Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
