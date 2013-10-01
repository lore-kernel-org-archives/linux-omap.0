From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 07/11] ARM: OMAP2+: CM: AM43x clockdomain data
Date: Tue, 1 Oct 2013 12:37:58 +0530
Message-ID: <a5dd6d51f8908301e1c664c0b94e61a52e734a08.1380608720.git.afzal@ti.com>
References: <cover.1380608719.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46957 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350Ab3JAHI2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Oct 2013 03:08:28 -0400
In-Reply-To: <cover.1380608719.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Ambresh K <ambresh@ti.com>

From: Ambresh K <ambresh@ti.com>

Add the data file to describe clock domains in AM43x SoC.
OMAP4 clockdomain operations is being reused here.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/clockdomain.h           |   2 +
 arch/arm/mach-omap2/clockdomains43xx_data.c | 196 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cminst44xx.c            |   9 ++
 3 files changed, 207 insertions(+)
 create mode 100644 arch/arm/mach-omap2/clockdomains43xx_data.c

diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 5431b0c..f17f006 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -218,6 +218,7 @@ extern void __init am33xx_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
 extern void __init omap54xx_clockdomains_init(void);
 extern void __init dra7xx_clockdomains_init(void);
+void am43xx_clockdomains_init(void);
 
 extern void clkdm_add_autodeps(struct clockdomain *clkdm);
 extern void clkdm_del_autodeps(struct clockdomain *clkdm);
@@ -226,6 +227,7 @@ extern struct clkdm_ops omap2_clkdm_operations;
 extern struct clkdm_ops omap3_clkdm_operations;
 extern struct clkdm_ops omap4_clkdm_operations;
 extern struct clkdm_ops am33xx_clkdm_operations;
+extern struct clkdm_ops am43xx_clkdm_operations;
 
 extern struct clkdm_dep gfx_24xx_wkdeps[];
 extern struct clkdm_dep dsp_24xx_wkdeps[];
diff --git a/arch/arm/mach-omap2/clockdomains43xx_data.c b/arch/arm/mach-omap2/clockdomains43xx_data.c
new file mode 100644
index 0000000..6d71c60
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains43xx_data.c
@@ -0,0 +1,196 @@
+/*
+ * AM43xx Clock domains framework
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+#include "prcm44xx.h"
+#include "prcm43xx.h"
+
+static struct clockdomain l4_cefuse_43xx_clkdm = {
+	.name		  = "l4_cefuse_clkdm",
+	.pwrdm		  = { .name = "cefuse_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_CEFUSE_INST,
+	.clkdm_offs	  = AM43XX_CM_CEFUSE_CEFUSE_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain mpu_43xx_clkdm = {
+	.name		  = "mpu_clkdm",
+	.pwrdm		  = { .name = "mpu_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_MPU_INST,
+	.clkdm_offs	  = AM43XX_CM_MPU_MPU_CDOFFS,
+	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain l4ls_43xx_clkdm = {
+	.name		  = "l4ls_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_L4LS_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain tamper_43xx_clkdm = {
+	.name		  = "tamper_clkdm",
+	.pwrdm		  = { .name = "tamper_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_TAMPER_INST,
+	.clkdm_offs	  = AM43XX_CM_TAMPER_TAMPER_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain l4_rtc_43xx_clkdm = {
+	.name		  = "l4_rtc_clkdm",
+	.pwrdm		  = { .name = "rtc_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_RTC_INST,
+	.clkdm_offs	  = AM43XX_CM_RTC_RTC_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain pruss_ocp_43xx_clkdm = {
+	.name		  = "pruss_ocp_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_ICSS_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain ocpwp_l3_43xx_clkdm = {
+	.name		  = "ocpwp_l3_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_OCPWP_L3_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain l3s_tsc_43xx_clkdm = {
+	.name		  = "l3s_tsc_clkdm",
+	.pwrdm		  = { .name = "wkup_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_WKUP_INST,
+	.clkdm_offs	  = AM43XX_CM_WKUP_L3S_TSC_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain dss_43xx_clkdm = {
+	.name		  = "dss_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_DSS_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain l3_aon_43xx_clkdm = {
+	.name		  = "l3_aon_clkdm",
+	.pwrdm		  = { .name = "wkup_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_WKUP_INST,
+	.clkdm_offs	  = AM43XX_CM_WKUP_L3_AON_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain emif_43xx_clkdm = {
+	.name		  = "emif_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_EMIF_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain l4_wkup_aon_43xx_clkdm = {
+	.name		  = "l4_wkup_aon_clkdm",
+	.pwrdm		  = { .name = "wkup_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_WKUP_INST,
+	.clkdm_offs	  = AM43XX_CM_WKUP_L4_WKUP_AON_CDOFFS,
+};
+
+static struct clockdomain l3_43xx_clkdm = {
+	.name		  = "l3_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_L3_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain l4_wkup_43xx_clkdm = {
+	.name		  = "l4_wkup_clkdm",
+	.pwrdm		  = { .name = "wkup_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_WKUP_INST,
+	.clkdm_offs	  = AM43XX_CM_WKUP_WKUP_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain cpsw_125mhz_43xx_clkdm = {
+	.name		  = "cpsw_125mhz_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_CPSW_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain gfx_l3_43xx_clkdm = {
+	.name		  = "gfx_l3_clkdm",
+	.pwrdm		  = { .name = "gfx_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_GFX_INST,
+	.clkdm_offs	  = AM43XX_CM_GFX_GFX_L3_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain l3s_43xx_clkdm = {
+	.name		  = "l3s_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_L3S_CDOFFS,
+	.flags		  = CLKDM_CAN_SWSUP,
+};
+
+static struct clockdomain *clockdomains_am43xx[] __initdata = {
+	&l4_cefuse_43xx_clkdm,
+	&mpu_43xx_clkdm,
+	&l4ls_43xx_clkdm,
+	&tamper_43xx_clkdm,
+	&l4_rtc_43xx_clkdm,
+	&pruss_ocp_43xx_clkdm,
+	&ocpwp_l3_43xx_clkdm,
+	&l3s_tsc_43xx_clkdm,
+	&dss_43xx_clkdm,
+	&l3_aon_43xx_clkdm,
+	&emif_43xx_clkdm,
+	&l4_wkup_aon_43xx_clkdm,
+	&l3_43xx_clkdm,
+	&l4_wkup_43xx_clkdm,
+	&cpsw_125mhz_43xx_clkdm,
+	&gfx_l3_43xx_clkdm,
+	&l3s_43xx_clkdm,
+	NULL
+};
+
+void __init am43xx_clockdomains_init(void)
+{
+	clkdm_register_platform_funcs(&am43xx_clkdm_operations);
+	clkdm_register_clkdms(clockdomains_am43xx);
+	clkdm_complete_init();
+}
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index e957222..731ca13 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -483,3 +483,12 @@ struct clkdm_ops omap4_clkdm_operations = {
 	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
 };
+
+struct clkdm_ops am43xx_clkdm_operations = {
+	.clkdm_sleep		= omap4_clkdm_sleep,
+	.clkdm_wakeup		= omap4_clkdm_wakeup,
+	.clkdm_allow_idle	= omap4_clkdm_allow_idle,
+	.clkdm_deny_idle	= omap4_clkdm_deny_idle,
+	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
+	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
+};
-- 
1.8.3.4

