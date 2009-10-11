From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH v1 2/2] OMAP3: add platform devices for ETM and ETB
Date: Sun, 11 Oct 2009 22:57:04 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D0CA0@dbde02.ent.ti.com>
References: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
 <1255279286-8904-2-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50708 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbZJKR2G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Oct 2009 13:28:06 -0400
In-Reply-To: <1255279286-8904-2-git-send-email-virtuoso@slind.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>, Russell King <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Alexander Shishkin wrote:
> This enables debug components found in omap3xxx.
> 
> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
> ---
>  arch/arm/mach-omap2/Kconfig  |    7 ++++
>  arch/arm/mach-omap2/Makefile |    3 ++
>  arch/arm/mach-omap2/emu.c    |   70 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/emu.c
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 75b1c7e..87bcc2a 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -88,3 +88,10 @@ config MACH_OMAP_ZOOM2
>  config MACH_OMAP_4430SDP
>  	bool "OMAP 4430 SDP board"
>  	depends on ARCH_OMAP4
> +
> +config OMAP3_EMU
> +	tristate "OMAP3 debugging peripherals"
> +	depends on ARCH_OMAP3 && OC_ETM
> +	help
> +	  Say Y here to enable debugging hardware of omap3
> +


The OMAP3 also has other debugging peripherals - the HWDEBUG pads
for instance. Maybe a better description is needed?


> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 6b7702f..572dd27 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -44,6 +44,9 @@ obj-$(CONFIG_ARCH_OMAP4)		+= cm4xxx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
>  
> +# EMU periferals
> +obj-$(CONFIG_OMAP3_EMU)		+= emu.o
> +
>  iommu-y					+= iommu2.o
>  iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
>  
> diff --git a/arch/arm/mach-omap2/emu.c b/arch/arm/mach-omap2/emu.c
> new file mode 100644
> index 0000000..f98874e
> --- /dev/null
> +++ b/arch/arm/mach-omap2/emu.c
> @@ -0,0 +1,70 @@
> +/*
> + * linux/arch/arm/mach-omap2/emu.c

Typically, we tend to leave out the full file-path, since the file might move
in future.

> + *
> + * ETM and ETB CoreSight components' resources as found in OMAP3xxx.
> + *
> + * Copyright (C) 2009 Nokia Corporation.
> + * Alexander Shishkin
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Alexander Shishkin");
> +
> +/* Cortex CoreSight components within omap3xxx EMU */
> +#define ETM_BASE	(L4_EMU_34XX_PHYS + 0x10000)
> +#define DBG_BASE	(L4_EMU_34XX_PHYS + 0x11000)
> +#define ETB_BASE	(L4_EMU_34XX_PHYS + 0x1b000)
> +#define DAPCTL		(L4_EMU_34XX_PHYS + 0x1d000)
> +
> +static struct resource rx51_etb_resource = {

Why rx51_*? Since this hardware is present in all omap3 chips, would
you consider calling them omap3_* instead?

> +	.start = ETB_BASE,
> +	.end   = ETB_BASE + SZ_4K,

Shouldn't this be ETB_BASE + SZ_4K - 1 ?

> +	.flags = IORESOURCE_MEM,
> +};
> +
> +static struct platform_device rx51_etb_device = {
> +	.name = "etb",
> +	.id   = -1,
> +	.num_resources = 1,
> +	.resource = &rx51_etb_resource,
> +};
> +
> +static struct resource rx51_etm_resource = {
> +	.start = ETM_BASE,
> +	.end   = ETM_BASE + SZ_4K,

Same here.

> +	.flags = IORESOURCE_MEM,
> +};
> +
> +static struct platform_device rx51_etm_device = {
> +	.name = "etm",
> +	.id   = -1,
> +	.num_resources = 1,
> +	.resource = &rx51_etm_resource,
> +};
> +
> +static struct platform_device *rx51_trace_devices[] = {
> +	&rx51_etm_device,
> +	&rx51_etb_device,
> +};
> +
> +static int __init emu_init(void)
> +{
> +	platform_add_devices(rx51_trace_devices,
> +			ARRAY_SIZE(rx51_trace_devices));
> +
> +	return 0;
> +}
> +
> +module_init(emu_init);
> +

Missing module_exit?
(I'm not even sure it's required. This is just an observation).


Regards,
Anand