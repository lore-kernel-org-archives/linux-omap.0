From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP: clockdomain: Wait for powerdomain to be ON when
 using clockdomain force wakeup
Date: Thu, 11 Aug 2011 19:37:56 +0530
Message-ID: <4E43E23C.2080207@ti.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com> <1310527588-13022-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1107150159580.16606@utopia.booyaka.com> <4E214267.2090700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:45105 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751033Ab1HKOIG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 10:08:06 -0400
Received: by gyd10 with SMTP id 10so1979277gyd.27
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 07:08:05 -0700 (PDT)
In-Reply-To: <4E214267.2090700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, p-titiano@ti.com, b-cousson@ti.com

Paul,

On Saturday 16 July 2011 01:18 PM, Santosh Shilimkar wrote:
> Hi Paul,
>
> On 7/15/2011 1:03 AM, Paul Walmsley wrote:
>> cc'ing Patrick
>>
>> Hi Rajendra, Santosh,
>>
>> some comments here:
>>
>> On Wed, 13 Jul 2011, Santosh Shilimkar wrote:
>>
>>> While using clockdomain force wakeup method, not waiting for powerdomain
>>> to be effectively ON may end up locking the clockdomain FSM until a
>>> next wakeup event occurs.
>>>
>>> One such issue was seen on OMAP4430, where L4_PER was periodically
>>> getting stuck in in-transition state when transitioning from from
>>> OSWR to ON.
>>>
>>> This issue was reported and investigated by Patrick
>>> Titiano<p-titiano@ti.com>
>>>
>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>> Reported-by: Patrick Titiano<p-titiano@ti.com>
>>> Cc: Kevin Hilman<khilman@ti.com>
>>> Cc: Benoit Cousson<b-cousson@ti.com>
>>> Cc: Paul Walmsley<paul@pwsan.com>
>>> ---
>>> arch/arm/mach-omap2/clockdomain.c | 7 ++++++-
>>> 1 files changed, 6 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/clockdomain.c
>>> b/arch/arm/mach-omap2/clockdomain.c
>>> index b98a972..583cc3d 100644
>>> --- a/arch/arm/mach-omap2/clockdomain.c
>>> +++ b/arch/arm/mach-omap2/clockdomain.c
>>> @@ -718,6 +718,8 @@ int clkdm_sleep(struct clockdomain *clkdm)
>>> */
>>> int clkdm_wakeup(struct clockdomain *clkdm)
>>> {
>>> + int ret;
>>> +
>>> if (!clkdm)
>>> return -EINVAL;
>>>
>>> @@ -732,7 +734,10 @@ int clkdm_wakeup(struct clockdomain *clkdm)
>>>
>>> pr_debug("clockdomain: forcing wakeup on %s\n", clkdm->name);
>>>
>>> - return arch_clkdm->clkdm_wakeup(clkdm);
>>> + ret = arch_clkdm->clkdm_wakeup(clkdm);
>>> + ret |= pwrdm_wait_transition(clkdm->pwrdm.ptr);
>>
>> Seems like this should just call pwrdm_state_switch() or
>> pwrdm_clkdm_state_switch()? (This second function looks superfluous, we
>> should probably get rid of it.)
>>
> This comment was expected since initially we thought of using
> pwrdm_clkdm_state_switch
>
> pwrdm_clkdm_state_switch()
> |--> pwrdm_wait_transition()
> |--> pwrdm_state_switch()
>
> What we need is only first function to ensure that we don't
> proceed when PD is in middle of transition.
>
> The second function is actually just doing those debug counter
> updates and we wanted to avoid that since it's a live path.
> Rajendra observed some huge latencies while doing the
> profiling and the suspect was "pwrdm_state_switch()" which
> actually keeps adding overhead because of those counter
> updates.
>
>> Shouldn't this be added to all of
>> clkdm_{wakeup,sleep,allow_idle,deny_idle}() if it isn't there already?
>>
> clkdm_allow_idle() already has the power-domain wait.
> This patch adds it for clkdm_wakeup() function.
> clkdm_sleep(), this shouldn't be applicable since power
> domain sleep transition is depdent on other clockdomains
> in the PD and it's a lazy operation.
> That leaves clkdm_deny_idle() and I guess we should
> address this API as well.
>
> If you agree with above, I can update the patch to address
> remaining clkdm_deny_idle() function.
>
Ping?

Regards
Santosh


