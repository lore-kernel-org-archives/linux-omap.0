From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 2/6] dmaengine: Add driver for TI DMA crossbar on DRA7x
Date: Sat, 28 Feb 2015 17:00:58 +0100
Message-ID: <1425139258.24292.56.camel@x220>
References: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
	 <1424787683-19151-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:60682 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751706AbbB1QBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 28 Feb 2015 11:01:01 -0500
In-Reply-To: <1424787683-19151-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com

On Tue, 2015-02-24 at 16:21 +0200, Peter Ujfalusi wrote:
> The DRA7x has more peripherals with DMA requests than the sDMA can handle:
> 205 vs 127. All DMA requests are routed through the DMA crossbar, which can
> be configured to route selected incoming DMA requests to specific sDMA
> request.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/Kconfig           |   4 +
>  drivers/dma/Makefile          |   1 +
>  drivers/dma/ti-dma-crossbar.c | 191 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 196 insertions(+)
>  create mode 100644 drivers/dma/ti-dma-crossbar.c

A simple observation follows.

> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index a874b6ec6650..dfe72a0f46dc 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -245,6 +245,9 @@ config TI_EDMA
>  	  Enable support for the TI EDMA controller. This DMA
>  	  engine is found on TI DaVinci and AM33xx parts.
>  
> +config TI_DMA_CROSSBAR
> +	bool
> +

This is a bool symbol...

>  config ARCH_HAS_ASYNC_TX_FIND_CHANNEL
>  	bool
>  
> @@ -330,6 +333,7 @@ config DMA_OMAP
>  	depends on ARCH_OMAP
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
> +	select TI_DMA_CROSSBAR if SOC_DRA7XX
>  
>  config DMA_BCM2835
>  	tristate "BCM2835 DMA engine support"
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index f915f61ec574..bc12f9a4e62b 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
>  obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
>  obj-$(CONFIG_MMP_TDMA) += mmp_tdma.o
>  obj-$(CONFIG_DMA_OMAP) += omap-dma.o
> +obj-$(CONFIG_TI_DMA_CROSSBAR) += ti-dma-crossbar.o

... so this file will be either not built or built into the kernel...

>  obj-$(CONFIG_DMA_BCM2835) += bcm2835-dma.o
>  obj-$(CONFIG_MMP_PDMA) += mmp_pdma.o
>  obj-$(CONFIG_DMA_JZ4740) += dma-jz4740.o
> diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
> new file mode 100644
> index 000000000000..bf01434df46a
> --- /dev/null
> +++ b/drivers/dma/ti-dma-crossbar.c
> @@ -0,0 +1,191 @@
> +/*
> + *  Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/io.h>
> +#include <linux/regmap.h>
> +#include <linux/idr.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/module.h>

...  this includes linux/module.h ...

[...]

> +static struct platform_driver ti_dma_xbar_driver = {
> +	.probe	= ti_dma_xbar_probe,
> +	.driver = {
> +		.name = "ti-dma-crossbar",
> +		.owner = THIS_MODULE,

... is that needed to make this work?

> +		.of_match_table = of_match_ptr(ti_dma_xbar_match),
> +	},
> +};
> +
> +int omap_dmaxbar_init(void)
> +{
> +	return platform_driver_register(&ti_dma_xbar_driver);
> +}
> +arch_initcall(omap_dmaxbar_init);
> +
> +MODULE_DESCRIPTION("TI DMA Crossbar");
> +MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
> +MODULE_LICENSE("GPL");

And why are these three macros needed?

By the way: there's a mismatch between the header (which is GPL v2) and
the MODULE_LICENSE() string (which means GPL v2 or later).

Paul Bolle

