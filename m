From: Tony Lindgren <tony@atomide.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 14:48:32 -0700
Message-ID: <20080903214828.GB23085@atomide.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com> <20080903184804.GA1788@flint.arm.linux.org.uk> <a0580c510809031233x452968f5g84311eb694cdde45@mail.gmail.com> <20080903194824.GE19980@flint.arm.linux.org.uk> <20080903203720.GV23085@atomide.com> <20080903210412.GJ19980@flint.arm.linux.org.uk> <a0580c510809031426l56392fc3te704477553c04e5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63780 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781AbYICVsm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 17:48:42 -0400
Content-Disposition: inline
In-Reply-To: <a0580c510809031426l56392fc3te704477553c04e5c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

* Eduardo Valentin <edubezval@gmail.com> [080903 14:27]:
> Hi Russell,
> 
> On Wed, Sep 3, 2008 at 5:04 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Sep 03, 2008 at 01:37:21PM -0700, Tony Lindgren wrote:
> >> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080903 12:49]:
> >> > Yes, that will be virtual.  But what does it mean to call:
> >> >
> >> >     omap_set_dma_dest_params()
> >> >
> >> > specifying a virtual address?  Can the DMA controller cope with DMAing
> >> > to virtual addresses?  My hunch is that the DMA controller can't cope
> >> > with that, so giving it a virtual address is a bug.
> >> >
> >> > Let me change the question: does omap_set_dma_dest_params()'s 4th
> >> > argument take a virtual or a physical address?  If the former, it's
> >> > prototype is wrong, and its 4th argument needs to be typed as
> >> > 'void __iomem *' rather than 'unsigned long'.  If the latter, the code
> >> > above is wrong.
> >>
> >> The dma src and dest functions take physical addresses so the prototype
> >> should be void __iomem *.
> >
> > Grr.  No.  Let me repeat the rule:
> >
> > - virtual addresses are pointer like.
> > - physical addresses are integer like.
> >
> > So, if it's a physical address, it should be stored in an integer type
> > large enough to contain it, and that means something like u32, or
> > unsigned long.
> >
> > If it's a virtual MMIO address, then it should be something like
> > 'void __iomem *', or if you want to play roulette with compiler padding,
> > 'struct foo __iomem *'.

Oops sorry, that's correct.

> > Okay, so lets accept that the 4th argument to omap_set_dma_dest_params()
> > is a physical address.  It should be typed as 'unsigned long' (it is)
> > and it then means that:
> >
> > diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> > index d084405..d9b1a42 100644
> > --- a/arch/arm/plat-omap/mcbsp.c
> > +++ b/arch/arm/plat-omap/mcbsp.c
> > @@ -652,6 +652,7 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
> >        omap_set_dma_dest_params(mcbsp[id].dma_tx_lch,
> >                                 src_port,
> >                                 OMAP_DMA_AMODE_CONSTANT,
> > +                                /* FIXME: this is a virtual address */
> >                                 mcbsp[id].io_base + OMAP_MCBSP_REG_DXR1,
> >                                 0, 0);
> >
> > @@ -713,6 +714,7 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer,
> >        omap_set_dma_src_params(mcbsp[id].dma_rx_lch,
> >                                src_port,
> >                                OMAP_DMA_AMODE_CONSTANT,
> > +                               /* FIXME: this is a virtual address */
> >                                mcbsp[id].io_base + OMAP_MCBSP_REG_DRR1,
> >                                0, 0);
> >
> >
> > are broken because they're passing a virtual address into a function
> > requiring a physical address.
> 
> Yes, the code above is wrong. Now I understood that I was messing up
> with what you meant.
> 
> >
> > Now, to fix this in the right way isn't going to be easy, because
> > arch/arm/plat-omap/mcbsp.c doesn't know what the physical address of
> > the mcbsp actually is - it's only passed the virtual address via
> > platform data (eww, yuck yuck yuck)...
> >
> > If this was a properly reviewed platform driver, and on *any* *other*
> > ARM platform, it would take the resources containing the physical
> > addresses and ioremap them... and this would be a trivial bug fix.
> 
> Yes, I agreed here.
> >
> > I'll cook a patch up.
> >

Heh, I don't see how we still have working audio on at least 24xx :)
Maybe the DMA src and dest addresses are really only 28-bit and it's
ignoring the rest.

Tony
