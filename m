From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/3] Runitme check for OMAP35x
Date: Mon, 12 Jan 2009 18:16:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BB859397@dbde02.ent.ti.com>
References: <1231617654-18729-1-git-send-email-premi@ti.com>
 <20090110222050.GJ25493@frodo> <20090112122724.GC9373@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34311 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755568AbZALMr7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 07:47:59 -0500
In-Reply-To: <20090112122724.GC9373@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Monday, January 12, 2009 5:57 PM
> To: Felipe Balbi
> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/3] Runitme check for OMAP35x
> 
> * Felipe Balbi <me@felipebalbi.com> [090111 00:21]:
> > On Sun, Jan 11, 2009 at 01:30:54AM +0530, Sanjeev Premi wrote:
> > > Added runtime check via omap2_set_globals_35xx()
> > > 
> > > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > > ---
> > >  arch/arm/plat-omap/common.c              |   68 
> +++++++++++++++++++++++
> > >  arch/arm/plat-omap/include/mach/common.h |    1 +
> > >  arch/arm/plat-omap/include/mach/cpu.h    |   88 
> +++++++++++++++++++++++++++++-
> > >  3 files changed, 155 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/plat-omap/common.c 
> > > b/arch/arm/plat-omap/common.c index 8c53125..7861a25 100644
> > > --- a/arch/arm/plat-omap/common.c
> > > +++ b/arch/arm/plat-omap/common.c
> > > @@ -333,3 +333,71 @@ void __init omap2_set_globals_343x(void)  }  
> > > #endif
> > >  
> > > +#if defined(CONFIG_ARCH_OMAP35XX)
> > > +
> > > +#if defined(CONFIG_ARCH_OMAP3503)
> > 
> > use ifdef here
> > 
> > > +static struct omap_globals omap3503_globals = {
> > > +	.class	= OMAP35XX_CLASS,
> > > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> > > +	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
> > > +	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
> > > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > > +	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
> > > +	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
> > > +};
> > > +#endif	/* if defined(CONFIG_ARCH_OMAP3503) */
> > 
> > traditionaly this would be:
> > 
> > #endif	/* CONFIG_ARCH_OMAP3503 */
> > 
> > but that's a matter of taste...
> > 
> > > +
> > > +#if defined(CONFIG_ARCH_OMAP3515)
> > 
> > and here
> > 
> > > +static struct omap_globals omap3515_globals = {
> > > +	.class	= OMAP35XX_CLASS,
> > > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> > > +	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
> > > +	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
> > > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > > +	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
> > > +	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
> > > +};
> > > +#endif	/* if defined(CONFIG_ARCH_OMAP3515) */
> > > +
> > > +#if defined(CONFIG_ARCH_OMAP3525)
> > > +static struct omap_globals omap3525_globals = {
> > > +	.class	= OMAP35XX_CLASS,
> > > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> > > +	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
> > > +	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
> > > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > > +	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
> > > +	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
> > > +};
> > > +#endif	/* if defined(CONFIG_ARCH_OMAP3525) */
> > > +
> > > +#if defined(CONFIG_ARCH_OMAP3530)
> > > +static struct omap_globals omap3530_globals = {
> > > +	.class	= OMAP35XX_CLASS,
> > > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> > > +	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
> > > +	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
> > > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > > +	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
> > > +	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
> > > +};
> > > +#endif	/* if defined(CONFIG_ARCH_OMAP3530) */
> 
> What are the differences between these various omap35xx 
> processors? Maybe add a comment to each struct.

[sp] Sure will do. Thought that link in PATCH0 was sufficient.
> 
> Also do we really need a separate struct for each 35xx?

[sp] There was a comment to my initial patchset (AUG '08) that there should be a separate struct. Hence, I had made this change.
> 
> > > +
> > > +void __init omap2_set_globals_35xx(void) { #if 
> > > +defined(CONFIG_ARCH_OMAP3503)
> > > +	omap2_globals = &omap3503_globals; #endif #if 
> > > +defined(CONFIG_ARCH_OMAP3515)
> > > +	omap2_globals = &omap3515_globals; #endif #if 
> > > +defined(CONFIG_ARCH_OMAP3525)
> > > +	omap2_globals = &omap3525_globals; #endif #if 
> > > +defined(CONFIG_ARCH_OMAP3530)
> > > +	omap2_globals = &omap3530_globals; #endif
> > 
> > hmmm... so it's impossible to have multi-omap with 35xx ??
> > too bad...
> 
> This does not sounds right, the multi-omap should always work.
> 

[sp] If there is only one struct this multi-omap will still be a problem. Right?
     Each of the OMAPs will need its own struct. (I haven't worked with multi-omap;
     do correct me if my understanding is not right).

> > You should probably provide omap2_set_globals_350x(), 
> > omap2_set_globals_351x(), omap2_set_globals_352x() and 
> > omap2_set_globals_353x().
> > 
> > Tony, what do you think ??
> 
> Is there no way to detect them during runtime from the hardware?

[sp] The initial version of the TRM did not mention any specific means to do runtime detection. Had followed the same for this patchset. The new TRM does mention mechanism (also mentioned by Steve Sakoman in same mail thread). I am working to create a new patch set. I am trying to confirm if this will work on early versions of OMAP35x as well.

> If the answer is no, then yes we need a separate set_globals 
> for each omap35xx flavor.

[sp] If check works for initial Si versions as well; I will submit patch with only one function omap2_set_globals_35xx (); Else, will go with multiple functions for each of 35x processors as suggest above.

> 
> Regards,
> 
> Tony
> 
> 

~sanjeev