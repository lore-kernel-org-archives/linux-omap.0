From: ming.lei@canonical.com
Subject: [PATCH v5 2/7] arm: pmu: allow platform specific irq enable/disable handling
Date: Mon, 24 Oct 2011 22:45:54 +0800
Message-ID: <1319467559-5518-3-git-send-email-ming.lei@canonical.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:33422 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932752Ab1JXOrN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Oct 2011 10:47:13 -0400
Received: by mail-pz0-f42.google.com with SMTP id 36so17104708pzk.1
        for <linux-omap@vger.kernel.org>; Mon, 24 Oct 2011 07:47:13 -0700 (PDT)
In-Reply-To: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, Ming Lei <ming.lei@canonical.com>

From: Ming Lei <ming.lei@canonical.com>

This patch introduces .enable_irq and .disable_irq into
struct arm_pmu_platdata, so platform specific irq enablement
can be handled after request_irq, and platform specific irq
disablement can be handled before free_irq.

This patch is for support of  pmu irq routed from CTI on omap4.

Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/include/asm/pmu.h   |   15 ++++++++++++---
 arch/arm/kernel/perf_event.c |   15 ++++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index b7e82c4..3af5e39 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -22,13 +22,22 @@ enum arm_pmu_type {
 /*
  * struct arm_pmu_platdata - ARM PMU platform data
  *
- * @handle_irq: an optional handler which will be called from the interrupt and
- * passed the address of the low level handler, and can be used to implement
- * any platform specific handling before or after calling it.
+ * @handle_irq: an optional handler which will be called from the
+ *	interrupt and passed the address of the low level handler,
+ *	and can be used to implement any platform specific handling
+ *	before or after calling it.
+ * @enable_irq: an optional handler which will be called after
+ *	request_irq and be used to handle some platform specific
+ *	irq enablement
+ * @disable_irq: an optional handler which will be called before
+ *	free_irq and be used to handle some platform specific
+ *	irq disablement
  */
 struct arm_pmu_platdata {
 	irqreturn_t (*handle_irq)(int irq, void *dev,
 				  irq_handler_t pmu_handler);
+	void (*enable_irq)(int irq);
+	void (*disable_irq)(int irq);
 };
 
 #ifdef CONFIG_CPU_HAS_PMU
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 53c9c26..f367780 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -426,14 +426,18 @@ armpmu_reserve_hardware(void)
 			pr_warning("unable to request IRQ%d for ARM perf "
 				"counters\n", irq);
 			break;
-		}
+		} else if (plat && plat->enable_irq)
+			plat->enable_irq(irq);
 	}
 
 	if (err) {
 		for (i = i - 1; i >= 0; --i) {
 			irq = platform_get_irq(pmu_device, i);
-			if (irq >= 0)
+			if (irq >= 0) {
+				if (plat && plat->disable_irq)
+					plat->disable_irq(irq);
 				free_irq(irq, NULL);
+			}
 		}
 		release_pmu(ARM_PMU_DEVICE_CPU);
 		pmu_device = NULL;
@@ -446,11 +450,16 @@ static void
 armpmu_release_hardware(void)
 {
 	int i, irq;
+	struct arm_pmu_platdata *plat =
+		dev_get_platdata(&pmu_device->dev);
 
 	for (i = pmu_device->num_resources - 1; i >= 0; --i) {
 		irq = platform_get_irq(pmu_device, i);
-		if (irq >= 0)
+		if (irq >= 0) {
+			if (plat && plat->disable_irq)
+				plat->disable_irq(irq);
 			free_irq(irq, NULL);
+		}
 	}
 	armpmu->stop();
 
-- 
1.7.5.4

