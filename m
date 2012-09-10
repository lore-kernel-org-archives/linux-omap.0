From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 4/8] ARM: OMAP4430: Create PMU device via HWMOD
Date: Mon, 10 Sep 2012 10:23:42 -0500
Message-ID: <1347290626-21164-5-git-send-email-jon-hunter@ti.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44947 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757539Ab2IJPYK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 11:24:10 -0400
In-Reply-To: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Ming Lei <ming.lei@canonical.com>

For OMAP4430 PMU events are routed to the CPU via the cross trigger interface
(CTI) because there are no dedicated interrupts. In order to route the PMU
events via the CTI IRQs, the following modules must be enabled:

        l3_instr, l3_main_3, debugss

Therefore, build the arm-pmu device via these three HWMODs.

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Ming Lei <ming.lei@canonical.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/pmu.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 1de52ed..7c137be 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -20,6 +20,7 @@
 
 static char *omap2_pmu_oh_names[] = {"mpu"};
 static char *omap3_pmu_oh_names[] = {"mpu", "debugss"};
+static char *omap4430_pmu_oh_names[] = {"l3_main_3", "l3_instr", "debugss"};
 static struct platform_device *omap_pmu_dev;
 
 /**
@@ -28,16 +29,16 @@ static struct platform_device *omap_pmu_dev;
  * @oh_names:	Array of OMAP HWMODS names required to create PMU device
  *
  * Uses OMAP HWMOD framework to create and register an ARM PMU device
- * from a list of HWMOD names passed. Currently supports OMAP2 and
- * OMAP3 devices.
+ * from a list of HWMOD names passed. Currently supports OMAP2, OMAP3
+ * and OMAP4430 devices.
  */
 static int __init omap2_init_pmu(unsigned oh_num, char *oh_names[])
 {
 	int i;
-	struct omap_hwmod *oh[2];
+	struct omap_hwmod *oh[3];
 	char *dev_name = "arm-pmu";
 
-	if ((!oh_num) || (oh_num > 2))
+	if ((!oh_num) || (oh_num > 3))
 		return -EINVAL;
 
 	for (i = 0; i < oh_num; i++) {
@@ -67,6 +68,7 @@ static int __init omap_init_pmu(void)
 	 *
 	 * OMAP24xx:	mpu
 	 * OMAP3xxx:	mpu, debugss
+	 * OMAP4430:	l3_main_3, l3_instr, debugss
 	 */
 	if (cpu_is_omap24xx()) {
 		oh_num = ARRAY_SIZE(omap2_pmu_oh_names);
@@ -74,6 +76,9 @@ static int __init omap_init_pmu(void)
 	} else if (cpu_is_omap34xx()) {
 		oh_num = ARRAY_SIZE(omap3_pmu_oh_names);
 		oh_names = omap3_pmu_oh_names;
+	} else if (cpu_is_omap443x()) {
+		oh_num = ARRAY_SIZE(omap4430_pmu_oh_names);
+		oh_names = omap4430_pmu_oh_names;
 	} else {
 		return 0;
 	}
-- 
1.7.9.5

