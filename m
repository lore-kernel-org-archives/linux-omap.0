From: Jon Hunter <jon-hunter@TI.COM>
Subject: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Thu, 7 Jun 2012 16:22:03 -0500
Message-ID: <1339104132-26885-2-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58347 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932140Ab2FGVW5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 17:22:57 -0400
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@TI.COM>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@TI.COM>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@TI.COM>

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

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/include/asm/pmu.h   |   20 ++++++++++++--------
 arch/arm/kernel/perf_event.c |   41 +++++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 90114fa..77b023b 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -31,18 +31,22 @@ enum arm_pmu_type {
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
 
 #ifdef CONFIG_CPU_HAS_PMU
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 186c8cb..00adb98 100644
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
 
@@ -376,14 +375,12 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
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
 
 	release_pmu(armpmu->type);
+	pm_runtime_put_sync(&armpmu->plat_device->dev);
 }
 
 static int
@@ -403,6 +400,8 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 		return err;
 	}
 
+	pm_runtime_get_sync(&armpmu->plat_device->dev);
+
 	plat = dev_get_platdata(&pmu_device->dev);
 	if (plat && plat->handle_irq)
 		handle_irq = armpmu_platform_irq;
@@ -440,8 +439,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 				irq);
 			armpmu_release_hardware(armpmu);
 			return err;
-		} else if (plat && plat->enable_irq)
-			plat->enable_irq(irq);
+		}
 
 		cpumask_set_cpu(i, &armpmu->active_irqs);
 	}
@@ -584,6 +582,28 @@ static void armpmu_disable(struct pmu *pmu)
 	armpmu->stop();
 }
 
+#ifdef CONFIG_PM_RUNTIME
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
+#endif
+
 static void __init armpmu_init(struct arm_pmu *armpmu)
 {
 	atomic_set(&armpmu->active_events, 0);
@@ -650,9 +670,14 @@ static int __devinit armpmu_device_probe(struct platform_device *pdev)
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
-- 
1.7.9.5

