From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: ti: edma: Enable support for polled (memcpy)
 completion
Date: Tue, 21 May 2019 10:34:30 +0530
Message-ID: <20190521050430.GS15118@vkoul-mobl>
References: <20190514080909.10306-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190514080909.10306-1-peter.ujfalusi@ti.com>
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

On 14-05-19, 11:09, Peter Ujfalusi wrote:
> When a DMA client driver decides that it is not providing callback for
> completion of a transfer (and/or does not set the DMA_PREP_INTERRUPT) but
> it will poll the status of the transfer (in case of short memcpy for
> example) we will not get interrupt for the completion of the transfer and
> will not mark the transaction as done.
> 
> Check the event registers (ER and EER) and if the channel is inactive then
> return wioth DMA_COMPLETE to let the client know that the transfer is
        ^^^^^
Typo

> completed.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/edma.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index ceabdea40ae0..7501445af069 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -1211,8 +1211,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
>  
>  	edesc->pset[0].param.opt |= ITCCHEN;
>  	if (nslots == 1) {
> -		/* Enable transfer complete interrupt */
> -		edesc->pset[0].param.opt |= TCINTEN;
> +		/* Enable transfer complete interrupt if requested */
> +		if (tx_flags & DMA_PREP_INTERRUPT)
> +			edesc->pset[0].param.opt |= TCINTEN;
>  	} else {
>  		/* Enable transfer complete chaining for the first slot */
>  		edesc->pset[0].param.opt |= TCCHEN;
> @@ -1239,7 +1240,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
>  		}
>  
>  		edesc->pset[1].param.opt |= ITCCHEN;
> -		edesc->pset[1].param.opt |= TCINTEN;
> +		/* Enable transfer complete interrupt if requested */
> +		if (tx_flags & DMA_PREP_INTERRUPT)
> +			edesc->pset[1].param.opt |= TCINTEN;
>  	}
>  
>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
> @@ -1801,6 +1804,20 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
>  	unsigned long flags;
>  
>  	ret = dma_cookie_status(chan, cookie, txstate);
> +
> +	if (ret != DMA_COMPLETE && echan->edesc && !echan->edesc->cyclic) {
> +		struct edma_cc *ecc = echan->ecc;
> +		int channel = EDMA_CHAN_SLOT(echan->ch_num);
> +		int j = (channel >> 5);
> +		unsigned int mask = BIT(channel & 0x1f);

GENMASK or define a macro instead of a magic number?

> +		unsigned int sh_er = edma_shadow0_read_array(ecc, SH_ER, j);
> +		unsigned int sh_eer = edma_shadow0_read_array(ecc, SH_EER, j);
> +
> +		/* The channel is no longer active */
> +		if (!(sh_er & mask) && !(sh_eer & mask))
> +			ret = DMA_COMPLETE;
> +	}
> +
>  	if (ret == DMA_COMPLETE || !txstate)
>  		return ret;
>  
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
