From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 09/20] ARM: OMAP4: PM: save/restore all DPLL settings in OFF mode
Date: Tue, 12 Jun 2012 18:31:24 +0300
Message-ID: <1339515095-9908-10-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41023 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012Ab2FLPcI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 11:32:08 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

SAR/ROM code restores only CORE DPLL to its original state
post wakeup from OFF mode.
The rest of the DPLL's in OMAP4 platform (MPU/IVA/ABE/USB/PER)
are saved and restored here during an OFF transition.

[nm@ti.com: minor cleanups]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm44xx.h              |    5 +
 arch/arm/mach-omap2/dpll44xx.c            |  225 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   11 ++-
 3 files changed, 239 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm44xx.h
index 3380bee..5fba0fa 100644
--- a/arch/arm/mach-omap2/cm44xx.h
+++ b/arch/arm/mach-omap2/cm44xx.h
@@ -23,4 +23,9 @@
 #define OMAP4_CM_CLKSTCTRL				0x0000
 #define OMAP4_CM_STATICDEP				0x0004
 
+#ifndef __ASSEMBLER__
+extern void omap4_dpll_prepare_off(void);
+extern void omap4_dpll_resume_off(void);
+#endif
+
 #endif
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 9c6a296..f903057 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -21,6 +22,96 @@
 #include "clock.h"
 #include "clock44xx.h"
 #include "cm-regbits-44xx.h"
+#include "cm1_44xx.h"
+#include "cm2_44xx.h"
+#include "prcm44xx.h"
+#include "cminst44xx.h"
+#include "cm44xx.h"
+
+#define MAX_DPLL_WAIT_TRIES	1000000
+
+struct dpll_reg {
+	u16 offset;
+	u32 val;
+};
+
+struct omap4_dpll_regs {
+	char *name;
+	u32 mod_partition;
+	u32 mod_inst;
+	struct dpll_reg clkmode;
+	struct dpll_reg autoidle;
+	struct dpll_reg idlest;
+	struct dpll_reg clksel;
+	struct dpll_reg div_m2;
+	struct dpll_reg div_m3;
+	struct dpll_reg div_m4;
+	struct dpll_reg div_m5;
+	struct dpll_reg div_m6;
+	struct dpll_reg div_m7;
+	struct dpll_reg clkdcoldo;
+};
+
+static struct omap4_dpll_regs dpll_regs[] = {
+	/* MPU DPLL */
+	{ .name		= "mpu",
+	  .mod_partition = OMAP4430_CM1_PARTITION,
+	  .mod_inst	= OMAP4430_CM1_CKGEN_INST,
+	  .clkmode	= {.offset = OMAP4_CM_CLKMODE_DPLL_MPU_OFFSET},
+	  .autoidle	= {.offset = OMAP4_CM_AUTOIDLE_DPLL_MPU_OFFSET},
+	  .idlest	= {.offset = OMAP4_CM_IDLEST_DPLL_MPU_OFFSET},
+	  .clksel	= {.offset = OMAP4_CM_CLKSEL_DPLL_MPU_OFFSET},
+	  .div_m2	= {.offset = OMAP4_CM_DIV_M2_DPLL_MPU_OFFSET},
+	},
+	/* IVA DPLL */
+	{ .name		= "iva",
+	  .mod_partition = OMAP4430_CM1_PARTITION,
+	  .mod_inst	= OMAP4430_CM1_CKGEN_INST,
+	  .clkmode	= {.offset = OMAP4_CM_CLKMODE_DPLL_IVA_OFFSET},
+	  .autoidle	= {.offset = OMAP4_CM_AUTOIDLE_DPLL_IVA_OFFSET},
+	  .idlest	= {.offset = OMAP4_CM_IDLEST_DPLL_IVA_OFFSET},
+	  .clksel	= {.offset = OMAP4_CM_CLKSEL_DPLL_IVA_OFFSET},
+	  .div_m4	= {.offset = OMAP4_CM_DIV_M4_DPLL_IVA_OFFSET},
+	  .div_m5	= {.offset = OMAP4_CM_DIV_M5_DPLL_IVA_OFFSET},
+	},
+	/* ABE DPLL */
+	{ .name		= "abe",
+	  .mod_partition = OMAP4430_CM1_PARTITION,
+	  .mod_inst	= OMAP4430_CM1_CKGEN_INST,
+	  .clkmode	= {.offset = OMAP4_CM_CLKMODE_DPLL_ABE_OFFSET},
+	  .autoidle	= {.offset = OMAP4_CM_AUTOIDLE_DPLL_ABE_OFFSET},
+	  .idlest	= {.offset = OMAP4_CM_IDLEST_DPLL_ABE_OFFSET},
+	  .clksel	= {.offset = OMAP4_CM_CLKSEL_DPLL_ABE_OFFSET},
+	  .div_m2	= {.offset = OMAP4_CM_DIV_M2_DPLL_ABE_OFFSET},
+	  .div_m3	= {.offset = OMAP4_CM_DIV_M3_DPLL_ABE_OFFSET},
+	},
+	/* USB DPLL */
+	{ .name		= "usb",
+	  .mod_partition = OMAP4430_CM2_PARTITION,
+	  .mod_inst	= OMAP4430_CM2_CKGEN_INST,
+	  .clkmode	= {.offset = OMAP4_CM_CLKMODE_DPLL_USB_OFFSET},
+	  .autoidle	= {.offset = OMAP4_CM_AUTOIDLE_DPLL_USB_OFFSET},
+	  .idlest	= {.offset = OMAP4_CM_IDLEST_DPLL_USB_OFFSET},
+	  .clksel	= {.offset = OMAP4_CM_CLKSEL_DPLL_USB_OFFSET},
+	  .div_m2	= {.offset = OMAP4_CM_DIV_M2_DPLL_USB_OFFSET},
+	  .clkdcoldo	= {.offset = OMAP4_CM_CLKDCOLDO_DPLL_USB_OFFSET},
+	 },
+	/* PER DPLL */
+	{ .name		= "per",
+	  .mod_partition = OMAP4430_CM2_PARTITION,
+	  .mod_inst	= OMAP4430_CM2_CKGEN_INST,
+	  .clkmode	= {.offset = OMAP4_CM_CLKMODE_DPLL_PER_OFFSET},
+	  .autoidle	= {.offset = OMAP4_CM_AUTOIDLE_DPLL_PER_OFFSET},
+	  .idlest	= {.offset = OMAP4_CM_IDLEST_DPLL_PER_OFFSET},
+	  .clksel	= {.offset = OMAP4_CM_CLKSEL_DPLL_PER_OFFSET},
+	  .div_m2	= {.offset = OMAP4_CM_DIV_M2_DPLL_PER_OFFSET},
+	  .div_m3	= {.offset = OMAP4_CM_DIV_M3_DPLL_PER_OFFSET},
+	  .div_m4	= {.offset = OMAP4_CM_DIV_M4_DPLL_PER_OFFSET},
+	  .div_m5	= {.offset = OMAP4_CM_DIV_M5_DPLL_PER_OFFSET},
+	  .div_m6	= {.offset = OMAP4_CM_DIV_M6_DPLL_PER_OFFSET},
+	  .div_m7	= {.offset = OMAP4_CM_DIV_M7_DPLL_PER_OFFSET},
+	},
+};
 
 /* Supported only on OMAP4 */
 int omap4_dpllmx_gatectrl_read(struct clk *clk)
@@ -151,3 +242,137 @@ long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate)
 
 	return clk->dpll_data->last_rounded_rate;
 }
+
+/**
+ * omap4_dpll_read_reg - reads DPLL register value
+ * @dpll_reg: DPLL register to read
+ *
+ * Reads the value of a single DPLL register.
+ */
+static inline u32 omap4_dpll_read_reg(struct omap4_dpll_regs *dpll_reg,
+				      struct dpll_reg *tuple)
+{
+	if (tuple->offset)
+		return omap4_cminst_read_inst_reg(dpll_reg->mod_partition,
+						  dpll_reg->mod_inst,
+						  tuple->offset);
+	return 0;
+}
+
+/**
+ * omap4_dpll_store_reg - stores DPLL register value to memory location
+ * @dpll_reg: DPLL register to save
+ * @tuple: save address
+ *
+ * Saves a single DPLL register content to memory location defined by
+ * @tuple before entering device off mode.
+ */
+static inline void omap4_dpll_store_reg(struct omap4_dpll_regs *dpll_reg,
+					struct dpll_reg *tuple)
+{
+	tuple->val = omap4_dpll_read_reg(dpll_reg, tuple);
+}
+
+/**
+ * omap4_dpll_prepare_off - stores DPLL settings before off mode
+ *
+ * Saves all DPLL register settings. This must be called before
+ * entering device off.
+ */
+void omap4_dpll_prepare_off(void)
+{
+	u32 i;
+	struct omap4_dpll_regs *dpll_reg = dpll_regs;
+
+	for (i = 0; i < ARRAY_SIZE(dpll_regs); i++, dpll_reg++) {
+		omap4_dpll_store_reg(dpll_reg, &dpll_reg->clkmode);
+		omap4_dpll_store_reg(dpll_reg, &dpll_reg->autoidle);
+		omap4_dpll_store_reg(dpll_reg, &dpll_reg->clksel);
+		omap4_dpll_store_reg(dpll_reg, &dpll_reg->div_m2);
+		omap4_dpll_store_reg(dpll_reg, &dpll_reg->div_m3);
+		omap4_dpll_store_reg(dpll_reg, &dpll_reg->div_m4);
+		omap4_dpll_store_reg(dpll_reg, &dpll_reg->div_m5);
+		omap4_dpll_store_reg(dpll_reg, &dpll_reg->div_m6);
+		omap4_dpll_store_reg(dpll_reg, &dpll_reg->div_m7);
+		omap4_dpll_store_reg(dpll_reg, &dpll_reg->clkdcoldo);
+		omap4_dpll_store_reg(dpll_reg, &dpll_reg->idlest);
+	}
+}
+
+/**
+ * omap4_wait_dpll_lock - wait for a DPLL lock
+ * @dpll_reg: DPLL to wait for
+ *
+ * Waits for a DPLL lock after restore.
+ */
+static void omap4_wait_dpll_lock(struct omap4_dpll_regs *dpll_reg)
+{
+	int j = 0;
+	u32 status;
+
+	/* Return if we dont need to lock. */
+	if ((dpll_reg->clkmode.val & OMAP4430_DPLL_EN_MASK) !=
+	     DPLL_LOCKED << OMAP4430_DPLL_EN_SHIFT)
+		return;
+
+	while (1) {
+		status = (omap4_dpll_read_reg(dpll_reg, &dpll_reg->idlest)
+			  & OMAP4430_ST_DPLL_CLK_MASK)
+			 >> OMAP4430_ST_DPLL_CLK_SHIFT;
+		if (status == 0x1)
+			break;
+		if (j == MAX_DPLL_WAIT_TRIES) {
+			/* If we are unable to lock, warn and move on.. */
+			pr_err("Failed to lock dpll %s\n", dpll_reg->name);
+			break;
+		}
+		j++;
+		udelay(1);
+	}
+}
+
+/**
+ * omap4_dpll_restore_reg - restores a single register for a DPLL
+ * @dpll_reg: DPLL to restore
+ * @tuple: register value to restore
+ *
+ * Restores a single register for a DPLL.
+ */
+static inline void omap4_dpll_restore_reg(struct omap4_dpll_regs *dpll_reg,
+					  struct dpll_reg *tuple)
+{
+	if (tuple->offset)
+		omap4_cminst_write_inst_reg(tuple->val, dpll_reg->mod_partition,
+					    dpll_reg->mod_inst, tuple->offset);
+}
+
+/**
+ * omap4_dpll_resume_off - restore DPLL settings after device off
+ *
+ * Restores all DPLL settings. Must be called after wakeup from device
+ * off.
+ */
+void omap4_dpll_resume_off(void)
+{
+	u32 i;
+	struct omap4_dpll_regs *dpll_reg = dpll_regs;
+
+	for (i = 0; i < ARRAY_SIZE(dpll_regs); i++, dpll_reg++) {
+		omap4_dpll_restore_reg(dpll_reg, &dpll_reg->clksel);
+		omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m2);
+		omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m3);
+		omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m4);
+		omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m5);
+		omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m6);
+		omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m7);
+		omap4_dpll_restore_reg(dpll_reg, &dpll_reg->clkdcoldo);
+
+		/* Restore clkmode after the above registers are restored */
+		omap4_dpll_restore_reg(dpll_reg, &dpll_reg->clkmode);
+
+		omap4_wait_dpll_lock(dpll_reg);
+
+		/* Restore autoidle settings after the dpll is locked */
+		omap4_dpll_restore_reg(dpll_reg, &dpll_reg->autoidle);
+	}
+}
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 0155242..805ee38 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -60,6 +60,7 @@
 #include "prcm44xx.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
+#include "cm44xx.h"
 
 #ifdef CONFIG_SMP
 
@@ -265,10 +266,13 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * In MPUSS OSWR or device OFF, interrupt controller context is lost.
 	 */
 	mpuss_clear_prev_logic_pwrst();
-	if (pwrdm_read_next_func_pwrst(core_pd) == PWRDM_FUNC_PWRST_OFF)
+	if (pwrdm_read_next_func_pwrst(core_pd) == PWRDM_FUNC_PWRST_OFF) {
+		omap4_dpll_prepare_off();
 		save_state = 3;
-	else if (pwrdm_read_next_func_pwrst(mpuss_pd) == PWRDM_FUNC_PWRST_OSWR)
+	} else if (pwrdm_read_next_func_pwrst(mpuss_pd) ==
+		   PWRDM_FUNC_PWRST_OSWR) {
 		save_state = 2;
+	}
 
 	cpu_clear_prev_logic_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
@@ -291,6 +295,9 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	wakeup_cpu = smp_processor_id();
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_FUNC_PWRST_ON);
 
+	if (pwrdm_read_prev_func_pwrst(core_pd) == PWRDM_FUNC_PWRST_OFF)
+		omap4_dpll_resume_off();
+
 	pwrdm_post_transition();
 
 	return 0;
-- 
1.7.4.1

