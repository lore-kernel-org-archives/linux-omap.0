From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v4 2/4] mfd: omap: control: core system control driver
Date: Wed, 29 Aug 2012 12:33:26 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA21C6C@DBDE01.ent.ti.com>
References: <500FD2EC.7060208@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48644 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab2H2Mdu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Aug 2012 08:33:50 -0400
In-Reply-To: <500FD2EC.7060208@dev.rtsoft.ru>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>, "Cousson, Benoit" <b-cousson@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "Valentin, Eduardo" <eduardo.valentin@ti.com>

Hi Konstantin,

On Wed, Jul 25, 2012 at 16:35:16, Konstantin Baydarov wrote:
> This patch introduces a MFD core device driver for
> OMAP system control module.
> 
> The control module allows software control of
> various static modes supported by the device. It is
> composed of two control submodules: general control
> module and device (padconfiguration) control
> module.
> 
> Device driver is probed with postcore_initcall.
> Control module register CONTROL_STATUS that is needed
> by omap_type() is early mapped by postcore_initcall_sync.
> 
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
> ---
>  .../devicetree/bindings/mfd/omap_control.txt       |   32 ++++
>  arch/arm/mach-omap2/Kconfig                        |    1 +
>  arch/arm/plat-omap/Kconfig                         |    4 +
>  drivers/mfd/Kconfig                                |    6 +
>  drivers/mfd/Makefile                               |    1 +
>  drivers/mfd/omap-control-core.c                    |  162 ++++++++++++++++++++
>  include/linux/mfd/omap_control.h                   |   35 +++++
>  7 files changed, 241 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/omap_control.txt
>  create mode 100644 drivers/mfd/omap-control-core.c
>  create mode 100644 include/linux/mfd/omap_control.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/omap_control.txt b/Documentation/devicetree/bindings/mfd/omap_control.txt
> new file mode 100644
> index 0000000..a9dca9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/omap_control.txt
> @@ -0,0 +1,32 @@
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
> +OMAP CONTROL_STATUS register:
> +reg = <0x4A0022C4 0x4>; /* CONTROL_STATUS register */
> +
> +Examples:
> +ctrl_module_core: ctrl_module_core@4A0022C4 {
> +	compatible = "ti,omap4-control";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	/* ranges; */
> +	ti,hwmods = "ctrl_module_core";
> +	reg = <0x4A0022C4 0x4>; /* CONTROL_STATUS register */
> +};
> +
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index dd0fbf7..1235576 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -59,6 +59,7 @@ config ARCH_OMAP4
>  	select ARM_ERRATA_720789
>  	select ARCH_HAS_OPP
>  	select PM_RUNTIME if CPU_IDLE
> +	select ARCH_HAS_CONTROL_MODULE
>  	select PM_OPP if PM
>  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select ARM_CPU_SUSPEND if PM
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index dd36eba..2b2c9d8 100644
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
>  choice
>  	prompt "OMAP System Type"
>  	default ARCH_OMAP2PLUS
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 92144ed..530ac60 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -823,6 +823,12 @@ config MFD_WL1273_CORE
>  	  driver connects the radio-wl1273 V4L2 module and the wl1273
>  	  audio codec.
>  
> +config MFD_OMAP_CONTROL
> +	bool "Texas Instruments OMAP System control module"
> +	depends on ARCH_HAS_CONTROL_MODULE
> +	help
> +	  This is the core driver for system control module.
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
> index 0000000..cefbc5a
> --- /dev/null
> +++ b/drivers/mfd/omap-control-core.c
> @@ -0,0 +1,162 @@
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
> + *    Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
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
> +unsigned long omap_control_phys_base;
> +size_t omap_control_mapsize;
> +
> +u32 omap_control_status_read(void)
> +{
> +	return __raw_readl(omap_control_base);
> +}

In AM335X, D_CAN IP uses single CONTROL module register to
initialize D_CAN ram (D_CAN_RAMINIT). In order to enable
D_CAN RAM we have to write to that register in sync with
clock enable/disable.

How can I use this driver to handle this usecase? Similar to
above API?

Currently this is handled using platform call back (example below)

In arch/arm/mach-omap2/devices.c:
static void d_can_hw_raminit(unsigned int instance, unsigned int enable)
{
        u32 val;

        /* Read the value */
        val = readl(AM33XX_CTRL_REGADDR(AM33XX_DCAN_RAMINIT_OFFSET));
        if (enable) {
                /* Set to "1" */
                val &= ~AM33XX_DCAN_RAMINIT_START(instance);
                val |= AM33XX_DCAN_RAMINIT_START(instance);
                writel(val, AM33XX_CTRL_REGADDR(AM33XX_DCAN_RAMINIT_OFFSET));
        } else {
                /* Set to "0" */
                val &= ~AM33XX_DCAN_RAMINIT_START(instance);
                writel(val, AM33XX_CTRL_REGADDR(AM33XX_DCAN_RAMINIT_OFFSET));
        }
}

In drivers/net/can/c_can/c_can.c:
void d_can_reset_ram(struct d_can_priv *d_can, unsigned int instance,
                                        unsigned int enable)
{
        if (d_can->ram_init)
                d_can->ram_init(instance, enable);
}

Thanks
AnilKumar
