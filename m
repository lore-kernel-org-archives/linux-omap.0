From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 08/12] ARM: OMAP4430: PM: Work-around for ROM code BUG of PER pwrst ctrl
Date: Thu, 19 Jul 2012 16:26:28 +0300
Message-ID: <1342704392-23657-9-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56328 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645Ab2GSN1Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 09:27:24 -0400
In-Reply-To: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, nm@ti.com, paul@pwsan.com, khilman@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org

On OMAP4430 HS / EMU chips, ROM code appears to re-configure L4PER domain
next powerstate during wakeup from OSWR / OFF, programming it to ON.
This will prevent successive entries to cpuidle retention / off, until
kernel decices to change the L4PER target state, which can be delayed
for a very long time as kernel is lazy programming the target state.

This patch fixes the issue within the low power OSWR / OFF mode code, so
that this register is saved / restored across MPU OSWR / OFF state.

This problem seems to only occur with OMAP4430 HS/EMU, it does not impact
OMAP4460+ or GP devices.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   39 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm.h                  |    1 +
 arch/arm/mach-omap2/pm44xx.c              |   10 +++++++
 3 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 0e5f81b..963a61b 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -52,6 +52,7 @@
 
 #include <plat/omap44xx.h>
 
+#include "iomap.h"
 #include "common.h"
 #include "omap4-sar-layout.h"
 #include "pm.h"
@@ -97,6 +98,15 @@ static inline void set_cpu_next_pwrst(unsigned int cpu_id,
 	omap_set_pwrdm_state(pm_info->pwrdm, power_state);
 }
 
+struct reg_tuple {
+	void __iomem *addr;
+	u32 val;
+};
+
+static struct reg_tuple l4per_reg[] = {
+	{.addr = OMAP4430_PM_L4PER_PWRSTCTRL},
+};
+
 /*
  * Read CPU's previous power state
  */
@@ -215,6 +225,28 @@ static void save_l2x0_context(void)
 {}
 #endif
 
+static inline void save_l4per_regs(void)
+{
+	int i;
+
+	if (!IS_PM44XX_ERRATUM(PM_OMAP4_ROM_L4PER_ERRATUM_PWSTCT))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(l4per_reg); i++)
+		l4per_reg[i].val = __raw_readl(l4per_reg[i].addr);
+}
+
+static inline void restore_l4per_regs(void)
+{
+	int i;
+
+	if (!IS_PM44XX_ERRATUM(PM_OMAP4_ROM_L4PER_ERRATUM_PWSTCT))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(l4per_reg); i++)
+		__raw_writel(l4per_reg[i].val, l4per_reg[i].addr);
+}
+
 /**
  * omap4_enter_lowpower: OMAP4 MPUSS Low Power Entry Function
  * The purpose of this function is to manage low power programming
@@ -265,8 +297,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * In MPUSS OSWR or device OFF, interrupt controller context is lost.
 	 */
 	mpuss_clear_prev_logic_pwrst();
-	if (pwrdm_read_next_func_pwrst(mpuss_pd) == PWRDM_FUNC_PWRST_OSWR)
+	if (pwrdm_read_next_func_pwrst(mpuss_pd) == PWRDM_FUNC_PWRST_OSWR) {
+		save_l4per_regs();
 		save_state = 2;
+	}
 
 	cpu_clear_prev_logic_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
@@ -289,6 +323,9 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	wakeup_cpu = smp_processor_id();
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_FUNC_PWRST_ON);
 
+	if (omap4_mpuss_read_prev_context_state())
+		restore_l4per_regs();
+
 	pwrdm_post_transition();
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index d95d1d0..adce520 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -89,6 +89,7 @@ static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 #endif		/* defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3) */
 
 #define PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD	(1 << 0)
+#define PM_OMAP4_ROM_L4PER_ERRATUM_PWSTCT	(1 << 1)
 
 #if defined(CONFIG_ARCH_OMAP4)
 extern u16 pm44xx_errata;
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index eb3e073..1e98909 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -194,6 +194,16 @@ int __init omap4_pm_init(void)
 
 	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
 
+	/*
+	 * ROM core appears to modify the L4PER powerstate control register
+	 * during wakeup from OSWR / OFF, which will prevent further low
+	 * power state transitions until the register is re-programmed.
+	 * Thus, we must save / restore the register during idle. This
+	 * seems to happen only on omap4430, on HS / EMU chips only.
+	 */
+	if (cpu_is_omap443x() && omap_type() != OMAP2_DEVICE_TYPE_GP)
+		pm44xx_errata |= PM_OMAP4_ROM_L4PER_ERRATUM_PWSTCT;
+
 #ifdef CONFIG_SUSPEND
 	omap_pm_suspend = omap4_pm_suspend;
 #endif
-- 
1.7.4.1

