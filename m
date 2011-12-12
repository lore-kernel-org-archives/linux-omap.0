From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 12/15] vc: omap3: auto_ret / auto_off support
Date: Mon, 12 Dec 2011 07:05:36 -0800
Message-ID: <874nx5g79b.fsf@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	<1322236188-19456-13-git-send-email-t-kristo@ti.com>
	<87iplpcxl8.fsf@ti.com> <1323683585.31914.20.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:43541 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750862Ab1LLPFk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 10:05:40 -0500
Received: by qcsc20 with SMTP id c20so45702810qcs.30
        for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 07:05:38 -0800 (PST)
In-Reply-To: <1323683585.31914.20.camel@sokoban> (Tero Kristo's message of
	"Mon, 12 Dec 2011 11:53:05 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, nm@ti.com

Tero Kristo <t-kristo@ti.com> writes:

> On Fri, 2011-12-09 at 12:13 -0800, Kevin Hilman wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>> 
>> > Voltage code will now enable / disable auto_ret / auto_off dynamically
>> > according to the voltagedomain usecounts. This is accomplished via
>> > the usage of the voltdm callback functions for sleep / wakeup.
>> >
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> 
>> [...]
>> 
>> > -static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
>> > +static void omap3_set_core_off_timings(struct voltagedomain *voltdm)
>> >  {
>> > +	u32 tstart, tshut;
>> 
>> nit: insert blank line here
>
> Okay.
>
>> 
>> > +	omap_pm_get_oscillator(&tstart, &tshut);
>> > +	omap3_set_clksetup(tstart, voltdm);
>> >  	omap3_set_off_timings(voltdm);
>> >  }
>> >  
>> > +static void omap3_vc_channel_sleep(struct voltagedomain *voltdm)
>> > +{
>> > +	/* Set off timings if entering off */
>> > +	if (voltdm->target_state == PWRDM_POWER_OFF)
>> > +		omap3_set_off_timings(voltdm);
>> > +	else
>> > +		omap3_set_i2c_timings(voltdm, 0);
>> 
>> Comment probably applies more to patch 2 since that's where it was
>> introduced, but this is where I got confused, so mentioning it here:
>> 
>> Calling this 'set_i2c_timings' is a bit confusing IMO because reading
>> the code there is a choice between 'i2c' timings and 'off' timings.
>> Maybe just calling these 'ret' and 'off' timings will be better for
>> readability.
>
> Well, actually, you can use i2c timings when scaling voltage to off
> level also. You have following options for voltage scaling on omap3:
>
> - scale to ret level (0.975V) using i2c command
> - scale to off level (0.6V) using i2c command
> - switch to off (0V) using pmic scripts
>
> I was kind of trying to reflect this here, even though the pmic script
> support is missing.
>

OK, makes sense now.   Being more vebose in the changelog, or better,
having verbose kernel comments for the functions would help here.

Kevin
