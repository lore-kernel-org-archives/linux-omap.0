From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix iva2_pwrdm settings for 3703
Date: Wed, 15 May 2013 10:07:35 -0700
Message-ID: <20130515170734.GI5600@atomide.com>
References: <20130515002537.GG5600@atomide.com>
 <20130515015212.GB3268@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30430 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759551Ab3EORHi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 May 2013 13:07:38 -0400
Content-Disposition: inline
In-Reply-To: <20130515015212.GB3268@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>

* Mark A. Greer <mgreer@animalcreek.com> [130514 18:57]:
> On Tue, May 14, 2013 at 05:25:37PM -0700, Tony Lindgren wrote:
> > Commit a819c4f1 (ARM: OMAP3: PM: Only access IVA if one exists)
> > changed PM to not access IVA registers on omaps that don't have
> > them. Turns out we still need to idle iva2 as otherwise iva2_pwrdm
> > will stay on and block deeper idle states.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > ---
> > 
> > Paul & Kevin, do you have better ideas for fixing this?
> > 
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -546,8 +546,10 @@ static void __init prcm_setup_regs(void)
> >  	/* Clear any pending PRCM interrupts */
> >  	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> >  
> > -	if (omap3_has_iva())
> > -		omap3_iva_idle();
> > +	/*
> > +	 * We need to idle iva2_pwrdm even on am3703 with no iva2.
> > +	 */
> > +	omap3_iva_idle();
> >  
> >  	omap3_d2d_idle();
> >  }
> 
> [Kevin, Paul, some background: Tony discovered that the am3703 needs
> to have omap3_iva_idle() called even though its not supposed to have
> an IVA.]
> 
> This is potentially bad for other SoC's that don't have an IVA so I don't
> think its the way to go.  My preference would be to set the OMAP3_HAS_IVA
> flag for the am3703 only since its the one with the bug.  Maybe something
> in id.c:omap3xxx_check_features() but I don't see any existing way to check
> for an am3703 vs. other am37xx SoCs.  Any ideas?
> 
> Another option, I suppose, is a dts entry but I don't like that at all.

It seems that iva2_pwrdm is there for all omap3 even if OMAP3_HAS_IVA
flag is unset. And if that's the case, iva2 clocks still need to be idled
in all cases.

It's possible that not all steps in omap3_iva_idle() are needed though.
I can debug further to see which part of the omap3_iva_idle() are needed.

Mark, do you have some omap3 with no iva (other than am3703) to test the
idle states with?

Regards,

Tony
