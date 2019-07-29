From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 2/2] dmaengine: ti: omap-dma: Improved memcpy polling
 support
Date: Mon, 29 Jul 2019 11:46:34 +0530
Message-ID: <20190729061634.GD12733@vkoul-mobl.Dlink>
References: <20190716082459.1222-1-peter.ujfalusi@ti.com>
 <20190716082459.1222-3-peter.ujfalusi@ti.com>
 <20190725133748.GX12733@vkoul-mobl.Dlink>
 <59794775-95e6-04c3-2660-9344c89df9a1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <59794775-95e6-04c3-2660-9344c89df9a1@ti.com>
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

On 25-07-19, 17:07, Peter Ujfalusi wrote:
> 
> 
> On 25/07/2019 16.37, Vinod Koul wrote:
> > On 16-07-19, 11:24, Peter Ujfalusi wrote:
> >> When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
> >> does not want to use interrupts for DMA completion or because it can not
> >> rely on DMA interrupts due to executing the memcpy when interrupts are
> >> disabled it will poll the status of the transfer.
> >>
> >> If the interrupts are enabled then the cookie will be set completed in the
> >> interrupt handler so only check in HW completion when the polling is really
> >> needed.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  drivers/dma/ti/omap-dma.c | 44 +++++++++++++++++++++++++--------------
> >>  1 file changed, 28 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> >> index 029c0bd550d5..966d8f0323b5 100644
> >> --- a/drivers/dma/ti/omap-dma.c
> >> +++ b/drivers/dma/ti/omap-dma.c
> >> @@ -91,6 +91,7 @@ struct omap_desc {
> >>  	bool using_ll;
> >>  	enum dma_transfer_direction dir;
> >>  	dma_addr_t dev_addr;
> >> +	bool polled;
> >>  
> >>  	int32_t fi;		/* for OMAP_DMA_SYNC_PACKET / double indexing */
> >>  	int16_t ei;		/* for double indexing */
> >> @@ -815,26 +816,20 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
> >>  	struct virt_dma_desc *vd;
> >>  	enum dma_status ret;
> >>  	unsigned long flags;
> >> +	struct omap_desc *d = NULL;
> >>  
> >>  	ret = dma_cookie_status(chan, cookie, txstate);
> >> -
> >> -	if (!c->paused && c->running) {
> >> -		uint32_t ccr = omap_dma_chan_read(c, CCR);
> >> -		/*
> >> -		 * The channel is no longer active, set the return value
> >> -		 * accordingly
> >> -		 */
> >> -		if (!(ccr & CCR_ENABLE))
> >> -			ret = DMA_COMPLETE;
> >> -	}
> >> -
> >> -	if (ret == DMA_COMPLETE || !txstate)
> >> +	if (ret == DMA_COMPLETE)
> > 
> > why do you want to continue for txstate being null?
> 
> The caller could opt to not provide txstate and I still need to check if
> the non completed transfer is actually done by the HW or not.
> 
> > Also it would lead to NULL ptr deref for txstate
> 
> There is a !txstate check to avoid that.
> 
> > 
> >>  		return ret;
> >>  
> >>  	spin_lock_irqsave(&c->vc.lock, flags);
> >> +	if (c->desc && c->desc->vd.tx.cookie == cookie)
> >> +		d = c->desc;
> >> +
> >> +	if (!txstate)
> >> +		goto out;

Oops missed that, let me check again and do the needful

-- 
~Vinod
