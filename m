From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: PMU: fix runtime PM enable
Date: Tue, 23 Oct 2012 15:31:08 -0500
Message-ID: <1351024268-26734-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43539 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757519Ab2JWUb0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 16:31:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Commit 7be2958 (ARM: PMU: Add runtime PM Support) updated the ARM PMU code to
use runtime PM which was prototyped and validated on the OMAP devices. In this
commit, there is no call pm_runtime_enable() and for OMAP devices
pm_runtime_enable() is currently being called from the OMAP PMU code when the
PMU device is created. However, there are two problems with this:

1. For any other ARM device wishing to use runtime PM for PMU they will need
   to call pm_runtime_enable() for runtime PM to work.
2. When booting with device-tree and using device-tree to create the PMU
   device, pm_runtime_enable() needs to be called from within the ARM PERF
   driver as we are no longer calling any device specific code to create the
   device. Hence, PMU does not work on OMAP devices that use the runtime PM
   callbacks when using device-tree to create the PMU device.

Therefore, add a new platform data variable to indicate whether runtime PM is
used and if so call pm_runtime_enable() when the PMU device is registered. Note
that devices using runtime PM may not use the runtime_resume/suspend callbacks
and so we cannot use the presence of these handlers in the platform data to
determine whether we should call pm_runtime_enable().

Tested with PERF on OMAP2420, OMAP3430 and OMAP4460.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/include/asm/pmu.h   |    1 +
 arch/arm/kernel/perf_event.c |    6 ++++++
 arch/arm/mach-omap2/pmu.c    |    9 +++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index a26170d..50a6c3b 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -36,6 +36,7 @@
 struct arm_pmu_platdata {
 	irqreturn_t (*handle_irq)(int irq, void *dev,
 				  irq_handler_t pmu_handler);
+	bool use_runtime_pm;
 	int (*runtime_resume)(struct device *dev);
 	int (*runtime_suspend)(struct device *dev);
 };
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 93971b1..a8c5ddf 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -515,7 +515,13 @@ static void __init armpmu_init(struct arm_pmu *armpmu)
 
 int armpmu_register(struct arm_pmu *armpmu, char *name, int type)
 {
+	struct platform_device *plat_device = armpmu->plat_device;
+	struct arm_pmu_platdata *plat = dev_get_platdata(&plat_device->dev);
+
 	armpmu_init(armpmu);
+	if (plat && plat->use_runtime_pm)
+		pm_runtime_enable(&armpmu->plat_device->dev);
+
 	pr_info("enabled with %s PMU driver, %d counters available\n",
 			armpmu->name, armpmu->num_events);
 	return perf_pmu_register(&armpmu->pmu, name, type);
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 2a79176..1a3d4d7 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -22,6 +22,7 @@ static char *omap2_pmu_oh_names[] = {"mpu"};
 static char *omap3_pmu_oh_names[] = {"mpu", "debugss"};
 static char *omap4430_pmu_oh_names[] = {"l3_main_3", "l3_instr", "debugss"};
 static struct platform_device *omap_pmu_dev;
+static struct arm_pmu_platdata omap_pmu_data;
 
 /**
  * omap2_init_pmu - creates and registers PMU platform device
@@ -49,16 +50,14 @@ static int __init omap2_init_pmu(unsigned oh_num, char *oh_names[])
 		}
 	}
 
-	omap_pmu_dev = omap_device_build_ss(dev_name, -1, oh, oh_num, NULL, 0,
-					    NULL, 0, 0);
+	omap_pmu_dev = omap_device_build_ss(dev_name, -1, oh, oh_num,
+			&omap_pmu_data, sizeof(omap_pmu_data), NULL, 0, 0);
 	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
 	     dev_name);
 
 	if (IS_ERR(omap_pmu_dev))
 		return PTR_ERR(omap_pmu_dev);
 
-	pm_runtime_enable(&omap_pmu_dev->dev);
-
 	return 0;
 }
 
@@ -85,9 +84,11 @@ static int __init omap_init_pmu(void)
 	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		oh_num = ARRAY_SIZE(omap3_pmu_oh_names);
 		oh_names = omap3_pmu_oh_names;
+		omap_pmu_data.use_runtime_pm = true;
 	} else {
 		oh_num = ARRAY_SIZE(omap2_pmu_oh_names);
 		oh_names = omap2_pmu_oh_names;
+		omap_pmu_data.use_runtime_pm = false;
 	}
 
 	return omap2_init_pmu(oh_num, oh_names);
-- 
1.7.9.5

