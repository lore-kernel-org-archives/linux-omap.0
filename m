From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 12/20] ARM: OMAP4: PM: Work-around for ROM code BUG of IVAHD/TESLA
Date: Tue, 12 Jun 2012 18:31:27 +0300
Message-ID: <1339515095-9908-13-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41042 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2FLPcQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 11:32:16 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

The ROM BUG is when MPU Domain OFF wake up sequence that can compromise
IVA and Tesla execution.

At wakeup from MPU OFF on HS device only (not GP device), when
restoring the Secure RAM, the ROM Code reconfigures the clocks the
same way it is done at Cold Reset.
The IVAHD Clocks and Power Domain settings are:
	IVAHD_CM2 IVAHD_CLKCTRL_MODULE_MODE = DISABLE
	IVAHD_CM2 SL2_CLKCTRL_MODULE_MODE = DISABLE
	IVAHD_CM2 SL2_CLKSTCTRL_CLKTRCTRL = HW_AUTO
	IVAHD_PRM IVAHD_PWRSTCTRL_POWERSTATE = OFF
The TESLA Clocks and Power Domain settings are:
	TESLA_CM1 TESLA_CLKCTRL_MODULE_MODE = DISABLE
	TESLA_CM1 TESLA_CLKSTCTRL_CLKTRCTRL = HW_AUTO
	TESLA_PRM TESLA_PWRSTCTRL_POWERSTATE = OFF

This patch fixes the low power OFF mode code so that the these
registers are saved and restore across MPU OFF state.

Also because of this limitation, MPU OFF alone is not targeted without
device OFF to avoid IVAHD and TESLA execution impact

This erratum impacts only OMAP4430 HS/EMU and is fixed on devices from
OMAP4430 ES2.3 onwards.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[t-kristo@ti.com: added omap4 pm errata support]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   52 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h                  |    1 +
 arch/arm/mach-omap2/pm44xx.c              |   11 ++++++
 3 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index da84339..a361a30 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -52,6 +52,7 @@
 
 #include <plat/omap44xx.h>
 
+#include "iomap.h"
 #include "common.h"
 #include "omap4-sar-layout.h"
 #include "pm.h"
@@ -76,6 +77,24 @@ static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
 static struct powerdomain *mpuss_pd, *core_pd;
 static void __iomem *sar_base;
 
+struct reg_tuple {
+	void __iomem *addr;
+	u32 val;
+};
+
+static struct reg_tuple tesla_reg[] = {
+	{.addr = OMAP4430_CM_TESLA_CLKSTCTRL},
+	{.addr = OMAP4430_CM_TESLA_TESLA_CLKCTRL},
+	{.addr = OMAP4430_PM_TESLA_PWRSTCTRL},
+};
+
+static struct reg_tuple ivahd_reg[] = {
+	{.addr = OMAP4430_CM_IVAHD_CLKSTCTRL},
+	{.addr = OMAP4430_CM_IVAHD_IVAHD_CLKCTRL},
+	{.addr = OMAP4430_CM_IVAHD_SL2_CLKCTRL},
+	{.addr = OMAP4430_PM_IVAHD_PWRSTCTRL}
+};
+
 /*
  * Program the wakeup routine address for the CPU0 and CPU1
  * used for OFF or DORMANT wakeup.
@@ -216,6 +235,34 @@ static void save_l2x0_context(void)
 {}
 #endif
 
+static inline void save_ivahd_tesla_regs(void)
+{
+	int i;
+
+	if (!IS_PM44XX_ERRATUM(PM_OMAP4_ROM_IVAHD_TESLA_ERRATUM_xxx))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(tesla_reg); i++)
+		tesla_reg[i].val = __raw_readl(tesla_reg[i].addr);
+
+	for (i = 0; i < ARRAY_SIZE(ivahd_reg); i++)
+		ivahd_reg[i].val = __raw_readl(ivahd_reg[i].addr);
+}
+
+static inline void restore_ivahd_tesla_regs(void)
+{
+	int i;
+
+	if (!IS_PM44XX_ERRATUM(PM_OMAP4_ROM_IVAHD_TESLA_ERRATUM_xxx))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(tesla_reg); i++)
+		__raw_writel(tesla_reg[i].val, tesla_reg[i].addr);
+
+	for (i = 0; i < ARRAY_SIZE(ivahd_reg); i++)
+		__raw_writel(ivahd_reg[i].val, ivahd_reg[i].addr);
+}
+
 /**
  * omap4_enter_lowpower: OMAP4 MPUSS Low Power Entry Function
  * The purpose of this function is to manage low power programming
@@ -274,9 +321,11 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 			goto sar_save_failed;
 		omap4_cm_prepare_off();
 		omap4_dpll_prepare_off();
+		save_ivahd_tesla_regs();
 		save_state = 3;
 	} else if (pwrdm_read_next_func_pwrst(mpuss_pd) ==
 		   PWRDM_FUNC_PWRST_OSWR) {
+		save_ivahd_tesla_regs();
 		save_state = 2;
 	}
 
@@ -301,6 +350,9 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	wakeup_cpu = smp_processor_id();
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_FUNC_PWRST_ON);
 
+	if (omap4_mpuss_read_prev_context_state())
+		restore_ivahd_tesla_regs();
+
 	if (pwrdm_read_prev_func_pwrst(core_pd) == PWRDM_FUNC_PWRST_OFF) {
 		omap4_dpll_resume_off();
 		omap4_cm_resume_off();
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 43cacef..a6379a7 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -89,6 +89,7 @@ static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 #endif		/* defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3) */
 
 #define PM_OMAP4_ROM_SMP_BOOT_ERRATUM_xxx	(1 << 0)
+#define PM_OMAP4_ROM_IVAHD_TESLA_ERRATUM_xxx	(1 << 1)
 
 #if defined(CONFIG_ARCH_OMAP4)
 extern u16 pm44xx_errata;
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index eb3e073..7e10d4a 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -194,6 +194,17 @@ int __init omap4_pm_init(void)
 
 	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
 
+	/*
+	 * ROM code initializes IVAHD and TESLA clock registers during
+	 * secure RAM restore phase on omap4430 EMU/HS devices, thus
+	 * IVAHD / TESLA clock registers must be saved / restored
+	 * during MPU OSWR / device off.
+	 */
+	if (omap_rev() >= OMAP4430_REV_ES1_0 &&
+	    omap_rev() < OMAP4430_REV_ES2_3 &&
+	    omap_type() != OMAP2_DEVICE_TYPE_GP)
+		pm44xx_errata |= PM_OMAP4_ROM_IVAHD_TESLA_ERRATUM_xxx;
+
 #ifdef CONFIG_SUSPEND
 	omap_pm_suspend = omap4_pm_suspend;
 #endif
-- 
1.7.4.1

