From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Fri, 27 Aug 2010 11:46:52 +0200
Message-ID: <AANLkTin9sPHQD8v11_5iUDetJ0MsjfQ+NtENA3y92emN@mail.gmail.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41410 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab0H0Jqy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 05:46:54 -0400
Received: by qyk33 with SMTP id 33so2681391qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 02:46:54 -0700 (PDT)
In-Reply-To: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vishwanath.sripathy@linaro.org
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

Hi,

On Sat, Aug 28, 2010 at 12:08 AM,  <vishwanath.sripathy@linaro.org> wro=
te:
> From: Vishwanath BS <vishwanath.sripathy@linaro.org>
>
> This patch has instrumentation code for measuring latencies for
> various CPUIdle C states for OMAP. Idea here is to capture the
> timestamp at various phases of CPU Idle and then compute the sw
> latency for various c states. For OMAP, 32k clock is chosen as
> reference clock this as is an always on clock. wkup domain memory
> (scratchpad memory) is used for storing timestamps. One can see the
> worstcase latencies in below sysfs entries (after enabling CONFIG_CPU=
_IDLE_PROF
> in .config). This information can be used to correctly configure cpu =
idle
> latencies for various C states after adding HW latencies for each of
> these sw latencies.
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
>
> THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
>
> Signed-off-by: Vishwanath BS <vishwanath.sripathy@linaro.org>
> Cc: linaro-dev@lists.linaro.org
> ---
=2E..

>
> +#ifdef CONFIG_CPU_IDLE_PROF
> + =A0 =A0 =A0 sleep_time =3D omap3_sram_get_sleep_time();
> + =A0 =A0 =A0 wkup_time =3D omap3_sram_get_wkup_time();
> +
> + =A0 =A0 =A0 /* take care of overflow */
> + =A0 =A0 =A0 if (postidle_time < preidle_time)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 postidle_time +=3D (u32) 0xffffffff;
> + =A0 =A0 =A0 if (wkup_time < sleep_time)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wkup_time +=3D (u32) 0xffffffff;
> +
> + =A0 =A0 =A0 idle_time =3D postidle_time - preidle_time;
> + =A0 =A0 =A0 total_sleep_time =3D wkup_time - =A0sleep_time;
> + =A0 =A0 =A0 latency =3D idle_time - total_sleep_time;
> + =A0 =A0 =A0 sleep_time =3D omap3_sram_get_sleep_time();
> + =A0 =A0 =A0 wkup_time =3D omap3_sram_get_wkup_time();
Is it needed to re-read the sleep_time and wkup_time values from the sc=
ratchpad?
What about the 32k timer overflow? Could that cause the sleep_latency
and/or wkup_latency to be <0?

> +
> + =A0 =A0 =A0 /* calculate average latency after ignoring sprious one=
s */
> + =A0 =A0 =A0 if ((total_sleep_time > 0) && (latency > state->actual_=
latency)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (latency >=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state->actual_latency =3D CONVERT_32K_U=
SEC(latency);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 latency =3D (sleep_time - preidle_time)=
;
Risk of overflow?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state->sleep_latency =3D CONVERT_32K_US=
EC(latency);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 latency =3D postidle_time - wkup_time;
Risk of overflow?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state->wkup_latency =3D CONVERT_32K_USE=
C(latency);
> + =A0 =A0 =A0 }
> +#endif
> +
> =A0 =A0 =A0 =A0return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_se=
c * USEC_PER_SEC;
> =A0}
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
