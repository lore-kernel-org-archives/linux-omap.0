From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC][PATCH 4/9] ARM: OMAP3: define cpuidle statically
Date: Fri, 23 Mar 2012 13:41:48 +0100
Message-ID: <4F6C6F8C.8010307@linaro.org>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org> <1332494794-7810-4-git-send-email-daniel.lezcano@linaro.org> <CAORVsuUZUWrwzx0hYT4YC0HhwAzTKF+q++LPvg43iy-iYbTivA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50131 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758557Ab2CWMlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 08:41:50 -0400
Received: by eekc41 with SMTP id c41so1020361eek.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 05:41:48 -0700 (PDT)
In-Reply-To: <CAORVsuUZUWrwzx0hYT4YC0HhwAzTKF+q++LPvg43iy-iYbTivA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On 03/23/2012 01:35 PM, Jean Pihet wrote:
> On Fri, Mar 23, 2012 at 10:26 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org>  wrote:
>> Use the new cpuidle API and define in the driver the states.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> ---

[ ... ]

>>         /*
>>          * Erratum i583: implementation for ES rev<  Es1.2 on 3630. =
We cannot
> C7 is enabled only if the errata does not apply.
> This causes a problem with the statically defined C-states and also
> with the per C-state sysfs disable knob. A consistency check should b=
e
> performed before trying to enter a state.

In the patch 5/9, I decrement the state_count if the errata applies. I=20
believe it is still compatible with the static C-states.

>> @@ -338,7 +372,6 @@ int __init omap3_idle_init(void)
>>         drv->state_count =3D OMAP3_NUM_STATES;
>>         cpuidle_register_driver(&omap3_idle_driver);
>>
>> -       dev->state_count =3D OMAP3_NUM_STATES;
>>         if (cpuidle_register_device(dev)) {
>>                 printk(KERN_ERR "%s: CPUidle register device failed\=
n",
>>                        __func__);
>> --
>> 1.7.5.4
>>
>
> Thanks!
> Jean


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
