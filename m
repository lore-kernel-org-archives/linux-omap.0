From: tom.leiming@gmail.com
Subject: [patch v2 3/3] arm: omap4: support pmu
Date: Wed,  2 Mar 2011 18:57:00 +0800
Message-ID: <1299063420-22203-4-git-send-email-tom.leiming@gmail.com>
References: <1299063420-22203-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34010 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab1CBK6J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:58:09 -0500
Received: by iyb26 with SMTP id 26so4791822iyb.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:58:08 -0800 (PST)
In-Reply-To: <1299063420-22203-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, Ming Lei <tom.leiming@gmail.com>, Woodruff Richard <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

From: Ming Lei <tom.leiming@gmail.com>

This patch supports pmu irq routed from CTI, so
make pmu/perf working on OMAP4.

The idea is from Woodruff Richard in the disscussion
about "Oprofile on Pandaboard / Omap4" on pandaboard@googlegroups.com.

Cc: Woodruff Richard <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/dbg44xx.h |   18 +++++++++
 arch/arm/mach-omap2/devices.c |   83 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dbg44xx.h

diff --git a/arch/arm/mach-omap2/dbg44xx.h b/arch/arm/mach-omap2/dbg44xx.h
new file mode 100644
index 0000000..e447ad5
--- /dev/null
+++ b/arch/arm/mach-omap2/dbg44xx.h
@@ -0,0 +1,18 @@
+/*
+ * OMAP44xx on-chip debug support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX This file needs to be updated to align on one of "OMAP4", "OMAP44XX",
+ *     or "OMAP4430".
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_DBG44XX_H
+#define __ARCH_ARM_MACH_OMAP2_DBG44XX_H
+
+#define OMAP44XX_CTI0_BASE		0x54148000
+#define OMAP44XX_CTI1_BASE		0x54149000
+
+#endif
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index d216976..bae02d5 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -22,6 +22,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
+#include <asm/cti.h>
 
 #include <plat/tc.h>
 #include <plat/board.h>
@@ -35,6 +36,7 @@
 
 #include "mux.h"
 #include "control.h"
+#include "dbg44xx.h"
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
@@ -322,20 +324,95 @@ static struct resource omap3_pmu_resource = {
 	.flags	= IORESOURCE_IRQ,
 };
 
+static struct resource omap4_pmu_resource[] = {
+	{
+		.start	= OMAP44XX_IRQ_CTI0,
+		.end	= OMAP44XX_IRQ_CTI0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= OMAP44XX_IRQ_CTI1,
+		.end	= OMAP44XX_IRQ_CTI1,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
 static struct platform_device omap_pmu_device = {
 	.name		= "arm-pmu",
 	.id		= ARM_PMU_DEVICE_CPU,
 	.num_resources	= 1,
 };
 
+static struct arm_pmu_platdata omap4_pmu_data;
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
+static void omap4_configure_pmu_irq(void)
+{
+	void *base0;
+	void *base1;
+
+	base0 = ioremap(OMAP44XX_CTI0_BASE, 4096);
+	base1 = ioremap(OMAP44XX_CTI1_BASE, 4096);
+	if (!base0 && !base1) {
+		pr_err("ioremap for omap4 CTI failed\n");
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
+
+	omap4_pmu_data.handle_irq = omap4_pmu_handler;
+	omap4_pmu_data.enable_irq = omap4_enable_cti;
+	omap4_pmu_data.disable_irq = omap4_disable_cti;
+}
+
 static void omap_init_pmu(void)
 {
-	if (cpu_is_omap24xx())
+	if (cpu_is_omap24xx()) {
 		omap_pmu_device.resource = &omap2_pmu_resource;
-	else if (cpu_is_omap34xx())
+	} else if (cpu_is_omap34xx()) {
 		omap_pmu_device.resource = &omap3_pmu_resource;
-	else
+	} else if (cpu_is_omap44xx()) {
+		omap_pmu_device.resource = omap4_pmu_resource;
+		omap_pmu_device.num_resources = 2;
+		omap_pmu_device.dev.platform_data = &omap4_pmu_data;
+		omap4_configure_pmu_irq();
+	} else {
 		return;
+	}
 
 	platform_device_register(&omap_pmu_device);
 }
-- 
1.7.3

