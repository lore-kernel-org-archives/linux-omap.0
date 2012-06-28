From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v3 2/7] mfd: omap: control: core system
	control driver
Date: Thu, 28 Jun 2012 07:50:28 +0300
Message-ID: <20120628045028.GC2471@besouro>
References: <4FEB4B46.9020904@dev.rtsoft.ru>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FEB4B46.9020904@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello,

On Wed, Jun 27, 2012 at 10:04:54PM +0400, Konstantin Baydarov wrote:
> This patch introduces a MFD core device driver for OMAP system control module.
> 
> The control module allows software control of various static modes supported by the device.
> It is composed of two control submodules: general control module and device (padconfiguration) control module.
> 
> Changes since previous version:
> - omap-control-core: resources aren't hardcoded, they are specified in dts file.
> - omap-control-core: Control module is a built-in driver - added control module select to ARCH_HAS_CONTROL_MODULE and ARCH_OMAP4.
> Probably, no configuration option is required!
> - omap-control-core: Added early init call that ioremaps control module IOMEM window, this allows access of SCM registers very early, for example from omap_type()
> - omap-control-core: Removed device pointer from omap-control-core API arguments, becuase there can be only one instance control
> module device.
> - omap-control-core: removed omap_control_get, omap_control_readl, omap_control_writel
> - omap-control-core: added omap_control_status_read that is used early in omap_type
> 
> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  .../devicetree/bindings/mfd/omap_control.txt       |   44 +++++++
>  arch/arm/mach-omap2/Kconfig                        |    1 +
>  arch/arm/plat-omap/Kconfig                         |    4 +
>  drivers/mfd/Kconfig                                |    9 ++
>  drivers/mfd/Makefile                               |    1 +
>  drivers/mfd/omap-control-core.c                    |  131 ++++++++++++++++++++
>  include/linux/mfd/omap_control.h                   |   52 ++++++++
>  7 files changed, 242 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/omap_control.txt
>  create mode 100644 drivers/mfd/omap-control-core.c
>  create mode 100644 include/linux/mfd/omap_control.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/omap_control.txt b/Documentation/devicetree/bindings/mfd/omap_control.txt
> new file mode 100644
> index 0000000..46d5e7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/omap_control.txt
> @@ -0,0 +1,44 @@
> +* Texas Instrument OMAP System Control Module (SCM) bindings
> +
> +The control module allows software control of various static modes supported by
> +the device. The control module controls the settings of various device  modules
> +through register configuration and internal signals. It also controls  the  pad
> +configuration, pin functional multiplexing, and the routing of internal signals
> +(such as PRCM  signals or DMA requests)  to output pins configured for hardware
> +observability.
> +
> +Required properties:
> +- compatible : Should be:
> +  - "ti,omap3-control" for OMAP3 support
> +  - "ti,omap4-control" for OMAP4 support
> +  - "ti,omap5-control" for OMAP5 support
> +
> +OMAP specific properties:
> +- ti,hwmods: Name of the hwmod associated to the control module:
> +  Should be "ctrl_module_core";
> +
> +Sub-nodes:
> +- bandgap : contains the bandgap node
> +
> +  The bindings details of individual bandgap device can be found in:
> +  Documentation/devicetree/bindings/thermal/omap_bandgap.txt
> +
> +- usb : contains the usb phy pin control node
> +
> +  The only required property for this child is:
> +    - compatible = "ti,omap4-control-usb";
> +
> +Examples:
> +
> +ctrl_module_core: ctrl_module_core@4a002000 {
> +	compatible = "ti,omap4-control";
> +	ti,hwmods = "ctrl_module_core";
> +	bandgap {
> +		compatible = "ti,omap4460-bandgap";

You need to update the documentation if change the DT structure.

> +		interrupts = <0 126 4>; /* talert */
> +		ti,tshut-gpio = <86>; /* tshut */
> +	};
> +	usb {
> +		compatible = "ti,omap4-usb-phy";
> +	};
> +};
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 4cf5142..c2ef07c 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -52,6 +52,7 @@ config ARCH_OMAP4
>  	select PL310_ERRATA_727915
>  	select ARM_ERRATA_720789
>  	select ARCH_HAS_OPP
> +	select ARCH_HAS_CONTROL_MODULE
>  	select PM_OPP if PM
>  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select ARM_CPU_SUSPEND if PM
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index ad95c7a..0f9b575 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -5,6 +5,10 @@ menu "TI OMAP Common Features"
>  config ARCH_OMAP_OTG
>  	bool
>  
> +config ARCH_HAS_CONTROL_MODULE
> +	bool
> +	select MFD_OMAP_CONTROL
> +

OK now I got what you meant in patch 0. Fine for me.

>  choice
>  	prompt "OMAP System Type"
>  	default ARCH_OMAP2PLUS
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index e129c82..d0c5456 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -822,6 +822,15 @@ config MFD_WL1273_CORE
>  	  driver connects the radio-wl1273 V4L2 module and the wl1273
>  	  audio codec.
>  
> +config MFD_OMAP_CONTROL
> +	bool "Texas Instruments OMAP System control module"
> +	depends on ARCH_HAS_CONTROL_MODULE
> +	help
> +	  This is the core driver for system control module. This driver
> +	  is responsible for creating the control module mfd child,
> +	  like USB-pin control, pin muxing, MMC-pbias and DDR IO dynamic
> +	  change for off mode.
> +
>  config MFD_OMAP_USB_HOST
>  	bool "Support OMAP USBHS core driver"
>  	depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 75f6ed6..b037443 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -107,6 +107,7 @@ obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
>  obj-$(CONFIG_MFD_VX855)		+= vx855.o
>  obj-$(CONFIG_MFD_WL1273_CORE)	+= wl1273-core.o
>  obj-$(CONFIG_MFD_CS5535)	+= cs5535-mfd.o
> +obj-$(CONFIG_MFD_OMAP_CONTROL)	+= omap-control-core.o
>  obj-$(CONFIG_MFD_OMAP_USB_HOST)	+= omap-usb-host.o
>  obj-$(CONFIG_MFD_PM8921_CORE) 	+= pm8921-core.o
>  obj-$(CONFIG_MFD_PM8XXX_IRQ) 	+= pm8xxx-irq.o
> diff --git a/drivers/mfd/omap-control-core.c b/drivers/mfd/omap-control-core.c
> new file mode 100644
> index 0000000..724c51b
> --- /dev/null
> +++ b/drivers/mfd/omap-control-core.c
> @@ -0,0 +1,131 @@
> +/*
> + * OMAP system control module driver file
> + *
> + * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
> + * Contacts:
> + * Based on original code written by:
> + *    J Keerthy <j-keerthy@ti.com>
> + *    Moiz Sonasath <m-sonasath@ti.com>
> + * MFD clean up and re-factoring:
> + *    Eduardo Valentin <eduardo.valentin@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
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
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +void __iomem *omap_control_base;
> +
> +u32 omap_control_status_read(u16 offset)
> +{
> +	return __raw_readl(omap_control_base + (offset));
> +}
> +
> +static const struct of_device_id of_omap_control_match[] = {
> +	{ .compatible = "ti,omap3-control", },
> +	{ .compatible = "ti,omap4-control", },
> +	{ .compatible = "ti,omap5-control", },
> +	{ },
> +};
> +
> +static int __devinit omap_control_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +
> +	/*
> +	 *  Build child defvices of ctrl_module_core
> +	 */
> +	return of_platform_populate(np, of_omap_control_match, NULL, dev);
> +}
> +
> +
> +static struct platform_driver omap_control_driver = {
> +	.probe			= omap_control_probe,
> +	.driver = {
> +		.name		= "omap-control-core",
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= of_omap_control_match,
> +	},
> +};
> +
> +int __init omap_control_of_init(struct device_node *node,
> +			     struct device_node *parent)
> +{
> +	struct resource res;
> +
> +	if (WARN_ON(!node))
> +		return -ENODEV;
> +
> +	if (of_address_to_resource(node, 0, &res)) {
> +		WARN(1, "unable to get intc registers\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

The above function is used nowhere.

> +
> +void __init of_omap_control_init(const struct of_device_id *matches)
> +{
> +	struct device_node *np;
> +	struct property *pp = 0;
> +	unsigned long phys_base = 0;
> +	size_t mapsize = 0;
> +
> +	for_each_matching_node(np, matches) {
> +
> +		pp = of_find_property(np, "reg", NULL);
> +		if(pp) {
> +			phys_base = (unsigned long)be32_to_cpup(pp->value);
> +			mapsize = (size_t)be32_to_cpup( (void*)((char*)pp->value + 4) );
> +			omap_control_base = ioremap(phys_base, mapsize);

How the reservation is going to work?

> +		}
> +	}
> +}
> +
> +static int __init
> +omap_control_early_initcall(void)
> +{
> +	of_omap_control_init(of_omap_control_match);
> +
> +	return 0;
> +}
> +early_initcall(omap_control_early_initcall);
> +
> +static int __init omap_control_init(void)
> +{
> +	return platform_driver_register(&omap_control_driver);
> +}
> +postcore_initcall_sync(omap_control_init);
> +
> +static void __exit omap_control_exit(void)
> +{
> +	platform_driver_unregister(&omap_control_driver);
> +}
> +module_exit(omap_control_exit);
> +early_platform_init("early_omap_control", &omap_control_driver);

early_platform_init is not needed as you are implementing the early reads in a different way.

> +
> +MODULE_DESCRIPTION("OMAP system control module driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:omap-control-core");
> +MODULE_AUTHOR("Texas Instruments Inc.");
> diff --git a/include/linux/mfd/omap_control.h b/include/linux/mfd/omap_control.h
> new file mode 100644
> index 0000000..1795403
> --- /dev/null
> +++ b/include/linux/mfd/omap_control.h
> @@ -0,0 +1,52 @@
> +/*
> + * OMAP system control module header file
> + *
> + * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
> + * Contact:
> + *   J Keerthy <j-keerthy@ti.com>
> + *   Moiz Sonasath <m-sonasath@ti.com>
> + *   Abraham, Kishon Vijay <kishon@ti.com>
> + *   Eduardo Valentin <eduardo.valentin@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + */
> +
> +#ifndef __DRIVERS_OMAP_CONTROL_H
> +#define __DRIVERS_OMAP_CONTROL_H
> +
> +#include <linux/err.h>
> +
> +/**
> + * struct system control module - scm device structure
> + * @dev: device pointer
> + * @base: Base of the temp I/O
> + * @reg_lock: protect omap_control structure
> + * @use_count: track API users
> + */
> +struct omap_control {
> +	struct device		*dev;
> +	void __iomem		*base;
> +	/* protect this data structure and register access */
> +	spinlock_t		reg_lock;
> +	int			use_count;

I suppose the reg_lock and the use_count are not needed in this design?

> +};
> +
> +/* TODO: Add helpers for 16bit and byte access */
> +#ifdef CONFIG_MFD_OMAP_CONTROL
> +u32 omap_control_status_read(u16 offset);
> +#else
> +static inline u32 omap_control_status_read(u16 offset)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif /* __DRIVERS_OMAP_CONTROL_H */
> -- 
> 1.7.7.6
> 
> 
