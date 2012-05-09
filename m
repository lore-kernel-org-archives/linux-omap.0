From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 3/6] arm: omap4: support pmu
Date: Wed, 9 May 2012 16:35:50 -0500
Message-ID: <1336599350-10944-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38859 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932213Ab2EIVfy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 17:35:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ming Lei <ming.lei@canonical.com>, Woodruff Richard <r-woodruff2@ti.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Ming Lei <ming.lei@canonical.com>

This patch supports pmu irq routed from CTI, so make pmu/perf working on
OMAP4.

The idea is from Woodruff Richard in the disscussion
about "Oprofile on Pandaboard / Omap4" on pandaboard@googlegroups.com.

Acked-by: Jean Pihet <j-pihet@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Woodruff Richard <r-woodruff2@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/devices.c              |   60 +++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap44xx.h |    3 +
 2 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index d75b7d3..636533d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -24,6 +24,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
+#include <asm/cti.h>
 
 #include "iomap.h"
 #include <plat/board.h>
@@ -432,6 +433,57 @@ static struct omap_device_pm_latency omap_pmu_latency[] = {
 	},
 };
 
+static struct cti omap4_cti[2];
+
+static void omap4_enable_cti(int irq)
+{
+	if (irq == OMAP44XX_IRQ_CTI0)
+		cti_enable(&omap4_cti[0]);
+	else if (irq == OMAP44XX_IRQ_CTI1)
+		cti_enable(&omap4_cti[1]);
+}
+
+static void omap4_disable_cti(int irq)
+{
+	if (irq == OMAP44XX_IRQ_CTI0)
+		cti_disable(&omap4_cti[0]);
+	else if (irq == OMAP44XX_IRQ_CTI1)
+		cti_disable(&omap4_cti[1]);
+}
+
+static irqreturn_t omap4_pmu_handler(int irq, void *dev, irq_handler_t handler)
+{
+	if (irq == OMAP44XX_IRQ_CTI0)
+		cti_irq_ack(&omap4_cti[0]);
+	else if (irq == OMAP44XX_IRQ_CTI1)
+		cti_irq_ack(&omap4_cti[1]);
+
+	return handler(irq, dev);
+}
+
+static void __init omap4_configure_pmu_irq(void)
+{
+	void __iomem *base0;
+	void __iomem *base1;
+
+	base0 = ioremap(OMAP44XX_CTI0_BASE, SZ_4K);
+	base1 = ioremap(OMAP44XX_CTI1_BASE, SZ_4K);
+	if (!base0 && !base1) {
+		pr_err("ioremap for OMAP4 CTI failed\n");
+		return;
+	}
+
+	/*configure CTI0 for pmu irq routing*/
+	cti_init(&omap4_cti[0], base0, OMAP44XX_IRQ_CTI0, 6);
+	cti_unlock(&omap4_cti[0]);
+	cti_map_trigger(&omap4_cti[0], 1, 6, 2);
+
+	/*configure CTI1 for pmu irq routing*/
+	cti_init(&omap4_cti[1], base1, OMAP44XX_IRQ_CTI1, 6);
+	cti_unlock(&omap4_cti[1]);
+	cti_map_trigger(&omap4_cti[1], 1, 6, 2);
+}
+
 static struct platform_device* __init omap4_init_pmu(void)
 {
 	int id = -1;
@@ -459,6 +511,10 @@ static struct platform_device* __init omap4_init_pmu(void)
 		return NULL;
 	}
 
+	omap4_pmu_data.handle_irq = omap4_pmu_handler;
+	omap4_pmu_data.enable_irq = omap4_enable_cti;
+	omap4_pmu_data.disable_irq = omap4_disable_cti;
+
 	pd = omap_device_build_ss(dev_name, id, oh, 3, &omap4_pmu_data,
 				sizeof(omap4_pmu_data),
 				omap_pmu_latency,
@@ -479,7 +535,9 @@ static void __init omap_init_pmu(void)
 		pd = omap4_init_pmu();
 		if (!pd)
 			return;
-		omap_device_enable(pd);
+
+		omap_device_enable(&od->pdev);
+		omap4_configure_pmu_irq();
 		return;
 	} else {
 		return;
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index c0d478e..0b04969 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -58,5 +58,8 @@
 #define OMAP44XX_HSUSB_OHCI_BASE	(L4_44XX_BASE + 0x64800)
 #define OMAP44XX_HSUSB_EHCI_BASE	(L4_44XX_BASE + 0x64C00)
 
+#define OMAP44XX_CTI0_BASE		0x54148000
+#define OMAP44XX_CTI1_BASE		0x54149000
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
-- 
1.7.5.4

