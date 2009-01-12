From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] Runitme check for OMAP35x
Date: Mon, 12 Jan 2009 14:27:25 +0200
Message-ID: <20090112122724.GC9373@atomide.com>
References: <1231617654-18729-1-git-send-email-premi@ti.com> <20090110222050.GJ25493@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58388 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbZALM1b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 07:27:31 -0500
Content-Disposition: inline
In-Reply-To: <20090110222050.GJ25493@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [090111 00:21]:
> On Sun, Jan 11, 2009 at 01:30:54AM +0530, Sanjeev Premi wrote:
> > Added runtime check via omap2_set_globals_35xx()
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  arch/arm/plat-omap/common.c              |   68 +++++++++++++++++++++++
> >  arch/arm/plat-omap/include/mach/common.h |    1 +
> >  arch/arm/plat-omap/include/mach/cpu.h    |   88 +++++++++++++++++++++++++++++-
> >  3 files changed, 155 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> > index 8c53125..7861a25 100644
> > --- a/arch/arm/plat-omap/common.c
> > +++ b/arch/arm/plat-omap/common.c
> > @@ -333,3 +333,71 @@ void __init omap2_set_globals_343x(void)
> >  }
> >  #endif
> >  
> > +#if defined(CONFIG_ARCH_OMAP35XX)
> > +
> > +#if defined(CONFIG_ARCH_OMAP3503)
> 
> use ifdef here
> 
> > +static struct omap_globals omap3503_globals = {
> > +	.class	= OMAP35XX_CLASS,
> > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> > +	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
> > +	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
> > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > +	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
> > +	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
> > +};
> > +#endif	/* if defined(CONFIG_ARCH_OMAP3503) */
> 
> traditionaly this would be:
> 
> #endif	/* CONFIG_ARCH_OMAP3503 */
> 
> but that's a matter of taste...
> 
> > +
> > +#if defined(CONFIG_ARCH_OMAP3515)
> 
> and here
> 
> > +static struct omap_globals omap3515_globals = {
> > +	.class	= OMAP35XX_CLASS,
> > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> > +	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
> > +	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
> > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > +	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
> > +	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
> > +};
> > +#endif	/* if defined(CONFIG_ARCH_OMAP3515) */
> > +
> > +#if defined(CONFIG_ARCH_OMAP3525)
> > +static struct omap_globals omap3525_globals = {
> > +	.class	= OMAP35XX_CLASS,
> > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> > +	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
> > +	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
> > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > +	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
> > +	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
> > +};
> > +#endif	/* if defined(CONFIG_ARCH_OMAP3525) */
> > +
> > +#if defined(CONFIG_ARCH_OMAP3530)
> > +static struct omap_globals omap3530_globals = {
> > +	.class	= OMAP35XX_CLASS,
> > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> > +	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
> > +	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
> > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > +	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
> > +	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
> > +};
> > +#endif	/* if defined(CONFIG_ARCH_OMAP3530) */

What are the differences between these various omap35xx
processors? Maybe add a comment to each struct.

Also do we really need a separate struct for each 35xx?

> > +
> > +void __init omap2_set_globals_35xx(void)
> > +{
> > +#if defined(CONFIG_ARCH_OMAP3503)
> > +	omap2_globals = &omap3503_globals;
> > +#endif
> > +#if defined(CONFIG_ARCH_OMAP3515)
> > +	omap2_globals = &omap3515_globals;
> > +#endif
> > +#if defined(CONFIG_ARCH_OMAP3525)
> > +	omap2_globals = &omap3525_globals;
> > +#endif
> > +#if defined(CONFIG_ARCH_OMAP3530)
> > +	omap2_globals = &omap3530_globals;
> > +#endif
> 
> hmmm... so it's impossible to have multi-omap with 35xx ??
> too bad...

This does not sounds right, the multi-omap should always work.

> You should probably provide omap2_set_globals_350x(),
> omap2_set_globals_351x(), omap2_set_globals_352x() and
> omap2_set_globals_353x().
> 
> Tony, what do you think ??

Is there no way to detect them during runtime from the hardware?

If the answer is no, then yes we need a separate set_globals for
each omap35xx flavor.

Regards,

Tony
