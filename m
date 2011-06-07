From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip/voltdm_nm][PATCH 08/10] OMAP3+: PM: introduce a central pmic control
Date: Mon,  6 Jun 2011 21:16:11 -0500
Message-ID: <1307412972-25854-9-git-send-email-nm@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34712 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756861Ab1FGCQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 22:16:39 -0400
Received: by mail-gx0-f173.google.com with SMTP id 26so2065424gxk.4
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 19:16:38 -0700 (PDT)
In-Reply-To: <1307412972-25854-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Since we are starting to use multiple PMICs in various combinations,
use the existing .omap_chip = OMAP_CHIP_INIT() to mark the
structures we are interested in using per OMAP device we
are currently running on. This mapping is based on the default
device recommendations from TI. Boards using custom PMICs now
have an opportunity to register their own custom mapping.

With this we no longer need omap4_twl_init and omap3_twl_int
instead we introduce a registration mechanism which is PMIC
generic and move twl implementation to use the same. This allows
for future OMAP4460 support where there is a mixture of
PMIC combinations used.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    2 +-
 arch/arm/mach-omap2/omap_pmic.c |   74 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_twl.c  |   86 ++++++++++++++++++++++-----------------
 arch/arm/mach-omap2/pm.c        |    5 +-
 arch/arm/mach-omap2/pm.h        |   35 +++++++++++++---
 5 files changed, 155 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_pmic.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2cbef35..66a6b6d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
-	 common.o gpio.o dma.o wd_timer.o
+	 common.o gpio.o dma.o wd_timer.o omap_pmic.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/omap_pmic.c b/arch/arm/mach-omap2/omap_pmic.c
new file mode 100644
index 0000000..c11003c
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_pmic.c
@@ -0,0 +1,74 @@
+/*
+ * Registration hooks for PMICs used with OMAP
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *	Nishanth Menon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include "voltage.h"
+
+#include "pm.h"
+
+/**
+ * omap_pmic_data_init() - trigger point for all PMIC initializers
+ */
+void __init omap_pmic_data_init(void)
+{
+	omap_twl_init();
+}
+
+/**
+ * omap_pmic_register_data() - Register the PMIC information to OMAP mapping
+ * @omap_pmic_maps:	array ending with a empty element representing the maps
+ */
+int __init omap_pmic_register_data(struct omap_pmic_map *omap_pmic_maps)
+{
+	struct voltagedomain *voltdm;
+	struct omap_pmic_map *map;
+	int r;
+
+	if (!omap_pmic_maps)
+		return 0;
+
+	map = omap_pmic_maps;
+
+	while (map->name) {
+		if (!omap_chip_is(map->omap_chip))
+			goto next;
+
+		voltdm = voltdm_lookup(map->name);
+		if (IS_ERR_OR_NULL(voltdm)) {
+			pr_err("%s: unable to find map %s\n", __func__,
+				map->name);
+			goto next;
+		}
+		if (IS_ERR_OR_NULL(map->pmic_data)) {
+			pr_warning("%s: domain[%s] has no pmic data\n",
+					__func__, map->name);
+			goto next;
+		}
+
+		r = omap_voltage_register_pmic(voltdm, map->pmic_data);
+		if (r) {
+			pr_warning("%s: domain[%s] register returned %d\n",
+					__func__, map->name, r);
+			goto next;
+		}
+		if (map->special_action) {
+			r = map->special_action(voltdm);
+			WARN(r, "%s: domain[%s] action returned %d\n", __func__,
+				map->name, r);
+		}
+next:
+		map++;
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index df4e7c3..e8815aa 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -245,38 +245,9 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
 
-int __init omap4_twl_init(void)
+static int __init twl_set_sr(struct voltagedomain *voltdm)
 {
-	struct voltagedomain *voltdm;
-
-	if (!cpu_is_omap44xx())
-		return -ENODEV;
-
-	voltdm = voltdm_lookup("mpu");
-	omap_voltage_register_pmic(voltdm, &omap4_mpu_pmic);
-
-	voltdm = voltdm_lookup("iva");
-	omap_voltage_register_pmic(voltdm, &omap4_iva_pmic);
-
-	voltdm = voltdm_lookup("core");
-	omap_voltage_register_pmic(voltdm, &omap4_core_pmic);
-
-	return 0;
-}
-
-int __init omap3_twl_init(void)
-{
-	struct voltagedomain *voltdm;
-
-	if (!cpu_is_omap34xx())
-		return -ENODEV;
-
-	if (cpu_is_omap3630()) {
-		omap3_mpu_pmic.vp_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
-		omap3_mpu_pmic.vp_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
-		omap3_core_pmic.vp_vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
-		omap3_core_pmic.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
-	}
+	int r = 0;
 
 	/*
 	 * The smartreflex bit on twl4030 specifies if the setting of voltage
@@ -288,15 +259,56 @@ int __init omap3_twl_init(void)
 	 * voltage scaling will not function on TWL over I2C_SR.
 	 */
 	if (!twl_sr_enable_autoinit)
-		omap3_twl_set_sr_bit(true);
+		r = omap3_twl_set_sr_bit(true);
+	return r;
+}
 
-	voltdm = voltdm_lookup("mpu_iva");
-	omap_voltage_register_pmic(voltdm, &omap3_mpu_pmic);
+#define OMAP3_TWL4030_USED	(CHIP_GE_OMAP3430ES2 |	\
+				CHIP_GE_OMAP3630ES1_1 |	\
+				CHIP_IS_OMAP3630ES1)
+
+static __initdata struct omap_pmic_map omap_twl_map[] = {
+	{
+		.name = "mpu_iva",
+		.omap_chip = OMAP_CHIP_INIT(OMAP3_TWL4030_USED),
+		.pmic_data = &omap3_mpu_pmic,
+		.special_action = twl_set_sr,
+	},
+	{
+		.name = "core",
+		.omap_chip = OMAP_CHIP_INIT(OMAP3_TWL4030_USED),
+		.pmic_data = &omap3_core_pmic,
+	},
+	{
+		.name = "mpu",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+		.pmic_data = &omap4_mpu_pmic,
+	},
+	{
+		.name = "core",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+		.pmic_data = &omap4_core_pmic,
+	},
+	{
+		.name = "iva",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+		.pmic_data = &omap4_iva_pmic,
+	},
+	/* Terminator */
+	{ .name = NULL, .pmic_data = NULL},
+};
 
-	voltdm = voltdm_lookup("core");
-	omap_voltage_register_pmic(voltdm, &omap3_core_pmic);
+int __init omap_twl_init(void)
+{
+	/* Reuse OMAP3430 values */
+	if (cpu_is_omap3630()) {
+		omap3_mpu_pmic.vp_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
+		omap3_mpu_pmic.vp_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
+		omap3_core_pmic.vp_vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
+		omap3_core_pmic.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
+	}
 
-	return 0;
+	return omap_pmic_register_data(omap_twl_map);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index c6355e4..d085f29 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -251,9 +251,8 @@ postcore_initcall(omap2_common_pm_init);
 
 static int __init omap2_common_pm_late_init(void)
 {
-	/* Init the OMAP TWL parameters */
-	omap3_twl_init();
-	omap4_twl_init();
+	/* Init the OMAP PMIC parameters */
+	omap_pmic_data_init();
 
 	/* Init the voltage layer */
 	omap_voltage_late_init();
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 45bcfce..7f4fe9a 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -125,16 +125,39 @@ static inline int omap_devinit_smartreflex(void)
 static inline void omap_enable_smartreflex_on_init(void) {}
 #endif
 
-#ifdef CONFIG_TWL4030_CORE
-extern int omap3_twl_init(void);
-extern int omap4_twl_init(void);
-extern int omap3_twl_set_sr_bit(bool enable);
+/**
+ * struct omap_pmic_map - Describe the OMAP PMIC data for OMAP
+ * @name:	name of the voltage domain
+ * @pmic_data:	pmic data associated with it
+ * @omap_chip:	initialize with OMAP_CHIP_INIT the OMAP chips this data maps to
+ * @special_action: callback for any specific action to take for that map
+ *
+ * Since we support multiple PMICs each potentially functioning on multiple
+ * OMAP devices, we describe the parameters in a map allowing us to reuse the
+ * data as necessary.
+ */
+struct omap_pmic_map {
+	char			*name;
+	struct omap_voltdm_pmic	*pmic_data;
+	struct omap_chip_id	omap_chip;
+	int			(*special_action)(struct voltagedomain *);
+};
+
+#ifdef CONFIG_PM
+extern int omap_pmic_register_data(struct omap_pmic_map *map);
 #else
-static inline int omap3_twl_init(void)
+static inline int omap_pmic_register_data(struct omap_pmic_map *map)
 {
 	return -EINVAL;
 }
-static inline int omap4_twl_init(void)
+#endif
+extern void omap_pmic_data_init(void);
+
+#ifdef CONFIG_TWL4030_CORE
+extern int omap_twl_init(void);
+extern int omap3_twl_set_sr_bit(bool enable);
+#else
+static inline int omap_twl_init(void)
 {
 	return -EINVAL;
 }
-- 
1.7.1

