From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC 07/13] ARM: OMAP2+: CM: AM43x clockdomain data
Date: Thu, 11 Jul 2013 12:06:12 +0530
Message-ID: <cc28ac4f840bdef5816423b576af623972b137d9.1373519192.git.afzal@ti.com>
References: <cover.1373519192.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35802 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab3GKGgl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 02:36:41 -0400
In-Reply-To: <cover.1373519192.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>, Ambresh K <ambresh@ti.com>

From: Ambresh K <ambresh@ti.com>

Add the data file to describe clock domains in AM43x SoC.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

Note: domain operations to be used would have to modified as mentioned in
	the cover letter

 arch/arm/mach-omap2/clockdomain.h           |   1 +
 arch/arm/mach-omap2/clockdomains43xx_data.c | 199 ++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 arch/arm/mach-omap2/clockdomains43xx_data.c

diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 8c22ce6..3b61557 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -215,6 +215,7 @@ extern void __init omap242x_clockdomains_init(void);
 extern void __init omap243x_clockdomains_init(void);
 extern void __init omap3xxx_clockdomains_init(void);
 extern void __init am33xx_clockdomains_init(void);
+extern void am43xx_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
 extern void __init omap54xx_clockdomains_init(void);
 
diff --git a/arch/arm/mach-omap2/clockdomains43xx_data.c b/arch/arm/mach-omap2/clockdomains43xx_data.c
new file mode 100644
index 0000000..5ddc010
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains43xx_data.c
@@ -0,0 +1,199 @@
+/*
+ * AM43xx Clock domains framework
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This file is made by modifying the file generated automatically
+ * from the OMAP hardware databases.
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
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
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
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain tamper_43xx_clkdm = {
+	.name		  = "tamper_clkdm",
+	.pwrdm		  = { .name = "tamper_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_TAMPER_INST,
+	.clkdm_offs	  = AM43XX_CM_TAMPER_TAMPER_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain l4_rtc_43xx_clkdm = {
+	.name		  = "l4_rtc_clkdm",
+	.pwrdm		  = { .name = "rtc_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_RTC_INST,
+	.clkdm_offs	  = AM43XX_CM_RTC_RTC_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain pruss_ocp_43xx_clkdm = {
+	.name		  = "pruss_ocp_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_ICSS_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain ocpwp_l3_43xx_clkdm = {
+	.name		  = "ocpwp_l3_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_OCPWP_L3_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain l3s_tsc_43xx_clkdm = {
+	.name		  = "l3s_tsc_clkdm",
+	.pwrdm		  = { .name = "wkup_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_WKUP_INST,
+	.clkdm_offs	  = AM43XX_CM_WKUP_L3S_TSC_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain dss_43xx_clkdm = {
+	.name		  = "dss_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_DSS_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain l3_aon_43xx_clkdm = {
+	.name		  = "l3_aon_clkdm",
+	.pwrdm		  = { .name = "wkup_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_WKUP_INST,
+	.clkdm_offs	  = AM43XX_CM_WKUP_L3_AON_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain emif_43xx_clkdm = {
+	.name		  = "emif_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_EMIF_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
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
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain l4_wkup_43xx_clkdm = {
+	.name		  = "l4_wkup_clkdm",
+	.pwrdm		  = { .name = "wkup_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_WKUP_INST,
+	.clkdm_offs	  = AM43XX_CM_WKUP_WKUP_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain cpsw_125mhz_43xx_clkdm = {
+	.name		  = "cpsw_125mhz_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_CPSW_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain gfx_l3_43xx_clkdm = {
+	.name		  = "gfx_l3_clkdm",
+	.pwrdm		  = { .name = "gfx_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_GFX_INST,
+	.clkdm_offs	  = AM43XX_CM_GFX_GFX_L3_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
+};
+
+static struct clockdomain l3s_43xx_clkdm = {
+	.name		  = "l3s_clkdm",
+	.pwrdm		  = { .name = "per_pwrdm" },
+	.prcm_partition	  = AM43XX_CM_PARTITION,
+	.cm_inst	  = AM43XX_CM_PER_INST,
+	.clkdm_offs	  = AM43XX_CM_PER_L3S_CDOFFS,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_FORCE_SLEEP,
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
+	clkdm_register_platform_funcs(&omap4_clkdm_operations);
+	clkdm_register_clkdms(clockdomains_am43xx);
+	clkdm_complete_init();
+}
-- 
1.8.3.1

