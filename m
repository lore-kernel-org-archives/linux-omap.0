From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/2] dmaengine: OMAP: Register SDMA controller with Device
 Tree DMA driver
Date: Wed, 6 Feb 2013 15:14:55 -0600
Message-ID: <5112C7CF.7010606@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com> <1360184596-1603-3-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55353 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757465Ab3BFVPH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Feb 2013 16:15:07 -0500
In-Reply-To: <1360184596-1603-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Matt Porter <mporter@ti.com>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Balaji T K <balajitk@ti.com>


On 02/06/2013 03:03 PM, Jon Hunter wrote:
> If the device-tree blob is present during boot, then register the SDMA
> controller with the device-tree DMA driver so that we can use device-tree
> to look-up DMA client information.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  drivers/dma/omap-dma.c |   31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index 5a31264..a32d81b 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -16,6 +16,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_device.h>
>  
>  #include "virt-dma.h"
>  
> @@ -67,6 +69,8 @@ static const unsigned es_bytes[] = {
>  	[OMAP_DMA_DATA_TYPE_S32] = 4,
>  };
>  
> +static struct of_dma_filter_info info;
> +
>  static inline struct omap_dmadev *to_omap_dma_dev(struct dma_device *d)
>  {
>  	return container_of(d, struct omap_dmadev, ddev);
> @@ -621,10 +625,25 @@ static int omap_dma_probe(struct platform_device *pdev)
>  		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
>  			rc);
>  		omap_dma_free(od);
> +		return rc;
>  	} else {
>  		platform_set_drvdata(pdev, od);
>  	}

I realise now that I could get rid of the else here and just call
platform_set_drvdata(), if we don't return.

Anyway, I will wait for other comments before changing.

Cheers
Jon
