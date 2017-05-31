From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/11] ARM: OMAP2+: Remove unused legacy code for opp
Date: Wed, 31 May 2017 15:51:29 -0700
Message-ID: <20170531225139.30723-2-tony@atomide.com>
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

Note that the volt_data is still being used.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile       |   1 -
 arch/arm/mach-omap2/opp.c          | 104 -------------------------------------
 arch/arm/mach-omap2/opp3xxx_data.c |  86 ------------------------------
 arch/arm/mach-omap2/opp4xxx_data.c |  79 ----------------------------
 4 files changed, 270 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/opp.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -69,7 +69,6 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 
 # OPP table initialization
 ifeq ($(CONFIG_PM_OPP),y)
-obj-y					+= opp.o
 obj-$(CONFIG_ARCH_OMAP3)		+= opp3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
 endif
diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
deleted file mode 100644
--- a/arch/arm/mach-omap2/opp.c
+++ /dev/null
@@ -1,104 +0,0 @@
-/*
- * OMAP SoC specific OPP wrapper function
- *
- * Copyright (C) 2009-2010 Texas Instruments Incorporated - http://www.ti.com/
- *	Nishanth Menon
- *	Kevin Hilman
- * Copyright (C) 2010 Nokia Corporation.
- *      Eduardo Valentin
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/pm_opp.h>
-#include <linux/cpu.h>
-
-#include "omap_device.h"
-
-#include "omap_opp_data.h"
-
-/* Temp variable to allow multiple calls */
-static u8 __initdata omap_table_init;
-
-/**
- * omap_init_opp_table() - Initialize opp table as per the CPU type
- * @opp_def:		opp default list for this silicon
- * @opp_def_size:	number of opp entries for this silicon
- *
- * Register the initial OPP table with the OPP library based on the CPU
- * type. This is meant to be used only by SoC specific registration.
- */
-int __init omap_init_opp_table(struct omap_opp_def *opp_def,
-		u32 opp_def_size)
-{
-	int i, r;
-
-	if (of_have_populated_dt())
-		return -EINVAL;
-
-	if (!opp_def || !opp_def_size) {
-		pr_err("%s: invalid params!\n", __func__);
-		return -EINVAL;
-	}
-
-	/*
-	 * Initialize only if not already initialized even if the previous
-	 * call failed, because, no reason we'd succeed again.
-	 */
-	if (omap_table_init)
-		return -EEXIST;
-	omap_table_init = 1;
-
-	/* Lets now register with OPP library */
-	for (i = 0; i < opp_def_size; i++, opp_def++) {
-		struct omap_hwmod *oh;
-		struct device *dev;
-
-		if (!opp_def->hwmod_name) {
-			pr_err("%s: NULL name of omap_hwmod, failing [%d].\n",
-				__func__, i);
-			return -EINVAL;
-		}
-
-		if (!strncmp(opp_def->hwmod_name, "mpu", 3)) {
-			/* 
-			 * All current OMAPs share voltage rail and
-			 * clock source, so CPU0 is used to represent
-			 * the MPU-SS.
-			 */
-			dev = get_cpu_device(0);
-		} else {
-			oh = omap_hwmod_lookup(opp_def->hwmod_name);
-			if (!oh || !oh->od) {
-				pr_debug("%s: no hwmod or odev for %s, [%d] cannot add OPPs.\n",
-					 __func__, opp_def->hwmod_name, i);
-				continue;
-			}
-			dev = &oh->od->pdev->dev;
-		}
-
-		r = dev_pm_opp_add(dev, opp_def->freq, opp_def->u_volt);
-		if (r) {
-			dev_err(dev, "%s: add OPP %ld failed for %s [%d] result=%d\n",
-				__func__, opp_def->freq,
-				opp_def->hwmod_name, i, r);
-		} else {
-			if (!opp_def->default_available)
-				r = dev_pm_opp_disable(dev, opp_def->freq);
-			if (r)
-				dev_err(dev, "%s: disable %ld failed for %s [%d] result=%d\n",
-					__func__, opp_def->freq,
-					opp_def->hwmod_name, i, r);
-		}
-	}
-
-	return 0;
-}
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -83,89 +83,3 @@ struct omap_volt_data omap36xx_vddcore_volt_data[] = {
 	VOLT_DATA_DEFINE(OMAP3630_VDD_CORE_OPP100_UV, OMAP3630_CONTROL_FUSE_OPP100_VDD2, 0xf9, 0x16),
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
-
-/* OPP data */
-
-static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
-	/* MPU OPP1 */
-	OPP_INITIALIZER("mpu", true, 125000000, OMAP3430_VDD_MPU_OPP1_UV),
-	/* MPU OPP2 */
-	OPP_INITIALIZER("mpu", true, 250000000, OMAP3430_VDD_MPU_OPP2_UV),
-	/* MPU OPP3 */
-	OPP_INITIALIZER("mpu", true, 500000000, OMAP3430_VDD_MPU_OPP3_UV),
-	/* MPU OPP4 */
-	OPP_INITIALIZER("mpu", true, 550000000, OMAP3430_VDD_MPU_OPP4_UV),
-	/* MPU OPP5 */
-	OPP_INITIALIZER("mpu", true, 600000000, OMAP3430_VDD_MPU_OPP5_UV),
-
-	/*
-	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
-	 * almost the same than the one at 83MHz thus providing very little
-	 * gain for the power point of view. In term of energy it will even
-	 * increase the consumption due to the very negative performance
-	 * impact that frequency will do to the MPU and the whole system in
-	 * general.
-	 */
-	OPP_INITIALIZER("l3_main", false, 41500000, OMAP3430_VDD_CORE_OPP1_UV),
-	/* L3 OPP2 */
-	OPP_INITIALIZER("l3_main", true, 83000000, OMAP3430_VDD_CORE_OPP2_UV),
-	/* L3 OPP3 */
-	OPP_INITIALIZER("l3_main", true, 166000000, OMAP3430_VDD_CORE_OPP3_UV),
-
-	/* DSP OPP1 */
-	OPP_INITIALIZER("iva", true, 90000000, OMAP3430_VDD_MPU_OPP1_UV),
-	/* DSP OPP2 */
-	OPP_INITIALIZER("iva", true, 180000000, OMAP3430_VDD_MPU_OPP2_UV),
-	/* DSP OPP3 */
-	OPP_INITIALIZER("iva", true, 360000000, OMAP3430_VDD_MPU_OPP3_UV),
-	/* DSP OPP4 */
-	OPP_INITIALIZER("iva", true, 400000000, OMAP3430_VDD_MPU_OPP4_UV),
-	/* DSP OPP5 */
-	OPP_INITIALIZER("iva", true, 430000000, OMAP3430_VDD_MPU_OPP5_UV),
-};
-
-static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
-	/* MPU OPP1 - OPP50 */
-	OPP_INITIALIZER("mpu", true,  300000000, OMAP3630_VDD_MPU_OPP50_UV),
-	/* MPU OPP2 - OPP100 */
-	OPP_INITIALIZER("mpu", true,  600000000, OMAP3630_VDD_MPU_OPP100_UV),
-	/* MPU OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("mpu", false, 800000000, OMAP3630_VDD_MPU_OPP120_UV),
-	/* MPU OPP4 - OPP-SB */
-	OPP_INITIALIZER("mpu", false, 1000000000, OMAP3630_VDD_MPU_OPP1G_UV),
-
-	/* L3 OPP1 - OPP50 */
-	OPP_INITIALIZER("l3_main", true, 100000000, OMAP3630_VDD_CORE_OPP50_UV),
-	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
-	OPP_INITIALIZER("l3_main", true, 200000000, OMAP3630_VDD_CORE_OPP100_UV),
-
-	/* DSP OPP1 - OPP50 */
-	OPP_INITIALIZER("iva", true,  260000000, OMAP3630_VDD_MPU_OPP50_UV),
-	/* DSP OPP2 - OPP100 */
-	OPP_INITIALIZER("iva", true,  520000000, OMAP3630_VDD_MPU_OPP100_UV),
-	/* DSP OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("iva", false, 660000000, OMAP3630_VDD_MPU_OPP120_UV),
-	/* DSP OPP4 - OPP-SB */
-	OPP_INITIALIZER("iva", false, 800000000, OMAP3630_VDD_MPU_OPP1G_UV),
-};
-
-/**
- * omap3_opp_init() - initialize omap3 opp table
- */
-int __init omap3_opp_init(void)
-{
-	int r = -ENODEV;
-
-	if (!cpu_is_omap34xx())
-		return r;
-
-	if (cpu_is_omap3630())
-		r = omap_init_opp_table(omap36xx_opp_def_list,
-			ARRAY_SIZE(omap36xx_opp_def_list));
-	else
-		r = omap_init_opp_table(omap34xx_opp_def_list,
-			ARRAY_SIZE(omap34xx_opp_def_list));
-
-	return r;
-}
-omap_device_initcall(omap3_opp_init);
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -63,29 +63,6 @@ struct omap_volt_data omap443x_vdd_core_volt_data[] = {
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
-
-static struct omap_opp_def __initdata omap443x_opp_def_list[] = {
-	/* MPU OPP1 - OPP50 */
-	OPP_INITIALIZER("mpu", true, 300000000, OMAP4430_VDD_MPU_OPP50_UV),
-	/* MPU OPP2 - OPP100 */
-	OPP_INITIALIZER("mpu", true, 600000000, OMAP4430_VDD_MPU_OPP100_UV),
-	/* MPU OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("mpu", true, 800000000, OMAP4430_VDD_MPU_OPPTURBO_UV),
-	/* MPU OPP4 - OPP-SB */
-	OPP_INITIALIZER("mpu", true, 1008000000, OMAP4430_VDD_MPU_OPPNITRO_UV),
-	/* L3 OPP1 - OPP50 */
-	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430_VDD_CORE_OPP50_UV),
-	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
-	OPP_INITIALIZER("l3_main_1", true, 200000000, OMAP4430_VDD_CORE_OPP100_UV),
-	/* IVA OPP1 - OPP50 */
-	OPP_INITIALIZER("iva", true, 133000000, OMAP4430_VDD_IVA_OPP50_UV),
-	/* IVA OPP2 - OPP100 */
-	OPP_INITIALIZER("iva", true, 266100000, OMAP4430_VDD_IVA_OPP100_UV),
-	/* IVA OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("iva", false, 332000000, OMAP4430_VDD_IVA_OPPTURBO_UV),
-	/* TODO: add DSP, aess, fdif, gpu */
-};
-
 #define OMAP4460_VDD_MPU_OPP50_UV		1025000
 #define OMAP4460_VDD_MPU_OPP100_UV		1200000
 #define OMAP4460_VDD_MPU_OPPTURBO_UV		1313000
@@ -122,59 +99,3 @@ struct omap_volt_data omap446x_vdd_core_volt_data[] = {
 	VOLT_DATA_DEFINE(OMAP4460_VDD_CORE_OPP100_OV_UV, OMAP44XX_CONTROL_FUSE_CORE_OPP100OV, 0xf9, 0x16),
 	VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
-
-static struct omap_opp_def __initdata omap446x_opp_def_list[] = {
-	/* MPU OPP1 - OPP50 */
-	OPP_INITIALIZER("mpu", true, 350000000, OMAP4460_VDD_MPU_OPP50_UV),
-	/* MPU OPP2 - OPP100 */
-	OPP_INITIALIZER("mpu", true, 700000000, OMAP4460_VDD_MPU_OPP100_UV),
-	/* MPU OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("mpu", true, 920000000, OMAP4460_VDD_MPU_OPPTURBO_UV),
-	/*
-	 * MPU OPP4 - OPP-Nitro + Disabled as the reference schematics
-	 * recommends TPS623631 - confirm and enable the opp in board file
-	 * XXX: May be we should enable these based on mpu capability and
-	 * Exception board files disable it...
-	 */
-	OPP_INITIALIZER("mpu", false, 1200000000, OMAP4460_VDD_MPU_OPPNITRO_UV),
-	/* MPU OPP4 - OPP-Nitro SpeedBin */
-	OPP_INITIALIZER("mpu", false, 1500000000, OMAP4460_VDD_MPU_OPPNITRO_UV),
-	/* L3 OPP1 - OPP50 */
-	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4460_VDD_CORE_OPP50_UV),
-	/* L3 OPP2 - OPP100 */
-	OPP_INITIALIZER("l3_main_1", true, 200000000, OMAP4460_VDD_CORE_OPP100_UV),
-	/* IVA OPP1 - OPP50 */
-	OPP_INITIALIZER("iva", true, 133000000, OMAP4460_VDD_IVA_OPP50_UV),
-	/* IVA OPP2 - OPP100 */
-	OPP_INITIALIZER("iva", true, 266100000, OMAP4460_VDD_IVA_OPP100_UV),
-	/*
-	 * IVA OPP3 - OPP-Turbo + Disabled as the reference schematics
-	 * recommends Phoenix VCORE2 which can supply only 600mA - so the ones
-	 * above this OPP frequency, even though OMAP is capable, should be
-	 * enabled by board file which is sure of the chip power capability
-	 */
-	OPP_INITIALIZER("iva", false, 332000000, OMAP4460_VDD_IVA_OPPTURBO_UV),
-	/* IVA OPP4 - OPP-Nitro */
-	OPP_INITIALIZER("iva", false, 430000000, OMAP4460_VDD_IVA_OPPNITRO_UV),
-	/* IVA OPP5 - OPP-Nitro SpeedBin*/
-	OPP_INITIALIZER("iva", false, 500000000, OMAP4460_VDD_IVA_OPPNITRO_UV),
-
-	/* TODO: add DSP, aess, fdif, gpu */
-};
-
-/**
- * omap4_opp_init() - initialize omap4 opp table
- */
-int __init omap4_opp_init(void)
-{
-	int r = -ENODEV;
-
-	if (cpu_is_omap443x())
-		r = omap_init_opp_table(omap443x_opp_def_list,
-			ARRAY_SIZE(omap443x_opp_def_list));
-	else if (cpu_is_omap446x())
-		r = omap_init_opp_table(omap446x_opp_def_list,
-			ARRAY_SIZE(omap446x_opp_def_list));
-	return r;
-}
-omap_device_initcall(omap4_opp_init);
-- 
2.13.0
