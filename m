From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: ack spurious IRQs in get_irqnr_and_base
Date: Fri, 17 Oct 2008 14:19:12 -0700
Message-ID: <20081017211911.GU15820@atomide.com>
References: <1224071511-4670-1-git-send-email-lauri.leukkunen@nokia.com> <alpine.DEB.2.00.0810170226530.729@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56974 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717AbYJQVTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:19:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0810170226530.729@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [081017 01:30]:
> Hi Lauri,
> 
> I think we should merge your patch along with the SO patch also, so in the 
> event of a spurious interrupt, it won't wedge the whole system.   One 
> question though:
> 
> On Wed, 15 Oct 2008, Lauri Leukkunen wrote:
> 
> > This prevents spurious interrupts from repeating unacked and
> > thus locking the system, while still allowing the spurious
> > bad irq error message to be show on console.
> > 
> > Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
> > ---
> >  arch/arm/plat-omap/include/mach/entry-macro.S |   21 ++++++++++++++++++++-
> >  1 files changed, 20 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
> > index a8fca9d..c88a4cb 100644
> > --- a/arch/arm/plat-omap/include/mach/entry-macro.S
> > +++ b/arch/arm/plat-omap/include/mach/entry-macro.S
> > @@ -87,7 +87,26 @@
> >  		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
> >  		cmp	\irqnr, #0x0
> >  2222:
> > -		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> > +#if defined(CONFIG_ARCH_OMAP34XX)
> > +		mov	\tmp, \irqnr
> > +#endif
> > + 		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> > +#if defined(CONFIG_ARCH_OMAP34XX)
> > +		mov	\irqstat, \irqnr
> > +		bic	\irqstat, \irqstat, #0x7f /* check for spurious flag */
> 
> According to Table 10-14 in the TRM, the spurious flag field is 25 bits 
> wide, but the patch only checks for 7 bits.  This should probably be 
> extended?

That's OK, as the bic clears the non-spurious bits, so pushing.

Tony



> 
> > +		cmp	\irqstat, #0x0
> > +		beq	2223f
> > +		mov	\irqstat, #0x1 /* Ack the spurious irq, this lets it
> > +					* generate a bad irq error message,
> > +					* but prevents infinitely repeating
> > +					* irq.
> > +					*/
> > +		str	\irqstat, [\base, #0x48] /* INTC_CONTROL register */
> > +2223:
> > +		cmp	\tmp, #0x0 /* set conditional back to what it was
> > +				    * before spurious test
> > +				    */
> > +#endif
> >  
> >  		.endm
> >  
> 
> - Paul
