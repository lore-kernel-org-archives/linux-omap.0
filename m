From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/7] dmaengine: Add driver for TI DMA crossbar on DRA7x
Date: Thu, 26 Mar 2015 16:26:03 +0530
Message-ID: <20150326105603.GK32683@intel.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
 <1426080210-841-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426080210-841-4-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 11, 2015 at 03:23:26PM +0200, Peter Ujfalusi wrote:
> The DRA7x has more peripherals with DMA requests than the sDMA can handle:
> 205 vs 127. All DMA requests are routed through the DMA crossbar, which can
> be configured to route selected incoming DMA requests to specific sDMA
> request.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/dma/Kconfig           |   4 +
>  drivers/dma/Makefile          |   1 +
>  drivers/dma/ti-dma-crossbar.c | 190 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
>  create mode 100644 drivers/dma/ti-dma-crossbar.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 074ffad334a7..519657a37ca1 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -247,6 +247,9 @@ config TI_EDMA
>  	  Enable support for the TI EDMA controller. This DMA
>  	  engine is found on TI DaVinci and AM33xx parts.
>  
> +config TI_DMA_CROSSBAR
> +	bool
> +
>  config ARCH_HAS_ASYNC_TX_FIND_CHANNEL
>  	bool
>  
> @@ -332,6 +335,7 @@ config DMA_OMAP
>  	depends on ARCH_OMAP
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
> +	select TI_DMA_CROSSBAR if SOC_DRA7XX
>  
>  config DMA_BCM2835
>  	tristate "BCM2835 DMA engine support"
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index bf4485800c60..6ec7af6a416c 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
>  obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
>  obj-$(CONFIG_MMP_TDMA) += mmp_tdma.o
>  obj-$(CONFIG_DMA_OMAP) += omap-dma.o
> +obj-$(CONFIG_TI_DMA_CROSSBAR) += ti-dma-crossbar.o
>  obj-$(CONFIG_DMA_BCM2835) += bcm2835-dma.o
>  obj-$(CONFIG_MMP_PDMA) += mmp_pdma.o
>  obj-$(CONFIG_DMA_JZ4740) += dma-jz4740.o
> diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
> new file mode 100644
> index 000000000000..591307bd4370
> --- /dev/null
> +++ b/drivers/dma/ti-dma-crossbar.c
> @@ -0,0 +1,190 @@
> +/*
> + *  Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
> + *  Author: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
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
> +
> +#define TI_XBAR_OUTPUTS	127
> +#define TI_XBAR_INPUTS	256
Ideally this should be moved to DT. Will next revision of this chip always
support these output and inputs?

> +
> +static DEFINE_IDR(map_idr);
> +
> +struct ti_dma_xbar_data {
> +	struct dma_router dmarouter;
> +	struct regmap *regmap;
> +
> +	uint safe_val; /* Value to rest the crossbar lines */
> +	uint xbar_requests; /* number of DMA requests connected to XBAR */
> +	uint dma_requests; /* number of DMA requests forwarded to DMA */
> +
> +	void __iomem *iomem;
> +};
> +
> +struct ti_dma_xbar_map {
> +	int xbar_in;
> +	int xbar_out;
> +};
> +
> +static void ti_dma_xbar_free(struct device *dev, void *route_data)
> +{
> +	struct ti_dma_xbar_data *xbar = dev_get_drvdata(dev);
> +	struct ti_dma_xbar_map *map = route_data;
> +
> +	dev_dbg(dev, "Unmapping XBAR%d (was routed to %d)\n",
> +		map->xbar_in, map->xbar_out);
> +
> +	regmap_write(xbar->regmap, map->xbar_out * 2, 0);
just out of curiosity how much do you save using regmap :)

> +static int ti_dma_xbar_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct device_node *dma_node;
> +	struct ti_dma_xbar_data *xbar;
> +	struct resource *res;
> +	void __iomem *iomem;
> +	int i, ret;
> +
> +	if (!node)
> +		return -ENODEV;
> +
> +	dma_node = of_parse_phandle(node, "dma-device", 0);
> +	if (!dma_node) {
> +		dev_err(&pdev->dev, "Can't get target DMA node\n");
> +		return -ENODEV;
> +	}
> +
> +	xbar = devm_kzalloc(&pdev->dev, sizeof(*xbar), GFP_KERNEL);
> +	if (!xbar)
> +		return -ENOMEM;
> +
> +	if (of_property_read_u32(dma_node, "dma-requests",
> +				 &xbar->dma_requests)) {
> +		dev_info(&pdev->dev,
> +			 "Missing XBAR output information, using %u.\n",
> +			 TI_XBAR_OUTPUTS);
> +		xbar->dma_requests = TI_XBAR_OUTPUTS;
> +	}
> +	of_node_put(dma_node);
_put here?

> +int omap_dmaxbar_init(void)
> +{
> +	return platform_driver_register(&ti_dma_xbar_driver);
> +}
> +arch_initcall(omap_dmaxbar_init);
why arch_initcall?

-- 
~Vinod

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
