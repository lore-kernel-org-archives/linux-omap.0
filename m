From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: DMA: Fix for sDMA Errata 1.113
Date: Wed, 1 Oct 2008 15:12:03 +0300
Message-ID: <20081001121202.GH15017@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB028C45E9AD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52708 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbYJAMJJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 08:09:09 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB028C45E9AD@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [081001 14:09]:
> > -----Original Message-----
> > From: Shilimkar, Santosh 
> > Sent: Thursday, September 25, 2008 3:31 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Pandita, Vikram
> > Subject: [PATCH] ARM: OMAP3: DMA: Fix for sDMA Errata 1.113
> > 
> > From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > 
> > SDMA channel is not disabled after transaction error. So 
> > explicitly disable it.
> > 
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Acked By : Nishant kamat <nskamat@ti.com>
> > ---
> > Index: linux-omap-2.6/arch/arm/plat-omap/dma.c
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/plat-omap/dma.c 2008-09-23 16:41:23.000000000 +0530
> > +++ linux-omap-2.6/arch/arm/plat-omap/dma.c	2008-09-25 14:54:00.162059260 +0530
> > @@ -1849,9 +1849,22 @@ static int omap2_dma_handle_ch(int ch)
> >  		printk(KERN_INFO
> >  		       "DMA synchronization event drop occurred 
> > with device "
> >  		       "%d\n", dma_chan[ch].dev_id);
> > -	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ))
> > +	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ)) {
> >  		printk(KERN_INFO "DMA transaction error with 
> > device %d\n",
> >  		       dma_chan[ch].dev_id);
> > +		if (cpu_class_is_omap2()) {
> > +			/* Errata: sDMA Channel is not disabled
> > +			 * after a transaction error. So we explicitely
> > +			 * disable the channel
> > +			 */
> > +			u32 ccr;
> > +
> > +			ccr = dma_read(CCR(ch));
> > +			ccr &= ~OMAP_DMA_CCR_EN;
> > +			dma_write(ccr, CCR(ch));
> > +			dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
> > +		}
> > +	}
> >  	if (unlikely(status & OMAP2_DMA_SECURE_ERR_IRQ))
> >  		printk(KERN_INFO "DMA secure error with device %d\n",
> >  		       dma_chan[ch].dev_id);
> 
> Tony,
> What about this patch ?--

Looks OK, I'll add it and queue it up for upstream too.

Tony
