From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH][OMAP3][sDMA] : Fixing the DMA chain transfer callback.
Date: Thu, 18 Dec 2008 20:01:25 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB0297E9B5F9@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB0297DA1826@dbde02.ent.ti.com>
 <20081218140748.GE30366@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35991 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbYLRObh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 09:31:37 -0500
In-Reply-To: <20081218140748.GE30366@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "'linux-omap@vger.kernel.org'" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Thursday, December 18, 2008 7:38 PM
> To: Shilimkar, Santosh
> Cc: 'linux-omap@vger.kernel.org'
> Subject: Re: [PATCH][OMAP3][sDMA] : Fixing the DMA chain 
> transfer callback.
> 
> Hi,
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [081216 14:05]:
> > Tony,
> > Here is the patch for DMA to ease the chaining usage. OMAP 
> mcbsp drivers makes use of this chaining feature but it's not 
> pushed on mainline yet. It's available on zoom tree. Link for 
> the same driver. 
> http://git.omapzoom.org/?p=omapkernel.git;a=blob;f=arch/arm/ma
> ch-omap2/mcbsp.c;h=ce726c5d27eedb678ad3f981e2f5e08134e44e27;hb
> =2af15d1d7931a7c928d84057ed4494b77769de12
> 
> Hmm, the omap2_mcbsp_rx_dma_callback() and 
> omap2_mcbsp_tx_dma_callback()
> don't even use the lch parameter passed to them in the example above.
I gave this driver link just to say that we do have one driver on open source which is using chaining. The implementation is like that because this driver is also pushed on ZOOM tree and their the chain_id is no more passed as part of the callback. Also mcBSP, chains only two channels for tx and rx each with separate callbacks. So not makes much impact.

I agree that we don't have driver which shows this issue, but in the test code which chains 4-5 channels and run similar 3 modules together, you can see it's cumbersome to handle in callbacks.
 
> And can't you just use the data->chain_id to get the chain in the
> callback function?
Yes you can do that but then user have to store the chain_id in the 'data' when doing 'requset_dma_chain'. And if we want to do that, then their no pint of having a redundant "ch" info in the chained callbacks.Because channel number is useful only for normal dma transfers. More over in the kernel, we don't need any extra variable to store the chain_id since its already part of the dma channel structure. 
> Tony
> 

Regards
Santosh

> 
> > 
> > 
> > From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > 
> > This patch reverts back the change done on OMAP dma 
> library. It corrects the chaining callback and reduces the 
> complexity for the DMA users in chaining. So with this patch, 
> drivers making use of OMAP DMA chaining feature need not 
> built any intelligence for chain related transfers in their 
> callback using private data. 
> > 
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Acked By : Nishant kamat <nskamat@ti.com>
> > ---
> > --- omapkernel.orig/arch/arm/plat-omap/dma.c	
> 2008-12-04 11:11:07.000000000 +0530
> > +++ omapkernel/arch/arm/plat-omap/dma.c	2008-12-16 
> 16:59:42.066118383 +0530
> > @@ -1936,7 +1936,11 @@ static int omap2_dma_handle_ch(int ch)
> >  	}
> >  
> >  	if (likely(dma_chan[ch].callback != NULL))
> > -		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
> > +		if (dma_chan[ch].chain_id != -1)
> > +			
> dma_chan[ch].callback(dma_chan[ch].chain_id, status,
> > +					      dma_chan[ch].data);
> > +		else
> > +			dma_chan[ch].callback(ch, status, 
> dma_chan[ch].data);
> >  
> >  	dma_write(status, CSR(ch));
> 
> 