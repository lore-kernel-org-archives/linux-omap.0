From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 8/8] ARM: OMAP2+: PMU: Add QoS constraint
Date: Mon, 10 Sep 2012 10:23:46 -0500
Message-ID: <1347290626-21164-9-git-send-email-jon-hunter@ti.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48974 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757561Ab2IJPYK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 11:24:10 -0400
In-Reply-To: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

When CPU-idle is enabled, the MPU sub-system will transition to low power
states during idle periods. If the PMU is active and the MPU sub-system
transitions to a low power state, such as retention, then the PMU context
will be lost and PMU events will stop. To prevent this from happening add a
QoS constraint whenever PMU is active to prevent the MPU sub-system from
transitioning to a low power state.

By default the PMU QoS constraint is set to -1 so it will not prevent any low
power states and when the PMU is enabled, it is set to 0, so that only C-state
C0 is allowed. I plan to re-visit this and relax the constraint to allow some
low power states, but for now I just wish to ensure PMU is working.

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/pmu.c |   49 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 7fbaa3f..ca158f0 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -13,6 +13,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 
 #include <asm/pmu.h>
@@ -24,11 +25,41 @@
 static char *omap2_pmu_oh_names[] = {"mpu"};
 static char *omap3_pmu_oh_names[] = {"mpu", "debugss"};
 static char *omap4430_pmu_oh_names[] = {"l3_main_3", "l3_instr", "debugss"};
+static struct pm_qos_request pmu_pm_qos_request;
 static struct platform_device *omap_pmu_dev;
-static struct arm_pmu_platdata omap_pmu_data;
 static struct cti omap4_cti[2];
 
 /**
+ * omap_pmu_runtime_resume - PMU runtime resume callback
+ * @dev		OMAP PMU device
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
+/**
+ * omap_pmu_runtime_suspend - PMU runtime suspend callback
+ * @dev		OMAP PMU device
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
+/**
  * omap4_pmu_runtime_resume - PMU runtime resume callback
  * @dev		OMAP PMU device
  *
@@ -38,6 +69,8 @@ static struct cti omap4_cti[2];
  */
 static int omap4_pmu_runtime_resume(struct device *dev)
 {
+	pm_qos_update_request(&pmu_pm_qos_request, 0);
+
 	/* configure CTI0 for PMU IRQ routing */
 	cti_unlock(&omap4_cti[0]);
 	cti_map_trigger(&omap4_cti[0], 1, 6, 2);
@@ -64,6 +97,8 @@ static int omap4_pmu_runtime_suspend(struct device *dev)
 	cti_disable(&omap4_cti[0]);
 	cti_disable(&omap4_cti[1]);
 
+	pm_qos_update_request(&pmu_pm_qos_request, PM_QOS_DEFAULT_VALUE);
+
 	return 0;
 }
 
@@ -111,6 +146,11 @@ static int __init omap4_init_cti(void)
 	return 0;
 }
 
+static struct arm_pmu_platdata omap_pmu_data = {
+	.runtime_resume = omap_pmu_runtime_resume,
+	.runtime_suspend = omap_pmu_runtime_suspend,
+};
+
 /**
  * omap2_init_pmu - creates and registers PMU platform device
  * @oh_num:	Number of OMAP HWMODs required to create PMU device
@@ -183,6 +223,11 @@ static int __init omap_init_pmu(void)
 		oh_names = omap2_pmu_oh_names;
 	}
 
-	return omap2_init_pmu(oh_num, oh_names);
+	r = omap2_init_pmu(oh_num, oh_names);
+	if (!r)
+		pm_qos_add_request(&pmu_pm_qos_request, PM_QOS_CPU_DMA_LATENCY,
+				PM_QOS_DEFAULT_VALUE);
+
+	return r;
 }
 subsys_initcall(omap_init_pmu);
-- 
1.7.9.5

