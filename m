From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Wed, 21 Mar 2012 14:43:58 +0100
Message-ID: <CAORVsuUeE046O7YJ_fE49NbW1OjZHZX+GuNiDkF0AnzBnSMbxA@mail.gmail.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
	<4F69A872.50203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49116 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab2CUNn7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 09:43:59 -0400
Received: by vcqp1 with SMTP id p1so1018940vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 06:43:58 -0700 (PDT)
In-Reply-To: <4F69A872.50203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linaro Dev <linaro-dev@lists.linaro.org>

On Wed, Mar 21, 2012 at 11:07 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Daniel,
>
> On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
>> This patchset is a proposition to improve a bit the code.
>> The changes are code cleanup and does not change the behavior of the
>> driver itself.
>>
>> A couple a things call my intention. Why the cpuidle device is set f=
or cpu0 only
>> and why the WFI is not used ?
>>
>> Daniel Lezcano (7):
>> =A0 ARM: OMAP4: cpuidle - Remove unused valid field
>> =A0 ARM: OMAP4: cpuidle - Declare the states with the driver declara=
tion
>> =A0 ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
>> =A0 ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
>> =A0 ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
>> =A0 ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
>> =A0 ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at b=
oot
>> =A0 =A0 time
>>
> The series looks fine to me in general. This clean-up is applicable
> for OMAP3 cpuidle code as well.
Great!
However OMAP3 has a few specific things that cannot be removed as easil=
y:
- the 'valid' flag is used because only certain combinations of power
domains states are possible,
- the latency settings can be overriden by the board code, so the
cpuidle_params struct is needed.

> I want Jean to look at this series because some of his earlier
> clean up has introduced those custom functions which
> are getting removed in this series.
>
> Regards
> santosh
>
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
