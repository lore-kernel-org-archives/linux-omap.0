From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 3/6] PM: OMAP3 HS/EMU off-mode support
Date: Tue, 14 Oct 2008 15:23:28 +0300
Message-ID: <1223987011-25667-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1223987011-25667-1-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-2-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26848 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616AbYJNKhz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 06:37:55 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9EAbpIN023100
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 05:37:52 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9EAbjLv000373
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:37:50 +0300
In-Reply-To: <1223987011-25667-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c         |   58 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/sleep34xx.S      |   74 ++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/pm.h |    2 +
 3 files changed, 132 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/pm34xx.c
 mode change 100644 => 100755 arch/arm/mach-omap2/sleep34xx.S
 mode change 100644 => 100755 arch/arm/plat-omap/include/mach/pm.h

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
old mode 100644
new mode 100755
index 9d97dd6..d5892c5
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -31,6 +31,7 @@
 #include <mach/powerdomain.h>
 #include <mach/common.h>
 #include <mach/sdrc.h>
+#include <mach/dma.h>
 #include <asm/tlbflush.h>
 #include "sdrc.h"
 
@@ -55,6 +56,11 @@ struct power_state {
 	struct list_head node;
 };
 
+struct sram_mem {
+	u32 i[32000];
+};
+struct sram_mem *sdram_mem;
+
 u32 *scratchpad_restore_addr;
 u32 restore_pointer_address;
 
@@ -62,6 +68,8 @@ static LIST_HEAD(pwrst_list);
 
 void (*_omap_sram_idle)(u32 *addr, int save_state);
 
+static int (*_omap_save_secure_sram)(u32 *addr);
+
 static void (*saved_idle)(void);
 
 static struct powerdomain *mpu_pwrdm;
@@ -208,6 +216,32 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+void omap3_save_secure_ram_context(u32 target_mpu_state)
+{
+	u32 ret;
+
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+		/* Disable dma irq before calling secure rom code API */
+		omap_dma_disable_irq(0);
+		omap_dma_disable_irq(1);
+		/*
+		 * MPU next state must be set to POWER_ON temporarily,
+		 * otherwise the WFI executed inside the ROM code
+		 * will hang the system.
+		 */
+		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
+		ret = _omap_save_secure_sram((u32 *)__pa(sdram_mem));
+		pwrdm_set_next_pwrst(mpu_pwrdm, target_mpu_state);
+		/* Following is for error tracking, it should not happen */
+		if (ret) {
+			printk(KERN_ERR "save_secure_sram() returns %08x\n",
+				ret);
+			while (1)
+				;
+		}
+	}
+}
+
 static void restore_control_register(u32 val)
 {
 	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
@@ -249,6 +283,7 @@ void omap_sram_idle(void)
 	int mpu_next_state = PWRDM_POWER_ON, core_next_state = PWRDM_POWER_ON,
 		per_next_state = PWRDM_POWER_ON;
 	int mpu_prev_state, core_prev_state, per_prev_state;
+	u32 sdrc_pwr;
 
 	if (!_omap_sram_idle)
 		return;
@@ -304,6 +339,7 @@ void omap_sram_idle(void)
 			omap3_save_core_ctx();
 			omap_save_uart_ctx(0);
 			omap_save_uart_ctx(1);
+			omap3_save_secure_ram_context(mpu_next_state);
 		}
 		omap_serial_enable_clocks(0, 0);
 		omap_serial_enable_clocks(0, 1);
@@ -809,6 +845,9 @@ void omap_push_sram_idle()
 {
 	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
 					omap34xx_cpu_suspend_sz);
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+		_omap_save_secure_sram = omap_sram_push(save_secure_ram_context,
+				save_secure_ram_context_sz);
 }
 
 int __init omap3_pm_init(void)
@@ -822,7 +861,6 @@ int __init omap3_pm_init(void)
 	/* XXX prcm_setup_regs needs to be before enabling hw
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
-	save_scratchpad_contents();
 
 	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
 			  (irq_handler_t)prcm_interrupt_handler,
@@ -867,6 +905,19 @@ int __init omap3_pm_init(void)
 	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
 	pwrdm_add_wkdep(per_pwrdm, core_pwrdm);
 
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+		sdram_mem = kmalloc(sizeof(struct sram_mem), GFP_KERNEL);
+		if (!sdram_mem)
+			printk(KERN_ERR "Memory allocation failed when"
+				"allocating for secure sram context\n");
+	}
+	save_scratchpad_contents();
+
+	printk(KERN_INFO "system_rev=%08x\n", system_rev);
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+		printk(KERN_INFO "GP device\n");
+	else
+		printk(KERN_INFO "non-GP device\n");
 err1:
 	return ret;
 err2:
@@ -921,7 +972,10 @@ void save_scratchpad_contents(void)
 	restore_pointer_address = (u32) restore_address;
 	*(scratchpad_address++) = 0x0;
 	/* Secure ram restore pointer */
-	*(scratchpad_address++) = 0x0;
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+		*(scratchpad_address++) = 0x0;
+	else
+		*(scratchpad_address++) = (u32) __pa(sdram_mem);
 	/* SDRC Module semaphore */
 	*(scratchpad_address++) = 0x0;
 	/* PRCM Block Offset */
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
old mode 100644
new mode 100755
index efafa7e..a2bdab2
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -38,6 +38,8 @@
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
 #define PM_PWSTCTRL_MPU_P	0x483069E0
+#define SRAM_BASE_P		0x40200000
+#define CONTROL_STAT		0x480022F0
 #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
 				       * available */
 #define SCRATCHPAD_BASE_P	0x48002910
@@ -51,6 +53,40 @@ ENTRY(get_restore_pointer)
         ldmfd   sp!, {pc}     @ restore regs and return
 ENTRY(get_restore_pointer_sz)
         .word   . - get_restore_pointer_sz
+
+/* Function to call rom code to save secure ram context */
+ENTRY(save_secure_ram_context)
+	stmfd	sp!, {r1-r12, lr}	@ save registers on stack
+save_secure_ram_debug:
+	/* b save_secure_ram_debug */	@ enable to debug save code
+	adr	r3, api_params		@ r3 points to parameters
+	str	r0, [r3,#0x4]		@ r0 has sdram address
+	ldr	r12, high_mask
+	and	r3, r3, r12
+	ldr	r12, sram_phy_addr_mask
+	orr	r3, r3, r12
+	mov	r0, #25			@ set service ID for PPA
+	mov	r12, r0			@ copy secure Service ID in r12
+	mov	r1, #0			@ set task id for ROM code in r1
+	mov	r2, #7			@ set some flags in r2, r6
+	mov	r6, #0xff
+	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
+	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
+	.word	0xE1600071		@ call SMI monitor (smi #1)
+	nop
+	nop
+	nop
+	nop
+	ldmfd	sp!, {r1-r12, pc}
+sram_phy_addr_mask:
+	.word	SRAM_BASE_P
+high_mask:
+	.word	0xffff
+api_params:
+	.word	0x4, 0x0, 0x0, 0x1, 0x1
+ENTRY(save_secure_ram_context_sz)
+	.word	. - save_secure_ram_context
+
 /*
  * Forces OMAP into idle state
  *
@@ -107,9 +143,45 @@ restore:
         moveq   r9, #0x3        @ MPU OFF => L1 and L2 lost
 	movne	r9, #0x1	@ Only L1 and L2 lost => avoid L2 invalidation
 	bne	logic_l1_restore
+
+	ldr	r0, control_stat
+	ldr	r1, [r0]
+	and	r1, #0x700
+	cmp	r1, #0x300
+	beq	l2_inv_gp
+	mov	r0, #40		@ set service ID for PPA
+	mov	r12, r0		@ copy secure Service ID in r12
+	mov	r1, #0		@ set task id for ROM code in r1
+	mov	r2, #4		@ set some flags in r2, r6
+	mov	r6, #0xff
+	adr	r3, l2_inv_api_params	@ r3 points to dummy parameters
+	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
+	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
+	.word	0xE1600071		@ call SMI monitor (smi #1)
+	/* Write to Aux control register to set some bits */
+	mov	r0, #42		@ set service ID for PPA
+	mov	r12, r0		@ copy secure Service ID in r12
+	mov	r1, #0		@ set task id for ROM code in r1
+	mov	r2, #4		@ set some flags in r2, r6
+	mov	r6, #0xff
+	adr	r3, write_aux_control_params	@ r3 points to parameters
+	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
+	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
+	.word	0xE1600071		@ call SMI monitor (smi #1)
+
+	b	logic_l1_restore
+l2_inv_api_params:
+	.word	0x1, 0x00
+write_aux_control_params:
+	.word	0x1, 0x72
+l2_inv_gp:
 	/* Execute smi to invalidate L2 cache */
 	mov r12, #0x1                         @ set up to invalide L2
 smi:    .word 0xE1600070                @ Call SMI monitor (smieq)
+	/* Write to Aux control register to set some bits */
+	mov	r0, #0x72
+	mov	r12, #0x3
+	.word 0xE1600070		@ Call SMI monitor (smieq)
 logic_l1_restore:
 	mov	r1, #0
 	/* Invalidate all instruction caches to PoU
@@ -540,5 +612,7 @@ table_entry:
 	.word	0x00000C02
 cache_pred_disable_mask:
 	.word	0xFFFFE7FB
+control_stat:
+	.word	CONTROL_STAT
 ENTRY(omap34xx_cpu_suspend_sz)
 	.word	. - omap34xx_cpu_suspend
diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
old mode 100644
new mode 100755
index fd08490..532ffe9
--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -148,6 +148,7 @@ extern void omap1610_cpu_suspend(unsigned short, unsigned short);
 extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
 					void __iomem *sdrc_power);
 extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
+extern void save_secure_ram_context(u32 *addr);
 extern void omap730_idle_loop_suspend(void);
 extern void omap1510_idle_loop_suspend(void);
 extern void omap1610_idle_loop_suspend(void);
@@ -168,6 +169,7 @@ extern unsigned int omap1510_idle_loop_suspend_sz;
 extern unsigned int omap1610_idle_loop_suspend_sz;
 extern unsigned int omap24xx_idle_loop_suspend_sz;
 extern unsigned int omap34xx_suspend_sz;
+extern unsigned int save_secure_ram_context_sz;
 
 #ifdef CONFIG_OMAP_SERIAL_WAKE
 extern void omap_serial_wake_trigger(int enable);
-- 
1.5.4.3

