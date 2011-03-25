From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH 4/4] clock: Integrate TI816X clock data into OMAP clock framework
Date: Fri, 25 Mar 2011 21:50:47 +0530
Message-ID: <1301070047-8448-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55971 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab1CYQU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 12:20:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Hemant Pedanekar <hemantp@ti.com>

This patch hooks clock initialization and clockdomain/powerdomain setup into
OMAP clock framework.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/Makefile                     |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c             |    5 ++-
 arch/arm/mach-omap2/clock816x_data.c             |    1 +
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |   18 ++++++++++-
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   20 ++++++++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.c                |   35 ++++++++++++++++++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.h                |    5 +++
 arch/arm/mach-omap2/powerdomain.h                |    2 +
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c       |   27 +++++++++++++++--
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   18 ++++++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.h               |    4 ++
 11 files changed, 127 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 82b2a67..8b88e40 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -137,6 +137,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
 					   clock3517.o clock36xx.o \
 					   dpll3xxx.o clock3xxx_data.o \
 					   clkt_iclk.o
+obj-$(CONFIG_SOC_OMAPTI816X)		+= clock816x_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o \
 					   dpll3xxx.o dpll44xx.o
 
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d905ecc..b5fa4e0 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -27,6 +27,7 @@
 #include "clock34xx.h"
 #include "clock36xx.h"
 #include "clock3517.h"
+#include "clock816x.h"
 
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
@@ -3471,8 +3472,8 @@ int __init omap3xxx_clk_init(void)
 		cpu_mask = (RATE_IN_34XX | RATE_IN_36XX);
 		cpu_clkflg = CK_36XX;
 	} else if (cpu_is_ti816x()) {
-		cpu_mask = RATE_IN_TI816X;
-		cpu_clkflg = CK_TI816X;
+		ti816x_clk_init();
+		return 0;
 	} else if (cpu_is_omap34xx()) {
 		if (omap_rev() == OMAP3430_REV_ES1_0) {
 			cpu_mask = RATE_IN_3430ES1;
diff --git a/arch/arm/mach-omap2/clock816x_data.c b/arch/arm/mach-omap2/clock816x_data.c
index 083b0a1..1670d90 100644
--- a/arch/arm/mach-omap2/clock816x_data.c
+++ b/arch/arm/mach-omap2/clock816x_data.c
@@ -23,6 +23,7 @@
 #include "clock.h"
 #include "clock816x.h"
 #include "cm.h"
+#include "cm816x.h"
 #include "cm-regbits-816x.h"
 #include "prm.h"
 
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index 48d0db7..4e31584 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -151,6 +151,9 @@ static void _enable_hwsup(struct clockdomain *clkdm)
 	if (cpu_is_omap24xx())
 		omap2xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 					       clkdm->clktrctrl_mask);
+	else if (cpu_is_ti816x())
+		ti816x_cm_clkdm_enable_hwsup(clkdm->cm_inst, clkdm->clkdm_offs,
+					       clkdm->clktrctrl_mask);
 	else if (cpu_is_omap34xx())
 		omap3xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 					       clkdm->clktrctrl_mask);
@@ -161,6 +164,9 @@ static void _disable_hwsup(struct clockdomain *clkdm)
 	if (cpu_is_omap24xx())
 		omap2xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 						clkdm->clktrctrl_mask);
+	else if (cpu_is_ti816x())
+		ti816x_cm_clkdm_disable_hwsup(clkdm->cm_inst, clkdm->clkdm_offs,
+						clkdm->clktrctrl_mask);
 	else if (cpu_is_omap34xx())
 		omap3xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 						clkdm->clktrctrl_mask);
@@ -213,14 +219,22 @@ static int omap2_clkdm_clk_disable(struct clockdomain *clkdm)
 
 static int omap3_clkdm_sleep(struct clockdomain *clkdm)
 {
-	omap3xxx_cm_clkdm_force_sleep(clkdm->pwrdm.ptr->prcm_offs,
+	if (cpu_is_ti816x())
+		ti816x_cm_clkdm_force_sleep(clkdm->cm_inst, clkdm->clkdm_offs,
+				clkdm->clktrctrl_mask);
+	else
+		omap3xxx_cm_clkdm_force_sleep(clkdm->pwrdm.ptr->prcm_offs,
 				clkdm->clktrctrl_mask);
 	return 0;
 }
 
 static int omap3_clkdm_wakeup(struct clockdomain *clkdm)
 {
-	omap3xxx_cm_clkdm_force_wakeup(clkdm->pwrdm.ptr->prcm_offs,
+	if (cpu_is_ti816x())
+		ti816x_cm_clkdm_force_wakeup(clkdm->cm_inst, clkdm->clkdm_offs,
+				clkdm->clktrctrl_mask);
+	else
+		omap3xxx_cm_clkdm_force_wakeup(clkdm->pwrdm.ptr->prcm_offs,
 				clkdm->clktrctrl_mask);
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 13bde95..5f64938 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -809,6 +809,8 @@ static struct clkdm_autodep clkdm_autodeps[] = {
 	}
 };
 
+#include "clockdomains816x.h"
+
 static struct clockdomain *clockdomains_omap2[] __initdata = {
 	&wkup_clkdm,
 	&cm_clkdm,
@@ -854,6 +856,24 @@ static struct clockdomain *clockdomains_omap2[] __initdata = {
 	&dpll4_clkdm,
 	&dpll5_clkdm,
 #endif
+
+#ifdef CONFIG_SOC_OMAPTI816X
+	&alwon_mpu_816x_clkdm,
+	&alwon_l3_slow_816x_clkdm,
+	&alwon_ethernet_816x_clkdm,
+	&mmu_816x_clkdm,
+	&mmu_cfg_816x_clkdm,
+	&active_gem_816x_clkdm,
+	&hdvicp0_816x_clkdm,
+	&hdvicp1_816x_clkdm,
+	&hdvicp2_816x_clkdm,
+	&sgx_816x_clkdm,
+	&default_l3_med_816x_clkdm,
+	&default_ducati_816x_clkdm,
+	&default_pcie_816x_clkdm,
+	&default_usb_816x_clkdm,
+#endif
+
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index 9d0dec8..6a6fb23 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -84,6 +84,16 @@ static void _write_clktrctrl(u8 c, s16 module, u32 mask)
 	omap2_cm_write_mod_reg(v, module, OMAP2_CM_CLKSTCTRL);
 }
 
+static void _ti816x_write_clktrctrl(u8 c, s16 module, u16 idx, u32 mask)
+{
+	u32 v;
+
+	v = omap2_cm_read_mod_reg(module, idx);
+	v &= ~mask;
+	v |= c << __ffs(mask);
+	omap2_cm_write_mod_reg(v, module, idx);
+}
+
 bool omap2_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
 {
 	u32 v;
@@ -195,6 +205,31 @@ void omap2xxx_cm_set_apll96_auto_low_power_stop(void)
 				    OMAP24XX_AUTO_96M_MASK);
 }
 
+void ti816x_cm_clkdm_enable_hwsup(s16 inst, u16 clkdm, u32 mask)
+{
+	_ti816x_write_clktrctrl(OMAP34XX_CLKSTCTRL_ENABLE_AUTO, inst,
+				clkdm, mask);
+}
+
+void ti816x_cm_clkdm_disable_hwsup(s16 inst, u16 clkdm, u32 mask)
+{
+	_ti816x_write_clktrctrl(OMAP34XX_CLKSTCTRL_DISABLE_AUTO, inst,
+				clkdm, mask);
+}
+
+void ti816x_cm_clkdm_force_sleep(s16 inst, u16 clkdm, u32 mask)
+{
+	_ti816x_write_clktrctrl(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, inst,
+				clkdm, mask);
+}
+
+void ti816x_cm_clkdm_force_wakeup(s16 inst, u16 clkdm, u32 mask)
+{
+	_ti816x_write_clktrctrl(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP, inst,
+				clkdm, mask);
+}
+
+
 /*
  *
  */
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index 088bbad..11401c1 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -122,6 +122,11 @@ extern void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
 extern void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask);
 extern void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask);
 
+extern void ti816x_cm_clkdm_enable_hwsup(s16 inst, u16 clkdm, u32 mask);
+extern void ti816x_cm_clkdm_disable_hwsup(s16 inst, u16 clkdm, u32 mask);
+extern void ti816x_cm_clkdm_force_sleep(s16 inst, u16 clkdm, u32 mask);
+extern void ti816x_cm_clkdm_force_wakeup(s16 inst, u16 clkdm, u32 mask);
+
 extern void omap2xxx_cm_set_dpll_disable_autoidle(void);
 extern void omap2xxx_cm_set_dpll_auto_low_power_stop(void);
 
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 027f40b..480a134 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -212,10 +212,12 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
 extern void omap2xxx_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
+extern void ti816x_powerdomains_init(void);
 extern void omap44xx_powerdomains_init(void);
 
 extern struct pwrdm_ops omap2_pwrdm_operations;
 extern struct pwrdm_ops omap3_pwrdm_operations;
+extern struct pwrdm_ops ti816x_pwrdm_operations;
 extern struct pwrdm_ops omap4_pwrdm_operations;
 
 /* Common Internal functions used across OMAP rev's */
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index cf600e2..47f4c47 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -29,13 +29,16 @@ static int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
 	omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
 				(pwrst << OMAP_POWERSTATE_SHIFT),
-				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+				pwrdm->prcm_offs, cpu_is_ti816x() ?
+				TI816X_PM_PWSTCTRL : OMAP2_PM_PWSTCTRL);
 	return 0;
 }
 
 static int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 {
 	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     cpu_is_ti816x() ?
+					     TI816X_PM_PWSTCTRL :
 					     OMAP2_PM_PWSTCTRL,
 					     OMAP_POWERSTATE_MASK);
 }
@@ -43,7 +46,8 @@ static int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 static int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 {
 	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
-					     OMAP2_PM_PWSTST,
+					     cpu_is_ti816x() ?
+					     TI816X_PM_PWSTST : OMAP2_PM_PWSTST,
 					     OMAP_POWERSTATEST_MASK);
 }
 
@@ -115,7 +119,8 @@ static int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm)
 	 */
 
 	/* XXX Is this udelay() value meaningful? */
-	while ((omap2_prm_read_mod_reg(pwrdm->prcm_offs, OMAP2_PM_PWSTST) &
+	while ((omap2_prm_read_mod_reg(pwrdm->prcm_offs, cpu_is_ti816x() ?
+					TI816X_PM_PWSTST : OMAP2_PM_PWSTST) &
 		OMAP_INTRANSITION_MASK) &&
 		(c++ < PWRDM_TRANSITION_BAILOUT))
 			udelay(1);
@@ -208,6 +213,14 @@ static int omap3_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 					  OMAP2_PM_PWSTCTRL);
 }
 
+/* Applicable only for TI816X */
+static int ti816x_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
+{
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     TI816X_PM_PWSTST,
+					     OMAP3430_LOGICSTATEST_MASK);
+}
+
 struct pwrdm_ops omap2_pwrdm_operations = {
 	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
@@ -239,3 +252,11 @@ struct pwrdm_ops omap3_pwrdm_operations = {
 	.pwrdm_disable_hdwr_sar	= omap3_pwrdm_disable_hdwr_sar,
 	.pwrdm_wait_transition	= omap2_pwrdm_wait_transition,
 };
+
+struct pwrdm_ops ti816x_pwrdm_operations = {
+	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
+	.pwrdm_read_logic_pwrst	= ti816x_pwrdm_read_logic_pwrst,
+	.pwrdm_wait_transition	= omap2_pwrdm_wait_transition,
+};
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 9c9c113..5b95e82 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -16,6 +16,7 @@
 
 #include "powerdomain.h"
 #include "powerdomains2xxx_3xxx_data.h"
+#include "powerdomains816x.h"
 
 #include "prcm-common.h"
 #include "prm2xxx_3xxx.h"
@@ -254,10 +255,12 @@ static struct powerdomain dpll5_pwrdm = {
 	.prcm_offs	= PLL_MOD,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
+#endif
 
 /* As powerdomains are added or removed above, this list must also be changed */
 static struct powerdomain *powerdomains_omap3xxx[] __initdata = {
 
+#ifdef CONFIG_ARCH_OMAP3
 	&wkup_omap2_pwrdm,
 	&gfx_omap2_pwrdm,
 	&iva2_pwrdm,
@@ -276,12 +279,23 @@ static struct powerdomain *powerdomains_omap3xxx[] __initdata = {
 	&dpll3_pwrdm,
 	&dpll4_pwrdm,
 	&dpll5_pwrdm,
+
+#ifdef CONFIG_SOC_OMAPTI816X
+	&alwon_816x_pwrdm,
+	&active_816x_pwrdm,
+	&default_816x_pwrdm,
+	&hdvicp0_816x_pwrdm,
+	&hdvicp1_816x_pwrdm,
+	&hdvicp2_816x_pwrdm,
+	&sgx_816x_pwrdm,
+#endif
+
 #endif
 	NULL
 };
 
-
 void __init omap3xxx_powerdomains_init(void)
 {
-	pwrdm_init(powerdomains_omap3xxx, &omap3_pwrdm_operations);
+	pwrdm_init(powerdomains_omap3xxx, cpu_is_ti816x() ?
+			&ti816x_pwrdm_operations : &omap3_pwrdm_operations);
 }
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 94d28d0..9540578 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -229,6 +229,10 @@
 #define OMAP3430_PRM_IRQSTATUS_IVA2			0x00f8
 #define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
 
+/* TI816X specific register offsets */
+#define TI816X_PM_PWSTCTRL				0x0000
+#define TI816X_PM_PWSTST				0x0004
+
 /*
  * TI816X PRM module offsets
  */
-- 
1.7.3.5

