From: Tony Lindgren <tony@atomide.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 13:37:21 -0700
Message-ID: <20080903203720.GV23085@atomide.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com> <20080903184804.GA1788@flint.arm.linux.org.uk> <a0580c510809031233x452968f5g84311eb694cdde45@mail.gmail.com> <20080903194824.GE19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50822 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbYICUhb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 16:37:31 -0400
Content-Disposition: inline
In-Reply-To: <20080903194824.GE19980@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080903 12:49]:
> On Wed, Sep 03, 2008 at 03:33:55PM -0400, Eduardo Valentin wrote:
> > Hi,
> > 
> > On Wed, Sep 3, 2008 at 2:48 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> > > On Wed, Sep 03, 2008 at 11:33:51AM -0400, Eduardo Valentin wrote:
> > >> > @@ -159,7 +159,7 @@ static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
> > >> >  #ifdef CONFIG_ARCH_OMAP15XX
> > >> >  static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
> > >> >        {
> > >> > -               .virt_base      = OMAP1510_MCBSP1_BASE,
> > >> > +               .virt_base      = OMAP1510_MCBSP1_BASE, /* FIXME: virtual or physical */
> > >> AFAIK, OMAP1510_MCBSP1_BASE is physical. So, I'd say:
> > >> +               .virt_base      = IO_ADDRESS(OMAP1510_MCBSP1_BASE),
> > >>
> > >> Because, plat-omap/mcbsp.c expect .virt_base to be a virtual address.
> > >
> > > Ok, I'll fix these which you've confirmed in my version for mainline.
> > >
> > >> > @@ -701,6 +702,7 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
> > >> >        omap_set_dma_dest_params(mcbsp->dma_tx_lch,
> > >> >                                 src_port,
> > >> >                                 OMAP_DMA_AMODE_CONSTANT,
> > >> > +                                /* FIXME: this is a virtual address */
> > >> >                                 mcbsp->io_base + OMAP_MCBSP_REG_DXR1,
> > >>
> > >> yes, that's true. This is expected to be virtual (mcbsp->io_base).
> > >
> > > Don't you mean that it is expected to be physical?
> > >
> > 
> > Well, correct me if I'm wrong, but I meant that the result of
> >  mcbsp->io_base + OMAP_MCBSP_REG_DXR1
> > 
> > is supposed to be virtual.
> 
> Yes, that will be virtual.  But what does it mean to call:
> 
> 	omap_set_dma_dest_params()
> 
> specifying a virtual address?  Can the DMA controller cope with DMAing
> to virtual addresses?  My hunch is that the DMA controller can't cope
> with that, so giving it a virtual address is a bug.
> 
> Let me change the question: does omap_set_dma_dest_params()'s 4th
> argument take a virtual or a physical address?  If the former, it's
> prototype is wrong, and its 4th argument needs to be typed as
> 'void __iomem *' rather than 'unsigned long'.  If the latter, the code
> above is wrong.

The dma src and dest functions take physical addresses so the prototype
should be void __iomem *.

Tony

> Do you see what I'm getting at now?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
