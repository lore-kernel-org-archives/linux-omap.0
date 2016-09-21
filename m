From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 8/9] dmaengine: ti-dma-crossbar: Use enum for crossbar
 type
Date: Wed, 21 Sep 2016 09:22:26 +0530
Message-ID: <20160921035226.GE2609@localhost>
References: <20160916083324.29133-1-peter.ujfalusi@ti.com>
 <20160916083324.29133-9-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160916083324.29133-9-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, arnd@arndb.de, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 16, 2016 at 11:33:23AM +0300, Peter Ujfalusi wrote:
> Fixes compiler warning on 64bit architectures.

Would be good to give the warning message here

> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti-dma-crossbar.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
> index e4f3bd1ae264..876e4ccaf033 100644
> --- a/drivers/dma/ti-dma-crossbar.c
> +++ b/drivers/dma/ti-dma-crossbar.c
> @@ -16,8 +16,10 @@
>  #include <linux/of_device.h>
>  #include <linux/of_dma.h>
>  
> -#define TI_XBAR_DRA7		0
> -#define TI_XBAR_AM335X		1
> +enum ti_xbar_type {
> +	TI_XBAR_DRA7 = 0,
> +	TI_XBAR_AM335X,
> +};
>  
>  static const struct of_device_id ti_dma_xbar_match[] = {
>  	{
> @@ -395,7 +397,7 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
>  
>  	xbar->dmarouter.dev = &pdev->dev;
>  	xbar->dmarouter.route_free = ti_dra7_xbar_free;
> -	xbar->dma_offset = (u32)match->data;
> +	xbar->dma_offset = (enum ti_xbar_type)match->data;
>  
>  	mutex_init(&xbar->mutex);
>  	platform_set_drvdata(pdev, xbar);
> @@ -428,7 +430,7 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
>  	if (unlikely(!match))
>  		return -EINVAL;
>  
> -	switch ((u32)match->data) {
> +	switch ((enum ti_xbar_type)match->data) {
>  	case TI_XBAR_DRA7:
>  		ret = ti_dra7_xbar_probe(pdev);
>  		break;
> -- 
> 2.10.0
> 

-- 
~Vinod
