From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: ti-dma-crossbar: Fix possible race condition
 with dma_inuse
Date: Thu, 21 Sep 2017 23:00:13 +0530
Message-ID: <20170921173013.GL30097@localhost>
References: <20170921113532.15297-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170921113532.15297-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 21, 2017 at 02:35:32PM +0300, Peter Ujfalusi wrote:
> When looking for unused xbar_out lane we should also protect the set_bit()
> call with the same mutex to protect against concurrent threads picking the
> same ID.

Applied, thanks

Just a note, somehow the patches from you only are getting mangled for me.
Curiously, the ones in patchworks are fine and I used to apply that, not sure
what mail servers at our work places are doing!!

> 
> Fixes: ec9bfa1e1a796 ("dmaengine: ti-dma-crossbar: dra7: Use bitops instead of idr")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/dma/ti-dma-crossbar.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
> index 10ef9d5d5a66..7df910e7c348 100644
> --- a/drivers/dma/ti-dma-crossbar.c
> +++ b/drivers/dma/ti-dma-crossbar.c
> @@ -262,13 +262,14 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>  	mutex_lock(&xbar->mutex);
>  	map->xbar_out = find_first_zero_bit(xbar->dma_inuse,
>  					    xbar->dma_requests);
> -	mutex_unlock(&xbar->mutex);
>  	if (map->xbar_out == xbar->dma_requests) {
> +		mutex_unlock(&xbar->mutex);
>  		dev_err(&pdev->dev, "Run out of free DMA requests\n");
>  		kfree(map);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  	set_bit(map->xbar_out, xbar->dma_inuse);
> +	mutex_unlock(&xbar->mutex);
>  
>  	map->xbar_in = (u16)dma_spec->args[0];
>  
> -- 
> 2.14.1
> 
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> 

-- 
~Vinod
