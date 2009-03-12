From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Thu, 12 Mar 2009 01:57:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903120144050.26959@utopia.booyaka.com>
References: <1236532839-3696-1-git-send-email-juha.yrjola@solidboot.com> <20090309172140.GF7329@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50878 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbZCLH5N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 03:57:13 -0400
In-Reply-To: <20090309172140.GF7329@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Mon, 9 Mar 2009, Tony Lindgren wrote:

> * Juha Yrjola <juha.yrjola@solidboot.com> [090308 10:20]:
> > The reboot mode can be communicated to a bootloader (or the
> > kernel itself) with a scratchpad register. This functionality
> > is especially useful, if userspace is allowed to change
> > the reboot mode.
> > 
> > Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
> > ---
> >  arch/arm/mach-omap2/prcm.c |   10 ++++++++--
> >  1 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> > index f945156..2bd239e 100644
> > --- a/arch/arm/mach-omap2/prcm.c
> > +++ b/arch/arm/mach-omap2/prcm.c
> > @@ -43,9 +43,15 @@ void omap_prcm_arch_reset(char mode)
> >  
> >  	if (cpu_is_omap24xx())
> >  		prcm_offs = WKUP_MOD;
> > -	else if (cpu_is_omap34xx())
> > +	else if (cpu_is_omap34xx()) {
> > +		u32 l;
> > +
> >  		prcm_offs = OMAP3430_GR_MOD;
> > -	else
> > +		l = ('B' << 24) | ('M' << 16) | mode;
> > +		/* Reserve the first word in scratchpad for communicating
> > +		 * with the boot ROM. */
> > +		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
> > +	} else
> >  		WARN_ON(1);
> >  
> >  	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
> 
> Looks OK to me, any comments from Kevin or Paul?

Can't find "BMxx" in the Rev O 34xx TRM. Is this a NOLO-specific feature, 
or is this a known standard supported by other bootloaders?  If the 
former, maybe it would be good to add a few lines of documentation in 
Documentation/arm/OMAP/rebooting or some other place?



- Paul
