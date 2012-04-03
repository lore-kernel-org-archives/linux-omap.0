From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 2/3] ARM: OMAP3+: clockdomain33xx: Add clockdomain data and respective operations
Date: Tue, 3 Apr 2012 18:39:37 +0530
Message-ID: <1333458578-23073-3-git-send-email-hvaibhav@ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33647 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644Ab2DCNTy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Apr 2012 09:19:54 -0400
In-Reply-To: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>

AM33XX PRCM module consist of, various clockdomains, in all
total we have 18 clockdomains available, with following
controlling options,
   - NO Sleep: sleep transition can not be initiated,
   - SW Sleep: sw forced sleep transition,
   - SW Wakeup: sw forced wakeup transition,
   - HW Auto: transitions are based upon hw conditions.

This patch adds all available clockdomain data, respective
clockdomain operations for AM33XX family of device, and also
integrates it into existing OMAP framework.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
CC: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile                |    2 +
 arch/arm/mach-omap2/clockdomain.h           |    2 +
 arch/arm/mach-omap2/clockdomain33xx.c       |   74 +++++++++
 arch/arm/mach-omap2/clockdomains33xx_data.c |  214 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/io.c                    |    1 +
 5 files changed, 293 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/clockdomains33xx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1695dc8..13838df 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -135,6 +135,8 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o \
 					   clockdomain2xxx_3xxx.o \
 					   clockdomains2xxx_3xxx_data.o \
 					   clockdomains3xxx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= clockdomain33xx.o \
+					   clockdomains33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o \
 					   clockdomain44xx.o \
 					   clockdomains44xx_data.o
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index f7b5860..72cb12b 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -195,6 +195,7 @@ int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
 extern void __init omap242x_clockdomains_init(void);
 extern void __init omap243x_clockdomains_init(void);
 extern void __init omap3xxx_clockdomains_init(void);
+extern void __init am33xx_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
 extern void _clkdm_add_autodeps(struct clockdomain *clkdm);
 extern void _clkdm_del_autodeps(struct clockdomain *clkdm);
@@ -202,6 +203,7 @@ extern void _clkdm_del_autodeps(struct clockdomain *clkdm);
 extern struct clkdm_ops omap2_clkdm_operations;
 extern struct clkdm_ops omap3_clkdm_operations;
 extern struct clkdm_ops omap4_clkdm_operations;
+extern struct clkdm_ops am33xx_clkdm_operations;

 extern struct clkdm_dep gfx_24xx_wkdeps[];
 extern struct clkdm_dep dsp_24xx_wkdeps[];
diff --git a/arch/arm/mach-omap2/clockdomain33xx.c b/arch/arm/mach-omap2/clockdomain33xx.c
new file mode 100644
index 0000000..aca6388
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomain33xx.c
@@ -0,0 +1,74 @@
+/*
+ * AM33XX clockdomain control
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Vaibhav Hiremath <hvaibhav@ti.com>
+ *
+ * Derived from mach-omap2/clockdomain44xx.c written by Rajendra Nayak
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
+#include <linux/kernel.h>
+
+#include "clockdomain.h"
+#include "cm33xx.h"
+
+
+static int am33xx_clkdm_sleep(struct clockdomain *clkdm)
+{
+	am33xx_cm_clkdm_force_sleep(clkdm->cm_inst, clkdm->clkdm_offs);
+	return 0;
+}
+
+static int am33xx_clkdm_wakeup(struct clockdomain *clkdm)
+{
+	am33xx_cm_clkdm_force_wakeup(clkdm->cm_inst, clkdm->clkdm_offs);
+	return 0;
+}
+
+static void am33xx_clkdm_allow_idle(struct clockdomain *clkdm)
+{
+	am33xx_cm_clkdm_enable_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
+}
+
+static void am33xx_clkdm_deny_idle(struct clockdomain *clkdm)
+{
+	am33xx_cm_clkdm_disable_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
+}
+
+static int am33xx_clkdm_clk_enable(struct clockdomain *clkdm)
+{
+	if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
+		return am33xx_clkdm_wakeup(clkdm);
+
+	return 0;
+}
+
+static int am33xx_clkdm_clk_disable(struct clockdomain *clkdm)
+{
+	bool hwsup = false;
+
+	hwsup = am33xx_cm_is_clkdm_in_hwsup(clkdm->cm_inst, clkdm->clkdm_offs);
+
+	if (!hwsup && (clkdm->flags & CLKDM_CAN_FORCE_SLEEP))
+		am33xx_clkdm_sleep(clkdm);
+
+	return 0;
+}
+
+struct clkdm_ops am33xx_clkdm_operations = {
+	.clkdm_sleep		= am33xx_clkdm_sleep,
+	.clkdm_wakeup		= am33xx_clkdm_wakeup,
+	.clkdm_allow_idle	= am33xx_clkdm_allow_idle,
+	.clkdm_deny_idle	= am33xx_clkdm_deny_idle,
+	.clkdm_clk_enable	= am33xx_clkdm_clk_enable,
+	.clkdm_clk_disable	= am33xx_clkdm_clk_disable,
+};
diff --git a/arch/arm/mach-omap2/clockdomains33xx_data.c b/arch/arm/mach-omap2/clockdomains33xx_data.c
new file mode 100644
index 0000000..234035c
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains33xx_data.c
@@ -0,0 +1,214 @@
+/*
+ * AM33XX Clock Domain data.
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Vaibhav Hiremath <hvaibhav@ti.com>
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
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+#include "cm.h"
+#include "cm33xx.h"
+#include "cm-regbits-33xx.h"
+
+static struct clockdomain l4ls_am33xx_clkdm = {
+	.name		= "l4ls_clkdm",
+	.pwrdm		= { .name = "per_pwrdm" },
+	.cm_inst	= AM33XX_CM_PER_MOD,
+	.clkdm_offs	= AM33XX_CM_PER_L4LS_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain l3s_am33xx_clkdm = {
+	.name		= "l3s_clkdm",
+	.pwrdm		= { .name = "per_pwrdm" },
+	.cm_inst	= AM33XX_CM_PER_MOD,
+	.clkdm_offs	= AM33XX_CM_PER_L3S_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain l4fw_am33xx_clkdm = {
+	.name		= "l4fw_clkdm",
+	.pwrdm		= { .name = "per_pwrdm" },
+	.cm_inst	= AM33XX_CM_PER_MOD,
+	.clkdm_offs	= AM33XX_CM_PER_L4FW_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain l3_am33xx_clkdm = {
+	.name		= "l3_clkdm",
+	.pwrdm		= { .name = "per_pwrdm" },
+	.cm_inst	= AM33XX_CM_PER_MOD,
+	.clkdm_offs	= AM33XX_CM_PER_L3_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain l4hs_am33xx_clkdm = {
+	.name		= "l4hs_clkdm",
+	.pwrdm		= { .name = "per_pwrdm" },
+	.cm_inst	= AM33XX_CM_PER_MOD,
+	.clkdm_offs	= AM33XX_CM_PER_L4HS_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain ocpwp_l3_am33xx_clkdm = {
+	.name		= "ocpwp_l3_clkdm",
+	.pwrdm		= { .name = "per_pwrdm" },
+	.cm_inst	= AM33XX_CM_PER_MOD,
+	.clkdm_offs	= AM33XX_CM_PER_OCPWP_L3_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain pruss_ocp_am33xx_clkdm = {
+	.name		= "pruss_ocp_clkdm",
+	.pwrdm		= { .name = "per_pwrdm" },
+	.cm_inst	= AM33XX_CM_PER_MOD,
+	.clkdm_offs	= AM33XX_CM_PER_PRUSS_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain cpsw_125mhz_am33xx_clkdm = {
+	.name		= "cpsw_125mhz_clkdm",
+	.pwrdm		= { .name = "per_pwrdm" },
+	.cm_inst	= AM33XX_CM_PER_MOD,
+	.clkdm_offs	= AM33XX_CM_PER_CPSW_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain lcdc_am33xx_clkdm = {
+	.name		= "lcdc_clkdm",
+	.pwrdm		= { .name = "per_pwrdm" },
+	.cm_inst	= AM33XX_CM_PER_MOD,
+	.clkdm_offs	= AM33XX_CM_PER_LCDC_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain clk_24mhz_am33xx_clkdm = {
+	.name		= "clk_24mhz_clkdm",
+	.pwrdm		= { .name = "per_pwrdm" },
+	.cm_inst	= AM33XX_CM_PER_MOD,
+	.clkdm_offs	= AM33XX_CM_PER_CLK_24MHZ_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain l4_wkup_am33xx_clkdm = {
+	.name		= "l4_wkup_clkdm",
+	.pwrdm		= { .name = "wkup_pwrdm" },
+	.cm_inst	= AM33XX_CM_WKUP_MOD,
+	.clkdm_offs	= AM33XX_CM_WKUP_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain l3_aon_am33xx_clkdm = {
+	.name		= "l3_aon_clkdm",
+	.pwrdm		= { .name = "wkup_pwrdm" },
+	.cm_inst	= AM33XX_CM_WKUP_MOD,
+	.clkdm_offs	= AM33XX_CM_L3_AON_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain l4_wkup_aon_am33xx_clkdm = {
+	.name		= "l4_wkup_aon_clkdm",
+	.pwrdm		= { .name = "wkup_pwrdm" },
+	.cm_inst	= AM33XX_CM_WKUP_MOD,
+	.clkdm_offs	= AM33XX_CM_L4_WKUP_AON_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain mpu_am33xx_clkdm = {
+	.name		= "mpu_clkdm",
+	.pwrdm		= { .name = "mpu_pwrdm" },
+	.cm_inst	= AM33XX_CM_MPU_MOD,
+	.clkdm_offs	= AM33XX_CM_MPU_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain l4_rtc_am33xx_clkdm = {
+	.name		= "l4_rtc_clkdm",
+	.pwrdm		= { .name = "rtc_pwrdm" },
+	.cm_inst	= AM33XX_CM_RTC_MOD,
+	.clkdm_offs	= AM33XX_CM_RTC_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain gfx_l3_am33xx_clkdm = {
+	.name		= "gfx_l3_clkdm",
+	.pwrdm		= { .name = "gfx_pwrdm" },
+	.cm_inst	= AM33XX_CM_GFX_MOD,
+	.clkdm_offs	= AM33XX_CM_GFX_L3_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain gfx_l4ls_gfx_am33xx_clkdm = {
+	.name		= "gfx_l4ls_gfx_clkdm",
+	.pwrdm		= { .name = "gfx_pwrdm" },
+	.cm_inst	= AM33XX_CM_GFX_MOD,
+	.clkdm_offs	= AM33XX_CM_GFX_L4LS_GFX_CLKSTCTRL__1_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain l4_cefuse_am33xx_clkdm = {
+	.name		= "l4_cefuse_clkdm",
+	.pwrdm		= { .name = "cefuse_pwrdm" },
+	.cm_inst	= AM33XX_CM_CEFUSE_MOD,
+	.clkdm_offs	= AM33XX_CM_CEFUSE_CLKSTCTRL_OFFSET,
+	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
+	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
+};
+
+static struct clockdomain *clockdomains_am33xx[] __initdata = {
+	&l4ls_am33xx_clkdm,
+	&l3s_am33xx_clkdm,
+	&l4fw_am33xx_clkdm,
+	&l3_am33xx_clkdm,
+	&l4hs_am33xx_clkdm,
+	&ocpwp_l3_am33xx_clkdm,
+	&pruss_ocp_am33xx_clkdm,
+	&cpsw_125mhz_am33xx_clkdm,
+	&lcdc_am33xx_clkdm,
+	&clk_24mhz_am33xx_clkdm,
+	&l4_wkup_am33xx_clkdm,
+	&l3_aon_am33xx_clkdm,
+	&l4_wkup_aon_am33xx_clkdm,
+	&mpu_am33xx_clkdm,
+	&l4_rtc_am33xx_clkdm,
+	&gfx_l3_am33xx_clkdm,
+	&gfx_l4ls_gfx_am33xx_clkdm,
+	&l4_cefuse_am33xx_clkdm,
+	NULL,
+};
+
+void __init am33xx_clockdomains_init(void)
+{
+	clkdm_register_platform_funcs(&am33xx_clkdm_operations);
+	clkdm_register_clkdms(clockdomains_am33xx);
+	clkdm_complete_init();
+}
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b594918..be08dc7 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -474,6 +474,7 @@ void __init am33xx_init_early(void)
 	omap_common_init_early();
 	am33xx_voltagedomains_init();
 	am33xx_powerdomains_init();
+	am33xx_clockdomains_init();
 	omap3xxx_clk_init();
 }
 #endif
--
1.7.0.4

