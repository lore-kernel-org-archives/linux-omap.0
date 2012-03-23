From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC][PATCH 4/9] ARM: OMAP3: define cpuidle statically
Date: Fri, 23 Mar 2012 14:17:13 +0100
Message-ID: <CAORVsuX0CXjfJkeGyS8LHNsAuTf3yP8Qtqr-G7sm17J83_L1VA@mail.gmail.com>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
	<1332494794-7810-4-git-send-email-daniel.lezcano@linaro.org>
	<CAORVsuUZUWrwzx0hYT4YC0HhwAzTKF+q++LPvg43iy-iYbTivA@mail.gmail.com>
	<4F6C6F8C.8010307@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45596 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab2CWNRO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 09:17:14 -0400
Received: by vcqp1 with SMTP id p1so2781616vcq.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 06:17:14 -0700 (PDT)
In-Reply-To: <4F6C6F8C.8010307@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On Fri, Mar 23, 2012 at 1:41 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 03/23/2012 01:35 PM, Jean Pihet wrote:
>>
>> On Fri, Mar 23, 2012 at 10:26 AM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> =C2=A0wrote:
>>>
>>> Use the new cpuidle API and define in the driver the states.
>>>
>>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>>> ---
>
>
> [ ... ]
>
>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Erratum i583: implementation for ES r=
ev< =C2=A0Es1.2 on 3630. We
>>> cannot
>>
>> C7 is enabled only if the errata does not apply.
>> This causes a problem with the statically defined C-states and also
>> with the per C-state sysfs disable knob. A consistency check should =
be
>> performed before trying to enter a state.
>
>
> In the patch 5/9, I decrement the state_count if the errata applies. =
I
> believe it is still compatible with the static C-states.
Correct! That solves the issue with the statically defined C-states.
The (dynamic) per C-state sysfs disable knob requires a runtime check
on .disable though, in case the cpuidle chosen C-state is demoted
(depending on the value of enable_off_mode and later the latency
constraints on the power domain).

>
>
>>> @@ -338,7 +372,6 @@ int __init omap3_idle_init(void)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0drv->state_count =3D OMAP3_NUM_STATES;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cpuidle_register_driver(&omap3_idle_driv=
er);
>>>
>>> - =C2=A0 =C2=A0 =C2=A0 dev->state_count =3D OMAP3_NUM_STATES;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpuidle_register_device(dev)) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_=
ERR "%s: CPUidle register device failed\n",
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__);
>>> --
>>> 1.7.5.4
>>>
>>
Thanks!
Jean

>
>
>
> --
> =C2=A0<http://www.linaro.org/> Linaro.org =E2=94=82 Open source softw=
are for ARM SoCs
>
> Follow Linaro: =C2=A0<http://www.facebook.com/pages/Linaro> Facebook =
|
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
