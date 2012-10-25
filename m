From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2] ARM: PMU: fix runtime PM enable
Date: Thu, 25 Oct 2012 15:23:18 -0500
Message-ID: <1351196598-26667-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46347 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992639Ab2JYUXb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 16:23:31 -0400
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

Therefore,  call pm_runtime_enable() directly from the ARM PMU driver when
registering the device. For platforms that do not use runtime PM,
pm_runtime_enable() does nothing and for platforms that do use runtime PM but
may not require it specifically for PMU, this will just add a little overhead
when initialising and uninitialising the PMU device.

Tested with PERF on OMAP2420, OMAP3430 and OMAP4460.

V2 changes:
- Call pm_runtime_enable() unconditionally on registering the PMU device.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/kernel/perf_event.c |    1 +
 arch/arm/mach-omap2/pmu.c    |    2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 1f7166f..5ea182e 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -510,6 +510,7 @@ static void __init armpmu_init(struct arm_pmu *armpmu)
 int armpmu_register(struct arm_pmu *armpmu, int type)
 {
 	armpmu_init(armpmu);
+	pm_runtime_enable(&armpmu->plat_device->dev);
 	pr_info("enabled with %s PMU driver, %d counters available\n",
 			armpmu->name, armpmu->num_events);
 	return perf_pmu_register(&armpmu->pmu, armpmu->name, type);
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 2a79176..031e2fb 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -57,8 +57,6 @@ static int __init omap2_init_pmu(unsigned oh_num, char *oh_names[])
 	if (IS_ERR(omap_pmu_dev))
 		return PTR_ERR(omap_pmu_dev);
 
-	pm_runtime_enable(&omap_pmu_dev->dev);
-
 	return 0;
 }
 
-- 
1.7.9.5

