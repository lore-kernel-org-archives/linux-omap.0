From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock
 control detection
Date: Thu, 6 Oct 2011 17:07:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110061659070.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061310390.4611@utopia.booyaka.com> <CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com> <alpine.DEB.2.00.1110061346570.4611@utopia.booyaka.com> <20111006222912.GA27281@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37808 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759270Ab1JFXHg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 19:07:36 -0400
In-Reply-To: <20111006222912.GA27281@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Steve Sakoman <sakoman@gmail.com>, khilman@ti.com, dhylands@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 6 Oct 2011, Russell King - ARM Linux wrote:

> On Thu, Oct 06, 2011 at 01:47:22PM -0600, Paul Walmsley wrote:
> > +	if ((omap_rev() == OMAP3430_REV_ES3_1 ||
> > +	     omap_rev() == OMAP3430_REV_ES3_1_2) ||
> > +	    cpu_is_omap3630())
> > +		omap_features |= OMAP3_HAS_IO_CHAIN_CTRL;
> 
> 	(a || b) || c === a || b || c
> 
> IOW, no need for the additional parens.

Thanks; patch updated.

> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > index 7255d9b..a6156bd 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -99,31 +99,28 @@ static void omap3_enable_io_chain(void)
> >  {
> >  	int timeout = 0;
> >  
> > -	if (omap_rev() >= OMAP3430_REV_ES3_1) {
> > -		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> > -				     PM_WKEN);
> > -		/* Do a readback to assure write has been done */
> > -		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> > -
> > -		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
> > -			 OMAP3430_ST_IO_CHAIN_MASK)) {
> > -			timeout++;
> > -			if (timeout > 1000) {
> > -				printk(KERN_ERR "Wake up daisy chain "
> > -				       "activation failed.\n");
> > -				return;
> > -			}
> > -			omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
> > -					     WKUP_MOD, PM_WKEN);
> > +	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> > +				   PM_WKEN);
> > +	/* Do a readback to assure write has been done */
> > +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> > +
> > +	while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
> > +		 OMAP3430_ST_IO_CHAIN_MASK)) {
> > +		timeout++;
> > +		if (timeout > 1000) {
> > +			printk(KERN_ERR "Wake up daisy chain "
> > +			       "activation failed.\n");
> > +			return;
> >  		}
> > +		omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
> > +					   WKUP_MOD, PM_WKEN);
> >  	}
> 
> This should've been caught before.  Two things:
> 
> 1. Do you know how long it takes this to time out?

No, I don't; and I doubt the original author did either.

Really there should be at least a udelay(1) in that code; since as it 
stands right now, there's at least a partial CPU/interconnect/high 
frequency oscillator speed dependency in that loop.

But this patch was intended to be a minimal fix, avoiding code changes 
that are unrelated to the I/O chain feature detection change.  Those lines 
just showed up due to the indentation level change...
 
> 2. Don't wrap error printks, it prevents them being grepped for.

Thanks; patch updated.


- Paul
