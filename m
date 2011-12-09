From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 12/15] vc: omap3: auto_ret / auto_off support
Date: Fri, 09 Dec 2011 12:13:39 -0800
Message-ID: <87iplpcxl8.fsf@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	<1322236188-19456-13-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:35684 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485Ab1LIUNm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 15:13:42 -0500
Received: by mail-qy0-f181.google.com with SMTP id f13so3695599qcs.40
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 12:13:41 -0800 (PST)
In-Reply-To: <1322236188-19456-13-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Fri, 25 Nov 2011 17:49:45 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

Tero Kristo <t-kristo@ti.com> writes:

> Voltage code will now enable / disable auto_ret / auto_off dynamically
> according to the voltagedomain usecounts. This is accomplished via
> the usage of the voltdm callback functions for sleep / wakeup.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

[...]

> -static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
> +static void omap3_set_core_off_timings(struct voltagedomain *voltdm)
>  {
> +	u32 tstart, tshut;

nit: insert blank line here

> +	omap_pm_get_oscillator(&tstart, &tshut);
> +	omap3_set_clksetup(tstart, voltdm);
>  	omap3_set_off_timings(voltdm);
>  }
>  
> +static void omap3_vc_channel_sleep(struct voltagedomain *voltdm)
> +{
> +	/* Set off timings if entering off */
> +	if (voltdm->target_state == PWRDM_POWER_OFF)
> +		omap3_set_off_timings(voltdm);
> +	else
> +		omap3_set_i2c_timings(voltdm, 0);

Comment probably applies more to patch 2 since that's where it was
introduced, but this is where I got confused, so mentioning it here:

Calling this 'set_i2c_timings' is a bit confusing IMO because reading
the code there is a choice between 'i2c' timings and 'off' timings.
Maybe just calling these 'ret' and 'off' timings will be better for
readability.

> +}
> +
> +static void omap3_vc_channel_wakeup(struct voltagedomain *voltdm)
> +{
> +}

nit: empty function not needed since code checks for non-NULL function
pointer.

> +static void omap3_vc_core_sleep(struct voltagedomain *voltdm)
> +{
> +	u8 mode;
> +
> +	switch (voltdm->target_state) {
> +	case PWRDM_POWER_OFF:
> +		mode = OMAP3430_AUTO_OFF_MASK;
> +		break;
> +	case PWRDM_POWER_RET:
> +		mode = OMAP3430_AUTO_RET_MASK;
> +		break;
> +	default:
> +		mode = OMAP3430_AUTO_SLEEP_MASK;
> +		break;
> +	}
> +
> +	if (mode & OMAP3430_AUTO_OFF_MASK)

AND vs. == ?

speaking of which, this function probably needs a comment mentioning
that these bits are all mutually exclusive (with a TRM reference.)

> +		omap3_set_core_off_timings(voltdm);
> +	else
> +		omap3_set_core_ret_timings(voltdm);
> +
> +	voltdm->rmw(OMAP3430_AUTO_OFF_MASK | OMAP3430_AUTO_RET_MASK |
> +		    OMAP3430_AUTO_SLEEP_MASK, mode,
> +		    OMAP3_PRM_VOLTCTRL_OFFSET);
> +}

Kevin
