From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 13/20] ARM: OMAP4: PM: save/restore CM L3INSTR registers when MPU hits OSWR/OFF mode
Date: Tue, 12 Jun 2012 18:31:28 +0300
Message-ID: <1339515095-9908-14-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52930 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab2FLPcU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 11:32:20 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

On HS devices on the way out of MPU OSWR and OFF ROM code wrongly
overwrites the CM L3INSTR registers. So to avoid this, save them and
restore on the way out from MPU OSWR/OFF.

This errata applies to all HS/EMU versions of OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[t-kristo@ti.com: added omap4 pm errata support]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   34 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm.h                  |    1 +
 arch/arm/mach-omap2/pm44xx.c              |    8 ++++++
 3 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index a361a30..e09e871 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -95,6 +95,12 @@ static struct reg_tuple ivahd_reg[] = {
 	{.addr = OMAP4430_PM_IVAHD_PWRSTCTRL}
 };
 
+static struct reg_tuple l3instr_reg[] = {
+	{.addr = OMAP4430_CM_L3INSTR_L3_3_CLKCTRL},
+	{.addr = OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL},
+	{.addr = OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL},
+};
+
 /*
  * Program the wakeup routine address for the CPU0 and CPU1
  * used for OFF or DORMANT wakeup.
@@ -263,6 +269,28 @@ static inline void restore_ivahd_tesla_regs(void)
 		__raw_writel(ivahd_reg[i].val, ivahd_reg[i].addr);
 }
 
+static inline void save_l3instr_regs(void)
+{
+	int i;
+
+	if (!IS_PM44XX_ERRATUM(PM_OMAP4_ROM_L3INSTR_ERRATUM_xxx))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(l3instr_reg); i++)
+		l3instr_reg[i].val = __raw_readl(l3instr_reg[i].addr);
+}
+
+static inline void restore_l3instr_regs(void)
+{
+	int i;
+
+	if (!IS_PM44XX_ERRATUM(PM_OMAP4_ROM_L3INSTR_ERRATUM_xxx))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(l3instr_reg); i++)
+		__raw_writel(l3instr_reg[i].val, l3instr_reg[i].addr);
+}
+
 /**
  * omap4_enter_lowpower: OMAP4 MPUSS Low Power Entry Function
  * The purpose of this function is to manage low power programming
@@ -322,10 +350,12 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		omap4_cm_prepare_off();
 		omap4_dpll_prepare_off();
 		save_ivahd_tesla_regs();
+		save_l3instr_regs();
 		save_state = 3;
 	} else if (pwrdm_read_next_func_pwrst(mpuss_pd) ==
 		   PWRDM_FUNC_PWRST_OSWR) {
 		save_ivahd_tesla_regs();
+		save_l3instr_regs();
 		save_state = 2;
 	}
 
@@ -350,8 +380,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	wakeup_cpu = smp_processor_id();
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_FUNC_PWRST_ON);
 
-	if (omap4_mpuss_read_prev_context_state())
+	if (omap4_mpuss_read_prev_context_state()) {
 		restore_ivahd_tesla_regs();
+		restore_l3instr_regs();
+	}
 
 	if (pwrdm_read_prev_func_pwrst(core_pd) == PWRDM_FUNC_PWRST_OFF) {
 		omap4_dpll_resume_off();
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index a6379a7..dfaec5e 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -90,6 +90,7 @@ static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 
 #define PM_OMAP4_ROM_SMP_BOOT_ERRATUM_xxx	(1 << 0)
 #define PM_OMAP4_ROM_IVAHD_TESLA_ERRATUM_xxx	(1 << 1)
+#define PM_OMAP4_ROM_L3INSTR_ERRATUM_xxx	(1 << 2)
 
 #if defined(CONFIG_ARCH_OMAP4)
 extern u16 pm44xx_errata;
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 7e10d4a..271b166 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -205,6 +205,14 @@ int __init omap4_pm_init(void)
 	    omap_type() != OMAP2_DEVICE_TYPE_GP)
 		pm44xx_errata |= PM_OMAP4_ROM_IVAHD_TESLA_ERRATUM_xxx;
 
+	/*
+	 * Similar to above errata, ROM code modifies L3INSTR clock
+	 * registers also and these must be saved / restored during
+	 * MPU OSWR / device off.
+	 */
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+		pm44xx_errata |= PM_OMAP4_ROM_L3INSTR_ERRATUM_xxx;
+
 #ifdef CONFIG_SUSPEND
 	omap_pm_suspend = omap4_pm_suspend;
 #endif
-- 
1.7.4.1

