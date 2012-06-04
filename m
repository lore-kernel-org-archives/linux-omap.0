From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Mon, 4 Jun 2012 16:44:16 -0500
Message-ID: <4FCD2C30.8000106@ti.com>
References: <4FC54D3B.10301@ti.com> <87pq9l7306.fsf@ti.com> <20120531012923.GB8506@mudshark.cambridge.arm.com> <4FC7B465.60703@ti.com> <87r4u0ytd9.fsf@ti.com> <4FC7E161.1080400@ti.com> <87d35kyo3v.fsf@ti.com> <4FC7F87C.9080709@ti.com> <87obp3vptz.fsf@ti.com> <4FC8D4F0.6040806@ti.com> <20120602164228.GA14903@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38247 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756332Ab2FDVoY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 17:44:24 -0400
In-Reply-To: <20120602164228.GA14903@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Will,

On 06/02/2012 11:42 AM, Will Deacon wrote:
> Hi Jon, Kevin,
> 
> I've been between timezones, so sorry for the slow response.

No problem. I was expecting you guys in the UK to be out of office for the
next couple days :-)
 
> On Fri, Jun 01, 2012 at 03:42:56PM +0100, Jon Hunter wrote:
>> On 05/31/2012 07:27 PM, Kevin Hilman wrote:
>>>> Hmmm ... however, now looking at the history behind the plat->irq_*
>>>> hooks, I see that Ming specifically added these for omap4 [1]. I was
>>>> under the impression other architectures may be using this. I guess not.
>>>> So if it is preferred we could do-away with the plat->irq_* and replace
>>>> with the plat->runtime_*.
>>>
>>> Yes, that would certainly be my preference from a runtime PM readability
>>> PoV.  I guess it's Will's call since it's his code.
>>
>> Ok great.
>>
>> Will, let me know your thoughts. I have a V2 series ready to post, I
>> just need to know your thoughts on handling this runtime PM business. Or
>> if you would just like me to send it out for review anyway, I can do
>> that too.
> 
> From my perspective, we have up to three pairs of functions on the PMU:
> 
> 1. enable/disable irq
> 2. reserve/release pmu
> 3. suspend/resume pmu
> 
> As you pointed out, (1) was added purely for OMAP so I'd definitely like
> to remove that if we can. What I wonder is whether (2) and (3) can also be
> combined into a single pair of functions. The default behaviour could be the
> simple bit lock that we have in pmu.c. If a platform wants to do more, then
> it can supply its own functions for these and do PM there as well as the
> mutual exclusion (which we may well get for free). This also fits with my
> previous plans for making reserve/release PMU-specific and killing the
> arm_pmu_type enumeration.
> 
> So, if we can condense this all down into one pair of functions that also
> work correctly for the non-PM case (including mutual exclusion) then I'd
> love to see that merged.

That is definitely a possibility, but I believe that Kevin wanted this to
use the runtime callbacks so this fits in nicely with the pm runtime model.
The only slight difference I see here with what Kevin was suggesting is we
have ...

1. enable/disable irq
2. reserve/release pmu
3. pm_runtime_get/put pmu (enable/disable pmu)
4. runtime_resume/suspend (callbacks invoked by pm_runtime_get/put)

The callbacks, #4, are the hooks we use to do the custom platform 
specific stuff and the pm_runtime_get/put calls are non-platform 
specific functions to enable/disable the pmu.

So what we can do is replace #1 with #4 and then group #2 and #3
together. In fact we could place the pm_runtime_get/put in the
release/release pmu functions.

So with that being said, we could do something like the following.
Please note that patch is a bit nosier that I wanted as I needed to 
move the definitions of the reserve/release pmu for it to compile
(I need to look at this some more to make sure it does not break
anything).

>From 15940e67c0f012278c0b65aed910fa5b0de20f06 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Thu, 31 May 2012 13:05:20 -0500
Subject: [PATCH] ARM: PMU: Add runtime PM Support

Add runtime PM support to the ARM PMU driver so that devices such as OMAP
supporting dynamic PM can use the platform->runtime_* hooks to initialise
hardware at runtime. Without having these runtime PM hooks in place any
configuration of the PMU hardware would be lost when low power states are
entered and hence would prevent PMU from working.

This change also replaces the PMU platform functions enable_irq and disable_irq
added by Ming Lei with runtime_resume and runtime_suspend funtions. Ming had
added the enable_irq and disable_irq functions as a method to configure the
cross trigger interface on OMAP4 for routing the PMU interrupts. By adding
runtime PM support, we can move the code called by enable_irq and disable_irq
into the runtime PM callbacks runtime_resume and runtime_suspend.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/include/asm/pmu.h   |   88 ++++++++++++++++++++++--------------------
 arch/arm/kernel/perf_event.c |   40 ++++++++++++++-----
 arch/arm/kernel/pmu.c        |   12 ++++--
 3 files changed, 84 insertions(+), 56 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 90114fa..763faf5 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -31,54 +31,24 @@ enum arm_pmu_type {
  *	interrupt and passed the address of the low level handler,
  *	and can be used to implement any platform specific handling
  *	before or after calling it.
- * @enable_irq: an optional handler which will be called after
- *	request_irq and be used to handle some platform specific
- *	irq enablement
- * @disable_irq: an optional handler which will be called before
- *	free_irq and be used to handle some platform specific
- *	irq disablement
+ * @runtime_resume: an optional handler which will be called by the
+ *	runtime PM framework following a call to pm_runtime_get().
+ *	Note that if pm_runtime_get() is called more than once in
+ *	succession this handler will only be called once.
+ * @runtime_suspend: an optional handler which will be called by the
+ *	runtime PM framework following a call to pm_runtime_put().
+ *	Note that if pm_runtime_get() is called more than once in
+ *	succession this handler will only be called following the
+ *	final call to pm_runtime_put() that actually disables the
+ *	hardware.
  */
 struct arm_pmu_platdata {
 	irqreturn_t (*handle_irq)(int irq, void *dev,
 				  irq_handler_t pmu_handler);
-	void (*enable_irq)(int irq);
-	void (*disable_irq)(int irq);
+	int (*runtime_resume)(struct device *dev);
+	int (*runtime_suspend)(struct device *dev);
 };
 
-#ifdef CONFIG_CPU_HAS_PMU
-
-/**
- * reserve_pmu() - reserve the hardware performance counters
- *
- * Reserve the hardware performance counters in the system for exclusive use.
- * Returns 0 on success or -EBUSY if the lock is already held.
- */
-extern int
-reserve_pmu(enum arm_pmu_type type);
-
-/**
- * release_pmu() - Relinquish control of the performance counters
- *
- * Release the performance counters and allow someone else to use them.
- */
-extern void
-release_pmu(enum arm_pmu_type type);
-
-#else /* CONFIG_CPU_HAS_PMU */
-
-#include <linux/err.h>
-
-static inline int
-reserve_pmu(enum arm_pmu_type type)
-{
-	return -ENODEV;
-}
-
-static inline void
-release_pmu(enum arm_pmu_type type)	{ }
-
-#endif /* CONFIG_CPU_HAS_PMU */
-
 #ifdef CONFIG_HW_PERF_EVENTS
 
 /* The events for a given PMU register set. */
@@ -140,6 +110,40 @@ int armpmu_event_set_period(struct perf_event *event,
 			    struct hw_perf_event *hwc,
 			    int idx);
 
+#ifdef CONFIG_CPU_HAS_PMU
+
+/**
+ * reserve_pmu() - reserve the hardware performance counters
+ *
+ * Reserve the hardware performance counters in the system for exclusive use.
+ * Returns 0 on success or -EBUSY if the lock is already held.
+ */
+extern int
+reserve_pmu(struct arm_pmu *armpmu);
+
+/**
+ * release_pmu() - Relinquish control of the performance counters
+ *
+ * Release the performance counters and allow someone else to use them.
+ */
+extern void
+release_pmu(struct arm_pmu *armpmu);
+
+#else /* CONFIG_CPU_HAS_PMU */
+
+#include <linux/err.h>
+
+static inline int
+reserve_pmu(struct arm_pmu *armpmu)
+{
+	return -ENODEV;
+}
+
+static inline void
+release_pmu(struct arm_pmu *armpmu)	{ }
+
+#endif /* CONFIG_CPU_HAS_PMU */
+
 #endif /* CONFIG_HW_PERF_EVENTS */
 
 #endif /* __ARM_PMU_H__ */
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 186c8cb..34076fb 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/cputype.h>
 #include <asm/irq.h>
@@ -367,8 +368,6 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
 {
 	int i, irq, irqs;
 	struct platform_device *pmu_device = armpmu->plat_device;
-	struct arm_pmu_platdata *plat =
-		dev_get_platdata(&pmu_device->dev);
 
 	irqs = min(pmu_device->num_resources, num_possible_cpus());
 
@@ -376,14 +375,11 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
 		if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
 			continue;
 		irq = platform_get_irq(pmu_device, i);
-		if (irq >= 0) {
-			if (plat && plat->disable_irq)
-				plat->disable_irq(irq);
+		if (irq >= 0)
 			free_irq(irq, armpmu);
-		}
 	}
 
-	release_pmu(armpmu->type);
+	release_pmu(armpmu);
 }
 
 static int
@@ -397,7 +393,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 	if (!pmu_device)
 		return -ENODEV;
 
-	err = reserve_pmu(armpmu->type);
+	err = reserve_pmu(armpmu);
 	if (err) {
 		pr_warning("unable to reserve pmu\n");
 		return err;
@@ -440,8 +436,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 				irq);
 			armpmu_release_hardware(armpmu);
 			return err;
-		} else if (plat && plat->enable_irq)
-			plat->enable_irq(irq);
+		}
 
 		cpumask_set_cpu(i, &armpmu->active_irqs);
 	}
@@ -584,6 +579,26 @@ static void armpmu_disable(struct pmu *pmu)
 	armpmu->stop();
 }
 
+static int armpmu_runtime_resume(struct device *dev)
+{
+	struct arm_pmu_platdata *plat = dev_get_platdata(dev);
+
+	if (plat->runtime_resume)
+		return plat->runtime_resume(dev);
+
+	return 0;
+}
+
+static int armpmu_runtime_suspend(struct device *dev)
+{
+	struct arm_pmu_platdata *plat = dev_get_platdata(dev);
+
+	if (plat->runtime_suspend)
+		return plat->runtime_suspend(dev);
+
+	return 0;
+}
+
 static void __init armpmu_init(struct arm_pmu *armpmu)
 {
 	atomic_set(&armpmu->active_events, 0);
@@ -650,9 +665,14 @@ static int __devinit armpmu_device_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct dev_pm_ops armpmu_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(armpmu_runtime_suspend, armpmu_runtime_resume, NULL)
+};
+
 static struct platform_driver armpmu_driver = {
 	.driver		= {
 		.name	= "arm-pmu",
+		.pm	= &armpmu_dev_pm_ops,
 		.of_match_table = armpmu_of_device_ids,
 	},
 	.probe		= armpmu_device_probe,
diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index 2334bf8..8ffbb09 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -13,6 +13,8 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
 
 #include <asm/pmu.h>
 
@@ -22,15 +24,17 @@
 static unsigned long pmu_lock[BITS_TO_LONGS(ARM_NUM_PMU_DEVICES)];
 
 int
-reserve_pmu(enum arm_pmu_type type)
+reserve_pmu(struct arm_pmu *armpmu)
 {
-	return test_and_set_bit_lock(type, pmu_lock) ? -EBUSY : 0;
+	pm_runtime_get_sync(&armpmu->plat_device->dev);
+	return test_and_set_bit_lock(armpmu->type, pmu_lock) ? -EBUSY : 0;
 }
 EXPORT_SYMBOL_GPL(reserve_pmu);
 
 void
-release_pmu(enum arm_pmu_type type)
+release_pmu(struct arm_pmu *armpmu)
 {
-	clear_bit_unlock(type, pmu_lock);
+	clear_bit_unlock(armpmu->type, pmu_lock);
+	pm_runtime_put_sync(&armpmu->plat_device->dev);
 }
 EXPORT_SYMBOL_GPL(release_pmu);
-- 
1.7.9.5
