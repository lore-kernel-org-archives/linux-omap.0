From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: Re: [PATCH] Enable SYSOFFMODE use
Date: Wed, 06 Aug 2008 14:15:37 +0300
Message-ID: <1218021337.29799.60.camel@kj-ubuntu>
References: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com>
	 <1216656125-5800-2-git-send-email-peter.de-schrijver@nokia.com>
	 <20080805105057.GQ7193@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55064 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760606AbYHFLNT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 07:13:19 -0400
In-Reply-To: <20080805105057.GQ7193@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>, rnayak@ti.com
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap <linux-omap@vger.kernel.org>

On ti, 2008-08-05 at 13:50 +0300, ext Tony Lindgren wrote:
> * Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [080721 19:03]:
> > 
> > Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> > ---
> >  arch/arm/mach-omap2/smartreflex.c |   10 +++++-----
> >  1 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> > index 0f3a659..b41fe96 100644
> > --- a/arch/arm/mach-omap2/smartreflex.c
> > +++ b/arch/arm/mach-omap2/smartreflex.c
> > @@ -396,17 +396,17 @@ static void sr_configure_vc(void)
> >  
> >  	/* Setup voltctrl and other setup times */
> >  	/* XXX CONFIG_SYSOFFMODE has not been implemented yet */
> > -#ifdef CONFIG_SYSOFFMODE
> > -	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET,
> > -			OMAP3430_GR_MOD,
> > +#ifdef CONFIG_OMAP_SYSOFFMODE
> > +	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET |
> > +			OMAP3430_SEL_OFF, OMAP3430_GR_MOD,
> >  			OMAP3_PRM_VOLTCTRL_OFFSET);
> >  
> >  	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
> >  			OMAP3_PRM_CLKSETUP_OFFSET);
> >  	prm_write_mod_reg((OMAP3430_VOLTSETUP_TIME2 <<
> > -			OMAP3430_VOLTSETUP_TIME2_OFFSET) |
> > +			OMAP3430_SETUP_TIME2_SHIFT) |
> >  			(OMAP3430_VOLTSETUP_TIME1 <<
> > -			OMAP3430_VOLTSETUP_TIME1_OFFSET),
> > +			OMAP3430_SETUP_TIME1_SHIFT),
> >  			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
> >  
> >  	prm_write_mod_reg(OMAP3430_VOLTOFFSET_DURATION, OMAP3430_GR_MOD,
> 
> Do we need the CONFIG_SYSOFFMODE option? How about just add
> /sys/power/off_while_idle and if that's set to 1 then allow off mode?

I would say no, we don't need the CONFIG_SYSOFFMODE option.

I think we can always use 0 volt sys off mode for suspend, since it's
user activated and the wake-up latency is still in range of only few ms.

Dynamic idle is bit different, because the system would have to be idle
a lot longer for the 0V off mode to pay off (when comparing to sleep
voltage off mode). We could have an extra C-state in the upcoming
cpu-idle driver for 0 volt off-mode. Richard, Rajendra, any thoughts?

If that's not feasible, the "off_while_idle" sysfs interface can be
created. 

Br,
Kalle


> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
