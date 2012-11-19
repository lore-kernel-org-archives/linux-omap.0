From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch
 data
Date: Mon, 19 Nov 2012 09:49:18 -0700
Message-ID: <20121119164918.GC9758@animalcreek.com>
References: <20121018222046.GA28541@animalcreek.com>
 <50AA0388.4020803@ti.com>
 <20121119161915.GA9758@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:33657 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab2KSQtV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 11:49:21 -0500
Content-Disposition: inline
In-Reply-To: <20121119161915.GA9758@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

On Mon, Nov 19, 2012 at 09:19:15AM -0700, Mark A. Greer wrote:
> On Mon, Nov 19, 2012 at 11:01:44AM +0100, Peter Ujfalusi wrote:
> > Hi,
> > 
> > On 10/19/2012 12:20 AM, Mark A. Greer wrote:
> > > Enable DMA prefetching by setting the 'OMAP_DMA_DST_SYNC_PREFETCH'
> > > flag whenever there is a destination synchronized DMA transfer.
> > > Prefetching is not allowed on source synchronized DMA transfers.
> > > 
> > > Enabling prefetch significantly improves DMA performance.
> > > For example, running 'modprobe tcrypt sec=2 mode=403' which
> > > exercises the omap-sham driver on an am37x EVM yeilds the
> > > following results:
> > 
> > >  drivers/dma/omap-dma.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> > > index bb2d8e7..aadddb2 100644
> > > --- a/drivers/dma/omap-dma.c
> > > +++ b/drivers/dma/omap-dma.c
> > > @@ -310,7 +310,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
> > >  		dev_addr = c->cfg.dst_addr;
> > >  		dev_width = c->cfg.dst_addr_width;
> > >  		burst = c->cfg.dst_maxburst;
> > > -		sync_type = OMAP_DMA_DST_SYNC;
> > > +		sync_type = OMAP_DMA_DST_SYNC | OMAP_DMA_DST_SYNC_PREFETCH;
> > 
> > This should be:
> >  -		sync_type = OMAP_DMA_DST_SYNC;
> >  +		sync_type = OMAP_DMA_DST_SYNC_PREFETCH;
> 
> Ah, right.  I will fix.
> 
> > >  	} else {
> > >  		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
> > >  		return NULL;
> > > @@ -387,7 +387,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
> > >  		dev_addr = c->cfg.dst_addr;
> > >  		dev_width = c->cfg.dst_addr_width;
> > >  		burst = c->cfg.dst_maxburst;
> > > -		sync_type = OMAP_DMA_DST_SYNC;
> > > +		sync_type = OMAP_DMA_DST_SYNC | OMAP_DMA_DST_SYNC_PREFETCH;
> > 
> > We should not enable the prefetch for cyclic right now. We will investigate it
> > more.
> 
> OK.  I'll send a patch in a few minutes.

https://patchwork.kernel.org/patch/1765941/
