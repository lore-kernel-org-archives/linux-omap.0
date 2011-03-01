From: tom.leiming@gmail.com
Subject: [patch v1 3/3] arm: omap4: support pmu
Date: Wed,  2 Mar 2011 00:58:31 +0800
Message-ID: <1298998711-8165-4-git-send-email-tom.leiming@gmail.com>
References: <1298998711-8165-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61743 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab1CAQ7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 11:59:19 -0500
Received: by pzk35 with SMTP id 35so831401pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 08:59:19 -0800 (PST)
In-Reply-To: <1298998711-8165-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, Ming Lei <tom.leiming@gmail.com>, Woodruff Richard <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

From: Ming Lei <tom.leiming@gmail.com>

This patch supports pmu irq routed from CTI, so
make pmu/perf working on OMAP4.

The idea is from Woodruff Richard in the disscussion
"Oprofile on Pandaboard / Omap4" of pandaboard@googlegroups.com.

Cc: Woodruff Richard <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/dbg44xx.h |   18 +++++++++++++
 arch/arm/mach-omap2/devices.c |   55 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletions(-)
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
index d216976..0420a58 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -35,6 +35,7 @@
 
 #include "mux.h"
 #include "control.h"
+#include "dbg44xx.h"
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
@@ -322,19 +323,71 @@ static struct resource omap3_pmu_resource = {
 	.flags	= IORESOURCE_IRQ,
 };
 
+static struct resource omap4_pmu_resource[] = {
+	{
+	.start	= OMAP44XX_IRQ_CTI0,
+	.end	= OMAP44XX_IRQ_CTI0,
+	.flags	= IORESOURCE_IRQ,
+	},
+	{
+	.start	= OMAP44XX_IRQ_CTI1,
+	.end	= OMAP44XX_IRQ_CTI1,
+	.flags	= IORESOURCE_IRQ,
+	}
+};
+
 static struct platform_device omap_pmu_device = {
 	.name		= "arm-pmu",
 	.id		= ARM_PMU_DEVICE_CPU,
 	.num_resources	= 1,
 };
 
+struct arm_pmu_platdata omap4_pmu_data;
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
+	cti_init(&omap4_pmu_data.cti[0], base0,
+			OMAP44XX_IRQ_CTI0, 6);
+	cti_unlock(&omap4_pmu_data.cti[0]);
+	cti_map_trigger(&omap4_pmu_data.cti[0],
+			1, 6, 2);
+
+	/*configure CTI1 for pmu irq routing*/
+	cti_init(&omap4_pmu_data.cti[1], base1,
+			OMAP44XX_IRQ_CTI1, 6);
+	cti_unlock(&omap4_pmu_data.cti[1]);
+	cti_map_trigger(&omap4_pmu_data.cti[1],
+			1, 6, 3);
+
+	omap4_pmu_data.cti_cnt = 2;
+	omap4_pmu_data.use_cti_irq = 1;
+	omap4_pmu_data.handle_irq = NULL;
+}
+
 static void omap_init_pmu(void)
 {
 	if (cpu_is_omap24xx())
 		omap_pmu_device.resource = &omap2_pmu_resource;
 	else if (cpu_is_omap34xx())
 		omap_pmu_device.resource = &omap3_pmu_resource;
-	else
+	else if (cpu_is_omap44xx()) {
+		omap_pmu_device.resource = omap4_pmu_resource;
+		omap_pmu_device.num_resources = 2;
+		platform_set_drvdata(&omap_pmu_device, &omap4_pmu_data);
+
+		omap4_configure_pmu_irq();
+	} else
 		return;
 
 	platform_device_register(&omap_pmu_device);
-- 
1.7.3

