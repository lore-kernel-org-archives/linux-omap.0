From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 01/10] ARM: OMAP2+: PM QoS: control the power domains next
 state from the constraints
Date: Thu, 19 Jul 2012 22:08:34 -0500
Message-ID: <CAOMWX4d76EiS9tqwaWvHiCFLubaJ39EGSwwJdrpfFzmvp=iEVw@mail.gmail.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com> <1339686361-11526-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33334 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750789Ab2GTDI5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 23:08:57 -0400
Received: by wibhm2 with SMTP id hm2so9776wib.10
        for <linux-omap@vger.kernel.org>; Thu, 19 Jul 2012 20:08:54 -0700 (PDT)
In-Reply-To: <1339686361-11526-2-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

On Thu, Jun 14, 2012 at 10:05 AM, Jean Pihet <jean.pihet@newoldbits.com>
wrote:
>
>
> +static int _pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm,
> +                                        long min_latency)
> +{
> +       int ret = 0, state, new_state = PWRDM_FUNC_PWRST_ON;
> +
> +       if (!pwrdm) {
> +               WARN(1, "powerdomain: %s: invalid parameter(s)",
> __func__);
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * Find the next supported power state with
> +        *  wakeup latency <= min_latency.
> +        * Pick the lower state if no constraint on the pwrdm
> +        *  (min_latency == PM_QOS_DEV_LAT_DEFAULT_VALUE).
> +        * Skip the states marked as unsupported (UNSUP_STATE).
> +        * If no power state found, fall back to PWRDM_FUNC_PWRST_ON.
> +        */
> +       for (state = 0x0; state < PWRDM_MAX_FUNC_PWRSTS; state++) {
> +               if ((min_latency == PM_QOS_DEV_LAT_DEFAULT_VALUE) ||
Since we search for default_value, we will endup matching OFF always,
even if it is supported
state(marked UNSUP_STATE) or not. That is not correct, even though
omap_setpwrdm_state
will check for achievable state before setting it.
> +                   ((pwrdm->wakeup_lat[state] != UNSUP_STATE) &&
> +                    (pwrdm->wakeup_lat[state] <= min_latency))) {
further instead of the ()s, can we make it simple as:
if (pwrdm->wakeup_lat[state] == UNSUP_STATE)
        continue;
if (min_latency == PM_QOS_DEV_LAT_DEFAULT_VALUE ||
     pwrdm->wakeup_lat[state] <= min_latency) {
        new_state = state;
        break;
}

> +                       new_state = state;
> +                       break;
> +               }
> +       }


Regards,
Nishanth Menon
