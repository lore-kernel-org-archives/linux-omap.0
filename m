From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] dmaengine: omap-dma: Do not call omap_dma_callback()
 from tx_status()
Date: Fri, 26 Feb 2016 11:25:25 +0000
Message-ID: <20160226112524.GP5783@n2100.arm.linux.org.uk>
References: <1456388939-15722-1-git-send-email-peter.ujfalusi@ti.com>
 <20160226010658.GN5783@n2100.arm.linux.org.uk>
 <56D0279F.2050703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56D0279F.2050703@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 26, 2016 at 12:23:27PM +0200, Peter Ujfalusi wrote:
> On 2016-02-26 03:06, Russell King - ARM Linux wrote:
> > On Thu, Feb 25, 2016 at 10:28:59AM +0200, Peter Ujfalusi wrote:
> >> When based on the CCR_ENABLE bit the channel is stopped we should not call
> >> omap_dma_callback(), only change the return value to DMA_COMPLETE. Client
> >> drivers will do the right thing to clean up the channel after the transfer
> >> has been completed.
> >> Check the CCR_ENABLE only if the channel is not paused since pause in sDMA
> >> means that the channel is stopped.
> >> This will fix one hard to reproduce race condition when the channel is
> >> terminated during transfer (affecting cyclic operation).
> >>
> >> Fixes: 1a7cf7b26f25 ("dmaengine: omap-dma: Handle cases when the channel is polled for completion")
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  drivers/dma/omap-dma.c | 16 ++++++++++------
> >>  1 file changed, 10 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> >> index f6bef0d93998..a6b189fdbbe6 100644
> >> --- a/drivers/dma/omap-dma.c
> >> +++ b/drivers/dma/omap-dma.c
> >> @@ -671,18 +671,22 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
> >>  	struct omap_chan *c = to_omap_dma_chan(chan);
> >>  	struct virt_dma_desc *vd;
> >>  	enum dma_status ret;
> >> -	uint32_t ccr;
> >>  	unsigned long flags;
> >>  
> >> -	ccr = omap_dma_chan_read(c, CCR);
> >> -	/* The channel is no longer active, handle the completion right away */
> >> -	if (!(ccr & CCR_ENABLE))
> >> -		omap_dma_callback(c->dma_ch, 0, c);
> >> -
> >>  	ret = dma_cookie_status(chan, cookie, txstate);
> >>  	if (ret == DMA_COMPLETE || !txstate)
> >>  		return ret;
> >>  
> >> +	if (!c->paused) {
> >> +		uint32_t ccr = omap_dma_chan_read(c, CCR);
> >> +		/*
> >> +		 * The channel is no longer active, set the return value
> >> +		 * accordingly
> >> +		 */
> >> +		if (!(ccr & CCR_ENABLE))
> >> +			ret = DMA_COMPLETE;
> >> +	}
> >> +
> > 
> > This looks very much like a hack, and surely opens a race condition
> > up: what happens when a request submitted and pending but not yet
> > started?  If the channel is idle, requesting status will report
> > that the request has completed.
> > 
> > It's also wrong for another reason.  If txstate is NULL...
> 
> True, I have fixed these up.
> 
> > Your original commit adding the original hack that you're now removing
> > above says that this is to support polled operation: I'm not aware of
> > DMA engine supporting such a mode.  DMA_PREP_INTERRUPT is a mechanism
> > where requests can be queued without an interrupt to allow batching.
> 
> Also it is used to suppress DMA interrupts during audio playback for example.
> In this case we will run w/o interrupts and the position is polled.
> 
> > See the raid5/async_tx code, which queues a set of operations without
> > DMA_PREP_INTERRUPT, with the final operation with DMA_PREP_INTERRUPT
> > set.
> 
> We only allow the interrupts to be disabled in cyclic or memcpy mode. With
> slave_sg we have interrupts as it is needed to move to the next SG.
> 
> > As the driver is reliant on interrupts to move to the next transfer,
> > the patch which causes DMA_PREP_INTERRUPT to influence whether
> > interrupts are sent is actually buggy, and will prevent several
> > queued DMA operations to fail.
> 
> Yes, the omap-dma only allows the interrupts to be actually disabled when it
> is save to do so. slave_sg can not work w/o interrupts so there we don't
> disable them.

I get the impression that you haven't taken in what I've said, because
each fragment of your reply is just repeating what the previous fragment
said.

Let me state that I don't believe you need any hacks here, and this patch
is not necessary: the final operation in a set of chained memcpy()s should
have DMA_PREP_INTERRUPT set.

For the periodic stuff for audio, it's irrelevant anyway: periodic
transfers never complete - you can start them, and they continue running
until terminated.  There's no completion.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
