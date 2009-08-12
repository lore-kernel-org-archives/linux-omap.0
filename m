From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: Warnings: pm branch
Date: Wed, 12 Aug 2009 18:24:58 +0530 (IST)
Message-ID: <7803.10.24.255.18.1250081698.squirrel@dbdmail.itg.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F5989815@dbde02.ent.ti.com>
    <873a7y74mj.fsf@deeprootsystems.com>
    <03d301ca1b32$14f97d10$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39293 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbZHLMzI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Aug 2009 08:55:08 -0400
In-Reply-To: <03d301ca1b32$14f97d10$LocalHost@wipultra793>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

> ----- Original Message -----
> From: "Kevin Hilman" <khilman@deeprootsystems.com>
> To: "Pandita, Vikram" <vikram.pandita@ti.com>
> Cc: <linux-omap@vger.kernel.org>
> Sent: Tuesday, August 11, 2009 8:57 PM
> Subject: Re: Warnings: pm branch
>
>
>> "Pandita, Vikram" <vikram.pandita@ti.com> writes:
>>
>>> Has anyone send these warning logs on the pm branch on kevin's tree [1]
>>> This seems to be some issue in CpuIdle path with interrupts?
>>>
>>> <4>WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x60/0x88()
>>> WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x60/0x88()
>>> <d>Modules linked in:Modules linked in:
>>> [<c0031344>] [<c0031344>] (unwind_backtrace+0x0/0xdc)
>>> (unwind_backtrace+0x0/0xdc
>>> ) from [<c0057a08>] from [<c0057a08>] (warn_slowpath_common+0x48/0x60)
>>> (warn_slowpath_common+0x48/0x60)
>>> [<c0057a08>] [<c0057a08>] (warn_slowpath_common+0x48/0x60)
>>> (warn_slowpath_common
>>> +0x48/0x60) from [<c002d204>] from [<c002d204>] (cpu_idle+0x60/0x88)
>>> (cpu_idle+0x60/0x88)
>>> [<c002d204>] [<c002d204>] (cpu_idle+0x60/0x88) (cpu_idle+0x60/0x88) from
>>> [<c0008
>>> a70>] from [<c0008a70>] (start_kernel+0x234/0x28c)
>>> (start_kernel+0x234/0x28c)
>>> [<c0008a70>] [<c0008a70>] (start_kernel+0x234/0x28c)
>>> (start_kernel+0x234/0x28c)
>>> from [<80008034>] from [<80008034>] (0x80008034)
>>> (0x80008034)
>>>
>>
>> Yes, I've seen it, but have yet to debug it.
>>
>> This warning is from the generic ARM idle loop reporting that the OMAP
>> idle path is returning with IRQs disabled.
>>
>> Kevin
>
> I did some more debugging on this. I added the below instrumentation to
> local_irq_disable to capture
> the PC of the last call to local_irq_disable.
>
> extern unsigned long hem_pc;
> register unsigned long current_pc asm ("pc");
>
> #define local_irq_disable() \
>         do { hem_pc = current_pc;raw_local_irq_disable();
> trace_hardirqs_off(); } while (0)
>
>
> When I set a breakpoint  at the instruction pointing to
> WARN_ON(irqs_disabled()) using
> lauterbach and dump hem_pc, I see that the last call to irq_disable is
> actuall from cpu_idle itself.
> Looks like some recursion is happening. Does anyone have any inputs on this.
>
> void cpu_idle(void)
> {
>
>         local_fiq_enable();
>
>         /* endless idle loop with no priority at all */
>         while (1) {
>                 tick_nohz_stop_sched_tick(1);
>                 leds_event(led_idle_start);
>                 while (!need_resched()) {
> #ifdef CONFIG_HOTPLUG_CPU
>                         if (cpu_is_offline(smp_processor_id()))
>                                 cpu_die();
> #endif
>
>>>                        local_irq_disable();
>
>
> Thanks
> Hemanth
>

Below patch seems to fix the issue.

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 8504a21..3014104 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -75,8 +75,10 @@ static void cpuidle_idle_call(void)
 #endif
 	/* ask the governor for the next state */
 	next_state = cpuidle_curr_governor->select(dev);
+
 	if (need_resched())
-		return;
+		goto out;
+
 	target_state = &dev->states[next_state];

 	/* enter the state and update stats */
@@ -91,6 +93,12 @@ static void cpuidle_idle_call(void)
 	/* give the governor an opportunity to reflect on the outcome */
 	if (cpuidle_curr_governor->reflect)
 		cpuidle_curr_governor->reflect(dev);
+
+	return;
+
+out:
+	local_irq_enable();
+	return;
 }

 /**


