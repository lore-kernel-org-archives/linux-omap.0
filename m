From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 10/10] ARM: OMAP2+: PMU: Add QoS constraint
Date: Thu, 7 Jun 2012 16:22:12 -0500
Message-ID: <1339104132-26885-11-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49485 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932933Ab2FGVXG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 17:23:06 -0400
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

When CPU-idle is enabled, the MPU sub-system will transition to low power
states during idle periods. If the PMU is active and the MPU sub-system
transitions to a low power state, such as retention, then the PMU context
will be lost and PMU events will stop. To prevent this from happening add a
QoS constraint whenever PMU is active to prevent the MPU sub-system from
transitioning to a low power state.

By default the PMU QoS constraint is set to -1 so it will not prevent any low
power states and when the PMU is enabled, it is set to 0, so that only C-state
C0 is allowed.

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/pmu.c |   52 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index f1b535a..e457f0e 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -13,6 +13,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 
 #include <asm/pmu.h>
@@ -21,11 +22,40 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
+static struct pm_qos_request pmu_pm_qos_request;
 static struct arm_pmu_platdata omap_pmu_data;
 static struct platform_device *omap_pmu_dev;
 static struct cti omap4_cti[2];
 
 /*
+ * omap_pmu_runtime_resume - PMU runtime resume callback
+ *
+ * Platform specific PMU runtime resume callback for OMAP devices to
+ * configure the cross trigger interface for routing PMU interrupts.
+ * This is called by the PM runtime framework.
+ */
+static int omap_pmu_runtime_resume(struct device *dev)
+{
+	pm_qos_update_request(&pmu_pm_qos_request, 0);
+
+	return 0;
+}
+
+/*
+ * omap_pmu_runtime_suspend - PMU runtime suspend callback
+ *
+ * Platform specific PMU runtime suspend callback for OMAP devices to
+ * disable the cross trigger interface interrupts. This is called by
+ * the PM runtime framework.
+ */
+static int omap_pmu_runtime_suspend(struct device *dev)
+{
+	pm_qos_update_request(&pmu_pm_qos_request, PM_QOS_DEFAULT_VALUE);
+
+	return 0;
+}
+
+/*
  * omap2_init_pmu - creates and registers PMU platform device
  *
  * Uses OMAP HWMOD framework to create and register an ARM PMU device.
@@ -45,7 +75,11 @@ static int __init omap2_init_pmu(void)
 		return -ENODEV;
 	}
 
-	omap_pmu_dev = omap_device_build(dev_name, id, oh, NULL, 0, NULL, 0, 0);
+	omap_pmu_data.runtime_resume = omap_pmu_runtime_resume;
+	omap_pmu_data.runtime_suspend = omap_pmu_runtime_suspend;
+
+	omap_pmu_dev = omap_device_build(dev_name, id, oh, &omap_pmu_data,
+				sizeof(omap_pmu_data), NULL, 0, 0);
 
 	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
 				dev_name);
@@ -65,6 +99,8 @@ static int __init omap2_init_pmu(void)
  */
 static int omap4_pmu_runtime_resume(struct device *dev)
 {
+	pm_qos_update_request(&pmu_pm_qos_request, 0);
+
 	/* configure CTI0 for PMU IRQ routing */
 	cti_unlock(&omap4_cti[0]);
 	cti_map_trigger(&omap4_cti[0], 1, 6, 2);
@@ -90,6 +126,8 @@ static int omap4_pmu_runtime_suspend(struct device *dev)
 	cti_disable(&omap4_cti[0]);
 	cti_disable(&omap4_cti[1]);
 
+	pm_qos_update_request(&pmu_pm_qos_request, PM_QOS_DEFAULT_VALUE);
+
 	return 0;
 }
 
@@ -189,6 +227,8 @@ static int __init omap4430_init_pmu(void)
 
 static int __init omap_init_pmu(void)
 {
+	int r;
+
 	/*
 	 * OMAP4460/70 devices may use the omap2_init_pmu() function because
 	 * these devices have dedicated PMU IRQs and only need the MPU
@@ -197,9 +237,15 @@ static int __init omap_init_pmu(void)
 	 * sub-systems to be enabled.
 	 */
 	if (cpu_is_omap443x())
-		return omap4430_init_pmu();
+		r = omap4430_init_pmu();
 	else
-		return omap2_init_pmu();
+		r = omap2_init_pmu();
+
+	if (!r)
+		pm_qos_add_request(&pmu_pm_qos_request, PM_QOS_CPU_DMA_LATENCY,
+				PM_QOS_DEFAULT_VALUE);
+
+	return r;
 }
 
 subsys_initcall(omap_init_pmu);
-- 
1.7.9.5

