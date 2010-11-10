From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 13/13] OMAP: PM: DMA: Enable runtime pm
Date: Wed, 10 Nov 2010 19:32:19 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CC1@dbde02.ent.ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-14-git-send-email-manjugk@ti.com>
 <87fwvajepy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41626 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755816Ab0KJOC2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 09:02:28 -0500
In-Reply-To: <87fwvajepy.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Wednesday, November 10, 2010 4:18 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Cousson, Benoit; 
> Shilimkar, Santosh
> Subject: Re: [PATCH v3 13/13] OMAP: PM: DMA: Enable runtime pm
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > Enable runtime pm and use pm_runtime_get and pm_runtime_put
> > for OMAP DMA driver.
> >
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/plat-omap/dma.c |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index 41b14b0..feac7ee 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> >  #include <linux/delay.h>
> > +#include <linux/pm_runtime.h>
> >  
> >  #include <asm/system.h>
> >  #include <mach/hardware.h>
> > @@ -367,6 +368,8 @@ int omap_request_dma(int dev_id, const 
> char *dev_name,
> >  	chan = dma_chan + free_ch;
> >  	chan->dev_id = dev_id;
> >  
> > +	pm_runtime_get(&pd->dev);
> 
> The _get() call is asynchronous.  So if the device was actually
> idled/disabled, immediately after this call it may still be
> idle/disabled.   When using the asynchronous versions of the API, the
> device should not be touched until the driver's ->runtime_resume()
> callback is called.

driver runtime_resume will call omap_device_enable. How do we make 
we check from driver side, whether omap_device_enable execution is complete
or not.

> 
> >  	if (d->dev_caps & IS_WORD_16)
> >  		p->clear_lch_regs(free_ch);
> >  	else
> > @@ -452,6 +455,7 @@ void omap_free_dma(int lch)
> >  		omap_clear_dma(lch);
> >  		p->clear_dma_sglist_mode(lch);
> >  	}
> > +	pm_runtime_put(&pd->dev);
> >  	spin_lock_irqsave(&dma_chan_lock, flags);
> >  	dma_chan[lch].dev_id = -1;
> >  	dma_chan[lch].next_lch = -1;
> > @@ -819,6 +823,11 @@ static int __devinit 
> omap_system_dma_probe(struct platform_device *pdev)
> >  	dma_chan_count		= d->chan_count;
> >  	dma_chan		= d->chan;
> >  
> > +	/* Enable run time PM */
> 
> comment is redundant

ok.

> 
> > +	pm_runtime_enable(&pd->dev);
> > +
> > +	/* Accessing hw registers, get clock */
> 
> comment is wrong, driver doesn't know anything about clocks.
> Just drop comment as it doesn't tell you anything that the following
> 'get' doesn't.
> 
> > +	pm_runtime_get(&pd->dev);
> 
> see above Re: async calls.
> 
> >  	for (ch = 0; ch < dma_chan_count; ch++) {
> >  		unsigned long flags;
> >  		omap_clear_dma(ch);
> > @@ -846,6 +855,10 @@ static int __devinit 
> omap_system_dma_probe(struct platform_device *pdev)
> >  		dma_chan[0].dev_id = 0;
> >  		dma_chan[1].dev_id = 1;
> >  	}
> > +
> > +	if (!omap_dma_reserve_channels)
> > +		pm_runtime_put(&pd->dev);
> > +
> 
> So if the reserve channels feature is used, PM is essentially disabled
> for sDMA.  You should add a warning here to that effect as well.

I will add warning comment.

-Manjunath