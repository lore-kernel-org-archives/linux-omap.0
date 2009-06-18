From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] SDRC: Remove SDRC_POWER register configuration from SDRC
 init.
Date: Thu, 18 Jun 2009 15:29:15 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906181509350.4087@utopia.booyaka.com>
References: <1245245721-7052-1-git-send-email-Artem.Bityutskiy@nokia.com> <alpine.DEB.2.00.0906171021120.3382@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39890 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbZFRV3N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 17:29:13 -0400
In-Reply-To: <alpine.DEB.2.00.0906171021120.3382@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samu Onkalo <samu.p.onkalo@nokia.com>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Cc: r-woodruff2@ti.com, linux-omap@vger.kernel.org, mike@android.com, khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>

Hi, 

On Wed, 17 Jun 2009, Paul Walmsley wrote:

> On Wed, 17 Jun 2009, Artem Bityutskiy wrote:
> 
> > From: Samu Onkalo <samu.p.onkalo@nokia.com>
> > 
> > Bootloader must configure proper settings for SDRC before starting
> > kernel from SDRAM. Furthermore, removed lines violated omap3430 and
> > omap2420 SDRC errata (see errata 1.150)
> 
> The 2420 and 3430 errata data here seems to be old; neither one contains 
> 1.150.  While I wait for a new version to arrive, can you provide some 
> more context on this errata?  Does it imply any restrictions on 
> programming SDRC_POWER from SRAM, e.g., the CORE DVFS code?

Okay, so erratum 1.150 basically is that when SDRC_POWER.PWDENA is set, 
the SDRC can power down the SDRAM before writes complete, and so PWDENA 
should never be used.  That's easy enough to deal with by removing the 
PWDENA bit set from the SDRC_POWER register write.  So I'll pass on this 
patch.

The patch description does raise another issue, which is that SDRC_POWER 
should probably be written from SRAM, per TRM section 11.2.4.4.9.2.  We 
could do this as part of omap3_sram_configure_core_dpll, which is is 
called at boot for boards that define their SDRAM memory parameters.  
Another option would be to add another SRAM function to do this.  I'm 
leaning towards the former.  Any other opinions on this?


- Paul

> 
> 
> - Paul
> 
> > 
> > Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> > ---
> >  arch/arm/mach-omap2/sdrc.c |   10 ++--------
> >  1 files changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
> > index 2045441..0874687 100644
> > --- a/arch/arm/mach-omap2/sdrc.c
> > +++ b/arch/arm/mach-omap2/sdrc.c
> > @@ -86,8 +86,8 @@ void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
> >   * @sp: pointer to a null-terminated list of struct omap_sdrc_params
> >   *
> >   * Turn on smart idle modes for SDRAM scheduler and controller.
> > - * Program a known-good configuration for the SDRC to deal with buggy
> > - * bootloaders.
> > + * Bootloaders should make proper configuration for SDRC since kernel
> > + * is running from SDRAM.
> >   */
> >  void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
> >  {
> > @@ -104,10 +104,4 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
> >  	sdrc_write_reg(l, SDRC_SYSCONFIG);
> >  
> >  	sdrc_init_params = sp;
> > -
> > -	/* XXX Enable SRFRONIDLEREQ here also? */
> > -	l = (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
> > -		(1 << SDRC_POWER_PWDENA_SHIFT) |
> > -		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
> > -	sdrc_write_reg(l, SDRC_POWER);
> >  }
> > -- 
> > 1.6.0.6
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
