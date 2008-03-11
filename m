From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: DMA: fix CLINK mask, clear spurious
	interrupt
Date: Tue, 11 Mar 2008 17:21:09 +0200
Message-ID: <20080311152108.GJ7524@atomide.com>
References: <1204926553-6228-1-git-send-email-khilman@mvista.com> <010C7BAE6783F34D9AC336EE5A01A088057E388F@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55027 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbYCKPVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2008 11:21:20 -0400
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A088057E388F@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

* Gadiyar, Anand <gadiyar@ti.com> [080309 09:30]:
> Ack. Meant to send in this fix this weekend. 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> > Sent: Saturday, March 08, 2008 3:19 AM
> > To: linux-omap@vger.kernel.org
> > Cc: Kevin Hilman
> > Subject: [PATCH] ARM: OMAP: DMA: fix CLINK mask, clear 
> > spurious interrupt
> > 
> > Some bugfixes from the TI CDP kernel.

Pushing today.

Tony

> > Signed-off-by: Kevin Hilman <khilman@mvista.com>
> > ---
> >  arch/arm/plat-omap/dma.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index 3e94683..008b5dd 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -1020,12 +1020,12 @@ static void create_dma_lch_chain(int 
> > lch_head, int lch_queue)
> >  	}
> >  
> >  	w = OMAP_DMA_CLNK_CTRL_REG(lch_head);
> > -	w &= ~(0x0f);
> > +	w &= ~(0x1f);
> >  	w |= lch_queue;
> >  	OMAP_DMA_CLNK_CTRL_REG(lch_head) = w;
> >  
> >  	w = OMAP_DMA_CLNK_CTRL_REG(lch_queue);
> > -	w &= ~(0x0f);
> > +	w &= ~(0x1f);
> >  	w |= (dma_chan[lch_queue].next_linked_ch);
> >  	OMAP_DMA_CLNK_CTRL_REG(lch_queue) = w;
> >  }
> > @@ -1663,6 +1663,7 @@ static int omap2_dma_handle_ch(int ch)
> >  	if (!status) {
> >  		if (printk_ratelimit())
> >  			printk(KERN_WARNING "Spurious DMA IRQ 
> > for lch %d\n", ch);
> > +		omap_writel(1 << ch, OMAP_DMA4_IRQSTATUS_L0);
> >  		return 0;
> >  	}
> >  	if (unlikely(dma_chan[ch].dev_id == -1)) {
> > -- 
> > 1.5.4.1.99.gf1785
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
