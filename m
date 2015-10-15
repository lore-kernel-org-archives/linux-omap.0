From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/13] dmaengine: edma: Optimize memcpy operation
Date: Thu, 15 Oct 2015 09:29:23 +0530
Message-ID: <20151015035923.GA27370@localhost>
References: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
 <1444828344-21378-3-git-send-email-peter.ujfalusi@ti.com>
 <20151014144105.GV27370@localhost>
 <561E6E7A.6080408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <561E6E7A.6080408-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 14, 2015 at 06:02:18PM +0300, Peter Ujfalusi wrote:
> On 10/14/2015 05:41 PM, Vinod Koul wrote:
> > On Wed, Oct 14, 2015 at 04:12:13PM +0300, Peter Ujfalusi wrote:
> >> @@ -1320,41 +1317,92 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
> >>  	struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> >>  	size_t len, unsigned long tx_flags)
> >>  {
> >> -	int ret;
> >> +	int ret, nslots;
> >>  	struct edma_desc *edesc;
> >>  	struct device *dev = chan->device->dev;
> >>  	struct edma_chan *echan = to_edma_chan(chan);
> >> -	unsigned int width;
> >> +	unsigned int width, pset_len;
> >>  
> >>  	if (unlikely(!echan || !len))
> >>  		return NULL;
> >>  
> >> -	edesc = kzalloc(sizeof(*edesc) + sizeof(edesc->pset[0]), GFP_ATOMIC);
> >> +	if (len < SZ_64K) {
> >> +		/*
> >> +		 * Transfer size less than 64K can be handled with one paRAM
> >> +		 * slot. ACNT = length
> >> +		 */
> >> +		width = len;
> >> +		pset_len = len;
> >> +		nslots = 1;
> >> +	} else {
> >> +		/*
> >> +		 * Transfer size bigger than 64K will be handled with maximum of
> >> +		 * two paRAM slots.
> >> +		 * slot1: ACNT = 32767, length1: (length / 32767)
> >> +		 * slot2: the remaining amount of data.
> >> +		 */
> >> +		width = SZ_32K - 1;
> >> +		pset_len = rounddown(len, width);
> >> +		/* One slot is enough for lengths multiple of (SZ_32K -1) */
> > 
> > Hmm so does this mean if I have 140K transfer, it will do two 64K for 1st
> > slot and 12K in second slot ?
> 
> Not exactly. If the size is less than 64K it can be done with one 'burst' but
> if it is bigger we need to have two sets of transfer:
> 1. 32K blocks
> 2. the remaining data
> 
> so in case of 140K:
> 4 x 32K followed by 12K

Okay this part wasn't very clear to me, can you please add some comment
explaining this bit

> 
> > 
> > Is there a limit on 'blocks' of 64K we can do here?
> 
> 32767 32K blocks is the limit.
> 
> The 64K burst is only possible if the whole transfer is less less than 64K.
> With the ACNT counter we can transfer 64K - 1 bytes, but if this is not enough
> we need to use the BCNT counter and for that to work the the distance between
> the start of 'slot n' and the start of 'slot n+1' need to be less than 32K,
> this is the reason why we have 32K 'blocks' to transfer first followed by the
> remaining.

Okay IIUC, we have option to single burst if its less that 64K using one
slot, otherwise split to 32K chunk with 2 slots, or would it be N in that
case

Really need more documentation here :)
-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
