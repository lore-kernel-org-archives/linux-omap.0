From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 02/10] ARM: OMAP2+: PMU: Convert OMAP2/3 devices to use HWMOD
Date: Thu, 7 Jun 2012 16:22:04 -0500
Message-ID: <1339104132-26885-3-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56649 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932934Ab2FGVXH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 17:23:07 -0400
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Convert OMAP2/3 devices to use HWMOD for creating a PMU device. To support PMU
on OMAP2/3 devices we only need to use MPU sub-system and so we can simply use
the MPU HWMOD to create the PMU device. The MPU HWMOD for OMAP2/3 devices is
currently missing the PMU interrupt and so add the PMU interrupt to the MPU
HWMOD for these devices.

This change also moves the PMU code out of the mach-omap2/devices.c files into
its own pmu.c file as suggested by Kevin Hilman to de-clutter devices.c.

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |    1 +
 arch/arm/mach-omap2/devices.c                      |   33 -----------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    6 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    6 ++
 arch/arm/mach-omap2/pmu.c                          |   59 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h             |    1 +
 6 files changed, 73 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pmu.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 664224f..23a2569 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -169,6 +169,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
+obj-$(CONFIG_CPU_HAS_PMU)		+= pmu.o
 
 # L3 interconnect
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_l3_smx.o
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 25130ff..ba0751a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -23,7 +23,6 @@
 #include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
-#include <asm/pmu.h>
 
 #include "iomap.h"
 #include <plat/board.h>
@@ -434,37 +433,6 @@ static void omap_init_mcspi(void)
 static inline void omap_init_mcspi(void) {}
 #endif
 
-static struct resource omap2_pmu_resource = {
-	.start	= 3,
-	.end	= 3,
-	.flags	= IORESOURCE_IRQ,
-};
-
-static struct resource omap3_pmu_resource = {
-	.start	= INT_34XX_BENCH_MPU_EMUL,
-	.end	= INT_34XX_BENCH_MPU_EMUL,
-	.flags	= IORESOURCE_IRQ,
-};
-
-static struct platform_device omap_pmu_device = {
-	.name		= "arm-pmu",
-	.id		= ARM_PMU_DEVICE_CPU,
-	.num_resources	= 1,
-};
-
-static void omap_init_pmu(void)
-{
-	if (cpu_is_omap24xx())
-		omap_pmu_device.resource = &omap2_pmu_resource;
-	else if (cpu_is_omap34xx())
-		omap_pmu_device.resource = &omap3_pmu_resource;
-	else
-		return;
-
-	platform_device_register(&omap_pmu_device);
-}
-
-
 #if defined(CONFIG_CRYPTO_DEV_OMAP_SHAM) || defined(CONFIG_CRYPTO_DEV_OMAP_SHAM_MODULE)
 
 #ifdef CONFIG_ARCH_OMAP2
@@ -680,7 +648,6 @@ static int __init omap2_init_devices(void)
 		omap_init_mcpdm();
 		omap_init_mcspi();
 	}
-	omap_init_pmu();
 	omap_hdq_init();
 	omap_init_sti();
 	omap_init_sham();
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 83eafd9..4ef4b59 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -201,8 +201,14 @@ struct omap_hwmod omap2xxx_l4_wkup_hwmod = {
 };
 
 /* MPU */
+static struct omap_hwmod_irq_info omap2xxx_mpu_irqs[] = {
+	{ .name = "pmu", .irq = INT_24XX_BENCH_MPU_EMUL },
+	{ .irq = -1 }
+};
+
 struct omap_hwmod omap2xxx_mpu_hwmod = {
 	.name		= "mpu",
+	.mpu_irqs	= omap2xxx_mpu_irqs,
 	.class		= &mpu_hwmod_class,
 	.main_clk	= "mpu_ck",
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index b26d3c9..5de8fc0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -92,8 +92,14 @@ static struct omap_hwmod omap3xxx_l4_sec_hwmod = {
 };
 
 /* MPU */
+static struct omap_hwmod_irq_info omap3xxx_mpu_irqs[] = {
+	{ .name = "pmu", .irq = INT_34XX_BENCH_MPU_EMUL },
+	{ .irq = -1 }
+};
+
 static struct omap_hwmod omap3xxx_mpu_hwmod = {
 	.name		= "mpu",
+	.mpu_irqs	= omap3xxx_mpu_irqs,
 	.class		= &mpu_hwmod_class,
 	.main_clk	= "arm_fck",
 };
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
new file mode 100644
index 0000000..329e00c
--- /dev/null
+++ b/arch/arm/mach-omap2/pmu.c
@@ -0,0 +1,59 @@
+/*
+ * linux/arch/arm/mach-omap2/pmu.c
+ *
+ * OMAP2 ARM Performance Monitoring Unit (PMU) Support
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ *
+ * Contacts:
+ * Jon Hunter <jon-hunter@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <asm/pmu.h>
+
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+
+static struct platform_device *omap_pmu_dev;
+
+/*
+ * omap2_init_pmu - creates and registers PMU platform device
+ *
+ * Uses OMAP HWMOD framework to create and register an ARM PMU device.
+ * Currently supports OMAP2 and OMAP3 devices that only require the MPU
+ * sub-system to be active for PMU events to work.
+ */
+static int __init omap2_init_pmu(void)
+{
+	int id = -1;
+	struct omap_hwmod *oh;
+	char *oh_name = "mpu";
+	char *dev_name = "arm-pmu";
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s hwmod\n", oh_name);
+		return -ENODEV;
+	}
+
+	omap_pmu_dev = omap_device_build(dev_name, id, oh, NULL, 0, NULL, 0, 0);
+
+	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
+				dev_name);
+
+	return 0;
+}
+
+static int __init omap_init_pmu(void)
+{
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		return omap2_init_pmu();
+
+	return 0;
+}
+
+subsys_initcall(omap_init_pmu);
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 37bbbbb..18883eb 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -243,6 +243,7 @@
 #define INT_7XX_DMA_CH15	(62 + IH2_BASE)
 #define INT_7XX_NAND		(63 + IH2_BASE)
 
+#define INT_24XX_BENCH_MPU_EMUL	3
 #define INT_24XX_SYS_NIRQ	7
 #define INT_24XX_SDMA_IRQ0	12
 #define INT_24XX_SDMA_IRQ1	13
-- 
1.7.9.5

