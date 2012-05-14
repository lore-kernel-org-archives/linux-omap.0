From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 03/19] ARM: OMAP4: PM: Add device-off support
Date: Mon, 14 May 2012 13:18:34 +0300
Message-ID: <1336990730-26892-4-git-send-email-t-kristo@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34780 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab2ENKTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 May 2012 06:19:14 -0400
In-Reply-To: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds device off support to OMAP4 device type.

OFF mode is disabled by default, however, there are two ways to enable
OFF mode:
a) In the board file, call omap4_pm_off_mode_enable(1)
b) Enable OFF mode using the debugfs entry
echo "1">/sys/kernel/debug/pm_debug/enable_off_mode
(conversely echo '0' will disable it as well).

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[t-kristo@ti.com: largely re-structured the code]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   10 ++++-
 arch/arm/mach-omap2/omap-wakeupgen.c      |   47 +++++++++++++++++++-
 arch/arm/mach-omap2/pm-debug.c            |   17 +++++--
 arch/arm/mach-omap2/pm.h                  |   20 +++++++++
 arch/arm/mach-omap2/pm44xx.c              |   45 +++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.c             |   66 +++++++++++++++++++++++++++++
 6 files changed, 197 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index e02c082..7418e7c 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -60,6 +60,7 @@
 #include "prcm44xx.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
+#include "cm44xx.h"
 
 #ifdef CONFIG_SMP
 
@@ -263,9 +264,13 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * In MPUSS OSWR or device OFF, interrupt controller  contest is lost.
 	 */
 	mpuss_clear_prev_logic_pwrst();
-	if ((pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_RET) &&
+	if (omap4_device_next_state_off())
+		save_state = 3;
+	else if ((pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_RET) &&
 		(pwrdm_read_logic_retst(mpuss_pd) == PWRDM_POWER_OFF))
 		save_state = 2;
+	else if (pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_OFF)
+		save_state = 3;
 
 	cpu_clear_prev_logic_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
@@ -288,6 +293,9 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	wakeup_cpu = smp_processor_id();
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
 
+	if (omap4_device_prev_state_off())
+		omap4_device_clear_prev_off_state();
+
 	pwrdm_post_transition();
 
 	return 0;
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 42cd7fb..805d08d 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -32,6 +32,7 @@
 
 #include "omap4-sar-layout.h"
 #include "common.h"
+#include "pm.h"
 
 #define NR_REG_BANKS		4
 #define MAX_IRQS		128
@@ -46,6 +47,8 @@ static void __iomem *sar_base;
 static DEFINE_SPINLOCK(wakeupgen_lock);
 static unsigned int irq_target_cpu[NR_IRQS];
 
+static struct powerdomain *mpuss_pd;
+
 /*
  * Static helper functions.
  */
@@ -259,7 +262,7 @@ static void irq_save_context(void)
 /*
  * Clear WakeupGen SAR backup status.
  */
-void irq_sar_clear(void)
+static void irq_sar_clear(void)
 {
 	u32 val;
 	val = __raw_readl(sar_base + SAR_BACKUP_STATUS_OFFSET);
@@ -271,7 +274,7 @@ void irq_sar_clear(void)
  * Save GIC and Wakeupgen interrupt context using secure API
  * for HS/EMU devices.
  */
-static void irq_save_secure_context(void)
+static void irq_save_secure_gic(void)
 {
 	u32 ret;
 	ret = omap_secure_dispatcher(OMAP4_HAL_SAVEGIC_INDEX,
@@ -282,6 +285,40 @@ static void irq_save_secure_context(void)
 }
 #endif
 
+static void save_secure_ram(void)
+{
+	u32 ret;
+	ret = omap_secure_dispatcher(OMAP4_HAL_SAVESECURERAM_INDEX,
+				FLAG_START_CRITICAL,
+				1, omap_secure_ram_mempool_base(),
+				0, 0, 0);
+	if (ret != API_HAL_RET_VALUE_OK)
+		pr_err("Secure ram context save failed\n");
+}
+
+static void save_secure_all(void)
+{
+	u32 ret;
+	ret = omap_secure_dispatcher(OMAP4_HAL_SAVEALL_INDEX,
+				FLAG_START_CRITICAL,
+				1, omap_secure_ram_mempool_base(),
+				0, 0, 0);
+	if (ret != API_HAL_RET_VALUE_OK)
+		pr_err("Secure all context save failed\n");
+}
+
+static void irq_save_secure_context(void)
+{
+	if (omap4_device_next_state_off()) {
+		save_secure_all();
+	} else if (pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_OFF) {
+		irq_save_secure_gic();
+		save_secure_ram();
+	} else {
+		irq_save_secure_gic();
+	}
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int __cpuinit irq_cpu_hotplug_notify(struct notifier_block *self,
 					 unsigned long action, void *hcpu)
@@ -388,5 +425,11 @@ int __init omap_wakeupgen_init(void)
 	irq_hotplug_init();
 	irq_pm_init();
 
+	mpuss_pd = pwrdm_lookup("mpu_pwrdm");
+	if (!mpuss_pd) {
+		pr_err("wakeupgen: unable to get mpu_pwrdm\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index d9a8e42..d8cf5e5 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -40,6 +40,7 @@
 
 u32 enable_off_mode;
 static u32 enable_oswr_mode;
+static void (*off_mode_enable_func) (int);
 
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
@@ -249,7 +250,8 @@ static int option_set(void *data, u64 val)
 		else
 			omap_pm_disable_off_mode();
 
-		omap3_pm_off_mode_enable(val);
+		if (off_mode_enable_func)
+			off_mode_enable_func(val);
 	}
 
 	if (option == &enable_oswr_mode)
@@ -278,16 +280,21 @@ static int __init pm_dbg_init(void)
 
 	pwrdm_for_each(pwrdms_setup, (void *)d);
 
-	if (cpu_is_omap34xx())
-		(void) debugfs_create_file("enable_off_mode",
-			S_IRUGO | S_IWUSR, d, &enable_off_mode,
-			&pm_dbg_option_fops);
+	(void) debugfs_create_file("enable_off_mode",
+		S_IRUGO | S_IWUSR, d, &enable_off_mode,
+		&pm_dbg_option_fops);
 
 	if (cpu_is_omap44xx())
 		(void) debugfs_create_file("enable_oswr_mode",
 			S_IRUGO | S_IWUSR, d, &enable_oswr_mode,
 			&pm_dbg_option_fops);
 
+	if (cpu_is_omap34xx())
+		off_mode_enable_func = omap3_pm_off_mode_enable;
+
+	if (cpu_is_omap44xx())
+		off_mode_enable_func = omap4_pm_off_mode_enable;
+
 	pm_dbg_init_done = 1;
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index c36ab63..d95f8c5 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -18,6 +18,7 @@
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap4_pm_oswr_mode_enable(int);
+extern void omap4_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
@@ -25,6 +26,25 @@ extern int omap4_idle_init(void);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
 extern int (*omap_pm_suspend)(void);
 
+#ifdef CONFIG_PM
+extern void omap4_device_set_state_off(u8 enable);
+extern bool omap4_device_prev_state_off(void);
+extern bool omap4_device_next_state_off(void);
+extern void omap4_device_clear_prev_off_state(void);
+#else
+static inline void omap4_device_set_state_off(u8 enable)
+{
+}
+static inline bool omap4_device_prev_state_off(void)
+{
+	return false;
+}
+static inline bool omap4_device_next_state_off(void)
+{
+	return false;
+}
+#endif
+
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
 extern int omap4_opp_init(void);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 07ac0d3..8f0ec56 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -87,6 +87,27 @@ static int omap4_pm_suspend(void)
 }
 #endif /* CONFIG_SUSPEND */
 
+/**
+ * get_achievable_state() - Provide achievable state
+ * @available_states:	what states are available
+ * @req_min_state:	what state is the minimum we'd like to hit
+ *
+ * Power domains have varied capabilities. When attempting a low power
+ * state such as OFF/RET, a specific min requested state may not be
+ * supported on the power domain, in which case, the next higher power
+ * state which is supported is returned. This is because a combination
+ * of system power states where the parent PD's state is not in line
+ * with expectation can result in system instabilities.
+ */
+static inline u8 get_achievable_state(u8 available_states, u8 req_min_state)
+{
+	u16 mask = 0xFF << req_min_state;
+
+	if (available_states & mask)
+		return __ffs(available_states & mask);
+	return PWRDM_POWER_ON;
+}
+
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
@@ -115,6 +136,30 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
+void omap4_pm_off_mode_enable(int enable)
+{
+	u32 next_state = PWRDM_POWER_RET;
+	u32 next_logic_state = PWRDM_POWER_ON;
+	struct power_state *pwrst;
+
+	if (enable) {
+		next_state = PWRDM_POWER_OFF;
+		next_logic_state = PWRDM_POWER_OFF;
+	}
+
+	omap4_device_set_state_off(enable);
+
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		pwrst->next_state =
+			get_achievable_state(pwrst->pwrdm->pwrsts, next_state);
+		pwrst->next_logic_state =
+			get_achievable_state(pwrst->pwrdm->pwrsts_logic_ret,
+				next_logic_state);
+		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
+		pwrdm_set_logic_retst(pwrst->pwrdm, pwrst->next_logic_state);
+	}
+}
+
 void omap4_pm_oswr_mode_enable(int enable)
 {
 	u32 next_logic_state;
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 09d84de..86c6c6b 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -289,6 +289,72 @@ static void __init omap44xx_prm_enable_io_wakeup(void)
 			OMAP4_PRM_IO_PMCTRL_OFFSET);
 }
 
+/**
+ * omap4_device_set_state_off() - setup device off state
+ * @enable:	set to off or not.
+ *
+ * When Device OFF is enabled, Device is allowed to perform
+ * transition to off mode as soon as all power domains in MPU, IVA
+ * and CORE voltage are in OFF or OSWR state (open switch retention)
+ */
+void omap4_device_set_state_off(u8 enable)
+{
+	if (enable)
+		omap4_prminst_write_inst_reg(0x1 <<
+				OMAP4430_DEVICE_OFF_ENABLE_SHIFT,
+				OMAP4430_PRM_PARTITION,
+				OMAP4430_PRM_DEVICE_INST,
+				OMAP4_PRM_DEVICE_OFF_CTRL_OFFSET);
+	else
+		omap4_prminst_write_inst_reg(0x0 <<
+				OMAP4430_DEVICE_OFF_ENABLE_SHIFT,
+				OMAP4430_PRM_PARTITION,
+				OMAP4430_PRM_DEVICE_INST,
+				OMAP4_PRM_DEVICE_OFF_CTRL_OFFSET);
+}
+
+/**
+ * omap4_device_prev_state_off:
+ * returns true if the device hit OFF mode
+ * This is API to check whether OMAP is waking up from device OFF mode.
+ * There is no other status bit available for SW to read whether last state
+ * entered was device OFF. To work around this, CORE PD, RFF context state
+ * is used which is lost only when we hit device OFF state
+ */
+bool omap4_device_prev_state_off(void)
+{
+	u32 reg;
+
+	reg = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+				OMAP4430_PRM_CORE_INST,
+				OMAP4_RM_L3_1_L3_1_CONTEXT_OFFSET)
+		& OMAP4430_LOSTCONTEXT_RFF_MASK;
+
+	return reg ? true : false;
+}
+
+void omap4_device_clear_prev_off_state(void)
+{
+	omap4_prminst_write_inst_reg(OMAP4430_LOSTCONTEXT_RFF_MASK |
+				OMAP4430_LOSTCONTEXT_DFF_MASK,
+				OMAP4430_PRM_PARTITION,
+				OMAP4430_PRM_CORE_INST,
+				OMAP4_RM_L3_1_L3_1_CONTEXT_OFFSET);
+}
+
+/**
+ * omap4_device_next_state_off:
+ * returns true if the device next state is OFF
+ * This is API to check whether OMAP is programmed for device OFF
+ */
+bool omap4_device_next_state_off(void)
+{
+	return omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+			OMAP4430_PRM_DEVICE_INST,
+			OMAP4_PRM_DEVICE_OFF_CTRL_OFFSET)
+			& OMAP4430_DEVICE_OFF_ENABLE_MASK ? true : false;
+}
+
 static int __init omap4xxx_prcm_init(void)
 {
 	if (cpu_is_omap44xx()) {
-- 
1.7.4.1

