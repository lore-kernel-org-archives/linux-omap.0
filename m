From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH v2] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Thu, 12 Aug 2010 14:59:10 +0300
Message-ID: <1281614350.1861.14.camel@chotu>
References: <1281542626-4045-1-git-send-email-khilman@deeprootsystems.com>
	 <1281609324.1861.6.camel@chotu>  <20100812115107.GC6629@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58269 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758701Ab0HLL7x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 07:59:53 -0400
In-Reply-To: <20100812115107.GC6629@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

On Thu, 2010-08-12 at 13:51 +0200, ext Tony Lindgren wrote:
> * Ameya Palande <ameya.palande@nokia.com> [100812 13:28]:
> > Hi Kevin,
> > 
> > On Wed, 2010-08-11 at 18:03 +0200, ext Kevin Hilman wrote:
> > > From: Kevin Hilman <khilman@ti.com>
> > > 
> > > Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
> > > mistakenly removed the check for PER when disabling the IO chain.
> > > 
> > > During idle, if the PER powerdomain transitions and CORE does not (as
> > > is the case with the lower C-states when using CPUidle) the IO pad
> > > wakeups are not being disabled in the idle path after they are
> > > enabled.
> > > 
> > > This patch ensures that the check for disabling IO wakeups also checks
> > > for PER transitions, matching the check done to enable IO wakeups.
> > > 
> > > Found when debugging PM/CPUidle related problems reported by Ameya
> > > Palande <ameya.palande@nokia.com>.  Problems were triggered
> > > particularily on boards with UART2 consoles (n900, Overo) since UART2
> > > is in the PER powerdomain.
> > > 
> > > Tested on l-o master (omap3_defonfig + CONFIG_CPU_IDLE=y) as well
> > > as with current PM branch.  Boards tested: n900, Overo, omap3evm.
> > > 
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > Cc: Ameya Palande <ameya.palande@nokia.com>
> > > Tested-by: Jarkko Nikula <jhnikula@gmail.com>
> > > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> > > ---
> > > Tony, this should go in with fixes for -rc2
> > > 
> > > Changes since v1
> > > - added a bit of history about where the problem was created
> > > - added 'Tested-by' for Jarkko
> > > 
> > >  arch/arm/mach-omap2/pm34xx.c |    4 +++-
> > >  1 files changed, 3 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > > index fb4994a..7b03426 100644
> > > --- a/arch/arm/mach-omap2/pm34xx.c
> > > +++ b/arch/arm/mach-omap2/pm34xx.c
> > > @@ -480,7 +480,9 @@ void omap_sram_idle(void)
> > >  	}
> > >  
> > >  	/* Disable IO-PAD and IO-CHAIN wakeup */
> > > -	if (omap3_has_io_wakeup() && core_next_state < PWRDM_POWER_ON) {
> > > +	if (omap3_has_io_wakeup() &&
> > > +	    (per_next_state < PWRDM_POWER_ON ||
> > > +	     core_next_state < PWRDM_POWER_ON)) {
> > >  		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
> > >  		omap3_disable_io_chain();
> > >  	}
> > 
> > Thanks for your fix!
> > I tried out following patch on n900 kernel (based on 2.6.35 mainline)
> > hosted at: http://gitorious.org/nokia-n900-kernel
> > 
> > Patch:
> > 
> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > index b88737f..887242d 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -479,7 +479,8 @@ void omap_sram_idle(void)
> >         }
> >  
> >         /* Disable IO-PAD and IO-CHAIN wakeup */
> > -       if (core_next_state < PWRDM_POWER_ON) {
> > +       if (per_next_state < PWRDM_POWER_ON ||
> > +                       core_next_state < PWRDM_POWER_ON) {
> >                 prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
> > PM_WKEN);
> >                 omap3_disable_io_chain();
> >         }
> > 
> > And got following WARNING after sometime:
> 
> So what's the deal, is this ack or nak for Kevin's patch then?

Kevin's patch seems to fix the serial port issue for sure, so we
definitely need it. I just wanted to point out that there are more issue
in CPUIDLE :)

Cheers,
Ameya.

