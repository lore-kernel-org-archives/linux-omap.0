From: ming.lei@canonical.com
Subject: [PATCH v6 2/3] arm: omap4: support pmu
Date: Sat, 26 Nov 2011 10:53:48 +0800
Message-ID: <1322276029-3701-3-git-send-email-ming.lei@canonical.com>
References: <1322276029-3701-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54688 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469Ab1KZCzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Nov 2011 21:55:13 -0500
Received: by iage36 with SMTP id e36so5398188iag.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 18:55:12 -0800 (PST)
In-Reply-To: <1322276029-3701-1-git-send-email-ming.lei@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, Ming Lei <ming.lei@canonical.com>, Woodruff Richard <r-woodruff2@ti.com>

From: Ming Lei <ming.lei@canonical.com>

This patch supports pmu irq routed from CTI, so
make pmu/perf working on OMAP4.

The idea is from Woodruff Richard in the disscussion
about "Oprofile on Pandaboard / Omap4" on pandaboard@googlegroups.com.

Acked-by: Jean Pihet <j-pihet@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Woodruff Richard <r-woodruff2@ti.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/mach-omap2/devices.c              |   60 +++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap44xx.h |    3 +
 2 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 6e16274..bc791e0 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -23,6 +23,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
+#include <asm/cti.h>
 
 #include <plat/tc.h>
 #include <plat/board.h>
@@ -393,6 +394,57 @@ static struct omap_device_pm_latency omap_pmu_latency[] = {
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
@@ -420,6 +472,10 @@ static struct platform_device* __init omap4_init_pmu(void)
 		return NULL;
 	}
 
+	omap4_pmu_data.handle_irq = omap4_pmu_handler;
+	omap4_pmu_data.enable_irq = omap4_enable_cti;
+	omap4_pmu_data.disable_irq = omap4_disable_cti;
+
 	pd = omap_device_build_ss(dev_name, id, oh, 3, &omap4_pmu_data,
 				sizeof(omap4_pmu_data),
 				omap_pmu_latency,
@@ -440,7 +496,9 @@ static void __init omap_init_pmu(void)
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
index ea2b8a6..4637980 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -57,5 +57,8 @@
 #define OMAP44XX_HSUSB_OHCI_BASE	(L4_44XX_BASE + 0x64800)
 #define OMAP44XX_HSUSB_EHCI_BASE	(L4_44XX_BASE + 0x64C00)
 
+#define OMAP44XX_CTI0_BASE		0x54148000
+#define OMAP44XX_CTI1_BASE		0x54149000
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
-- 
1.7.5.4

