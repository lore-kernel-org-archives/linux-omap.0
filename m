From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/8] OMAP2+: powerdomain: control power domains next state
Date: Fri, 16 Sep 2011 11:27:49 -0700
Message-ID: <871uvgnxzu.fsf@ti.com>
References: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
	<1314969204-21704-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:54359 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754380Ab1IPS14 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 14:27:56 -0400
Received: by mail-gx0-f172.google.com with SMTP id 19so5281623gxk.17
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 11:27:54 -0700 (PDT)
In-Reply-To: <1314969204-21704-4-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Fri, 2 Sep 2011 15:13:19 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> When a PM QoS device latency constraint is requested or removed the
> PM QoS layer notifies the underlying layer with the updated aggregated
> constraint value. The constraint is stored in the powerdomain constraints
> list and then applied to the corresponding power domain.
> The power domains get the next power state programmed directly in the
> registers via pwrdm_wakeuplat_update_pwrst.
>
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using
> wake-up latency constraints on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

[...]

> @@ -191,6 +198,77 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
>  	return 0;
>  }
>  
> +/**
> + * pwrdm_wakeuplat_update_pwrst - Update power domain power state if needed
> + * @pwrdm: struct powerdomain * to which requesting device belongs to.
> + * @min_latency: the allowed wake-up latency for the given power domain. A
> + *  value of PM_QOS_DEV_LAT_DEFAULT_VALUE means 'no constraint' on the pwrdm.
> + *
> + * Finds the power domain next power state that fulfills the constraint.
> + * Programs a new target state if it is different from current power state.
> + * The power domains get the next power state programmed directly in the
> + * registers.
> + *
> + * Returns 0 upon success.
> + */
> +static int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm,
> +					long min_latency)
> +{
> +	int ret = 0, new_state = 0;
> +
> +	if (!pwrdm) {
> +		WARN(1, "powerdomain: %s: invalid parameter(s)", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Apply constraints to power domains by programming
> +	 * the pwrdm next power state.
> +	 */
> +
> +	/* Find power state with wakeup latency < minimum constraint */
> +	for (new_state = 0x0; new_state < PWRDM_MAX_PWRSTS; new_state++) {
> +		if (min_latency == PM_QOS_DEV_LAT_DEFAULT_VALUE ||
> +		    pwrdm->wakeup_lat[new_state] <= min_latency)

Since min_latency is signed, this is a signed compare.  In later patches
you've defined the UNSUP_STATE to be -1, which will always be <=
min_latency whn using a signed compare.

So, won't this always end up picking the first state marked as
UNSUP_STATE?

> +			break;
> +	}

Kevin
