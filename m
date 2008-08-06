From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 05/11] scratchpad contents
Date: Wed, 6 Aug 2008 18:44:56 +0530 (IST)
Message-ID: <43883.192.168.10.89.1218028496.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33740 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753682AbYHFNPD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Aug 2008 09:15:03 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m76DEvhQ013922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:15:02 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id m76DErmq023664
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:14:55 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch populates the scratchpad

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/pm.h        |    7 +
 arch/arm/mach-omap2/pm34xx.c    |  168 +++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/sleep34xx.S |    8 -
 include/asm-arm/arch-omap/pm.h  |    4
 4 files changed, 180 insertions(+), 7 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.h	2008-08-06 18:08:02.000000000
+0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm.h	2008-08-06 18:10:48.000000000 +0530
@@ -24,6 +24,13 @@ extern void omap2_block_sleep(void);
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
Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-08-06
18:09:48.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-08-06 18:10:48.000000000
+0530
@@ -30,6 +30,9 @@
 #include <asm/arch/clockdomain.h>
 #include <asm/arch/powerdomain.h>
 #include <asm/arch/common.h>
+#include <asm/arch/sdrc.h>
+#include <asm/tlbflush.h>
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

 void (*_omap_sram_idle)(u32 *addr, int save_state, int disable_clocks);
@@ -176,6 +188,35 @@ static irqreturn_t prcm_interrupt_handle
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
@@ -196,13 +237,19 @@ void omap_sram_idle(void)
 		/* No need to save context */
 		save_state = 0;
 		break;
+	case PWRDM_POWER_OFF:
+		save_state = 3;
+		break;
 	default:
 		/* Invalid state */
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
 		return;
 	}

-	_omap_sram_idle(NULL, save_state, clocks_off_while_idle);
+	_omap_sram_idle(context_mem, save_state, clocks_off_while_idle);
+	/* Restore table entry modified during MMU restoration */
+	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == 0x0)
+		restore_table_entry();
 }

 static int omap3_fclks_active(void)
@@ -591,7 +638,10 @@ static int __init pwrdms_setup(struct po
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
@@ -660,6 +710,120 @@ err2:
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
Index: linux-omap-2.6/arch/arm/mach-omap2/sleep34xx.S
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/sleep34xx.S	2008-08-06
18:07:31.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/sleep34xx.S	2008-08-06
18:10:48.000000000 +0530
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
Index: linux-omap-2.6/include/asm-arm/arch-omap/pm.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/pm.h	2008-08-06
18:07:31.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/pm.h	2008-08-06 18:10:48.000000000
+0530
@@ -153,6 +153,10 @@ extern void omap1510_idle_loop_suspend(v
 extern void omap1610_idle_loop_suspend(void);
 extern void omap242x_idle_loop_suspend(void);
 extern void omap243x_idle_loop_suspend(void);
+extern void save_scratchpad_contents(void);
+extern void clear_scratchpad_contents(void);
+extern u32 *get_restore_pointer(void);
+extern void vfp_enable(void);

 extern unsigned int omap730_cpu_suspend_sz;
 extern unsigned int omap1510_cpu_suspend_sz;


