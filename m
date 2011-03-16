From: Sanjeev Premi <premi@ti.com>
Subject: [RFCv2 1/2] OMAP3: Add support for TPS65023 (AM35x only)
Date: Wed, 16 Mar 2011 13:02:02 +0530
Message-ID: <1300260723-19422-2-git-send-email-premi@ti.com>
References: <1300260723-19422-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37355 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083Ab1CPHcU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 03:32:20 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2G7WGI6019750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 02:32:19 -0500
In-Reply-To: <1300260723-19422-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds support for TPS65023 used with
OMAP3 devices. The PMIC is currently hooked to
AM35x devices, but can easily be extended for
other OMAP3 devices.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/Makefile        |    3 +-
 arch/arm/mach-omap2/pm.c            |    1 +
 arch/arm/mach-omap2/pm.h            |    9 ++++
 arch/arm/mach-omap2/pmic_tps65023.c |   82 +++++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pmic_tps65023.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ac2155d..33d7bc2 100755
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -19,7 +19,8 @@ obj-$(CONFIG_ARCH_TI81XX) += $(omap-2-3-common) $(hwmod-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
-obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
+obj-$(CONFIG_TWL4030_CORE)		+= omap_twl.o
+obj-$(CONFIG_REGULATOR_TPS65023)	+= pmic_tps65023.o
 
 # SMP support ONLY available for OMAP4
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index a0f9f61..6d3d4c3 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -366,6 +366,7 @@ static int __init omap2_common_pm_late_init(void)
 	/* Init the OMAP TWL parameters */
 	omap3_twl_init();
 	omap4_twl_init();
+	omap3_tps65023_init();
 
 	/* Init the voltage layer */
 	omap_voltage_late_init();
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index c98be66..fc575ed 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -139,6 +139,15 @@ static inline int omap4_twl_init(void)
 }
 #endif
 
+#ifdef CONFIG_REGULATOR_TPS65023
+extern int omap3_tps65023_init(void);
+#else
+static inline int omap3_tps65023_init(void)
+{
+       return -EINVAL;
+}
+#endif
+
 #ifndef CONFIG_SUSPEND
 #define omap_pm_ops NULL
 #endif
diff --git a/arch/arm/mach-omap2/pmic_tps65023.c b/arch/arm/mach-omap2/pmic_tps65023.c
new file mode 100644
index 0000000..b4d185d
--- /dev/null
+++ b/arch/arm/mach-omap2/pmic_tps65023.c
@@ -0,0 +1,82 @@
+/**
+ * Implements support for TPS65023
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/i2c/twl.h>
+
+#include <plat/voltage.h>
+
+#include "pm.h"
+
+#define	TPS65023_VDCDC1_MIN		800000	/* 0.8V		*/
+#define	TPS65023_VDCDC1_STEP		25000	/* 0.025V	*/
+
+
+/*
+ * Get voltage corresponding to specified vsel value using this formula:
+ *	Vout = 0.8V + (25mV x Vsel)
+ */
+static unsigned long tps65023_vsel_to_uv(const u8 vsel)
+{
+	return (TPS65023_VDCDC1_MIN + (TPS65023_VDCDC1_STEP * vsel));
+}
+
+/*
+ * Get vsel value corresponding to specified voltage using this formula:
+ *	Vsel = (Vout - 0.8V)/ 25mV
+ */
+static u8 tps65023_uv_to_vsel(unsigned long uv)
+{
+	return DIV_ROUND_UP(uv - TPS65023_VDCDC1_MIN, TPS65023_VDCDC1_STEP);
+}
+
+/*
+ * TPS65023 is currently supported only for AM35x devices.
+ * Therefore, implementation below is specific to this device pair.
+ */
+
+/**
+ * Voltage information related to the MPU voltage domain of the
+ * AM35x processors - in relation to the TPS65023.
+ */
+static struct omap_volt_pmic_info tps65023_am35xx_mpu_volt_info = {
+	.step_size		= 25000,
+	.on_volt                = 1200000,
+	.vsel_to_uv		= tps65023_vsel_to_uv,
+	.uv_to_vsel		= tps65023_uv_to_vsel,
+};
+
+int __init omap3_tps65023_init(void)
+{
+	struct voltagedomain *voltdm;
+
+	if (!cpu_is_omap34xx())
+		return -ENODEV;
+
+	if (cpu_is_omap3505() || cpu_is_omap3517()) {
+		voltdm = omap_voltage_domain_lookup("mpu");
+		omap_voltage_register_pmic(voltdm, &tps65023_am35xx_mpu_volt_info);
+		voltdm = omap_voltage_domain_lookup("core");
+		omap_voltage_register_pmic(voltdm, &tps65023_am35xx_mpu_volt_info);
+	} else {
+		/* TODO:
+		 * Support for other devices that support TPS65023
+		 */
+	}
+
+	return 0;
+}
-- 
1.7.2.2

