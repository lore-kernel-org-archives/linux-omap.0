From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Wed, 14 May 2014 22:02:01 +0200
Message-ID: <5373CBB9.40506@linaro.org>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com> <5373C78E.7040301@linaro.org> <5373C8E8.6040208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:58687 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaENUBx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 16:01:53 -0400
Received: by mail-wg0-f46.google.com with SMTP id n12so2406585wgh.17
        for <linux-omap@vger.kernel.org>; Wed, 14 May 2014 13:01:51 -0700 (PDT)
In-Reply-To: <5373C8E8.6040208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, khilman@linaro.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On 05/14/2014 09:50 PM, Santosh Shilimkar wrote:
> On Wednesday 14 May 2014 03:44 PM, Daniel Lezcano wrote:
>> On 05/13/2014 04:39 PM, Santosh Shilimkar wrote:
>>> On OMAP4 panda board, there have been several bug reports about boo=
t
>>> hang and lock-ups with CPU_IDLE enabled. The root cause of the issu=
e
>>> is missing interrupts while in idle state. Commit cb7094e8 {cpuidle=
 / omap4 :
>>> use CPUIDLE_FLAG_TIMER_STOP flag} moved the broadcast notifiers to =
common
>>> code for right reasons but on OMAP4 which suffers from a nasty ROM =
code
>>> bug with GIC, commit ff999b8a {ARM: OMAP4460: Workaround for ROM bu=
g ..},
>>> we loose interrupts which leads to issues like lock-up, hangs etc.
>>>
>>> Patch reverts commit cb7094 {cpuidle / omap4 : use CPUIDLE_FLAG_TIM=
ER_STOP
>>> flag} to avoid the issue. With this change, OMAP4 panda boards, the=
 mentioned
>>> issues are getting fixed. We no longer loose interrupts which was t=
he cause
>>> of the regression.
>>>
>>> Cc: Roger Quadros <rogerq@ti.com>
>>> Cc: Kevin Hilman <khilman@linaro.org>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Reported-tested-by: Roger Quadros <rogerq@ti.com>
>>> Reported-tested-by: Kevin Hilman <khilman@linaro.org>
>>> Tested-by: Tony Lindgren <tony@atomide.com>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---

[ ... ]

>>>
>>> +    clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
>>> +
>>>        /*
>>>         * Call idle CPU PM enter notifier chain so that
>>>         * VFP and per CPU interrupt context is saved.
>>> @@ -165,6 +169,8 @@ static int omap_enter_idle_coupled(struct cpuid=
le_device *dev,
>>>        if (dev->cpu =3D=3D 0 && mpuss_can_lose_context)
>>>            cpu_cluster_pm_exit();
>>>
>>> +    clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);

[ ... ]

>>
>> Shouldn't the broadcast timer to be setup with CLOCK_EVT_NOTIFY_BROA=
DCAST_ON also ?
>>
> Which is already taken care by __cpuidle_register_driver(). Note that=
 setup code
> is still used from generic code...

Nope, if the flag CPUIDLE_FLAG_TIMER_STOP is not set, the cpuidle=20
framework won't setup the timer.

static void __cpuidle_driver_init(struct cpuidle_driver *drv)
{

	...

	for (i =3D drv->state_count - 1; i >=3D 0 ; i--) {
		if (drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP) {
			drv->bctimer =3D 1;
			break;
		}
	}

	...

}

static int __cpuidle_register_driver(struct cpuidle_driver *drv)
{
	...

	if (drv->bctimer)
		on_each_cpu_mask(drv->cpumask,
		cpuidle_setup_broadcast_timer,
		 (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON, 1);

	...
}

So the broadcast timer does not operate with this revert. Moreover, I a=
m=20
not sure reverting this patch is the right solution.

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
