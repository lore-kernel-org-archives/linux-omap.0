From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] omap: Add support for CONFIG_AUTO_ZRELADDR for
	DEBUG_LL
Date: Fri, 4 Feb 2011 17:15:26 +0000
Message-ID: <20110204171526.GA8821@n2100.arm.linux.org.uk>
References: <20110204012317.26410.55157.stgit@baageli.muru.com> <20110204012709.26410.78100.stgit@baageli.muru.com> <alpine.LFD.2.00.1102032205140.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33637 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab1BDRPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 12:15:41 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102032205140.12104@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 03, 2011 at 10:33:42PM -0500, Nicolas Pitre wrote:
> On Thu, 3 Feb 2011, Tony Lindgren wrote:
> 
> > This way we can have the debug-macro.S be common for omap1 and omap2+
> > and get sensible error messages booting the wrong zImage with
> > CONFIG_AUTO_ZRELADDR selected. Note that this does not seem to work
> > with u-boot and uImage.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap1/include/mach/debug-macro.S |   36 ++++++++++++++++++++----
> >  arch/arm/mach-omap2/include/mach/debug-macro.S |   27 +++++++++++++++++-
> >  2 files changed, 56 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > index 80dcf18..bae924e 100644
> > --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > @@ -27,7 +27,15 @@
> >  		.macro	inituart, id, a, v
> >  		mrc	p15, 0, \a, c1, c0
> >  		tst	\a, #1			@ MMU enabled?
> > +#ifdef CONFIG_AUTO_ZRELADDR
> > +		ldreq	\a, =omap_uart_phys
> > +		biceq	\a, \a, #0xf8000000	@ clear top bits of virt addr
> > +		moveq	\v, pc			@ copy pc
> > +		andeq	\v, \v, #0xf8000000	@ clear lower bits
> > +		orreq	\a, \v			@ combile to get phys addr
> > +#else
> >  		ldreq	\a, =omap_uart_v2p(omap_uart_phys)
> > +#endif
> >  		ldrne	\a, =omap_uart_phys
> 
> Gaaaaah!  This is horrible.
> 
> OK, you do want to store data in memory, right?  So the best way to 
> always be position independent, even cross section, is to do the 
> following (inspired by RMK's trick in the p2v series):

The other point to make is that for every machine in OMAP1, the
serial port is located at 0xffXXXXXX virtual, 0xfeXXXXXX physical.
For OMAP2, that's 0xfaXXXXXX virtual and 0x48XXXXXX physical.

So it's pointless storing both the virtual and physical addresses
as we can compute one from the other with a single instruction.
That gets rid of some of the complexity found in the debugging code.
