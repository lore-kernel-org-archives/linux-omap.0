From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH] OMAP: PM: DMA: Enable runtime pm
Date: Tue, 25 Jan 2011 05:22:05 +0530
Message-ID: <20110124235205.GA6351@manju-desktop>
References: <1295860819-20142-1-git-send-email-manjugk@ti.com>
 <87d3nm7zb0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51878 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751211Ab1AXXwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 18:52:18 -0500
Received: by iwn8 with SMTP id 8so4797854iwn.20
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 15:52:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87d3nm7zb0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Kevin,

On Mon, Jan 24, 2011 at 01:43:31PM -0800, Kevin Hilman wrote:
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > From: Manjunath G Kondaiah <manjugk@ti.com>
> >
> > Enable runtime pm and use pm_runtime_get_sync and pm_runtime_put
> > for OMAP DMA driver.
> >
> > Since DMA driver callback will happen from interrupt context and
> > DMA client driver will release all DMA resources from interrupt
> > context itself, pm_runtime_put_sync() cannot be used in DMA driver.
> > Instead, pm_runtime_put() is used which is asynchronous call and
> > gets executed in work queue.
> 
> It's fine that the asynchronous version of put is uses (it's actually
> preferred.)  However, the description is confusing here.  You talk about
> driver callbacks here but in the patch, your calling _put() from
> omap_dma_free(), not from the callback.

All dma client drivers are calling omap_dma_free from callback context. I can
update this info in patch description if it is useful.

> 
> You're also calling _get() from the request.  That means, as long as the
> DMA channel is allocated, it will be active.   
> 
> Wouldn't it be better to do the 'get' when the channel is started

No. omap_dma_request will call omap_clear_dma which in turn access all channel
specific registers for writing zeros.

> and the 'put' when the callback has finished, possibly using the

after omap_free_dma, none of the dma registers are accessed hence it is safe to
use _put immediately after free_dma.
Also, dma driver is not aware of callback completion status since it will be
executed in client driver.

> 'autosuspend' feature with a timeout so that back-to-back DMA transfers
> will not have have additional latency between transfers?
> 
> > Boot tested on OMAP4 blaze and all applicable tests are executed
> > along with dma hwmod series.
> 
> Any OMAP2 or OMAP3 testing?
> 
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > ---
> > Discussion and alignment for using runtime API's in DMA can be accessed at:
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37819.html
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38355.html
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38391.html
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38400.html
> >
> >  arch/arm/plat-omap/dma.c |   18 +++++++++++++++++-
> >  1 files changed, 17 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index c4b2b47..48ee292 100644
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
> > @@ -58,6 +59,7 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
> >  #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
> >  
> >  static struct omap_system_dma_plat_info *p;
> > +static struct platform_device           *pd;
> >  static struct omap_dma_dev_attr *d;
> >  
> >  static int enable_1510_mode;
> > @@ -676,6 +678,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
> >  	unsigned long flags;
> >  	struct omap_dma_lch *chan;
> >  
> > +	pm_runtime_get_sync(&pd->dev);
> >  	spin_lock_irqsave(&dma_chan_lock, flags);
> >  	for (ch = 0; ch < dma_chan_count; ch++) {
> >  		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
> > @@ -686,6 +689,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
> >  	}
> >  	if (free_ch == -1) {
> >  		spin_unlock_irqrestore(&dma_chan_lock, flags);
> > +		pm_runtime_put(&pd->dev);
> >  		return -EBUSY;
> >  	}
> >  	chan = dma_chan + free_ch;
> > @@ -779,7 +783,7 @@ void omap_free_dma(int lch)
> >  		p->dma_write(0, CCR, lch);
> >  		omap_clear_dma(lch);
> >  	}
> > -
> > +	pm_runtime_put(&pd->dev);
> >  	spin_lock_irqsave(&dma_chan_lock, flags);
> >  	dma_chan[lch].dev_id = -1;
> >  	dma_chan[lch].next_lch = -1;
> > @@ -1979,6 +1983,7 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > +	pd			= pdev;
> 
> minor: platform_device pointers are more commonly named pdev
> 
> >  	d			= p->dma_attr;
> >  	errata			= p->errata;
> >  
> > @@ -2000,6 +2005,9 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
> >  		}
> >  	}
> >  
> > +	pm_runtime_enable(&pd->dev);
> > +	pm_runtime_get_sync(&pd->dev);
> > +
> >  	spin_lock_init(&dma_chan_lock);
> >  	for (ch = 0; ch < dma_chan_count; ch++) {
> >  		omap_clear_dma(ch);
> > @@ -2065,6 +2073,14 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
> >  		dma_chan[1].dev_id = 1;
> >  	}
> >  	p->show_dma_caps();
> > +
> > +	/*
> > +	 * Note: If dma channels are reserved through boot paramters,
> > +	 * then dma device is always enabled.
> > +	 */
> > +	if (!omap_dma_reserve_channels)
> > +		pm_runtime_put(&pd->dev);
> > +
> 
> Readability would be improved if there was an unconditional
> pm_runtime_put() at the end of this function preceeded by an extra
> pm_runtime_get() (async version) if reserve_channels has been used.
ok. I will update.

-Manjunath
