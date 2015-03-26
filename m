From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 4/7] dmaengine: omap-dma: Use defines for dma channels
 and request count
Date: Thu, 26 Mar 2015 16:27:12 +0530
Message-ID: <20150326105712.GL32683@intel.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
 <1426080210-841-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426080210-841-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 11, 2015 at 03:23:27PM +0200, Peter Ujfalusi wrote:
> Instead of magic numbers in the code, use define for number of logical DMA
> channels and DMA requests.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/omap-dma.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index 7dd6dd121681..56c33e93dd24 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -22,6 +22,9 @@
>  
>  #include "virt-dma.h"
>  
> +#define OMAP_SDMA_REQUESTS	127
> +#define OMAP_SDMA_CHANNELS	32
Again why dont we put these things in DT ?

-- 
~Vinod
> +
>  struct omap_dmadev {
>  	struct dma_device ddev;
>  	spinlock_t lock;
> @@ -33,7 +36,7 @@ struct omap_dmadev {
>  	bool legacy;
>  	spinlock_t irq_lock;
>  	uint32_t irq_enable_mask;
> -	struct omap_chan *lch_map[32];
> +	struct omap_chan *lch_map[OMAP_SDMA_CHANNELS];
>  };
>  
>  struct omap_chan {
> @@ -1115,7 +1118,7 @@ static int omap_dma_probe(struct platform_device *pdev)
>  
>  	tasklet_init(&od->task, omap_dma_sched, (unsigned long)od);
>  
> -	for (i = 0; i < 127; i++) {
> +	for (i = 0; i < OMAP_SDMA_REQUESTS; i++) {
>  		rc = omap_dma_chan_init(od, i);
>  		if (rc) {
>  			omap_dma_free(od);
> -- 
> 2.3.0
> 

-- 
