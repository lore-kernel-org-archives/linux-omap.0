From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Thu, 12 Aug 2010 14:51:08 +0300
Message-ID: <20100812115107.GC6629@atomide.com>
References: <1281542626-4045-1-git-send-email-khilman@deeprootsystems.com>
 <1281609324.1861.6.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50619 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759922Ab0HLLvN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 07:51:13 -0400
Content-Disposition: inline
In-Reply-To: <1281609324.1861.6.camel@chotu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

* Ameya Palande <ameya.palande@nokia.com> [100812 13:28]:
> Hi Kevin,
> 
> On Wed, 2010-08-11 at 18:03 +0200, ext Kevin Hilman wrote:
> > From: Kevin Hilman <khilman@ti.com>
> > 
> > Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
> > mistakenly removed the check for PER when disabling the IO chain.
> > 
> > During idle, if the PER powerdomain transitions and CORE does not (as
> > is the case with the lower C-states when using CPUidle) the IO pad
> > wakeups are not being disabled in the idle path after they are
> > enabled.
> > 
> > This patch ensures that the check for disabling IO wakeups also checks
> > for PER transitions, matching the check done to enable IO wakeups.
> > 
> > Found when debugging PM/CPUidle related problems reported by Ameya
> > Palande <ameya.palande@nokia.com>.  Problems were triggered
> > particularily on boards with UART2 consoles (n900, Overo) since UART2
> > is in the PER powerdomain.
> > 
> > Tested on l-o master (omap3_defonfig + CONFIG_CPU_IDLE=y) as well
> > as with current PM branch.  Boards tested: n900, Overo, omap3evm.
> > 
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Ameya Palande <ameya.palande@nokia.com>
> > Tested-by: Jarkko Nikula <jhnikula@gmail.com>
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> > Tony, this should go in with fixes for -rc2
> > 
> > Changes since v1
> > - added a bit of history about where the problem was created
> > - added 'Tested-by' for Jarkko
> > 
> >  arch/arm/mach-omap2/pm34xx.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > index fb4994a..7b03426 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -480,7 +480,9 @@ void omap_sram_idle(void)
> >  	}
> >  
> >  	/* Disable IO-PAD and IO-CHAIN wakeup */
> > -	if (omap3_has_io_wakeup() && core_next_state < PWRDM_POWER_ON) {
> > +	if (omap3_has_io_wakeup() &&
> > +	    (per_next_state < PWRDM_POWER_ON ||
> > +	     core_next_state < PWRDM_POWER_ON)) {
> >  		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
> >  		omap3_disable_io_chain();
> >  	}
> 
> Thanks for your fix!
> I tried out following patch on n900 kernel (based on 2.6.35 mainline)
> hosted at: http://gitorious.org/nokia-n900-kernel
> 
> Patch:
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index b88737f..887242d 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -479,7 +479,8 @@ void omap_sram_idle(void)
>         }
>  
>         /* Disable IO-PAD and IO-CHAIN wakeup */
> -       if (core_next_state < PWRDM_POWER_ON) {
> +       if (per_next_state < PWRDM_POWER_ON ||
> +                       core_next_state < PWRDM_POWER_ON) {
>                 prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
> PM_WKEN);
>                 omap3_disable_io_chain();
>         }
> 
> And got following WARNING after sometime:

So what's the deal, is this ack or nak for Kevin's patch then?

Tony
