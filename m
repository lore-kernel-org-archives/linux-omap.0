From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 2/2] dmaengine: ti: omap-dma: Improved memcpy polling
 support
Date: Thu, 25 Jul 2019 19:07:48 +0530
Message-ID: <20190725133748.GX12733@vkoul-mobl.Dlink>
References: <20190716082459.1222-1-peter.ujfalusi@ti.com>
 <20190716082459.1222-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190716082459.1222-3-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 16-07-19, 11:24, Peter Ujfalusi wrote:
> When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
> does not want to use interrupts for DMA completion or because it can not
> rely on DMA interrupts due to executing the memcpy when interrupts are
> disabled it will poll the status of the transfer.
> 
> If the interrupts are enabled then the cookie will be set completed in the
> interrupt handler so only check in HW completion when the polling is really
> needed.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/omap-dma.c | 44 +++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 029c0bd550d5..966d8f0323b5 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -91,6 +91,7 @@ struct omap_desc {
>  	bool using_ll;
>  	enum dma_transfer_direction dir;
>  	dma_addr_t dev_addr;
> +	bool polled;
>  
>  	int32_t fi;		/* for OMAP_DMA_SYNC_PACKET / double indexing */
>  	int16_t ei;		/* for double indexing */
> @@ -815,26 +816,20 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
>  	struct virt_dma_desc *vd;
>  	enum dma_status ret;
>  	unsigned long flags;
> +	struct omap_desc *d = NULL;
>  
>  	ret = dma_cookie_status(chan, cookie, txstate);
> -
> -	if (!c->paused && c->running) {
> -		uint32_t ccr = omap_dma_chan_read(c, CCR);
> -		/*
> -		 * The channel is no longer active, set the return value
> -		 * accordingly
> -		 */
> -		if (!(ccr & CCR_ENABLE))
> -			ret = DMA_COMPLETE;
> -	}
> -
> -	if (ret == DMA_COMPLETE || !txstate)
> +	if (ret == DMA_COMPLETE)

why do you want to continue for txstate being null?
Also it would lead to NULL ptr deref for txstate

>  		return ret;
>  
>  	spin_lock_irqsave(&c->vc.lock, flags);
> +	if (c->desc && c->desc->vd.tx.cookie == cookie)
> +		d = c->desc;
> +
> +	if (!txstate)
> +		goto out;
>  
> -	if (c->desc && c->desc->vd.tx.cookie == cookie) {
> -		struct omap_desc *d = c->desc;
> +	if (d) {
>  		dma_addr_t pos;
>  
>  		if (d->dir == DMA_MEM_TO_DEV)
> @@ -851,8 +846,22 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
>  		txstate->residue = 0;
>  	}
>  
> -	if (ret == DMA_IN_PROGRESS && c->paused)
> +out:
> +	if (ret == DMA_IN_PROGRESS && c->paused) {
>  		ret = DMA_PAUSED;
> +	} else if (d && d->polled && c->running) {
> +		uint32_t ccr = omap_dma_chan_read(c, CCR);
> +		/*
> +		 * The channel is no longer active, set the return value
> +		 * accordingly and mark it as completed
> +		 */
> +		if (!(ccr & CCR_ENABLE)) {
> +			struct omap_desc *d = c->desc;
> +			ret = DMA_COMPLETE;
> +			omap_dma_start_desc(c);
> +			vchan_cookie_complete(&d->vd);
> +		}
> +	}
>  
>  	spin_unlock_irqrestore(&c->vc.lock, flags);
>  
> @@ -1180,7 +1189,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
>  	d->ccr = c->ccr;
>  	d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_POSTINC;
>  
> -	d->cicr = CICR_DROP_IE | CICR_FRAME_IE;
> +	if (tx_flags & DMA_PREP_INTERRUPT)
> +		d->cicr |= CICR_FRAME_IE;
> +	else
> +		d->polled = true;
>  
>  	d->csdp = data_type;
>  
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
