From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v6 08/10] OMAP3: PM: Register TWL4030 pmic info with the voltage driver.
Date: Mon, 20 Dec 2010 22:29:15 +0530
Message-ID: <1292864357-13939-9-git-send-email-thara@ti.com>
References: <1292864357-13939-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37658 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932891Ab0LTQ7m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 11:59:42 -0500
In-Reply-To: <1292864357-13939-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com, Thara Gopinath <thara@ti.com>

This patch registers the TWL4030 PMIC specific informtion
with the voltage driver. Failing this patch the voltage driver
is unware of the formula to use for vsel to voltage and vice versa
conversion and lot of other PMIC dependent parameters.

This file is based on the arch/arm/plat-omap opp_twl_tpl.c file
by Paul Walmsley. The original file is replaced by this file.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/Makefile   |    2 +
 arch/arm/mach-omap2/omap_twl.c |  111 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c       |    4 ++
 arch/arm/mach-omap2/pm.h       |   10 ++++
 4 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_twl.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1963f9e..ae29a00 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
+obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
+
 # SMP support ONLY available for OMAP4
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
new file mode 100644
index 0000000..b8f0874
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -0,0 +1,111 @@
+/**
+ * OMAP and TWL PMIC specific intializations.
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated.
+ * Thara Gopinath
+ * Copyright (C) 2009 Texas Instruments Incorporated.
+ * Nishanth Menon
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+
+#include <plat/voltage.h>
+
+#define OMAP3_SRI2C_SLAVE_ADDR		0x12
+#define OMAP3_VDD_MPU_SR_CONTROL_REG	0x00
+#define OMAP3_VDD_CORE_SR_CONTROL_REG	0x01
+#define OMAP3_VP_CONFIG_ERROROFFSET	0x00
+#define OMAP3_VP_VSTEPMIN_VSTEPMIN	0x1
+#define OMAP3_VP_VSTEPMAX_VSTEPMAX	0x04
+#define OMAP3_VP_VLIMITTO_TIMEOUT_US	200
+
+#define OMAP3430_VP1_VLIMITTO_VDDMIN	0x14
+#define OMAP3430_VP1_VLIMITTO_VDDMAX	0x42
+#define OMAP3430_VP2_VLIMITTO_VDDMIN	0x18
+#define OMAP3430_VP2_VLIMITTO_VDDMAX	0x2c
+
+#define OMAP3630_VP1_VLIMITTO_VDDMIN	0x18
+#define OMAP3630_VP1_VLIMITTO_VDDMAX	0x3c
+#define OMAP3630_VP2_VLIMITTO_VDDMIN	0x18
+#define OMAP3630_VP2_VLIMITTO_VDDMAX	0x30
+
+unsigned long twl4030_vsel_to_uv(const u8 vsel)
+{
+	return (((vsel * 125) + 6000)) * 100;
+}
+
+u8 twl4030_uv_to_vsel(unsigned long uv)
+{
+	return DIV_ROUND_UP(uv - 600000, 12500);
+}
+
+static struct omap_volt_pmic_info omap3_mpu_volt_info = {
+	.slew_rate		= 4000,
+	.step_size		= 12500,
+	.on_volt		= 1200000,
+	.onlp_volt		= 1000000,
+	.ret_volt		= 975000,
+	.off_volt		= 600000,
+	.volt_setup_time	= 0xfff,
+	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
+	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
+	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
+	.vp_vddmin		= OMAP3430_VP1_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP3430_VP1_VLIMITTO_VDDMAX,
+	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
+	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
+	.pmic_reg		= OMAP3_VDD_MPU_SR_CONTROL_REG,
+	.vsel_to_uv		= twl4030_vsel_to_uv,
+	.uv_to_vsel		= twl4030_uv_to_vsel,
+};
+
+static struct omap_volt_pmic_info omap3_core_volt_info = {
+	.slew_rate		= 4000,
+	.step_size		= 12500,
+	.on_volt                = 1200000,
+	.onlp_volt              = 1000000,
+	.ret_volt               = 975000,
+	.off_volt               = 600000,
+	.volt_setup_time        = 0xfff,
+	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
+	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
+	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
+	.vp_vddmin		= OMAP3430_VP2_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP3430_VP2_VLIMITTO_VDDMAX,
+	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
+	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
+	.pmic_reg		= OMAP3_VDD_CORE_SR_CONTROL_REG,
+	.vsel_to_uv		= twl4030_vsel_to_uv,
+	.uv_to_vsel		= twl4030_uv_to_vsel,
+};
+
+int __init omap3_twl_init(void)
+{
+	struct voltagedomain *voltdm;
+
+	if (!cpu_is_omap34xx())
+		return -ENODEV;
+
+	if (cpu_is_omap3630()) {
+		omap3_mpu_volt_info.vp_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
+		omap3_mpu_volt_info.vp_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
+		omap3_core_volt_info.vp_vddmin = OMAP3630_VP2_VLIMITTO_VDDMIN;
+		omap3_core_volt_info.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
+	}
+
+	voltdm = omap_voltage_domain_lookup("mpu");
+	omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
+
+	voltdm = omap_voltage_domain_lookup("core");
+	omap_voltage_register_pmic(voltdm, &omap3_core_volt_info);
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index a05f590..e84f46b 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -149,7 +149,11 @@ postcore_initcall(omap2_common_pm_init);
 
 static int __init omap2_common_pm_late_init(void)
 {
+	/* Init the OMAP TWL parameters */
+	omap3_twl_init();
+	/* Init the voltage layer */
 	omap_voltage_late_init();
+	/* Smartreflex device init */
 	omap_devinit_smartreflex();
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 77d3ec2..619db1b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -112,4 +112,14 @@ static inline int omap_devinit_smartreflex(void)
 
 static inline void omap_enable_smartreflex_on_init(void) {}
 #endif
+
+#ifdef CONFIG_TWL4030_CORE
+extern int omap3_twl_init(void);
+#else
+static inline int omap3_twl_init(void)
+{
+	return -EINVAL;
+}
+#endif
+
 #endif
-- 
1.7.0.4

