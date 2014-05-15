From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Thu, 15 May 2014 14:29:50 -0400
Message-ID: <5375079E.3060305@ti.com>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com> <5373C78E.7040301@linaro.org> <5373C8E8.6040208@ti.com> <5373CBB9.40506@linaro.org> <5373DD94.8030208@ti.com> <5374F35E.5040900@ti.com> <5374FE61.50901@linaro.org> <5374FF5B.8050702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40432 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbaEOSaQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 14:30:16 -0400
In-Reply-To: <5374FF5B.8050702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Alex Shi <alex.shi@linaro.org>
Cc: khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On Thursday 15 May 2014 01:54 PM, Santosh Shilimkar wrote:
> On Thursday 15 May 2014 01:50 PM, Daniel Lezcano wrote:
>> On 05/15/2014 07:03 PM, Santosh Shilimkar wrote:

[..]

>>>> With above mentioned change, it should work. Other alternatives is OMAP4 driver does
>>>> its won registration where it can start the timer. The way it was before the
>>>> consolidation.
>>>>
>>>> Ofcourse if you have better fix, then great.
>>>>
>>> What is your suggestion. We *must* fix the regression asap. I think
>>> $subject patch with an update to bctimer start under CPUIDLE_FLAG_COUPLED
>>> seems a good way forward.
>>>
>>> Do let me know.
>>
>> Did you see Alex Shi's email [cc'ed] ? Reverting this change makes the panda ES to hang.
>>
> The hang is definitely due to the bctimer not started. As I said, I assumed it was and
> then you corrected saying it is under the flag.
> 
>> I am not convinced the culprit is this code you are trying to revert.
>>
> fair enough. Thats why I said if you have an alternative fix thats great.
> 
For record, below is updated patch with bctimer started which
was missed in earlier version. I haven't tested it though.

Alex,
Please give a try with your test-case and see if you still see the hang.
Am just curious about your issue and hence the request..

Regards,
Santosh


>From bb3b82cc5645b83bedf1343d03cc956f27f6fc83 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 12 May 2014 17:37:59 -0400
Subject: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled

On OMAP4 panda board, there have been several bug reports about boot
hang and lock-ups with CPU_IDLE enabled. The root cause of the issue
is missing interrupts while in idle state. Commit cb7094e8 {cpuidle / omap4 :
use CPUIDLE_FLAG_TIMER_STOP flag} moved the broadcast notifiers to common
code for right reasons but on OMAP4 which suffers from a nasty ROM code
bug with GIC, commit ff999b8a {ARM: OMAP4460: Workaround for ROM bug ..},
we loose interrupts which leads to issues like lock-up, hangs etc.

Patch reverts commit cb7094 {cpuidle / omap4 : use CPUIDLE_FLAG_TIMER_STOP
flag} and 54769d6 {cpuidle: OMAP4: remove timer broadcast initialization} to
avoid the issue. With this change, OMAP4 panda boards, the mentioned
issues are getting fixed. We no longer loose interrupts which was the cause
of the regression.

Cc: Roger Quadros <rogerq@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Reported-tested-by: Roger Quadros <rogerq@ti.com>
Reported-tested-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 01fc710..2498ab0 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -14,6 +14,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/export.h>
+#include <linux/clockchips.h>
 
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
@@ -83,6 +84,7 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 {
 	struct idle_statedata *cx = state_ptr + index;
 	u32 mpuss_can_lose_context = 0;
+	int cpu_id = smp_processor_id();
 
 	/*
 	 * CPU0 has to wait and stay ON until CPU1 is OFF state.
@@ -110,6 +112,8 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 	mpuss_can_lose_context = (cx->mpu_state == PWRDM_POWER_RET) &&
 				 (cx->mpu_logic_state == PWRDM_POWER_OFF);
 
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
+
 	/*
 	 * Call idle CPU PM enter notifier chain so that
 	 * VFP and per CPU interrupt context is saved.
@@ -165,6 +169,8 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 	if (dev->cpu == 0 && mpuss_can_lose_context)
 		cpu_cluster_pm_exit();
 
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
+
 fail:
 	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
 	cpu_done[dev->cpu] = false;
@@ -172,6 +178,16 @@ fail:
 	return index;
 }
 
+/*
+ * For each cpu, setup the broadcast timer because local timers
+ * stops for the states above C1.
+ */
+static void omap_setup_broadcast_timer(void *arg)
+{
+	int cpu = smp_processor_id();
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
+}
+
 static struct cpuidle_driver omap4_idle_driver = {
 	.name				= "omap4_idle",
 	.owner				= THIS_MODULE,
@@ -189,8 +205,7 @@ static struct cpuidle_driver omap4_idle_driver = {
 			/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
 			.exit_latency = 328 + 440,
 			.target_residency = 960,
-			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
-			         CPUIDLE_FLAG_TIMER_STOP,
+			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
 			.enter = omap_enter_idle_coupled,
 			.name = "C2",
 			.desc = "CPUx OFF, MPUSS CSWR",
@@ -199,8 +214,7 @@ static struct cpuidle_driver omap4_idle_driver = {
 			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
 			.exit_latency = 460 + 518,
 			.target_residency = 1100,
-			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
-			         CPUIDLE_FLAG_TIMER_STOP,
+			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
 			.enter = omap_enter_idle_coupled,
 			.name = "C3",
 			.desc = "CPUx OFF, MPUSS OSWR",
@@ -231,5 +245,8 @@ int __init omap4_idle_init(void)
 	if (!cpu_clkdm[0] || !cpu_clkdm[1])
 		return -ENODEV;
 
+	/* Configure the broadcast timer on each cpu */
+	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
+
 	return cpuidle_register(&omap4_idle_driver, cpu_online_mask);
 }
-- 
1.7.9.5


