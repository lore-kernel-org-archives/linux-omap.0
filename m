From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 08/29] scratchpad contents
Date: Thu, 11 Sep 2008 15:33:52 +0300
Message-ID: <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43052 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123AbYIKMea (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:30 -0400
In-Reply-To: <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch populates the scratchpad
---
 arch/arm/mach-omap2/pm.h             |    7 ++
 arch/arm/mach-omap2/pm34xx.c         |  170 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/sleep34xx.S      |    8 +-
 arch/arm/plat-omap/include/mach/pm.h |    5 +
 4 files changed, 181 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 19da5c7..7776cdb 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -24,6 +24,13 @@ extern atomic_t sleep_block;
 extern void omap2_block_sleep(void);
 extern void omap2_allow_sleep(void);
 
+#define SCRATCHPAD_ROM  		0x48002860
+#define SCRATCHPAD      		0x48002910
+#define SCRATHPAD_ROM_OFFSET    	0x19C
+#define TABLE_ADDRESS_OFFSET    	0x31
+#define TABLE_VALUE_OFFSET      	0x30
+#define CONTROL_REG_VALUE_OFFSET	0x32
+
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern int omap2_pm_debug;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0646595..acfca0b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -30,6 +30,9 @@
 #include <mach/clockdomain.h>
 #include <mach/powerdomain.h>
 #include <mach/common.h>
+#include <mach/sdrc.h>
+#include <mach/tlbflush.h>
+#include "sdrc.h"
 
 #include "cm.h"
 #include "cm-regbits-34xx.h"
@@ -38,6 +41,12 @@
 #include "prm.h"
 #include "pm.h"
 #include "smartreflex.h"
+#include "clock34xx.h"
+
+#define OMAP3430_PRM_RSTST      \
+	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
+
+u32 context_mem[128];
 
 struct power_state {
 	struct powerdomain *pwrdm;
@@ -46,6 +55,9 @@ struct power_state {
 	struct list_head node;
 };
 
+u32 *scratchpad_restore_addr;
+u32 restore_pointer_address;
+
 static LIST_HEAD(pwrst_list);
 
 static void (*_omap_sram_idle)(u32 *addr, int save_state);
@@ -185,6 +197,35 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void restore_control_register(u32 val)
+{
+	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
+}
+
+/* Function to restore the table entry that was modified for enabling MMU*/
+static void restore_table_entry(void)
+{
+	u32 *scratchpad_address;
+	u32 previous_value, control_reg_value;
+	u32 *address;
+	/* Get virtual address of SCRATCHPAD */
+	scratchpad_address = (u32 *) io_p2v(SCRATCHPAD);
+	/* Get address of entry that was modified */
+	address = (u32 *) *(scratchpad_address + TABLE_ADDRESS_OFFSET);
+	/* Get the previous value which needs to be restored */
+	previous_value = *(scratchpad_address + TABLE_VALUE_OFFSET);
+	/* Convert address to virtual address */
+	address = __va(address);
+	/* Restore table entry */
+	*address = previous_value;
+	/* Flush TLB */
+	flush_tlb_all();
+	control_reg_value = *(scratchpad_address + CONTROL_REG_VALUE_OFFSET);
+	/* Restore control register*/
+	/* This will enable caches and prediction */
+	restore_control_register(control_reg_value);
+}
+
 void omap_sram_idle(void)
 {
 	/* Variable to tell what needs to be saved and restored
@@ -205,6 +246,9 @@ void omap_sram_idle(void)
 		/* No need to save context */
 		save_state = 0;
 		break;
+	case PWRDM_POWER_OFF:
+		save_state = 3;
+		break;
 	default:
 		/* Invalid state */
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
@@ -213,9 +257,10 @@ void omap_sram_idle(void)
 
 	pm_dbg_pre_suspend();
 
-	_omap_sram_idle(NULL, save_state);
-
-	omap2_gpio_resume_after_retention();
+	_omap_sram_idle(context_mem, save_state);
+	/* Restore table entry modified during MMU restoration */
+	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == 0x0)
+		restore_table_entry();
 
 	pm_dbg_post_suspend();
 }
@@ -677,7 +722,10 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm"))
+		pwrst->next_state = PWRDM_POWER_RET;
+	else
+		pwrst->next_state = PWRDM_POWER_OFF;
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
@@ -764,6 +812,120 @@ err2:
 	return ret;
 }
 
+/* Clears the scratchpad contents in case of cold boot- called during bootup*/
+void clear_scratchpad_contents(void)
+{
+	u32 max_offset = SCRATHPAD_ROM_OFFSET;
+	u32 offset = 0;
+	u32 v;
+	u32 v_addr = io_p2v(SCRATCHPAD_ROM);
+	if (__raw_readl(OMAP3430_PRM_RSTST) & 0x1) {
+		for ( ; offset <= max_offset; offset += 0x4)
+			 __raw_writel(0x0, (v_addr + offset));
+		v = __raw_readl(OMAP3430_PRM_RSTST);
+		v |= 0x1;
+		__raw_writel(v, OMAP3430_PRM_RSTST);
+	}
+}
+
+/* Populate the scratchpad structure with restore structure */
+void save_scratchpad_contents(void)
+{
+	u32 *scratchpad_address;
+	u32 *restore_address;
+	u32 *sdram_context_address;
+
+	/* Get virtual address of SCRATCHPAD */
+	scratchpad_address = (u32 *) io_p2v(SCRATCHPAD);
+	/* Get Restore pointer to jump to while waking up from OFF */
+	restore_address = get_restore_pointer();
+	/* Convert it to physical address */
+	restore_address = (u32 *) io_v2p(restore_address);
+	/* Get address where registers are saved in SDRAM */
+	sdram_context_address = (u32 *) io_v2p(context_mem);
+	/* Booting configuration pointer*/
+	*(scratchpad_address++) = 0x0;
+	/* Public restore pointer */
+	/* On ES 2.0, if scrathpad is populated with valid
+	* pointer, warm reset does not work
+	* So populate scrathpad restore address only in
+	* cpuidle and suspend calls
+	*/
+	scratchpad_restore_addr = scratchpad_address;
+	restore_pointer_address = (u32) restore_address;
+	*(scratchpad_address++) = 0x0;
+	/* Secure ram restore pointer */
+	*(scratchpad_address++) = 0x0;
+	/* SDRC Module semaphore */
+	*(scratchpad_address++) = 0x0;
+	/* PRCM Block Offset */
+	*(scratchpad_address++) = 0x2C;
+	/* SDRC Block Offset */
+	*(scratchpad_address++) = 0x64;
+	/* Empty */
+	/* Offset 0x8*/
+	*(scratchpad_address++) = 0x0;
+	*(scratchpad_address++) = 0x0;
+	/* Offset 0xC*/
+	*(scratchpad_address++) = 0x0;
+	/* Offset 0x10*/
+	*(scratchpad_address++) = 0x0;
+	/* Offset 0x14*/
+	*(scratchpad_address++) = 0x0;
+	/* Offset 0x18*/
+	/* PRCM Block */
+	*(scratchpad_address++) = __raw_readl(OMAP3430_PRM_CLKSRC_CTRL);
+	*(scratchpad_address++) = __raw_readl(OMAP3430_PRM_CLKSEL);
+	*(scratchpad_address++) = cm_read_mod_reg(CORE_MOD, CM_CLKSEL);
+	*(scratchpad_address++) = cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
+	*(scratchpad_address++) = cm_read_mod_reg(PLL_MOD,
+				      OMAP3430_CM_CLKEN_PLL);
+	*(scratchpad_address++) = cm_read_mod_reg(PLL_MOD,
+				      OMAP3430_CM_AUTOIDLE_PLL);
+	*(scratchpad_address++) = cm_read_mod_reg(PLL_MOD,
+				      OMAP3430_CM_CLKSEL1_PLL);
+	*(scratchpad_address++) = cm_read_mod_reg(PLL_MOD,
+				      OMAP3430_CM_CLKSEL2_PLL);
+	*(scratchpad_address++) = cm_read_mod_reg(PLL_MOD,
+				      OMAP3430_CM_CLKSEL3);
+	*(scratchpad_address++) = cm_read_mod_reg(MPU_MOD,
+				      OMAP3430_CM_CLKEN_PLL);
+	*(scratchpad_address++) = cm_read_mod_reg(MPU_MOD,
+				      OMAP3430_CM_AUTOIDLE_PLL);
+	*(scratchpad_address++) = cm_read_mod_reg(MPU_MOD,
+				      OMAP3430_CM_CLKSEL1_PLL);
+	*(scratchpad_address++) = cm_read_mod_reg(MPU_MOD,
+				      OMAP3430_CM_CLKSEL2_PLL);
+	*(scratchpad_address++) = 0x0;
+	/* SDRC Block */
+	*(scratchpad_address++) = (((sdrc_read_reg(SDRC_CS_CFG) & 0xFFFF) << 16)
+			       | (sdrc_read_reg(SDRC_SYSCONFIG) & 0xFFFF));
+	*(scratchpad_address++) = (((sdrc_read_reg(SDRC_ERR_TYPE)
+			       & 0xFFFF) << 16)
+			       | (sdrc_read_reg(SDRC_SHARING) & 0xFFFF));
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_DLLA_CTRL);
+	*(scratchpad_address++) = 0x0;
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_POWER);
+	*(scratchpad_address++) = 0x0;
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_MCFG_0);
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_MR_0) & 0xFFFF;
+	*(scratchpad_address++) = 0x0;
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_ACTIM_CTRL_A_0);
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_ACTIM_CTRL_B_0);
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_RFR_CTRL_0);
+	*(scratchpad_address++) = 0x0;
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_MCFG_1);
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_MR_1) & 0xFFFF;
+	*(scratchpad_address++) = 0x0;
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_ACTIM_CTRL_A_1);
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_ACTIM_CTRL_B_1);
+	*(scratchpad_address++) = sdrc_read_reg(SDRC_RFR_CTRL_1);
+	*(scratchpad_address++) = 0x0;
+	*(scratchpad_address++) = 0x0;
+	*(scratchpad_address++) = 0x0;
+	*(scratchpad_address++) = (u32) sdram_context_address;
+}
+
 static void __init configure_vc(void)
 {
 	prm_write_mod_reg((R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA1_SHIFT) |
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 125b75a..7cce8ef 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -37,12 +37,10 @@
 				OMAP3430_PM_PREPWSTST)
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
-#define PM_PWSTCTRL_MPU_P	OMAP34XX_PRM_REGADDR(MPU_MOD, PM_PWSTCTRL)
+#define PM_PWSTCTRL_MPU_P	0x483069E0
 #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
 				       * available */
-#define SCRATCHPAD_BASE_P	OMAP343X_CTRL_REGADDR(\
-				OMAP343X_CONTROL_MEM_WKUP +\
-				SCRATCHPAD_MEM_OFFS)
+#define SCRATCHPAD_BASE_P	0x48002910
 #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
 
 	.text
@@ -97,7 +95,7 @@ loop:
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
 restore:
-	/* b restore*/ 	@ Enable to debug restore code
+	/* b restore*/  @ Enable to debug restore code
         /* Check what was the reason for mpu reset and store the reason in r9*/
         /* 1 - Only L1 and logic lost */
         /* 2 - Only L2 lost - In this case, we wont be here */
diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
index e4cf1c5..fd08490 100644
--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -153,6 +153,11 @@ extern void omap1510_idle_loop_suspend(void);
 extern void omap1610_idle_loop_suspend(void);
 extern void omap24xx_idle_loop_suspend(void);
 
+extern void save_scratchpad_contents(void);
+extern void clear_scratchpad_contents(void);
+extern u32 *get_restore_pointer(void);
+extern void vfp_enable(void);
+
 extern unsigned int omap730_cpu_suspend_sz;
 extern unsigned int omap1510_cpu_suspend_sz;
 extern unsigned int omap1610_cpu_suspend_sz;
-- 
1.6.0

