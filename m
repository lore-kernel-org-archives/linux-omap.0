From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: cpuidle: Fix the C-state reporting to cpuidle governor.
Date: Tue, 14 Feb 2012 10:58:32 -0800
Message-ID: <87obt16y3r.fsf@ti.com>
References: <1328521095-24025-1-git-send-email-santosh.shilimkar@ti.com>
	<87haz2gtfw.fsf@ti.com> <4F3A1FB4.5010304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53319 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752487Ab2BNS6e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 13:58:34 -0500
Received: by pbcxa7 with SMTP id xa7so803269pbc.13
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 10:58:33 -0800 (PST)
In-Reply-To: <4F3A1FB4.5010304@ti.com> (Santosh Shilimkar's message of "Tue,
	14 Feb 2012 14:17:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Wednesday 08 February 2012 04:08 AM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>> 
>>> OMAP4 cpuidle driver is reporting the state requested by governor rather than
>>> the actually attempted one.
>>>
>>> This is obviously misleading sysfs and powertop cpuidle statistics.
>>> Fix it so that stats are reported correctly.
>>>
>>> Reported-by: Kevin Hilman <khilman@ti.com>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/cpuidle44xx.c |    1 +
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
>>> index cfdbb86..f128489 100644
>>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
>>> @@ -85,6 +85,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
>>>  	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
>>>  	if (cpu1_state != PWRDM_POWER_OFF) {
>>>  		new_state_idx = drv->safe_state_index;
>>> +		index = drv->safe_state_index;
>> 
>> How about just get rid of new_state_idx all together and just update
>> index and use it to index in to the states.
>> 
> Make sense. Updated patch below.
>
> Regards,
> Santosh
>
> From 939dc3eda7895043c03526110e2a6b41e9861146 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Sun, 5 Feb 2012 13:18:44 +0530
> Subject: [PATCH 2/2] ARM: OMAP4: cpuidle: Fix the C-state reporting to
> cpuidle governor.
>
> OMAP4 cpuidle driver is reporting the state requested by governor rather
> than
> the actually attempted one.
>
> This is obviously misleading sysfs and powertop cpuidle statistics.
> Fix it so that stats are reported correctly.
>
> While at this, get rid of new_state_idx, update and use
> index in to the states.
>
> Reported-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Perfect.  Thanks. 

Queuing as a fix for v3.3.

Kevin
