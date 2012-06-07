From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 09/10] ARM: OMAP4: Enable PMU for OMAP4460/70
Date: Thu, 7 Jun 2012 16:22:11 -0500
Message-ID: <1339104132-26885-10-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56646 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932917Ab2FGVXE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 17:23:04 -0400
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

OMAP4460 and OMAP4470 devices have dedicated PMU interrupts and so add these
interrupts to the MPU HWMOD so we can use these for PMU events on these
devices. The PMU interrupts need to be the first interrupts in the array of
interrupts as the ARM PMU driver assumes this.

By using these dedicated interrupts we only need to enable the MPU sub-system
for PMU to work. This is different to OMAP4430 that did not have dedicated
interrupts and required other power domains such as the DEBUGSS to be enabled
so we could route the PMU events to the CTI interrupts. Hence, OMAP4460 and
OMAP4470 devices can use the same function to create the PMU device that is
using by OMAP2/3.

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 ++
 arch/arm/mach-omap2/pmu.c                  |   14 +++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index faf5a6d..882bbe6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2453,6 +2453,8 @@ static struct omap_hwmod_class omap44xx_mpu_hwmod_class = {
 
 /* mpu */
 static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] = {
+	{ .name = "pmu0", .irq = 54 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "pmu1", .irq = 55 + OMAP44XX_IRQ_GIC_START },
 	{ .name = "pl310", .irq = 0 + OMAP44XX_IRQ_GIC_START },
 	{ .irq = -1 }
 };
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 228e247..f1b535a 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -189,13 +189,17 @@ static int __init omap4430_init_pmu(void)
 
 static int __init omap_init_pmu(void)
 {
-
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		return omap2_init_pmu();
+	/*
+	 * OMAP4460/70 devices may use the omap2_init_pmu() function because
+	 * these devices have dedicated PMU IRQs and only need the MPU
+	 * sub-system to be enabled. OMAP4430 does not have dedicated PMU
+	 * interrupts and so the CTI IRQs are used and this requires additional
+	 * sub-systems to be enabled.
+	 */
 	if (cpu_is_omap443x())
 		return omap4430_init_pmu();
-
-	return 0;
+	else
+		return omap2_init_pmu();
 }
 
 subsys_initcall(omap_init_pmu);
-- 
1.7.9.5

