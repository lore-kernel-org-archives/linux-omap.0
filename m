From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Wed, 14 May 2014 15:50:00 -0400
Message-ID: <5373C8E8.6040208@ti.com>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com> <5373C78E.7040301@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40833 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaENTua (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 15:50:30 -0400
In-Reply-To: <5373C78E.7040301@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, khilman@linaro.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On Wednesday 14 May 2014 03:44 PM, Daniel Lezcano wrote:
> On 05/13/2014 04:39 PM, Santosh Shilimkar wrote:
>> On OMAP4 panda board, there have been several bug reports about boot
>> hang and lock-ups with CPU_IDLE enabled. The root cause of the issue
>> is missing interrupts while in idle state. Commit cb7094e8 {cpuidle / omap4 :
>> use CPUIDLE_FLAG_TIMER_STOP flag} moved the broadcast notifiers to common
>> code for right reasons but on OMAP4 which suffers from a nasty ROM code
>> bug with GIC, commit ff999b8a {ARM: OMAP4460: Workaround for ROM bug ..},
>> we loose interrupts which leads to issues like lock-up, hangs etc.
>>
>> Patch reverts commit cb7094 {cpuidle / omap4 : use CPUIDLE_FLAG_TIMER_STOP
>> flag} to avoid the issue. With this change, OMAP4 panda boards, the mentioned
>> issues are getting fixed. We no longer loose interrupts which was the cause
>> of the regression.
>>
>> Cc: Roger Quadros <rogerq@ti.com>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reported-tested-by: Roger Quadros <rogerq@ti.com>
>> Reported-tested-by: Kevin Hilman <khilman@linaro.org>
>> Tested-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>   arch/arm/mach-omap2/cpuidle44xx.c |   12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
>> index 01fc710..3e169d9 100644
>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/cpuidle.h>
>>   #include <linux/cpu_pm.h>
>>   #include <linux/export.h>
>> +#include <linux/clockchips.h>
>>
>>   #include <asm/cpuidle.h>
>>   #include <asm/proc-fns.h>
>> @@ -83,6 +84,7 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>>   {
>>       struct idle_statedata *cx = state_ptr + index;
>>       u32 mpuss_can_lose_context = 0;
>> +    int cpu_id = smp_processor_id();
>>
>>       /*
>>        * CPU0 has to wait and stay ON until CPU1 is OFF state.
>> @@ -110,6 +112,8 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>>       mpuss_can_lose_context = (cx->mpu_state == PWRDM_POWER_RET) &&
>>                    (cx->mpu_logic_state == PWRDM_POWER_OFF);
>>
>> +    clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
>> +
>>       /*
>>        * Call idle CPU PM enter notifier chain so that
>>        * VFP and per CPU interrupt context is saved.
>> @@ -165,6 +169,8 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>>       if (dev->cpu == 0 && mpuss_can_lose_context)
>>           cpu_cluster_pm_exit();
>>
>> +    clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
>> +
>>   fail:
>>       cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
>>       cpu_done[dev->cpu] = false;
>> @@ -189,8 +195,7 @@ static struct cpuidle_driver omap4_idle_driver = {
>>               /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
>>               .exit_latency = 328 + 440,
>>               .target_residency = 960,
>> -            .flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
>> -                     CPUIDLE_FLAG_TIMER_STOP,
>> +            .flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
>>               .enter = omap_enter_idle_coupled,
>>               .name = "C2",
>>               .desc = "CPUx OFF, MPUSS CSWR",
>> @@ -199,8 +204,7 @@ static struct cpuidle_driver omap4_idle_driver = {
>>               /* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
>>               .exit_latency = 460 + 518,
>>               .target_residency = 1100,
>> -            .flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
>> -                     CPUIDLE_FLAG_TIMER_STOP,
>> +            .flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
>>               .enter = omap_enter_idle_coupled,
>>               .name = "C3",
>>               .desc = "CPUx OFF, MPUSS OSWR",
> 
> Shouldn't the broadcast timer to be setup with CLOCK_EVT_NOTIFY_BROADCAST_ON also ?
> 
Which is already taken care by __cpuidle_register_driver(). Note that setup code
is still used from generic code...

