From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 21/25] OMAP4: PM: Add MPUSS power domain OSWR support
Date: Sun, 4 Sep 2011 19:24:22 +0530
Message-ID: <1315144466-9395-22-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36819 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754623Ab1IDN4S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:56:18 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds the MPUSS OSWR (Open Switch Retention) support. The MPUSS
OSWR configuration is as below.
	- CPUx L1 and logic lost, MPUSS logic lost, L2 memory is retained

OMAP4460 onwards, MPUSS power domain doesn't support OFF state any more
anymore just like CORE power domain. The deepest state supported is OSWR.
On OMAP4430 secure devices too, MPUSS off mode can't be used because of
a bug which alters Ducati and Tesla states. Hence MPUSS off mode as an
independent state isn't supported on OMAP44XX devices.

Ofcourse when MPUSS power domain transitions to OSWR along
with device off mode, it eventually hits off state since memory
contents are lost.

Hence the MPUSS off mode independent state is not attempted without
device off mode. All the necessary infrastructure code for MPUSS
off mode is in place as part of this series.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |   10 +++-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c       |   65 +++++++++++++++++++++-
 arch/arm/mach-omap2/pm44xx.c                    |    4 ++
 3 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 14803c3..6651cb0 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -52,6 +52,7 @@ extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
 extern int omap4_finish_suspend(unsigned long cpu_state);
 extern void omap4_cpu_resume(void);
 extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
+extern u32 omap4_mpuss_read_prev_context_state(void);
 #else
 static inline int omap4_enter_lowpower(unsigned int cpu,
 					unsigned int power_state)
@@ -70,11 +71,18 @@ static inline int omap4_mpuss_init(void)
 {
 	return 0;
 }
-
+static inline u32 omap4_mpuss_read_prev_context_state(void)
+{
+	return 0;
+}
 static inline int omap4_finish_suspend(unsigned long cpu_state)
 {}
 static inline void omap4_cpu_resume(void)
 {}
+static inline u32 omap4_mpuss_read_prev_context_state(void)
+{
+	return 0;
+}
 #endif
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index aea6deb..4dd9d0f 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -24,8 +24,8 @@
  *	ON		ON		ON
  *	ON(Inactive)	OFF		ON(Inactive)
  *	OFF		OFF		CSWR
- *	OFF		OFF		OSWR (*TBD)
- *	OFF		OFF		OFF* (*TBD)
+ *	OFF		OFF		OSWR
+ *	OFF		OFF		OFF(Device OFF *TBD)
  *	----------------------------------------------
  *
  * Note: CPU0 is the master core and it is the last CPU to go down
@@ -56,7 +56,11 @@
 
 #include "omap4-sar-layout.h"
 #include "pm.h"
-#include "powerdomain.h"
+#include "prcm_mpu44xx.h"
+#include "prminst44xx.h"
+#include "prcm44xx.h"
+#include "prm44xx.h"
+#include "prm-regbits-44xx.h"
 
 #ifdef CONFIG_SMP
 
@@ -138,6 +142,48 @@ static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
 	__raw_writel(scu_pwr_st, pm_info->scu_sar_addr);
 }
 
+/* Helper functions for MPUSS OSWR */
+static inline void mpuss_clear_prev_logic_pwrst(void)
+{
+	u32 reg;
+
+	reg = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+		OMAP4430_PRM_MPU_INST, OMAP4_RM_MPU_MPU_CONTEXT_OFFSET);
+	omap4_prminst_write_inst_reg(reg, OMAP4430_PRM_PARTITION,
+		OMAP4430_PRM_MPU_INST, OMAP4_RM_MPU_MPU_CONTEXT_OFFSET);
+}
+
+static inline void cpu_clear_prev_logic_pwrst(unsigned int cpu_id)
+{
+	u32 reg;
+
+	if (cpu_id) {
+		reg = omap4_prcm_mpu_read_inst_reg(OMAP4430_PRCM_MPU_CPU1_INST,
+					OMAP4_RM_CPU1_CPU1_CONTEXT_OFFSET);
+		omap4_prcm_mpu_write_inst_reg(reg, OMAP4430_PRCM_MPU_CPU1_INST,
+					OMAP4_RM_CPU1_CPU1_CONTEXT_OFFSET);
+	} else {
+		reg = omap4_prcm_mpu_read_inst_reg(OMAP4430_PRCM_MPU_CPU0_INST,
+					OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET);
+		omap4_prcm_mpu_write_inst_reg(reg, OMAP4430_PRCM_MPU_CPU0_INST,
+					OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET);
+	}
+}
+
+/**
+ * omap4_mpuss_read_prev_context_state:
+ * Function returns the MPUSS previous context state
+ */
+u32 omap4_mpuss_read_prev_context_state(void)
+{
+	u32 reg;
+
+	reg = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+		OMAP4430_PRM_MPU_INST, OMAP4_RM_MPU_MPU_CONTEXT_OFFSET);
+	reg &= OMAP4430_LOSTCONTEXT_DFF_MASK;
+	return reg;
+}
+
 /*
  * Store the CPU cluster state for L2X0 low power operations.
  */
@@ -207,8 +253,18 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		return -ENXIO;
 	}
 
+	/*
+	 * Check MPUSS next state and save interrupt controller if needed.
+	 * In MPUSS OSWR or device OFF, interrupt controller  contest is lost.
+	 */
+	mpuss_clear_prev_logic_pwrst();
 	pwrdm_clear_all_prev_pwrst(mpuss_pd);
+	if ((pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_RET) &&
+		(pwrdm_read_logic_retst(mpuss_pd) == PWRDM_POWER_OFF))
+		save_state = 2;
+
 	clear_cpu_prev_pwrst(cpu);
+	cpu_clear_prev_logic_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
 	set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));
 	scu_pwrst_prepare(cpu, power_state);
@@ -293,6 +349,7 @@ int __init omap4_mpuss_init(void)
 
 	/* Clear CPU previous power domain state */
 	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
+	cpu_clear_prev_logic_pwrst(0);
 
 	/* Initialise CPU0 power domain state to ON */
 	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
@@ -309,6 +366,7 @@ int __init omap4_mpuss_init(void)
 
 	/* Clear CPU previous power domain state */
 	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
+	cpu_clear_prev_logic_pwrst(1);
 
 	/* Initialise CPU1 power domain state to ON */
 	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
@@ -319,6 +377,7 @@ int __init omap4_mpuss_init(void)
 		return -ENODEV;
 	}
 	pwrdm_clear_all_prev_pwrst(mpuss_pd);
+	mpuss_clear_prev_logic_pwrst();
 
 	/* Save device type on scratchpad for low level code to use */
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 63e8f9b..8df57cb 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -28,6 +28,7 @@ struct power_state {
 	u32 next_state;
 #ifdef CONFIG_SUSPEND
 	u32 saved_state;
+	u32 saved_logic_state;
 #endif
 	struct list_head node;
 };
@@ -44,11 +45,13 @@ static int omap4_pm_suspend(void)
 	/* Save current powerdomain state */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
+		pwrst->saved_logic_state = pwrdm_read_logic_retst(pwrst->pwrdm);
 	}
 
 	/* Set targeted power domain states by suspend */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
+		pwrdm_set_logic_retst(pwrst->pwrdm, PWRDM_POWER_OFF);
 	}
 
 	/*
@@ -73,6 +76,7 @@ static int omap4_pm_suspend(void)
 			ret = -1;
 		}
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
+		pwrdm_set_logic_retst(pwrst->pwrdm, pwrst->saved_logic_state);
 	}
 	if (ret)
 		pr_err("Could not enter target state in pm_suspend\n");
-- 
1.7.4.1

