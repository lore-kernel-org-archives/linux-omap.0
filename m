From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP3: PM: cpuidle: optimize the clkdm idle
 latency in C1 state
Date: Wed, 20 Jun 2012 14:16:58 +0530
Message-ID: <4FE18E02.6020008@ti.com>
References: <1338563468-31403-1-git-send-email-j-pihet@ti.com>	<1338563468-31403-4-git-send-email-j-pihet@ti.com>	<4FE187A8.8060203@ti.com> <CAORVsuWEpsY2MDO=6oLWs=Sdxq+0gk5PHvMvqCwYCjv1+4WDOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:50672 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753365Ab2FTIrG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 04:47:06 -0400
Received: by obbtb18 with SMTP id tb18so11342125obb.33
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 01:47:04 -0700 (PDT)
In-Reply-To: <CAORVsuWEpsY2MDO=6oLWs=Sdxq+0gk5PHvMvqCwYCjv1+4WDOw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Wednesday 20 June 2012 02:01 PM, Jean Pihet wrote:
> Hi Rajendra,
>
> On Wed, Jun 20, 2012 at 10:19 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
>> Hi Jean,
>>
>>
>> On Friday 01 June 2012 08:41 PM, Jean Pihet wrote:
>>>
>>> For a power domain to idle all the clock domains in it must idle.
>>> This patch implements an optimization of the cpuidle code by
>>> denying and later allowing only the first registered clock domain
>>> of a power domain, and so optimizes the latency of the low power code.
>>
>>
>> How much do we really save doing this? I understand what you are doing
>> by looking at the patch but the changelog seems very confusing.
> The gain is on the registers accesses and the internal PRCM state machine.
> If needed the changelog can be updated.

Can you explain a bit more on which register accesses are you talking
about? and some more on the PRCM state machine.

>
>> What the patch does is get rid of a few function indirection
>> and assumes there is only *one* clkdm for mpu and core. Is that right?
> Not exactly. The patch does not assume that there is only one clkdm
> per power domain. It just allows or denies only one clkdm to idle,
> which has the same effect at the power domain level.

Ok, so lets assume mpu on OMAP3 has 2 clkdms, and you allow only one
of them to idle. Will that have the same effect at the power domain
level?
The first line of the change log says "For a power domain to idle *all*
the clock domains in it must idle" and now you say allowing only *one*
clkdm to idle should have the same effect at the power domain level.
I am confused.

>
> Thanks for reviewing,
> Jean
>
>>
>> regards,
>> Rajendra
>>
>>
>>>
>>> The functions _cpuidle_allow_idle and _cpuidle_deny_idle are
>>> not used anymore and so are removed.
>>>
>>> Signed-off-by: Jean Pihet<j-pihet@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/cpuidle34xx.c |   22 ++++------------------
>>>   1 files changed, 4 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
>>> b/arch/arm/mach-omap2/cpuidle34xx.c
>>> index 2e2f1c6..e6ae3fe 100644
>>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>>> @@ -77,20 +77,6 @@ static struct omap3_idle_statedata omap3_idle_data[] =
>>> {
>>>
>>>   static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>>>
>>> -static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
>>> -                               struct clockdomain *clkdm)
>>> -{
>>> -       clkdm_allow_idle(clkdm);
>>> -       return 0;
>>> -}
>>> -
>>> -static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
>>> -                               struct clockdomain *clkdm)
>>> -{
>>> -       clkdm_deny_idle(clkdm);
>>> -       return 0;
>>> -}
>>> -
>>>   static int __omap3_enter_idle(struct cpuidle_device *dev,
>>>                                 struct cpuidle_driver *drv,
>>>                                 int index)
>>> @@ -108,8 +94,8 @@ static int __omap3_enter_idle(struct cpuidle_device
>>> *dev,
>>>
>>>         /* Deny idle for C1 */
>>>         if (index == 0) {
>>> -               pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
>>> -               pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
>>> +               clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
>>> +               clkdm_deny_idle(core_pd->pwrdm_clkdms[0]);
>>>         }
>>>
>>>         /*
>>> @@ -131,8 +117,8 @@ static int __omap3_enter_idle(struct cpuidle_device
>>> *dev,
>>>
>>>         /* Re-allow idle for C1 */
>>>         if (index == 0) {
>>> -               pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
>>> -               pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
>>> +               clkdm_allow_idle(mpu_pd->pwrdm_clkdms[0]);
>>> +               clkdm_allow_idle(core_pd->pwrdm_clkdms[0]);
>>>         }
>>>
>>>   return_sleep_time:
>>
>>

