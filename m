From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 8/8] ARM: OMAP4: PM: Added option for enabling OSWR
Date: Wed, 16 May 2012 12:10:45 +0300
Message-ID: <1337159445.2149.355.camel@sokoban>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
	 <1336989796-26594-9-git-send-email-t-kristo@ti.com> <87zk999ie4.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39493 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932639Ab2EPJKz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 05:10:55 -0400
In-Reply-To: <87zk999ie4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Tue, 2012-05-15 at 15:41 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > PM debug now contains a file that can be used to control OSWR support
> > enable / disable on OMAP4. Also removed the off_mode_enable file for
> > the same platform as it is unsupported.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> I'll gladly take a patch that makes enable_off_mode OMAP3-only, but I am
> not interested managing another new flag for OSWR.
> 
> For OMAP4, this should just be the default, and any drivers that are
> broken just need to be fixed either by implementing context save/restore
> or by using constraints.

Well, it is not flag as such, as it is static variable internal to
pm-debug.c. I could drop this, however it is extremely useful as a
testing feature. Without this, it is difficult to test CSWR / OSWR. If
you have taken a look at the device-off set, I am actually adding the
flag back for omap4 there for enabling device off. If this flag is also
dropped, the device will always just go to device off, in which case
testing CSWR / OSWR becomes an issue again, and I don't think this is
ideal.

Speaking of enable_off_mode, it might be possible to change it also be
static and remove all the references to it from code. Currently it is
only used from cpuidle34xx.c.

-Tero

> 
> Kevin
> 
> > ---
> >  arch/arm/mach-omap2/pm-debug.c |   20 ++++++++++++++++----
> >  arch/arm/mach-omap2/pm.h       |    1 +
> >  arch/arm/mach-omap2/pm44xx.c   |   16 ++++++++++++++++
> >  3 files changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> > index 814bcd9..d9a8e42 100644
> > --- a/arch/arm/mach-omap2/pm-debug.c
> > +++ b/arch/arm/mach-omap2/pm-debug.c
> > @@ -39,6 +39,7 @@
> >  #include "pm.h"
> >  
> >  u32 enable_off_mode;
> > +static u32 enable_oswr_mode;
> >  
> >  #ifdef CONFIG_DEBUG_FS
> >  #include <linux/debugfs.h>
> > @@ -247,10 +248,13 @@ static int option_set(void *data, u64 val)
> >  			omap_pm_enable_off_mode();
> >  		else
> >  			omap_pm_disable_off_mode();
> > -		if (cpu_is_omap34xx())
> > -			omap3_pm_off_mode_enable(val);
> > +
> > +		omap3_pm_off_mode_enable(val);
> >  	}
> >  
> > +	if (option == &enable_oswr_mode)
> > +		omap4_pm_oswr_mode_enable(val);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -274,8 +278,16 @@ static int __init pm_dbg_init(void)
> >  
> >  	pwrdm_for_each(pwrdms_setup, (void *)d);
> >  
> > -	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
> > -				   &enable_off_mode, &pm_dbg_option_fops);
> > +	if (cpu_is_omap34xx())
> > +		(void) debugfs_create_file("enable_off_mode",
> > +			S_IRUGO | S_IWUSR, d, &enable_off_mode,
> > +			&pm_dbg_option_fops);
> > +
> > +	if (cpu_is_omap44xx())
> > +		(void) debugfs_create_file("enable_oswr_mode",
> > +			S_IRUGO | S_IWUSR, d, &enable_oswr_mode,
> > +			&pm_dbg_option_fops);
> > +
> >  	pm_dbg_init_done = 1;
> >  
> >  	return 0;
> > diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> > index 36fa90b..c36ab63 100644
> > --- a/arch/arm/mach-omap2/pm.h
> > +++ b/arch/arm/mach-omap2/pm.h
> > @@ -17,6 +17,7 @@
> >  
> >  extern void *omap3_secure_ram_storage;
> >  extern void omap3_pm_off_mode_enable(int);
> > +extern void omap4_pm_oswr_mode_enable(int);
> >  extern void omap_sram_idle(void);
> >  extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
> >  extern int omap3_idle_init(void);
> > diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> > index cc85576..07ac0d3 100644
> > --- a/arch/arm/mach-omap2/pm44xx.c
> > +++ b/arch/arm/mach-omap2/pm44xx.c
> > @@ -115,6 +115,22 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
> >  	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
> >  }
> >  
> > +void omap4_pm_oswr_mode_enable(int enable)
> > +{
> > +	u32 next_logic_state;
> > +	struct power_state *pwrst;
> > +
> > +	if (enable)
> > +		next_logic_state = PWRDM_POWER_OFF;
> > +	else
> > +		next_logic_state = PWRDM_POWER_RET;
> > +
> > +	list_for_each_entry(pwrst, &pwrst_list, node) {
> > +		pwrst->next_logic_state = next_logic_state;
> > +		pwrdm_set_logic_retst(pwrst->pwrdm, pwrst->next_logic_state);
> > +	}
> > +}
> > +
> >  /**
> >   * omap_default_idle - OMAP4 default ilde routine.'
> >   *


