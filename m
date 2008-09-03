From: Tony Lindgren <tony@atomide.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 13:50:06 -0700
Message-ID: <20080903205004.GW23085@atomide.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com> <20080903184804.GA1788@flint.arm.linux.org.uk> <a0580c510809031233x452968f5g84311eb694cdde45@mail.gmail.com> <20080903194824.GE19980@flint.arm.linux.org.uk> <a0580c510809031304p1da1d0f7h4f7c97e377505bc5@mail.gmail.com> <20080903204524.GI19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49198 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbYICUuQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 16:50:16 -0400
Content-Disposition: inline
In-Reply-To: <20080903204524.GI19980@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080903 13:46]:
> On Wed, Sep 03, 2008 at 04:04:11PM -0400, Eduardo Valentin wrote:
> > Hi Russell,
> > 
> > On Wed, Sep 3, 2008 at 3:48 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > Yes, that will be virtual.  But what does it mean to call:
> > >
> > >        omap_set_dma_dest_params()
> > >
> > > specifying a virtual address?  Can the DMA controller cope with DMAing
> > > to virtual addresses?  My hunch is that the DMA controller can't cope
> > > with that, so giving it a virtual address is a bug.
> > >
> > > Let me change the question: does omap_set_dma_dest_params()'s 4th
> > > argument take a virtual or a physical address?  If the former, it's
> > > prototype is wrong, and its 4th argument needs to be typed as
> > > 'void __iomem *' rather than 'unsigned long'.  If the latter, the code
> > > above is wrong.
> > >
> > > Do you see what I'm getting at now?
> > 
> > Ok. I got your point. I took a look at it and it expects a virtual address
> > on its 4th argument.
> 
> I'm sorry, but I don't think you have.
> 
> > I uses it with dma_write() macro, which uses it with __raw_write()
> > (arch/arm/plat-omap/dma.c).
> 
> That's true, but probably not in the way which would require it to be
> a virtual address that you're thinking.
> 
> void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
>                               unsigned long dest_start,
>                               int dst_ei, int dst_fi)
> {
>         if (cpu_class_is_omap1()) {
>                 dma_write(dest_start >> 16, CDSA_U(lch));
>                 dma_write(dest_start, CDSA_L(lch));
>         }
> 
>         if (cpu_class_is_omap2())
>                 dma_write(dest_start, CDSA(lch));
> }
> 
> 'dest_start' is a value to be written to the hardware registers in
> the DMA controller.  So, the question now is: do the CDSA registers
> expect a virtual or a physical address to be written to them?

C[DS][DS]A register need physical addresses for the DMA. The DMA
controller does not know anything about virtual addresses.

> I would look up this CDSA register in the OMAP manuals, if they were
> accessible... Are they not publically available?  (Google isn't
> helping, neither is searching on ti.com...)

There is a 3450 public TRM somewhere AFAIK, anybody got a link for that?
At least 5912 TRM is available somewhere.

Tony
