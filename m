From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 2/8] ARM: OMAP2+: PMU: Convert OMAP2/3 devices to use HWMOD
Date: Mon, 10 Sep 2012 10:23:40 -0500
Message-ID: <1347290626-21164-3-git-send-email-jon-hunter@ti.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48972 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757559Ab2IJPYK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 11:24:10 -0400
In-Reply-To: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Convert OMAP2/3 devices to use HWMOD for creating a PMU device. To support PMU
on OMAP2 devices we only need to use MPU sub-system and so we can simply use
the MPU HWMOD to create the PMU device. To support PMU on OMAP3 devices, we need
to use the MPU and DEBUG sub-systems and so use these HWMODs to create the PMU
device for OMAP3.

The MPU HWMOD for OMAP2/3 devices is currently missing the PMU interrupt and so
add the PMU interrupt to the MPU HWMOD for these devices.

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
 arch/arm/mach-omap2/devices.c                      |   32 --------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    6 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    6 ++
 arch/arm/mach-omap2/pmu.c                          |   83 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h             |    1 +
 6 files changed, 97 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pmu.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f6a24b3..9d533b7 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -198,6 +198,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
+obj-$(CONFIG_HW_PERF_EVENTS)		+= pmu.o
 
 # L3 interconnect
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_l3_smx.o
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 02b9478..2659c7b 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -433,37 +433,6 @@ static void omap_init_mcspi(void)
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
-	.id		= -1,
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
@@ -644,7 +613,6 @@ static int __init omap2_init_devices(void)
 		omap_init_mcpdm();
 		omap_init_mcspi();
 	}
-	omap_init_pmu();
 	omap_init_sti();
 	omap_init_sham();
 	omap_init_aes();
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index afad69c..411e2df 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -200,8 +200,14 @@ struct omap_hwmod omap2xxx_l4_wkup_hwmod = {
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
index 78a0c2d..4a5b8ab 100644
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
index 0000000..1de52ed
--- /dev/null
+++ b/arch/arm/mach-omap2/pmu.c
@@ -0,0 +1,83 @@
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
+static char *omap2_pmu_oh_names[] = {"mpu"};
+static char *omap3_pmu_oh_names[] = {"mpu", "debugss"};
+static struct platform_device *omap_pmu_dev;
+
+/**
+ * omap2_init_pmu - creates and registers PMU platform device
+ * @oh_num:	Number of OMAP HWMODs required to create PMU device
+ * @oh_names:	Array of OMAP HWMODS names required to create PMU device
+ *
+ * Uses OMAP HWMOD framework to create and register an ARM PMU device
+ * from a list of HWMOD names passed. Currently supports OMAP2 and
+ * OMAP3 devices.
+ */
+static int __init omap2_init_pmu(unsigned oh_num, char *oh_names[])
+{
+	int i;
+	struct omap_hwmod *oh[2];
+	char *dev_name = "arm-pmu";
+
+	if ((!oh_num) || (oh_num > 2))
+		return -EINVAL;
+
+	for (i = 0; i < oh_num; i++) {
+		oh[i] = omap_hwmod_lookup(oh_names[i]);
+		if (!oh[i]) {
+			pr_err("Could not look up %s hwmod\n", oh_names[i]);
+			return -ENODEV;
+		}
+	}
+
+	omap_pmu_dev = omap_device_build_ss(dev_name, -1, oh, oh_num, NULL, 0,
+				NULL, 0, 0);
+	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
+				dev_name);
+
+	return IS_ERR(omap_pmu_dev) ? PTR_ERR(omap_pmu_dev) : 0;
+}
+
+static int __init omap_init_pmu(void)
+{
+	unsigned oh_num;
+	char **oh_names;
+
+	/*
+	 * To create an ARM-PMU device the following HWMODs
+	 * are required for the various OMAP2+ devices.
+	 *
+	 * OMAP24xx:	mpu
+	 * OMAP3xxx:	mpu, debugss
+	 */
+	if (cpu_is_omap24xx()) {
+		oh_num = ARRAY_SIZE(omap2_pmu_oh_names);
+		oh_names = omap2_pmu_oh_names;
+	} else if (cpu_is_omap34xx()) {
+		oh_num = ARRAY_SIZE(omap3_pmu_oh_names);
+		oh_names = omap3_pmu_oh_names;
+	} else {
+		return 0;
+	}
+
+	return omap2_init_pmu(oh_num, oh_names);
+}
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

