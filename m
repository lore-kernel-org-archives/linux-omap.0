From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 05/11] mfd: omap: control: core system
	control driver
Date: Tue, 29 May 2012 15:25:31 +0200
Message-ID: <4FC4CE4B.8020708@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-6-git-send-email-eduardo.valentin@ti.com>
	<4FBF8078.9050809@ti.com> <20120528113502.GG3923@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120528113502.GG3923@besouro>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: eduardo.valentin@ti.com
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, J Keerthy <j-keerthy@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 5/28/2012 1:35 PM, Eduardo Valentin wrote:
> Hello,
>
> On Fri, May 25, 2012 at 02:52:08PM +0200, Cousson Benoit wrote:
>> On 5/25/2012 10:25 AM, Eduardo Valentin wrote:
>>> This patch introduces a MFD core device driver for
>>> OMAP system control module.
>>>
>>> The control module allows software control of
>>> various static modes supported by the device. It is
>>> composed of two control submodules: general control
>>> module and device (padconfiguration) control
>>> module.
>>>
>>> In this patch, the children defined are for:
>>> . USB-phy pin control
>>> . Bangap temperature sensor
>>>
>>> Device driver is probed with postcore_initcall.
>>> However, as some of the APIs exposed by this driver
>>> may be needed in very early init phase, an early init
>>> class is also available: "early_omap_control".
>>>
>>> Signed-off-by: J Keerthy<j-keerthy@ti.com>
>>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>>> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
>>> ---
>>>   .../devicetree/bindings/mfd/omap_control.txt       |   44 ++++
>>>   arch/arm/mach-omap2/Kconfig                        |    1 +
>>>   arch/arm/plat-omap/Kconfig                         |    3 +
>>>   drivers/mfd/Kconfig                                |    9 +
>>>   drivers/mfd/Makefile                               |    1 +
>>>   drivers/mfd/omap-control-core.c                    |  211 ++++++++++++++++++++
>>>   include/linux/mfd/omap_control.h                   |   69 +++++++
>>>   7 files changed, 338 insertions(+), 0 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/omap_control.txt
>>>   create mode 100644 drivers/mfd/omap-control-core.c
>>>   create mode 100644 include/linux/mfd/omap_control.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/omap_control.txt b/Documentation/devicetree/bindings/mfd/omap_control.txt
>>> new file mode 100644
>>> index 0000000..46d5e7e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/omap_control.txt
>>> @@ -0,0 +1,44 @@
>>> +* Texas Instrument OMAP System Control Module (SCM) bindings
>>> +
>>> +The control module allows software control of various static modes supported by
>>> +the device. The control module controls the settings of various device  modules
>>> +through register configuration and internal signals. It also controls  the  pad
>>> +configuration, pin functional multiplexing, and the routing of internal signals
>>> +(such as PRCM  signals or DMA requests)  to output pins configured for hardware
>>> +observability.
>>> +
>>> +Required properties:
>>> +- compatible : Should be:
>>> +  - "ti,omap3-control" for OMAP3 support
>>> +  - "ti,omap4-control" for OMAP4 support
>>> +  - "ti,omap5-control" for OMAP5 support
>>> +
>>> +OMAP specific properties:
>>> +- ti,hwmods: Name of the hwmod associated to the control module:
>>> +  Should be "ctrl_module_core";
>>> +
>>> +Sub-nodes:
>>> +- bandgap : contains the bandgap node
>>> +
>>> +  The bindings details of individual bandgap device can be found in:
>>> +  Documentation/devicetree/bindings/thermal/omap_bandgap.txt
>>> +
>>> +- usb : contains the usb phy pin control node
>>> +
>>> +  The only required property for this child is:
>>> +    - compatible = "ti,omap4-control-usb";
>>> +
>>> +Examples:
>>> +
>>> +ctrl_module_core: ctrl_module_core@4a002000 {
>>> +	compatible = "ti,omap4-control";
>>> +	ti,hwmods = "ctrl_module_core";
>>> +	bandgap {
>>> +		compatible = "ti,omap4460-bandgap";
>>> +		interrupts =<0 126 4>; /* talert */
>>> +		ti,tshut-gpio =<86>; /* tshut */
>>> +	};
>>> +	usb {
>>> +		compatible = "ti,omap4-usb-phy";
>>> +	};
>>> +};
>>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>>> index a2b946d..7dfe5e1 100644
>>> --- a/arch/arm/mach-omap2/Kconfig
>>> +++ b/arch/arm/mach-omap2/Kconfig
>>> @@ -52,6 +52,7 @@ config ARCH_OMAP4
>>>   	select PL310_ERRATA_727915
>>>   	select ARM_ERRATA_720789
>>>   	select ARCH_HAS_OPP
>>> +	select ARCH_HAS_CONTROL_MODULE
>>>   	select PM_OPP if PM
>>>   	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>>>   	select ARM_CPU_SUSPEND if PM
>>> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
>>> index ad95c7a..222dbad 100644
>>> --- a/arch/arm/plat-omap/Kconfig
>>> +++ b/arch/arm/plat-omap/Kconfig
>>> @@ -5,6 +5,9 @@ menu "TI OMAP Common Features"
>>>   config ARCH_OMAP_OTG
>>>   	bool
>>>
>>> +config ARCH_HAS_CONTROL_MODULE
>>> +	bool
>>> +
>>>   choice
>>>   	prompt "OMAP System Type"
>>>   	default ARCH_OMAP2PLUS
>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>> index 11e4438..25a66d8 100644
>>> --- a/drivers/mfd/Kconfig
>>> +++ b/drivers/mfd/Kconfig
>>> @@ -795,6 +795,15 @@ config MFD_WL1273_CORE
>>>   	  driver connects the radio-wl1273 V4L2 module and the wl1273
>>>   	  audio codec.
>>>
>>> +config MFD_OMAP_CONTROL
>>> +	bool "Texas Instruments OMAP System control module"
>>> +	depends on ARCH_HAS_CONTROL_MODULE
>>> +	help
>>> +	  This is the core driver for system control module. This driver
>>> +	  is responsible for creating the control module mfd child,
>>> +	  like USB-pin control, pin muxing, MMC-pbias and DDR IO dynamic
>>> +	  change for off mode.
>>> +
>>>   config MFD_OMAP_USB_HOST
>>>   	bool "Support OMAP USBHS core driver"
>>>   	depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>> index 05fa538..00f99d6 100644
>>> --- a/drivers/mfd/Makefile
>>> +++ b/drivers/mfd/Makefile
>>> @@ -106,6 +106,7 @@ obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
>>>   obj-$(CONFIG_MFD_VX855)		+= vx855.o
>>>   obj-$(CONFIG_MFD_WL1273_CORE)	+= wl1273-core.o
>>>   obj-$(CONFIG_MFD_CS5535)	+= cs5535-mfd.o
>>> +obj-$(CONFIG_MFD_OMAP_CONTROL)	+= omap-control-core.o
>>>   obj-$(CONFIG_MFD_OMAP_USB_HOST)	+= omap-usb-host.o
>>>   obj-$(CONFIG_MFD_PM8921_CORE) 	+= pm8921-core.o
>>>   obj-$(CONFIG_MFD_PM8XXX_IRQ) 	+= pm8xxx-irq.o
>>> diff --git a/drivers/mfd/omap-control-core.c b/drivers/mfd/omap-control-core.c
>>> new file mode 100644
>>> index 0000000..7d8d408
>>> --- /dev/null
>>> +++ b/drivers/mfd/omap-control-core.c
>>> @@ -0,0 +1,211 @@
>>> +/*
>>> + * OMAP system control module driver file
>>> + *
>>> + * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
>>> + * Contacts:
>>> + * Based on original code written by:
>>> + *    J Keerthy<j-keerthy@ti.com>
>>> + *    Moiz Sonasath<m-sonasath@ti.com>
>>> + * MFD clean up and re-factoring:
>>> + *    Eduardo Valentin<eduardo.valentin@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * General Public License for more details.
>>> + *
>>> + */
>>> +
>>> +#include<linux/module.h>
>>> +#include<linux/export.h>
>>> +#include<linux/platform_device.h>
>>> +#include<linux/slab.h>
>>> +#include<linux/io.h>
>>> +#include<linux/err.h>
>>> +#include<linux/of_platform.h>
>>> +#include<linux/of_address.h>
>>> +#include<linux/mfd/core.h>
>>> +#include<linux/mfd/omap_control.h>
>>> +
>>> +static struct omap_control *omap_control_module;
>>
>> Mmm, we can have up to 4 control module instances in OMAP4.
>>
>> Well, I'm not sure it worth considering them as separate devices. Is
>> that your plan as well?
>
> At least for now I was focusing on the ctrl_module_core ...

OK, that's a good start already :-)

>> But since they all have different base address, it will be trick to
>> handle them with only a single entry.
>
> Indeed. We can always add the support latter on.
>
> I am not sure what would be the best way to handle those instances though,
> and how they are going to expose APIs. Would need to have an instance bound
> to API set?

We should not go to that path I guess. We should have an API at children 
level independent of the underlying control module partitioning.

Regards,
Benoit

>>> +
>>> +/**
>>> + * omap_control_readl: Read a single omap control module register.
>>> + *
>>> + * @dev: device to read from.
>>> + * @reg: register to read.
>>> + * @val: output with register value.
>>> + *
>>> + * returns 0 on success or -EINVAL in case struct device is invalid.
>>> + */
>>> +int omap_control_readl(struct device *dev, u32 reg, u32 *val)
>>> +{
>>> +	struct omap_control *omap_control = dev_get_drvdata(dev);
>>> +
>>> +	if (!omap_control)
>>> +		return -EINVAL;
>>> +
>>> +	*val = readl(omap_control->base + reg);
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(omap_control_readl);
>>> +
>>> +/**
>>> + * omap_control_writel: Write a single omap control module register.
>>> + *
>>> + * @dev: device to read from.
>>> + * @val: value to write.
>>> + * @reg: register to write to.
>>> + *
>>> + * returns 0 on success or -EINVAL in case struct device is invalid.
>>> + */
>>> +int omap_control_writel(struct device *dev, u32 val, u32 reg)
>>> +{
>>> +	struct omap_control *omap_control = dev_get_drvdata(dev);
>>> +	unsigned long flags;
>>> +
>>> +	if (!omap_control)
>>> +		return -EINVAL;
>>> +
>>> +	spin_lock_irqsave(&omap_control->reg_lock, flags);
>>> +	writel(val, omap_control->base + reg);
>>> +	spin_unlock_irqrestore(&omap_control->reg_lock, flags);
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(omap_control_writel);
>>> +
>>> +/**
>>> + * omap_control_get: returns the control module device pinter
>>
>> typo
>
> K
>
>>
>>> + *
>>> + * The modules which has to use control module API's to read or write should
>>> + * call this API to get the control module device pointer.
>>> + */
>>> +struct device *omap_control_get(void)
>>> +{
>>> +	unsigned long flags;
>>> +
>>> +	if (!omap_control_module)
>>> +		return ERR_PTR(-ENODEV);
>>> +
>>> +	spin_lock_irqsave(&omap_control_module->reg_lock, flags);
>>> +	omap_control_module->use_count++;
>>> +	spin_unlock_irqrestore(&omap_control_module->reg_lock, flags);
>>
>> Don't we do have some better way to increment atomically a variable
>> in Linux.
>
> Yeah we have, atomic API. In general I think the SCM/bangap/phy APIs
> need to be revisited WRT locking, in general.
>
>>
>>> +
>>> +	return omap_control_module->dev;
>>> +}
>>> +EXPORT_SYMBOL_GPL(omap_control_get);
>>> +
>>> +/**
>>> + * omap_control_put: returns the control module device pinter
>>> + *
>>> + * The modules which has to use control module API's to read or write should
>>> + * call this API to get the control module device pointer.
>>> + */
>>> +void omap_control_put(struct device *dev)
>>> +{
>>> +	struct omap_control *omap_control = dev_get_drvdata(dev);
>>> +	unsigned long flags;
>>> +
>>> +	if (!omap_control)
>>> +		return;
>>> +
>>> +	spin_lock_irqsave(&omap_control->reg_lock, flags);
>>> +	omap_control->use_count--;
>>> +	spin_unlock_irqrestore(&omap_control_module->reg_lock, flags);
>>> +}
>>> +EXPORT_SYMBOL_GPL(omap_control_put);
>>> +
>>> +static const struct of_device_id of_omap_control_match[] = {
>>> +	{ .compatible = "ti,omap3-control", },
>>> +	{ .compatible = "ti,omap4-control", },
>>> +	{ .compatible = "ti,omap5-control", },
>>> +	{ },
>>> +};
>>> +
>>> +static int __devinit omap_control_probe(struct platform_device *pdev)
>>> +{
>>> +	struct resource *res;
>>> +	void __iomem *base;
>>> +	struct device *dev =&pdev->dev;
>>> +	struct device_node *np = dev->of_node;
>>> +	struct omap_control *omap_control;
>>
>> Maybe omap_control_data instead? At least if this is drvdata only.
>> If this is supposed to be the *handle* to the control module
>> instance, it should be fine.
>
> That's suppose to be the phandle :-)
>
>>
>>> +
>>> +	omap_control = devm_kzalloc(dev, sizeof(*omap_control), GFP_KERNEL);
>>> +	if (!omap_control) {
>>> +		dev_err(dev, "not enough memory for omap_control\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (!res) {
>>> +		dev_err(dev, "missing memory base resource\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	base = devm_request_and_ioremap(dev, res);
>>> +	if (!base) {
>>> +		dev_err(dev, "ioremap failed\n");
>>> +		return -EADDRNOTAVAIL;
>>> +	}
>>> +
>>> +	omap_control->base = base;
>>> +	omap_control->dev = dev;
>>> +	spin_lock_init(&omap_control->reg_lock);
>>> +
>>> +	platform_set_drvdata(pdev, omap_control);
>>> +	omap_control_module = omap_control;
>>> +
>>> +	return of_platform_populate(np, of_omap_control_match, NULL, dev);
>>> +}
>>> +
>>> +static int __devexit omap_control_remove(struct platform_device *pdev)
>>> +{
>>> +	struct omap_control *omap_control = platform_get_drvdata(pdev);
>>> +
>>> +	spin_lock(&omap_control->reg_lock);
>>> +	if (omap_control->use_count>   0) {
>>> +		spin_unlock(&omap_control->reg_lock);
>>> +		dev_err(&pdev->dev, "device removed while still being used\n");
>>> +		return -EBUSY;
>>> +	}
>>> +	spin_unlock(&omap_control->reg_lock);
>>> +
>>> +	iounmap(omap_control->base);
>>> +	platform_set_drvdata(pdev, NULL);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct platform_driver omap_control_driver = {
>>> +	.probe			= omap_control_probe,
>>> +	.remove			= __devexit_p(omap_control_remove),
>>> +	.driver = {
>>> +		.name		= "omap-control-core",
>>> +		.owner		= THIS_MODULE,
>>> +		.of_match_table	= of_omap_control_match,
>>> +	},
>>> +};
>>> +
>>> +static int __init omap_control_init(void)
>>> +{
>>> +	return platform_driver_register(&omap_control_driver);
>>> +}
>>> +postcore_initcall_sync(omap_control_init);
>>> +
>>> +static void __exit omap_control_exit(void)
>>> +{
>>> +	platform_driver_unregister(&omap_control_driver);
>>> +}
>>> +module_exit(omap_control_exit);
>>> +early_platform_init("early_omap_control",&omap_control_driver);
>>> +
>>> +MODULE_DESCRIPTION("OMAP system control module driver");
>>> +MODULE_LICENSE("GPL v2");
>>> +MODULE_ALIAS("platform:omap-control-core");
>>> +MODULE_AUTHOR("Texas Instruments Inc.");
>>> diff --git a/include/linux/mfd/omap_control.h b/include/linux/mfd/omap_control.h
>>> new file mode 100644
>>> index 0000000..7a33eda
>>> --- /dev/null
>>> +++ b/include/linux/mfd/omap_control.h
>>> @@ -0,0 +1,69 @@
>>> +/*
>>> + * OMAP system control module header file
>>> + *
>>> + * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
>>> + * Contact:
>>> + *   J Keerthy<j-keerthy@ti.com>
>>> + *   Moiz Sonasath<m-sonasath@ti.com>
>>> + *   Abraham, Kishon Vijay<kishon@ti.com>
>>> + *   Eduardo Valentin<eduardo.valentin@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * General Public License for more details.
>>> + *
>>> + */
>>> +
>>> +#ifndef __DRIVERS_OMAP_CONTROL_H
>>> +#define __DRIVERS_OMAP_CONTROL_H
>>> +
>>> +#include<linux/err.h>
>>> +
>>> +/**
>>> + * struct system control module - scm device structure
>>> + * @dev: device pointer
>>> + * @base: Base of the temp I/O
>>> + * @reg_lock: protect omap_control structure
>>> + * @use_count: track API users
>>> + */
>>> +struct omap_control {
>>> +	struct device		*dev;
>>
>> Do you really need the dev?
>> You API is device based and not omap_control based, so it should not
>> be needed.
>>
>> I guess we should be consistent here. We can store the devices and
>> used a device based API or store the omap_control and thus expose a
>> omap_control API.
>
> Yeah, this API structure is left over of the previous driver.
>
> The omap_control_get returns the SCM device reference
> and the users of SCM use it as parameter for the SCM APIs.
>
> We need to have in mind that, for SCM, the users are:
> a. Its children (USB phy, BG, etc)
> b. Non children users (mach code)
>
> The refcounting and the locking needs to take care of both I'd say.
> The struct dev was just a way to pass the SCM phandle.
>
>>
>> Regards,
>> Benoit
