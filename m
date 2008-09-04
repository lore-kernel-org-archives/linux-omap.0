From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Thu, 4 Sep 2008 17:12:48 +0100
Message-ID: <20080904161248.GC2309@flint.arm.linux.org.uk>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com> <20080904094655.GB10426@flint.arm.linux.org.uk> <20080904161033.GQ23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45606 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbYIDQNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 12:13:04 -0400
Content-Disposition: inline
In-Reply-To: <20080904161033.GQ23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org

On Thu, Sep 04, 2008 at 09:10:34AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080904 02:47]:
> > On Wed, Sep 03, 2008 at 11:33:51AM -0400, Eduardo Valentin wrote:
> > > > @@ -159,7 +159,7 @@ static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
> > > >  #ifdef CONFIG_ARCH_OMAP15XX
> > > >  static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
> > > >        {
> > > > -               .virt_base      = OMAP1510_MCBSP1_BASE,
> > > > +               .virt_base      = OMAP1510_MCBSP1_BASE, /* FIXME: virtual or physical */
> > > AFAIK, OMAP1510_MCBSP1_BASE is physical. So, I'd say:
> > > +               .virt_base      = IO_ADDRESS(OMAP1510_MCBSP1_BASE),
> > > 
> > > Because, plat-omap/mcbsp.c expect .virt_base to be a virtual address.
> > 
> > And today, the story is completely different, having looked through more
> > of the code and some documentation.
> > 
> > - OMAPxxxx_MCBSPx_BASE are all physical addresses.  Fine.
> > - physical addresses > 0xfffb0000 are subject to an offset (IO_OFFSET)
> >   but others for the DSP located and DSP shared peripherals aren't.
> > 
> > So, applying the IO_OFFSET via IO_ADDRESS() or io_p2v() to all addresses
> > breaks.  Meaning it's completely random whether something should be put
> > through IO_ADDRESS() and similar.
> > 
> > This isn't obvious.  It isn't readable.  It isn't maintainable.  It doesn't
> > lend itself to compile time checking.
> 
> Ouch. Looking at the history of the mcbsp.c the MCBSPX_BASE defines have
> been a mix of virt and phys addresses to start with.
> 
> Looks like in the short term we need to define both virt_base and phys_base
> for omap_mcbsp_platform_data.
> 
> Then define __arch_ioremap that understands also the DSP mappings and get
> rid of the remaining hardcoded virtual DSP defines.
> 
> At that point we can also remove the virt_base from omap_mcbsp_platform_data.

Already done. ;)
