From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 12/15] vc: omap3: auto_ret / auto_off support
Date: Mon, 12 Dec 2011 11:53:05 +0200
Message-ID: <1323683585.31914.20.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <1322236188-19456-13-git-send-email-t-kristo@ti.com>
	 <87iplpcxl8.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43742 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105Ab1LLJxJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 04:53:09 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBC9r8Dj017752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:53:08 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC9r8tn020168
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:53:08 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC9r8eF000410
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:53:08 -0600 (CST)
In-Reply-To: <87iplpcxl8.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

On Fri, 2011-12-09 at 12:13 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Voltage code will now enable / disable auto_ret / auto_off dynamically
> > according to the voltagedomain usecounts. This is accomplished via
> > the usage of the voltdm callback functions for sleep / wakeup.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> [...]
> 
> > -static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
> > +static void omap3_set_core_off_timings(struct voltagedomain *voltdm)
> >  {
> > +	u32 tstart, tshut;
> 
> nit: insert blank line here

Okay.

> 
> > +	omap_pm_get_oscillator(&tstart, &tshut);
> > +	omap3_set_clksetup(tstart, voltdm);
> >  	omap3_set_off_timings(voltdm);
> >  }
> >  
> > +static void omap3_vc_channel_sleep(struct voltagedomain *voltdm)
> > +{
> > +	/* Set off timings if entering off */
> > +	if (voltdm->target_state == PWRDM_POWER_OFF)
> > +		omap3_set_off_timings(voltdm);
> > +	else
> > +		omap3_set_i2c_timings(voltdm, 0);
> 
> Comment probably applies more to patch 2 since that's where it was
> introduced, but this is where I got confused, so mentioning it here:
> 
> Calling this 'set_i2c_timings' is a bit confusing IMO because reading
> the code there is a choice between 'i2c' timings and 'off' timings.
> Maybe just calling these 'ret' and 'off' timings will be better for
> readability.

Well, actually, you can use i2c timings when scaling voltage to off
level also. You have following options for voltage scaling on omap3:

- scale to ret level (0.975V) using i2c command
- scale to off level (0.6V) using i2c command
- switch to off (0V) using pmic scripts

I was kind of trying to reflect this here, even though the pmic script
support is missing.

> 
> > +}
> > +
> > +static void omap3_vc_channel_wakeup(struct voltagedomain *voltdm)
> > +{
> > +}
> 
> nit: empty function not needed since code checks for non-NULL function
> pointer.

Yea can drop that away, I left it there because I thought it might need
some beef in it at some point.

> 
> > +static void omap3_vc_core_sleep(struct voltagedomain *voltdm)
> > +{
> > +	u8 mode;
> > +
> > +	switch (voltdm->target_state) {
> > +	case PWRDM_POWER_OFF:
> > +		mode = OMAP3430_AUTO_OFF_MASK;
> > +		break;
> > +	case PWRDM_POWER_RET:
> > +		mode = OMAP3430_AUTO_RET_MASK;
> > +		break;
> > +	default:
> > +		mode = OMAP3430_AUTO_SLEEP_MASK;
> > +		break;
> > +	}
> > +
> > +	if (mode & OMAP3430_AUTO_OFF_MASK)
> 
> AND vs. == ?

Oh yea, some strange logic here for sure, I'll change that to ==. :)

> 
> speaking of which, this function probably needs a comment mentioning
> that these bits are all mutually exclusive (with a TRM reference.)

Can add that too.

-Tero


