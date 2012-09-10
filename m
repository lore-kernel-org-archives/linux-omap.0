From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 7/8] ARM: OMAP4: Enable PMU for OMAP4460/70
Date: Mon, 10 Sep 2012 10:23:45 -0500
Message-ID: <1347290626-21164-8-git-send-email-jon-hunter@ti.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59786 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab2IJPYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 11:24:05 -0400
In-Reply-To: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

OMAP4460 and OMAP4470 devices have dedicated PMU interrupts and so add these
interrupts to the MPU HWMOD so we can use these for PMU events on these
devices. The PMU interrupts need to be the first interrupts in the array of
interrupts as the ARM PMU driver assumes this.

By using these dedicated interrupts we only need to enable the MPU and DEBUG
sub-systems for PMU to work. This is different to OMAP4430 that did not have
dedicated interrupts and required other power domains in addition to the DEBUG
sub-system to be enabled so we could route the PMU events to the CTI interrupts.
Hence, OMAP4460 and OMAP4470 devices can use the same list of HWMODs to create
the PMU device that is using by OMAP3.

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 ++
 arch/arm/mach-omap2/pmu.c                  |   17 ++++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7de8fbe..cdf0e05 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2456,6 +2456,8 @@ static struct omap_hwmod_class omap44xx_mpu_hwmod_class = {
 
 /* mpu */
 static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] = {
+	{ .name = "pmu0", .irq = 54 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "pmu1", .irq = 55 + OMAP44XX_IRQ_GIC_START },
 	{ .name = "pl310", .irq = 0 + OMAP44XX_IRQ_GIC_START },
 	{ .irq = -1 }
 };
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 5918098..7fbaa3f 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -118,7 +118,7 @@ static int __init omap4_init_cti(void)
  *
  * Uses OMAP HWMOD framework to create and register an ARM PMU device
  * from a list of HWMOD names passed. Currently supports OMAP2, OMAP3
- * and OMAP4430 devices.
+ * and OMAP4 devices.
  */
 static int __init omap2_init_pmu(unsigned oh_num, char *oh_names[])
 {
@@ -163,14 +163,9 @@ static int __init omap_init_pmu(void)
 	 * OMAP24xx:	mpu
 	 * OMAP3xxx:	mpu, debugss
 	 * OMAP4430:	l3_main_3, l3_instr, debugss
+	 * OMAP4460/70:	mpu, debugss
 	 */
-	if (cpu_is_omap24xx()) {
-		oh_num = ARRAY_SIZE(omap2_pmu_oh_names);
-		oh_names = omap2_pmu_oh_names;
-	} else if (cpu_is_omap34xx()) {
-		oh_num = ARRAY_SIZE(omap3_pmu_oh_names);
-		oh_names = omap3_pmu_oh_names;
-	} else if (cpu_is_omap443x()) {
+	if (cpu_is_omap443x()) {
 		r = omap4_init_cti();
 		if (r)
 			return r;
@@ -180,8 +175,12 @@ static int __init omap_init_pmu(void)
 		omap_pmu_data.runtime_suspend = omap4_pmu_runtime_suspend;
 		oh_num = ARRAY_SIZE(omap4430_pmu_oh_names);
 		oh_names = omap4430_pmu_oh_names;
+	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		oh_num = ARRAY_SIZE(omap3_pmu_oh_names);
+		oh_names = omap3_pmu_oh_names;
 	} else {
-		return 0;
+		oh_num = ARRAY_SIZE(omap2_pmu_oh_names);
+		oh_names = omap2_pmu_oh_names;
 	}
 
 	return omap2_init_pmu(oh_num, oh_names);
-- 
1.7.9.5

