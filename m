From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: RCU stall on panda
Date: Thu, 15 May 2014 14:36:13 -0400
Message-ID: <5375091D.3010607@ti.com>
References: <53675C5F.10509@linaro.org> <20140505180617.GM8754@linux.vnet.ibm.com> <20140512212102.GF5668@atomide.com> <5371BD69.8010600@linaro.org> <20140513153220.GC16837@atomide.com> <53747E6D.60500@linaro.org> <53748371.5030704@linaro.org> <5374C07C.1070400@linaro.org> <20140515183247.GF23659@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------070000080109050101040702"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34395 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139AbaEOSgq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 May 2014 14:36:46 -0400
In-Reply-To: <20140515183247.GF23659@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alex Shi <alex.shi@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "naresh.kamboju@linaro.org Kamboju" <naresh.kamboju@linaro.org>, Linaro Kernel <linaro-kernel@lists.linaro.org>, LAK <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@linaro.org>, linux-omap@vger.kernel.org

--------------070000080109050101040702
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 15 May 2014 02:32 PM, Tony Lindgren wrote:
> * Alex Shi <alex.shi@linaro.org> [140515 06:27]:
>> On 05/15/2014 05:05 PM, Daniel Lezcano wrote:
>>>>>
>>>>
>>>> After enable this patch, system maybe hang in idle. :(
>>>
>>> Hi Alex,
>>>
>>> do you mean even with this revert applied, the board hangs in idle ?
>>>
>>
>> yes.
>> My board is panda ES. without this revert, it works.
> 
> Care to specify what linux version you are testing against?
> 
> Does it hang in idle always immediately on booting?
> 
> Or does the serial console first hang with sysrq still
> working (ctrl-a h in minicom for help) with device
> eventually locking up hard?
>
I just posted an updated patch Alex on other thread.
Attaching here again for your reference. Please try
it out and see if the you still get a hang.

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


--------------070000080109050101040702
Content-Type: text/x-diff;
	name="0001-ARM-OMAP4-Fix-the-boot-regression-with-CPU_IDLE-enab.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-ARM-OMAP4-Fix-the-boot-regression-with-CPU_IDLE-enab.pa";
	filename*1="tch"

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


--------------070000080109050101040702--
