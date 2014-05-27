From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Tue, 27 May 2014 23:06:28 +0200
Message-ID: <5384FE54.4040303@linaro.org>
References: <20140519172338.GJ4849@atomide.com> <537A408F.7070301@ti.com> <20140519175157.GK4849@atomide.com> <537A4827.30604@linaro.org> <20140519193622.GA11945@atomide.com> <537A5F5B.6050403@linaro.org> <537A7522.30007@math.uni-bielefeld.de> <20140523144425.GB2321@atomide.com> <20140523183228.GH2321@atomide.com> <CAKnoXLxj42veWCbRjX98iT3FNAb92J4yR+UAL716JFSOb=pcrQ@mail.gmail.com> <20140527203452.GA32336@atomide.com> <5384FDBF.2050604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:39747 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbaE0VGN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2014 17:06:13 -0400
Received: by mail-we0-f175.google.com with SMTP id p10so1407979wes.34
        for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 14:06:12 -0700 (PDT)
In-Reply-To: <5384FDBF.2050604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Alex Shi <alex.shi@linaro.org>, Kevin Hilman <khilman@linaro.org>, Linux ARM Kernel ML <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On 05/27/2014 11:03 PM, Santosh Shilimkar wrote:
> On Tuesday 27 May 2014 04:34 PM, Tony Lindgren wrote:
>> * Daniel Lezcano <daniel.lezcano@linaro.org> [140523 13:53]:
>>> On 23 May 2014 20:32, Tony Lindgren <tony@atomide.com> wrote:
>>>
>>>> * Tony Lindgren <tony@atomide.com> [140523 07:45]:
>>>>> * Tobias Jakobi <tjakobi@math.uni-bielefeld.de> [140519 14:19]:
>>>>>>
>>>>>> But even if I don't connect via WiFi at all, just boot and let m=
e
>>>> system
>>>>>> run with serial console connected, after some time I get a kerne=
l
>>>> 'WARNING':
>>>>>> http://www.math.uni-bielefeld.de/~tjakobi/archive/dmesg.1.log
>>>>>
>>>>> BTW, care to update the bugzilla page with the second warning
>>>>> in this log?
>>>>>
>>>>> That's the WARNING: CPU: 1 PID: 0 at kernel/timer.c:1147 that's
>>>>> at 238 seconds.
>>>>
>>>> Also, with Santosh's fix applied, can you also try disabling one
>>>> or more of the idle states for cpuidle and see if that helps?
>>>>
>>>> Something like this patch below. If that helps with the WARNING
>>>> above you're getting it narrows down the problem down quite a bit.
>>>>
>>>> Regards,
>>>>
>>>> Tony
>>>>
>>>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>>>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
>>>> @@ -44,11 +44,13 @@ static struct idle_statedata omap4_idle_data[]=
 =3D {
>>>>                  .mpu_state =3D PWRDM_POWER_RET,
>>>>                  .mpu_logic_state =3D PWRDM_POWER_RET,
>>>>          },
>>>> +#if 0
>>>>          {
>>>>                  .cpu_state =3D PWRDM_POWER_OFF,
>>>>                  .mpu_state =3D PWRDM_POWER_RET,
>>>>                  .mpu_logic_state =3D PWRDM_POWER_OFF,
>>>>          },
>>>> +#endif
>>>>
>>>
>>> Hmm, I am afraid that will lead to a fault. Safer to set the state_=
count =3D
>>> 2 instead.
>>
>> Hmm don't we have state_count =3D ARRAY_SIZE(omap4_idle_data) or am =
I
>> missing something?
>>
> I don't think you are missing anything. The change should work.

Oh, yes. Sorry, over-sighted that. I am too used with the other drivers=
=20
assigning the state_count with a number.


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
