From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/11] ARM: OMAP2+: Remove unused legacy code for PMU
Date: Wed, 31 May 2017 15:51:31 -0700
Message-ID: <20170531225139.30723-4-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531225139.30723-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are now booting all mach-omap2 in device tree only mode.
Any code that is only called in legacy boot mode where
of_have_populated_dt() is not set is safe to remove now.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile |  3 --
 arch/arm/mach-omap2/pmu.c    | 97 --------------------------------------------
 2 files changed, 100 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/pmu.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -219,9 +219,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap_hwmod_54xx_data.o
 obj-$(CONFIG_SOC_DRA7XX)		+= omap_hwmod_7xx_data.o
 
-# EMU peripherals
-obj-$(CONFIG_HW_PERF_EVENTS)		+= pmu.o
-
 # OMAP2420 MSDI controller integration support ("MMC")
 obj-$(CONFIG_SOC_OMAP2420)		+= msdi.o
 
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
deleted file mode 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * OMAP2 ARM Performance Monitoring Unit (PMU) Support
- *
- * Copyright (C) 2012 Texas Instruments, Inc.
- *
- * Contacts:
- * Jon Hunter <jon-hunter@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#include <linux/of.h>
-
-#include <asm/system_info.h>
-
-#include "soc.h"
-#include "omap_hwmod.h"
-#include "omap_device.h"
-
-static char *omap2_pmu_oh_names[] = {"mpu"};
-static char *omap3_pmu_oh_names[] = {"mpu", "debugss"};
-static char *omap4430_pmu_oh_names[] = {"l3_main_3", "l3_instr", "debugss"};
-static struct platform_device *omap_pmu_dev;
-
-/**
- * omap2_init_pmu - creates and registers PMU platform device
- * @oh_num:	Number of OMAP HWMODs required to create PMU device
- * @oh_names:	Array of OMAP HWMODS names required to create PMU device
- *
- * Uses OMAP HWMOD framework to create and register an ARM PMU device
- * from a list of HWMOD names passed. Currently supports OMAP2, OMAP3
- * and OMAP4 devices.
- */
-static int __init omap2_init_pmu(unsigned oh_num, char *oh_names[])
-{
-	int i;
-	struct omap_hwmod *oh[3];
-	char *dev_name = cpu_architecture() == CPU_ARCH_ARMv6 ?
-			 "armv6-pmu" : "armv7-pmu";
-
-	if ((!oh_num) || (oh_num > 3))
-		return -EINVAL;
-
-	for (i = 0; i < oh_num; i++) {
-		oh[i] = omap_hwmod_lookup(oh_names[i]);
-		if (!oh[i]) {
-			pr_err("Could not look up %s hwmod\n", oh_names[i]);
-			return -ENODEV;
-		}
-	}
-
-	omap_pmu_dev = omap_device_build_ss(dev_name, -1, oh, oh_num, NULL, 0);
-	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
-	     dev_name);
-
-	return PTR_ERR_OR_ZERO(omap_pmu_dev);
-}
-
-static int __init omap_init_pmu(void)
-{
-	unsigned oh_num;
-	char **oh_names;
-
-	/* XXX Remove this check when the CTI driver is available */
-	if (cpu_is_omap443x()) {
-		pr_info("ARM PMU: not yet supported on OMAP4430 due to missing CTI driver\n");
-		return 0;
-	}
-
-	if (of_have_populated_dt())
-		return 0;
-
-	/*
-	 * To create an ARM-PMU device the following HWMODs
-	 * are required for the various OMAP2+ devices.
-	 *
-	 * OMAP24xx:	mpu
-	 * OMAP3xxx:	mpu, debugss
-	 * OMAP4430:	l3_main_3, l3_instr, debugss
-	 * OMAP4460/70:	mpu, debugss
-	 */
-	if (cpu_is_omap443x()) {
-		oh_num = ARRAY_SIZE(omap4430_pmu_oh_names);
-		oh_names = omap4430_pmu_oh_names;
-	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		oh_num = ARRAY_SIZE(omap3_pmu_oh_names);
-		oh_names = omap3_pmu_oh_names;
-	} else {
-		oh_num = ARRAY_SIZE(omap2_pmu_oh_names);
-		oh_names = omap2_pmu_oh_names;
-	}
-
-	return omap2_init_pmu(oh_num, oh_names);
-}
-omap_subsys_initcall(omap_init_pmu);
-- 
2.13.0
