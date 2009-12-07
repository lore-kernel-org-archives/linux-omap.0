From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: PM: Enable wake-up from McBSP2, 3 and 4 modules
Date: Mon, 7 Dec 2009 13:34:11 -0800
Message-ID: <20091207213411.GJ24013@atomide.com>
References: <1259241530-26109-1-git-send-email-peter.ujfalusi@nokia.com>
 <200912071538.06968.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64310 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935594AbZLGVeG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 16:34:06 -0500
Content-Disposition: inline
In-Reply-To: <200912071538.06968.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

* Peter Ujfalusi <peter.ujfalusi@nokia.com> [091207 05:37]:
> Hello Tony, Kevin,
> 
> On Thursday 26 November 2009 15:18:50 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> > Wake-up from McBSP ports are needed, especially when the THRESHOLD
> > dma mode is in use for audio playback.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > ---
> >  arch/arm/mach-omap2/pm34xx.c |    8 ++++++--
> >  1 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > index 81ed252..6b17647 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -878,12 +878,16 @@ static void __init prcm_setup_regs(void)
> >  	/* Enable wakeups in PER */
> >  	prm_write_mod_reg(OMAP3430_EN_GPIO2 | OMAP3430_EN_GPIO3 |
> >  			  OMAP3430_EN_GPIO4 | OMAP3430_EN_GPIO5 |
> > -			  OMAP3430_EN_GPIO6 | OMAP3430_EN_UART3,
> > +			  OMAP3430_EN_GPIO6 | OMAP3430_EN_UART3 |
> > +			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
> > +			  OMAP3430_EN_MCBSP4,
> >  			  OMAP3430_PER_MOD, PM_WKEN);
> >  	/* and allow them to wake up MPU */
> >  	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2 | OMAP3430_EN_GPIO3 |
> >  			  OMAP3430_GRPSEL_GPIO4 | OMAP3430_EN_GPIO5 |
> > -			  OMAP3430_GRPSEL_GPIO6 | OMAP3430_EN_UART3,
> > +			  OMAP3430_GRPSEL_GPIO6 | OMAP3430_EN_UART3 |
> > +			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
> > +			  OMAP3430_EN_MCBSP4,
> >  			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
> > 
> >  	/* Don't attach IVA interrupts */
> > 
> 
> Have you had time to take a look at this patch?

Makes sense to me, let's let Kevin queue it up.

Tony
