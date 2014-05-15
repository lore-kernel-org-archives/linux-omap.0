From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Thu, 15 May 2014 19:50:25 +0200
Message-ID: <5374FE61.50901@linaro.org>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com> <5373C78E.7040301@linaro.org> <5373C8E8.6040208@ti.com> <5373CBB9.40506@linaro.org> <5373DD94.8030208@ti.com> <5374F35E.5040900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:44697 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbaEORuR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 13:50:17 -0400
Received: by mail-wi0-f175.google.com with SMTP id f8so10273710wiw.2
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2014 10:50:15 -0700 (PDT)
In-Reply-To: <5374F35E.5040900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Alex Shi <alex.shi@linaro.org>

On 05/15/2014 07:03 PM, Santosh Shilimkar wrote:
> Daniel,
>
> On Wednesday 14 May 2014 05:18 PM, Santosh Shilimkar wrote:
>> On Wednesday 14 May 2014 04:02 PM, Daniel Lezcano wrote:
>>> On 05/14/2014 09:50 PM, Santosh Shilimkar wrote:
>>>> On Wednesday 14 May 2014 03:44 PM, Daniel Lezcano wrote:
>>>>> On 05/13/2014 04:39 PM, Santosh Shilimkar wrote:
>>>>>> On OMAP4 panda board, there have been several bug reports about =
boot
>>>>>> hang and lock-ups with CPU_IDLE enabled. The root cause of the i=
ssue
>>>>>> is missing interrupts while in idle state. Commit cb7094e8 {cpui=
dle / omap4 :
>>>>>> use CPUIDLE_FLAG_TIMER_STOP flag} moved the broadcast notifiers =
to common
>>>>>> code for right reasons but on OMAP4 which suffers from a nasty R=
OM code
>>>>>> bug with GIC, commit ff999b8a {ARM: OMAP4460: Workaround for ROM=
 bug ..},
>>>>>> we loose interrupts which leads to issues like lock-up, hangs et=
c.
>>>>>>
>>>>>> Patch reverts commit cb7094 {cpuidle / omap4 : use CPUIDLE_FLAG_=
TIMER_STOP
>>>>>> flag} to avoid the issue. With this change, OMAP4 panda boards, =
the mentioned
>>>>>> issues are getting fixed. We no longer loose interrupts which wa=
s the cause
>>>>>> of the regression.
>>>>>>
>>>>>> Cc: Roger Quadros <rogerq@ti.com>
>>>>>> Cc: Kevin Hilman <khilman@linaro.org>
>>>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>> Reported-tested-by: Roger Quadros <rogerq@ti.com>
>>>>>> Reported-tested-by: Kevin Hilman <khilman@linaro.org>
>>>>>> Tested-by: Tony Lindgren <tony@atomide.com>
>>>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>>> ---
>>>
>>> [ ... ]
>>>
>>>>>>
>>>>>> +    clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_i=
d);
>>>>>> +
>>>>>>         /*
>>>>>>          * Call idle CPU PM enter notifier chain so that
>>>>>>          * VFP and per CPU interrupt context is saved.
>>>>>> @@ -165,6 +169,8 @@ static int omap_enter_idle_coupled(struct cp=
uidle_device *dev,
>>>>>>         if (dev->cpu =3D=3D 0 && mpuss_can_lose_context)
>>>>>>             cpu_cluster_pm_exit();
>>>>>>
>>>>>> +    clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id=
);
>>>
>>> [ ... ]
>>>
>>>>>
>>>>> Shouldn't the broadcast timer to be setup with CLOCK_EVT_NOTIFY_B=
ROADCAST_ON also ?
>>>>>
>>>> Which is already taken care by __cpuidle_register_driver(). Note t=
hat setup code
>>>> is still used from generic code...
>>>
>>> Nope, if the flag CPUIDLE_FLAG_TIMER_STOP is not set, the cpuidle f=
ramework won't setup the timer.
>>>
>> I see. I assumed it was taken care. So we might have setup the timer=
 too.
>>
>>> static void __cpuidle_driver_init(struct cpuidle_driver *drv)
>>> {
>>>
>>>      ...
>>>
>>>      for (i =3D drv->state_count - 1; i >=3D 0 ; i--) {
>>>          if (drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP) {
>> May be you should start the bc timer in case 'CPUIDLE_FLAG_TIMER_STO=
P'
>> or 'CPUIDLE_FLAG_COUPLED'
>>>              drv->bctimer =3D 1;
>>>              break;
>>>          }
>>>      }
>>>
>>>      ...
>>>
>>> }
>>>
>>> static int __cpuidle_register_driver(struct cpuidle_driver *drv)
>>> {
>>>      ...
>>>
>>>      if (drv->bctimer)
>>>          on_each_cpu_mask(drv->cpumask,
>>>          cpuidle_setup_broadcast_timer,
>>>           (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON, 1);
>>>
>>>      ...
>>> }
>>>
>>> So the broadcast timer does not operate with this revert. Moreover,=
 I am not sure reverting this patch is the right solution.
>>>
>> With above mentioned change, it should work. Other alternatives is O=
MAP4 driver does
>> its won registration where it can start the timer. The way it was be=
fore the
>> consolidation.
>>
>> Ofcourse if you have better fix, then great.
>>
> What is your suggestion. We *must* fix the regression asap. I think
> $subject patch with an update to bctimer start under CPUIDLE_FLAG_COU=
PLED
> seems a good way forward.
>
> Do let me know.

Did you see Alex Shi's email [cc'ed] ? Reverting this change makes the=20
panda ES to hang.

I am not convinced the culprit is this code you are trying to revert.

I will try to reproduce the bug on my board.

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
