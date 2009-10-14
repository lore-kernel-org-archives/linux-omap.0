From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 13/27] OMAP3 PM: off-mode support for HS/EMU devices
Date: Wed, 14 Oct 2009 14:57:56 -0700
Message-ID: <1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:56230 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761267AbZJNV7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 17:59:12 -0400
Received: by pzk26 with SMTP id 26so195749pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 14:58:35 -0700 (PDT)
In-Reply-To: <1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/control.c   |    8 ++++-
 arch/arm/mach-omap2/pm.h        |    3 ++
 arch/arm/mach-omap2/pm34xx.c    |   44 ++++++++++++++++++++++-
 arch/arm/mach-omap2/sleep34xx.S |   75 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 58ba6ee..6c462c7 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -84,6 +84,8 @@ struct omap3_scratchpad_sdrc_block {
 	u32 block_size;
 };
 
+void *omap3_secure_ram_storage;
+
 /*
  * This is used to store ARM registers in SDRAM before attempting
  * an MPU OFF. The save and restore happens from the SRAM sleep code.
@@ -207,7 +209,11 @@ void omap3_save_scratchpad_contents(void)
 	scratchpad_contents.boot_config_ptr = 0x0;
 	scratchpad_contents.public_restore_ptr =
 			 virt_to_phys(get_restore_pointer());
-	scratchpad_contents.secure_ram_restore_ptr = 0x0;
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+		scratchpad_contents.secure_ram_restore_ptr = 0x0;
+	else
+		scratchpad_contents.secure_ram_restore_ptr =
+			(u32) __pa(omap3_secure_ram_storage);
 	scratchpad_contents.sdrc_module_semaphore = 0x0;
 	scratchpad_contents.prcm_block_offset = 0x2C;
 	scratchpad_contents.sdrc_block_offset = 0x64;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 8400f57..f1d0214 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -13,6 +13,8 @@
 
 #include <mach/powerdomain.h>
 
+extern void *omap3_secure_ram_storage;
+
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
@@ -36,6 +38,7 @@ extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
 					void __iomem *sdrc_power);
 extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
 extern void save_secure_ram_context(u32 *addr);
+extern void omap3_save_scratchpad_contents(void);
 
 extern unsigned int omap24xx_idle_loop_suspend_sz;
 extern unsigned int omap34xx_suspend_sz;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 764bf2c..b8055f9 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -33,6 +33,7 @@
 #include <mach/control.h>
 #include <mach/serial.h>
 #include <mach/sdrc.h>
+#include <mach/dma.h>
 #include <mach/gpmc.h>
 #include <mach/dma.h>
 
@@ -63,6 +64,8 @@ static LIST_HEAD(pwrst_list);
 
 static void (*_omap_sram_idle)(u32 *addr, int save_state);
 
+static int (*_omap_save_secure_sram)(u32 *addr);
+
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 
@@ -110,6 +113,33 @@ static void omap3_core_restore_context(void)
 	omap_dma_global_context_restore();
 }
 
+static void omap3_save_secure_ram_context(u32 target_mpu_state)
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
+		ret = _omap_save_secure_sram((u32 *)
+				__pa(omap3_secure_ram_storage));
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
 /*
  * PRCM Interrupt Handler Helper Function
  *
@@ -308,6 +338,7 @@ static void omap_sram_idle(void)
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_prcm_save_context();
+			omap3_save_secure_ram_context(mpu_next_state);
 		}
 		/* Enable IO-PAD wakeup */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
@@ -900,6 +931,9 @@ void omap_push_sram_idle(void)
 {
 	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
 					omap34xx_cpu_suspend_sz);
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+		_omap_save_secure_sram = omap_sram_push(save_secure_ram_context,
+				save_secure_ram_context_sz);
 }
 
 static int __init omap3_pm_init(void)
@@ -915,7 +949,6 @@ static int __init omap3_pm_init(void)
 	/* XXX prcm_setup_regs needs to be before enabling hw
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
-	omap3_save_scratchpad_contents();
 
 	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
 			  (irq_handler_t)prcm_interrupt_handler,
@@ -960,6 +993,15 @@ static int __init omap3_pm_init(void)
 	*/
 	pwrdm_add_wkdep(per_pwrdm, core_pwrdm);
 
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+		omap3_secure_ram_storage =
+			kmalloc(0x803F, GFP_KERNEL);
+		if (!omap3_secure_ram_storage)
+			printk(KERN_ERR "Memory allocation failed when"
+					"allocating for secure sram context\n");
+	}
+	omap3_save_scratchpad_contents();
+
 err1:
 	return ret;
 err2:
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 5e761ec..a099816 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -37,6 +37,8 @@
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
 #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + PM_PWSTCTRL
+#define SRAM_BASE_P		0x40200000
+#define CONTROL_STAT		0x480022F0
 #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
 				       * available */
 #define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
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
+	mov	r12, r0			@ copy secure service ID in r12
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
@@ -107,9 +143,44 @@ restore:
         moveq   r9, #0x3        @ MPU OFF => L1 and L2 lost
 	movne	r9, #0x1	@ Only L1 and L2 lost => avoid L2 invalidation
 	bne	logic_l1_restore
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
+	.word   0x1, 0x00
+write_aux_control_params:
+	.word   0x1, 0x72
+l2_inv_gp:
 	/* Execute smi to invalidate L2 cache */
 	mov r12, #0x1                         @ set up to invalide L2
-smi:    .word 0xE1600070                @ Call SMI monitor (smieq)
+smi:    .word 0xE1600070		@ Call SMI monitor (smieq)
+	/* Write to Aux control register to set some bits */
+	mov	r0, #0x72
+	mov	r12, #0x3
+	.word 0xE1600070	@ Call SMI monitor (smieq)
 logic_l1_restore:
 	mov	r1, #0
 	/* Invalidate all instruction caches to PoU
@@ -429,5 +500,7 @@ table_entry:
 	.word	0x00000C02
 cache_pred_disable_mask:
 	.word	0xFFFFE7FB
+control_stat:
+	.word	CONTROL_STAT
 ENTRY(omap34xx_cpu_suspend_sz)
 	.word	. - omap34xx_cpu_suspend
-- 
1.6.4.3

