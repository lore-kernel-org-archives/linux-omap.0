From: Russ Dill <Russ.Dill@ti.com>
Subject: [RFC 4/4] ARM: AM33XX: Move suspend/resume assembly to C
Date: Tue,  3 Sep 2013 09:44:25 -0700
Message-ID: <1378226665-27090-5-git-send-email-Russ.Dill@ti.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:55659 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068Ab3ICQoh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 12:44:37 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so6644820pad.18
        for <linux-omap@vger.kernel.org>; Tue, 03 Sep 2013 09:44:36 -0700 (PDT)
In-Reply-To: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, mans@mansr.com

This provides a proof of concept of the SRAM helpers. The
SRAM_SECTIONS macro is added to vmlinux.lds.S, the code
in sleep33xx.S is translated to C and moved to sleep33xx.c.
In the process, a struct used for passing arguments is
removed and instead the fixed arguments are only passed
once at init time, only an argument with some flags
remains.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/kernel/vmlinux.lds.S   |   2 +
 arch/arm/mach-omap2/Makefile    |   2 +-
 arch/arm/mach-omap2/pm33xx.c    |  50 ++---
 arch/arm/mach-omap2/pm33xx.h    |  23 +--
 arch/arm/mach-omap2/sleep33xx.S | 394 ----------------------------------------
 arch/arm/mach-omap2/sleep33xx.c | 309 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sram.c      |  15 --
 7 files changed, 339 insertions(+), 456 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/sleep33xx.S
 create mode 100644 arch/arm/mach-omap2/sleep33xx.c

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 7bcee5c..21c3b64 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -112,6 +112,8 @@ SECTIONS
 			ARM_CPU_KEEP(PROC_INFO)
 	}
 
+	SRAM_SECTIONS(am33xx)
+
 	RO_DATA(PAGE_SIZE)
 
 	. = ALIGN(4);
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index dcf5d89..195485c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -95,7 +95,7 @@ obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
-AFLAGS_sleep33xx.o			:=-Wa,-march=armv7-a$(plus_sec)
+CFLAGS_sleep33xx.o			+= -fPIC -march=armv7-a
 
 endif
 
diff --git a/arch/arm/mach-omap2/pm33xx.c b/arch/arm/mach-omap2/pm33xx.c
index ea36415..0cd3e76 100644
--- a/arch/arm/mach-omap2/pm33xx.c
+++ b/arch/arm/mach-omap2/pm33xx.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/ti_emif.h>
+#include <linux/sram.h>
 #include <linux/omap-mailbox.h>
 
 #include <asm/suspend.h>
@@ -45,8 +46,8 @@
 #include "omap_hwmod.h"
 #include "omap_device.h"
 #include "soc.h"
-#include "sram.h"
 
+static unsigned long am33xx_wfi_flags;
 static void __iomem *am33xx_emif_base;
 static struct powerdomain *cefuse_pwrdm, *gfx_pwrdm, *per_pwrdm, *mpu_pwrdm;
 static struct clockdomain *gfx_l4ls_clkdm;
@@ -61,9 +62,6 @@ struct forced_standby_module am33xx_mod[] = {
 	{.oh_name = "cpgmac0"},
 };
 
-static void (*am33xx_do_wfi_sram)(struct am33xx_suspend_params *);
-static struct am33xx_suspend_params susp_params;
-
 #ifdef CONFIG_SUSPEND
 
 struct wakeup_src wakeups[] = {
@@ -87,11 +85,6 @@ static DECLARE_COMPLETION(am33xx_pm_sync);
 
 #endif
 
-static int am33xx_do_sram_idle(long unsigned int arg)
-{
-	am33xx_do_wfi_sram((struct am33xx_suspend_params *) arg);
-	return 0;
-}
 
 int am33xx_do_sram_cpuidle(u32 wfi_flags, u32 m3_flags)
 {
@@ -158,8 +151,7 @@ static int am33xx_pm_suspend(void)
 
 	/* Try to put GFX to sleep */
 	omap_set_pwrdm_state(gfx_pwrdm, PWRDM_POWER_OFF);
-	ret = cpu_suspend((long unsigned int) &susp_params,
-							am33xx_do_sram_idle);
+	ret = cpu_suspend(am33xx_wfi_flags, am33xx_suspend);
 
 	status = pwrdm_read_prev_pwrst(gfx_pwrdm);
 	if (status != PWRDM_POWER_OFF)
@@ -366,6 +358,7 @@ static void am33xx_pm_firmware_cb(const struct firmware *fw, void *context)
 {
 	struct am33xx_pm_context *am33xx_pm = context;
 	int ret = 0;
+	unsigned long sram_trampoline;
 
 	/* no firmware found */
 	if (!fw) {
@@ -395,8 +388,8 @@ static void am33xx_pm_firmware_cb(const struct firmware *fw, void *context)
 	}
 
 	/* Physical resume address to be used by ROM code */
-	am33xx_pm->ipc.resume_addr = (AM33XX_OCMC_END -
-		am33xx_do_wfi_sz + am33xx_resume_offset + 0x4);
+	sram_trampoline = (long) kern_to_sram(&am33xx_resume_trampoline);
+	am33xx_pm->ipc.resume_addr = sram_to_phys(sram_trampoline);
 
 	am33xx_pm->mbox = omap_mbox_get("wkup_m3", &wkup_mbox_notifier);
 
@@ -413,15 +406,6 @@ static void am33xx_pm_firmware_cb(const struct firmware *fw, void *context)
 
 #endif /* CONFIG_SUSPEND */
 
-/*
- * Push the minimal suspend-resume code to SRAM
- */
-void am33xx_push_sram_idle(void)
-{
-	am33xx_do_wfi_sram = (void *)omap_sram_push
-					(am33xx_do_wfi, am33xx_do_wfi_sz);
-}
-
 static int __init am33xx_map_emif(void)
 {
 	am33xx_emif_base = ioremap(AM33XX_EMIF_BASE, SZ_32K);
@@ -480,21 +464,27 @@ int __init am33xx_pm_init(void)
 	temp = readl(am33xx_emif_base + EMIF_SDRAM_CONFIG);
 	temp = (temp & SDRAM_TYPE_MASK) >> SDRAM_TYPE_SHIFT;
 	/* Parameters to pass to assembly code */
-	susp_params.wfi_flags = 0;
-	susp_params.emif_addr_virt = am33xx_emif_base;
-	susp_params.dram_sync = am33xx_dram_sync;
+	am33xx_wfi_flags = 0;
 	am33xx_pm->ipc.param3 = temp;
 	switch (temp) {
 	case MEM_TYPE_DDR2:
-		susp_params.wfi_flags |= WFI_MEM_TYPE_DDR2;
+		am33xx_wfi_flags |= WFI_MEM_TYPE_DDR2;
 		break;
 	case MEM_TYPE_DDR3:
-		susp_params.wfi_flags |= WFI_MEM_TYPE_DDR3;
+		am33xx_wfi_flags |= WFI_MEM_TYPE_DDR3;
 		break;
 	}
-	susp_params.wfi_flags |= WFI_SELF_REFRESH;
-	susp_params.wfi_flags |= WFI_SAVE_EMIF;
-	susp_params.wfi_flags |= WFI_WAKE_M3;
+	am33xx_wfi_flags |= WFI_SELF_REFRESH;
+	am33xx_wfi_flags |= WFI_SAVE_EMIF;
+	am33xx_wfi_flags |= WFI_WAKE_M3;
+
+	ret = sram_load_sections("/ocp/ocmcram@40300000", am33xx);
+	if (ret < 0) {
+		pr_err("%s: Could not load SRAM\n", __func__);
+		goto err;
+	}
+
+	am33xx_sram_init(am33xx_emif_base, am33xx_dram_sync);
 
 	np = of_find_compatible_node(NULL, NULL, "ti,am3353-wkup-m3");
 	if (np) {
diff --git a/arch/arm/mach-omap2/pm33xx.h b/arch/arm/mach-omap2/pm33xx.h
index b9c3a3f..aaa5f71 100644
--- a/arch/arm/mach-omap2/pm33xx.h
+++ b/arch/arm/mach-omap2/pm33xx.h
@@ -16,10 +16,9 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PM33XX_H
 #define __ARCH_ARM_MACH_OMAP2_PM33XX_H
 
+#include <linux/kernel.h>
 #include "control.h"
 
-#ifndef __ASSEMBLER__
-
 struct am33xx_pm_context {
 	struct am33xx_ipc_data	ipc;
 	struct firmware		*firmware;
@@ -28,19 +27,6 @@ struct am33xx_pm_context {
 	u32			ver;
 };
 
-/*
- * Params passed to suspend routine
- *
- * Since these are used to load into registers by suspend code,
- * entries here must always be in sync with the suspend code
- * in arm/mach-omap2/sleep33xx.S
- */
-struct am33xx_suspend_params {
-	void __iomem *emif_addr_virt;
-	u32 wfi_flags;
-	void __iomem *dram_sync;
-};
-
 struct wakeup_src {
 	int irq_nr;
 	char src[10];
@@ -55,8 +41,13 @@ int wkup_m3_copy_code(const u8 *data, size_t size);
 int wkup_m3_prepare(void);
 void wkup_m3_register_txev_handler(void (*txev_handler)(void));
 int am33xx_do_sram_cpuidle(u32, u32);
+int am33xx_suspend(long unsigned int flags);
+void am33xx_resume_trampoline(void);
+void am33xx_sram_init(void __iomem *emif_base, void __iomem *dram_sync);
 
-#endif
+#define __sram_am33xx		__section(.sram.am33xx.text)
+#define __sram_am33xxdata	__section(.sram.am33xx.data)
+#define __sram_am33xxconst	__section(.sram.am33xx.rodata)
 
 #define	IPC_CMD_DS0			0x4
 #define	IPC_CMD_IDLE			0xd
diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
deleted file mode 100644
index 317fb77..0000000
--- a/arch/arm/mach-omap2/sleep33xx.S
+++ /dev/null
@@ -1,394 +0,0 @@
-/*
- * Low level suspend code for AM33XX SoCs
- *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
- * Vaibhav Bedia <vaibhav.bedia@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/linkage.h>
-#include <linux/ti_emif.h>
-#include <asm/memory.h>
-#include <asm/assembler.h>
-
-#include "cm33xx.h"
-#include "pm33xx.h"
-#include "prm33xx.h"
-
-	.text
-	.align 3
-
-/*
- * This routine is executed from internal RAM and expects some
- * parameters to be passed in r0 _strictly_ in following order:
- * 1) emif_addr_virt - ioremapped EMIF address
- * 2) wfi_flags - actions to perform
- * 3) dram_sync_word - uncached word in SDRAM
- *
- * The code loads these values taking r0 value as reference to
- * the array in registers starting from r0, i.e emif_addr_virt
- * goes to r1, wfi_flags goes to r2 and and so on. These are
- * then saved into memory locations before proceeding with the
- * sleep sequence and hence registers r0, r1 etc can still be
- * used in the rest of the sleep code.
- */
-
-ENTRY(am33xx_do_wfi)
-	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
-
-	ldm	r0, {r1-r3}		@ gather values passed
-
-	/* Save the values passed */
-	str	r1, emif_addr_virt
-	str	r2, wfi_flags
-	str	r3, dram_sync_word
-
-	tst	r2, #WFI_SELF_REFRESH
-	beq	skip_sr
-
-	/*
-	 * Flush all data from the L1 data cache before disabling
-	 * SCTLR.C bit.
-	 */
-	ldr	r1, kernel_flush
-	blx	r1
-
-	/*
-	 * Clear the SCTLR.C bit to prevent further data cache
-	 * allocation. Clearing SCTLR.C would make all the data accesses
-	 * strongly ordered and would not hit the cache.
-	 */
-	mrc	p15, 0, r0, c1, c0, 0
-	bic	r0, r0, #(1 << 2)	@ Disable the C bit
-	mcr	p15, 0, r0, c1, c0, 0
-	isb
-
-	/*
-	 * Invalidate L1 data cache. Even though only invalidate is
-	 * necessary exported flush API is used here. Doing clean
-	 * on already clean cache would be almost NOP.
-	 */
-	ldr	r1, kernel_flush
-	blx	r1
-
-	ldr	r0, emif_addr_virt
-
-	/* Save config register */
-	ldr	r1, [r0, #EMIF_SDRAM_CONFIG]
-	str	r1, emif_sdcfg_val
-
-	/* Only necessary if PER is losing context */
-	ldr	r2, wfi_flags
-	tst	r2, #WFI_SAVE_EMIF
-	beq	skip_save_emif
-
-	/* Save EMIF configuration */
-	ldr	r1, [r0, #EMIF_SDRAM_REFRESH_CONTROL]
-	str	r1, emif_ref_ctrl_val
-	ldr	r1, [r0, #EMIF_SDRAM_TIMING_1]
-	str	r1, emif_timing1_val
-	ldr	r1, [r0, #EMIF_SDRAM_TIMING_2]
-	str	r1, emif_timing2_val
-	ldr	r1, [r0, #EMIF_SDRAM_TIMING_3]
-	str	r1, emif_timing3_val
-	ldr	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
-	str	r1, emif_pmcr_val
-	ldr	r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
-	str	r1, emif_pmcr_shdw_val
-	ldr	r1, [r0, #EMIF_SDRAM_OUTPUT_IMPEDANCE_CALIBRATION_CONFIG]
-	str	r1, emif_zqcfg_val
-	ldr	r1, [r0, #EMIF_DDR_PHY_CTRL_1]
-	str	r1, emif_rd_lat_val
-
-skip_save_emif:
-	/* Put SDRAM in self-refresh */
-	ldr	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
-	orr	r1, r1, #0xa0
-	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
-	str	r1, [r0, #4]
-
-	ldr	r1, dram_sync_word	@ a dummy access to DDR as per spec
-	ldr	r2, [r1, #0]
-	ldr	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
-	orr	r1, r1, #0x200
-	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
-
-	mov	r1, #0x1000		@ Wait for system to enter SR
-wait_sr:
-	subs	r1, r1, #1
-	bne	wait_sr
-
-	/* Disable EMIF */
-	ldr	r1, virt_emif_clkctrl
-	ldr	r2, [r1]
-	bic	r2, r2, #0x03
-	str	r2, [r1]
-
-	ldr	r1, virt_emif_clkctrl
-wait_emif_disable:
-	ldr	r2, [r1]
-	ldr	r3, module_disabled_val
-	cmp	r2, r3
-	bne	wait_emif_disable
-
-skip_sr:
-	ldr	r2, wfi_flags
-	tst	r2, #WFI_WAKE_M3
-	beq	skip_m3
-
-	/*
-	 * For the MPU WFI to be registered as an interrupt
-	 * to WKUP_M3, MPU_CLKCTRL.MODULEMODE needs to be set
-	 * to DISABLED
-	 */
-	ldr	r1, virt_mpu_clkctrl
-	ldr	r2, [r1]
-	bic	r2, r2, #0x03
-	str	r2, [r1]
-
-skip_m3:
-	/*
-	 * Execute an ISB instruction to ensure that all of the
-	 * CP15 register changes have been committed.
-	 */
-	isb
-
-	/*
-	 * Execute a barrier instruction to ensure that all cache,
-	 * TLB and branch predictor maintenance operations issued
-	 * have completed.
-	 */
-	dsb
-	dmb
-
-	/*
-	 * Execute a WFI instruction and wait until the
-	 * STANDBYWFI output is asserted to indicate that the
-	 * CPU is in idle and low power state. CPU can specualatively
-	 * prefetch the instructions so add NOPs after WFI. Thirteen
-	 * NOPs as per Cortex-A8 pipeline.
-	 */
-	wfi
-
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-
-	/* We come here in case of an abort due to a late interrupt */
-	ldr	r2, wfi_flags
-	tst	r2, #WFI_WAKE_M3
-
-	/* Set MPU_CLKCTRL.MODULEMODE back to ENABLE */
-	ldrne	r1, virt_mpu_clkctrl
-	movne	r2, #0x02
-	strne	r2, [r1]
-
-	ldr	r2, wfi_flags
-	tst	r2, #WFI_SELF_REFRESH
-	beq	skip_reenable_emif
-
-	/* Re-enable EMIF */
-	ldr	r1, virt_emif_clkctrl
-	mov	r2, #0x02
-	str	r2, [r1]
-wait_emif_enable:
-	ldr	r3, [r1]
-	cmp	r2, r3
-	bne	wait_emif_enable
-
-	/* Disable EMIF self-refresh */
-	ldr	r0, emif_addr_virt
-	ldr	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
-	bic	r1, r1, #LP_MODE_MASK
-	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
-	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
-
-	/*
-	 * A write to SDRAM CONFIG register triggers
-	 * an init sequence and hence it must be done
-	 * at the end for DDR2
-	 */
-	ldr r0, emif_addr_virt
-	add r0, r0, #EMIF_SDRAM_CONFIG
-	ldr r4, emif_sdcfg_val
-	str r4, [r0]
-
-	/*
-	 * Set SCTLR.C bit to allow data cache allocation
-	 */
-	mrc	p15, 0, r0, c1, c0, 0
-	orr	r0, r0, #(1 << 2)	@ Enable the C bit
-	mcr	p15, 0, r0, c1, c0, 0
-	isb
-
-	/* Kill some time for sanity to settle in */
-	mov r0, #0x1000
-wait_abt:
-	subs   r0, r0, #1
-	bne wait_abt
-
-	/* Let the suspend code know about the abort */
-skip_reenable_emif:
-	mov	r0, #1
-	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
-ENDPROC(am33xx_do_wfi)
-
-	.align
-ENTRY(am33xx_resume_offset)
-	.word . - am33xx_do_wfi
-
-ENTRY(am33xx_resume_from_deep_sleep)
-	ldr	r2, wfi_flags
-	tst	r2, #WFI_SELF_REFRESH
-	beq	skip_reenable_emif1
-
-	/* Re-enable EMIF */
-	ldr	r0, phys_emif_clkctrl
-	mov	r1, #0x02
-	str	r1, [r0]
-wait_emif_enable1:
-	ldr	r2, [r0]
-	cmp	r1, r2
-	bne	wait_emif_enable1
-
-	ldr	r0, emif_phys_addr
-
-	ldr	r2, wfi_flags
-	tst	r2, #WFI_SAVE_EMIF
-	beq	skip_restore_emif
-
-	/* Config EMIF Timings */
-	ldr	r1, emif_rd_lat_val
-	str	r1, [r0, #EMIF_DDR_PHY_CTRL_1]
-	str	r1, [r0, #EMIF_DDR_PHY_CTRL_1_SHDW]
-	ldr	r1, emif_timing1_val
-	str	r1, [r0, #EMIF_SDRAM_TIMING_1]
-	str	r1, [r0, #EMIF_SDRAM_TIMING_1_SHDW]
-	ldr	r1, emif_timing2_val
-	str	r1, [r0, #EMIF_SDRAM_TIMING_2]
-	str	r1, [r0, #EMIF_SDRAM_TIMING_2_SHDW]
-	ldr	r1, emif_timing3_val
-	str	r1, [r0, #EMIF_SDRAM_TIMING_3]
-	str	r1, [r0, #EMIF_SDRAM_TIMING_3_SHDW]
-	ldr	r1, emif_ref_ctrl_val
-	str	r1, [r0, #EMIF_SDRAM_REFRESH_CONTROL]
-	str	r1, [r0, #EMIF_SDRAM_REFRESH_CTRL_SHDW]
-	ldr	r1, emif_pmcr_val
-	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
-	ldr	r1, emif_pmcr_shdw_val
-	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
-
-	/*
-	 * Output impedence calib needed only for DDR3
-	 * but since the initial state of this will be
-	 * disabled for DDR2 no harm in restoring the
-	 * old configuration
-	 */
-	ldr	r1, emif_zqcfg_val
-	str	r1, [r0, #EMIF_SDRAM_OUTPUT_IMPEDANCE_CALIBRATION_CONFIG]
-
-	/* Write to SDRAM_CONFIG only for DDR2 */
-	ldr	r2, wfi_flags
-	tst	r2, #WFI_MEM_TYPE_DDR2
-	bne	resume_to_ddr2
-	b	resume_to_ddr3
-
-skip_restore_emif:
-	/* Disable EMIF self-refresh */
-	ldr	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
-	bic	r1, r1, #LP_MODE_MASK
-	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
-	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
-
-resume_to_ddr2:
-	/*
-	 * A write to SDRAM CONFIG register triggers
-	 * an init sequence and hence it must be done
-	 * at the end for DDR2
-	 */
-	ldr	r1, emif_sdcfg_val
-	str	r1, [r0, #EMIF_SDRAM_CONFIG]
-
-resume_to_ddr3:
-	/* Back from la-la-land. Kill some time for sanity to settle in */
-	mov	r0, #0x1000
-wait_resume:
-	subs	r0, r0, #1
-	bne	wait_resume
-
-skip_reenable_emif1:
-	/* We are back. Branch to the common CPU resume routine */
-	mov	r0, #0
-	ldr	pc, resume_addr
-ENDPROC(am33xx_resume_from_deep_sleep)
-
-
-/*
- * Local variables
- */
-	.align
-resume_addr:
-	.word	cpu_resume - PAGE_OFFSET + 0x80000000
-kernel_flush:
-	.word   v7_flush_dcache_all
-ddr_start:
-	.word	PAGE_OFFSET
-emif_phys_addr:
-	.word	AM33XX_EMIF_BASE
-virt_mpu_clkctrl:
-	.word	AM33XX_CM_MPU_MPU_CLKCTRL
-virt_emif_clkctrl:
-	.word	AM33XX_CM_PER_EMIF_CLKCTRL
-phys_emif_clkctrl:
-	.word	(AM33XX_CM_BASE + AM33XX_CM_PER_MOD + \
-		AM33XX_CM_PER_EMIF_CLKCTRL_OFFSET)
-module_disabled_val:
-	.word	0x30000
-
-/* DDR related defines */
-dram_sync_word:
-	.word	0xDEADBEEF
-wfi_flags:
-	.word	0xDEADBEEF
-emif_addr_virt:
-	.word	0xDEADBEEF
-emif_rd_lat_val:
-	.word	0xDEADBEEF
-emif_timing1_val:
-	.word	0xDEADBEEF
-emif_timing2_val:
-	.word	0xDEADBEEF
-emif_timing3_val:
-	.word	0xDEADBEEF
-emif_sdcfg_val:
-	.word	0xDEADBEEF
-emif_ref_ctrl_val:
-	.word	0xDEADBEEF
-emif_zqcfg_val:
-	.word	0xDEADBEEF
-emif_pmcr_val:
-	.word	0xDEADBEEF
-emif_pmcr_shdw_val:
-	.word	0xDEADBEEF
-
-	.align 3
-ENTRY(am33xx_do_wfi_sz)
-	.word	. - am33xx_do_wfi
diff --git a/arch/arm/mach-omap2/sleep33xx.c b/arch/arm/mach-omap2/sleep33xx.c
new file mode 100644
index 0000000..a2b8608
--- /dev/null
+++ b/arch/arm/mach-omap2/sleep33xx.c
@@ -0,0 +1,309 @@
+/*
+ * AM33XX Power Management Routines
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Vaibhav Bedia <vaibhav.bedia@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/ti_emif.h>
+#include <linux/platform_data/emif_plat.h>
+#include <linux/sram.h>
+
+#include <asm/suspend.h>
+#include <asm/cp15.h>
+
+#include "pm33xx.h"
+#include "cm33xx.h"
+#include "cm-regbits-33xx.h"
+#include "omap_hwmod.h"
+
+#define CLKCTRL_IDLEST_FUNCTIONAL	0x0
+#define CLKCTRL_IDLEST_DISABLED		0x3
+
+struct emif_regs {
+	u32 sdcfg;
+	u32 ref_ctrl;
+	u32 timing1;
+	u32 timing2;
+	u32 timing3;
+	u32 pmcr;
+	u32 pmcr_shdw;
+	u32 zqcfg;
+	u32 rd_lat;
+};
+
+extern int call_with_stack(int (*fn)(void *), void *arg, void *sp);
+extern void v7_flush_dcache_all(void);
+
+static void (*__abs_v7_flush_dcache_all)(void) __sram_am33xxdata;
+static char sram_stack[1024] __sram_am33xxdata;
+static void __noreturn (*__cpu_resume_phys)(void) __sram_am33xxdata;
+static struct emif_regs emif_regs __sram_am33xxdata;
+static void __iomem *emif_virt_base __sram_am33xxdata;
+static void __iomem *emif_base __sram_am33xxdata;
+static void __iomem *dram_sync_addr __sram_am33xxdata;
+static u32 wfi_flags __sram_am33xxdata;
+static u32 cm_offset __sram_am33xxdata;
+
+static inline void flush_dcache_all(void)
+{
+	__asm__ __volatile__("" : : : "r0", "r1", "r2", "r3", "r4", "r5",
+				"r5", "r6", "r7", "r9", "r10", "r11");
+	__abs_v7_flush_dcache_all();
+}
+
+static u32 __sram_am33xx emif_read(u16 idx)
+{
+	return __raw_readl(emif_base + idx);
+}
+
+static void __sram_am33xx emif_write(u32 val, u16 idx)
+{
+	__raw_writel(val, emif_base + idx);
+}
+
+static inline void am33xx_cm_write(u32 val, void __iomem *reg)
+{
+	__raw_writel(val, reg + cm_offset);
+}
+
+static inline u32 am33xx_cm_read(void __iomem *reg)
+{
+	return __raw_readl(reg + cm_offset);
+}
+
+static void __sram_am33xx am33xx_module_set(u16 mode, void __iomem *reg)
+{
+	u32 val = am33xx_cm_read(reg) & ~AM33XX_MODULEMODE_MASK;
+	am33xx_cm_write(val | mode, reg);
+}
+
+static void __sram_am33xx am33xx_module_disable(void __iomem *reg)
+{
+	am33xx_module_set(MODULEMODE_SWCTRL, reg);
+}
+
+static void __sram_am33xx am33xx_module_disable_wait(void __iomem *reg)
+{
+	u32 val;
+	am33xx_module_disable(reg);
+	do {
+		val = am33xx_cm_read(reg) & AM33XX_IDLEST_MASK;
+		val >>= AM33XX_IDLEST_SHIFT;
+	} while (val != CLKCTRL_IDLEST_DISABLED);
+}
+
+static void __sram_am33xx am33xx_module_enable(void __iomem *reg)
+{
+	am33xx_module_set(0, reg);
+}
+
+static void __sram_am33xx am33xx_module_enable_wait(void __iomem *reg)
+{
+	u32 val;
+	am33xx_module_enable(reg);
+	do {
+		val = am33xx_cm_read(reg) & AM33XX_IDLEST_MASK;
+		val >>= AM33XX_IDLEST_SHIFT;
+	} while (val != CLKCTRL_IDLEST_FUNCTIONAL);
+}
+
+static void __sram_am33xx noinline am33xx_enable_sr(void)
+{
+	u32 val;
+
+	emif_regs.sdcfg = emif_read(EMIF_SDRAM_CONFIG);
+	val = emif_read(EMIF_POWER_MANAGEMENT_CONTROL);
+	val &= ~SR_TIM_MASK;
+	val |= 0xa << SR_TIM_SHIFT;
+	emif_write(val, EMIF_POWER_MANAGEMENT_CONTROL);
+	emif_write(val, EMIF_POWER_MANAGEMENT_CTRL_SHDW);
+
+	__raw_readl(dram_sync_addr);
+	val &= ~LP_MODE_MASK;
+	val |= EMIF_LP_MODE_SELF_REFRESH << LP_MODE_SHIFT;
+	emif_write(val, EMIF_POWER_MANAGEMENT_CONTROL);
+}
+
+static void __sram_am33xx noinline am33xx_disable_sr(void)
+{
+	u32 val;
+
+	val = emif_read(EMIF_POWER_MANAGEMENT_CONTROL);
+	val &= ~LP_MODE_MASK;
+	val |= EMIF_LP_MODE_DISABLE << LP_MODE_SHIFT;
+	emif_write(val, EMIF_POWER_MANAGEMENT_CONTROL);
+	emif_write(val, EMIF_POWER_MANAGEMENT_CTRL_SHDW);
+
+	/*
+	 * A write to SDRAM CONFIG register triggers
+	 * an init sequence and hence it must be done
+	 * at the end for DDR2
+	 */
+	emif_write(emif_regs.sdcfg, EMIF_SDRAM_CONFIG);
+}
+
+static void __sram_am33xx noinline am33xx_emif_save(void)
+{
+	emif_regs.ref_ctrl = emif_read(EMIF_SDRAM_REFRESH_CONTROL);
+	emif_regs.timing1 = emif_read(EMIF_SDRAM_TIMING_1);
+	emif_regs.timing2 = emif_read(EMIF_SDRAM_TIMING_2);
+	emif_regs.timing3 = emif_read(EMIF_SDRAM_TIMING_3);
+	emif_regs.pmcr = emif_read(EMIF_POWER_MANAGEMENT_CONTROL);
+	emif_regs.pmcr_shdw = emif_read(EMIF_POWER_MANAGEMENT_CTRL_SHDW);
+	emif_regs.zqcfg = emif_read(EMIF_SDRAM_OUTPUT_IMPEDANCE_CALIBRATION_CONFIG);
+	emif_regs.rd_lat = emif_read(EMIF_DDR_PHY_CTRL_1);
+}
+
+static void __sram_am33xx noinline am33xx_emif_restore(void)
+{
+	emif_write(emif_regs.rd_lat, EMIF_DDR_PHY_CTRL_1);
+	emif_write(emif_regs.rd_lat, EMIF_DDR_PHY_CTRL_1_SHDW);
+	emif_write(emif_regs.timing1, EMIF_SDRAM_TIMING_1);
+	emif_write(emif_regs.timing1, EMIF_SDRAM_TIMING_1_SHDW);
+	emif_write(emif_regs.timing2, EMIF_SDRAM_TIMING_2);
+	emif_write(emif_regs.timing2, EMIF_SDRAM_TIMING_2_SHDW);
+	emif_write(emif_regs.timing3, EMIF_SDRAM_TIMING_3);
+	emif_write(emif_regs.timing3, EMIF_SDRAM_TIMING_3_SHDW);
+	emif_write(emif_regs.ref_ctrl, EMIF_SDRAM_REFRESH_CONTROL);
+	emif_write(emif_regs.ref_ctrl, EMIF_SDRAM_REFRESH_CTRL_SHDW);
+	emif_write(emif_regs.pmcr, EMIF_POWER_MANAGEMENT_CONTROL);
+	emif_write(emif_regs.pmcr_shdw, EMIF_POWER_MANAGEMENT_CTRL_SHDW);
+	/*
+	 * Output impedence calib needed only for DDR3
+	 * but since the initial state of this will be
+	 * disabled for DDR2 no harm in restoring the
+	 * old configuration
+	 */
+	emif_write(emif_regs.zqcfg, EMIF_SDRAM_OUTPUT_IMPEDANCE_CALIBRATION_CONFIG);
+	/* Write to SDRAM_CONFIG only for DDR2 */
+	if (wfi_flags & WFI_MEM_TYPE_DDR2)
+		emif_write(emif_regs.sdcfg, EMIF_SDRAM_CONFIG);
+}
+
+static int __sram_am33xx am33xx_wfi_sram(void *data)
+{
+	wfi_flags = (unsigned long) data;
+	emif_base = emif_virt_base;
+	cm_offset = 0;
+
+	if (wfi_flags & WFI_SELF_REFRESH) {
+		/*
+		 * Flush all data from the L1 data cache before disabling
+		 * SCTLR.C bit.
+		 */
+		flush_dcache_all();
+		/*
+		 * Clear the SCTLR.C bit to prevent further data cache
+		 * allocation. Clearing SCTLR.C would make all the data
+		 * accesses strongly ordered and would not hit the cache.
+		 */
+		set_cr(get_cr() & ~CR_C);
+		/*
+		 * Invalidate L1 data cache. Even though only invalidate is
+		 * necessary exported flush API is used here. Doing clean
+		 * on already clean cache would be almost NOP.
+		 */
+		flush_dcache_all();
+
+		/* Only necessary if PER is losing context */
+		if (wfi_flags & WFI_SAVE_EMIF)
+			am33xx_emif_save();
+
+		am33xx_enable_sr();
+		am33xx_module_disable_wait(AM33XX_CM_PER_EMIF_CLKCTRL);
+	}
+
+
+	/*
+	 * For the MPU WFI to be registered as an interrupt
+	 * to WKUP_M3, MPU_CLKCTRL.MODULEMODE needs to be set
+	 * to DISABLED
+	 */
+	if (wfi_flags & WFI_WAKE_M3)
+		am33xx_module_disable(AM33XX_CM_MPU_MPU_CLKCTRL);
+
+	__asm__ __volatile__ (
+		/*
+		 * Execute an ISB instruction to ensure that all of the
+		 * CP15 register changes have been committed.
+		 */
+		"isb\n\t"
+		/*
+		 * Execute a barrier instruction to ensure that all cache,
+		 * TLB and branch predictor maintenance operations issued
+		 * have completed.
+		 */
+		"dsb\n\t"
+		"dmb\n\t"
+		/*
+		 * Execute a WFI instruction and wait until the
+		 * STANDBYWFI output is asserted to indicate that the
+		 * CPU is in idle and low power state. CPU can specualatively
+		 * prefetch the instructions so add NOPs after WFI. Thirteen
+		 * NOPs as per Cortex-A8 pipeline.
+		 */
+		"wfi\n\t"
+		".rept 13\n\t"
+		"nop\n\t"
+		".endr" : : : "memory");
+
+	/* We come here in case of an abort due to a late interrupt */
+
+	if (wfi_flags & WFI_WAKE_M3)
+		am33xx_module_enable(AM33XX_CM_MPU_MPU_CLKCTRL);
+
+	if (wfi_flags & WFI_SELF_REFRESH) {
+		am33xx_module_enable_wait(AM33XX_CM_PER_EMIF_CLKCTRL);
+		am33xx_disable_sr();
+		/* Set SCTLR.C bit to allow data cache allocation */
+		set_cr(get_cr() | CR_C);
+	}
+
+	/* Let the suspend code know about the abort */
+	return 1;
+}
+
+int am33xx_suspend(long unsigned int flags)
+{
+	return call_with_stack(kern_to_sram(&am33xx_wfi_sram), (void *) flags,
+		kern_to_sram((char *) sram_stack) + ARRAY_SIZE(sram_stack));
+}
+
+static void __sram_am33xx __noreturn noinline am33xx_resume(void)
+{
+	emif_base = (void *) AM33XX_EMIF_BASE;
+	/* Undo the offset built into the register defines */
+	cm_offset = -AM33XX_L4_WK_IO_OFFSET;
+
+	if (wfi_flags & WFI_SELF_REFRESH) {
+		am33xx_module_enable_wait(AM33XX_CM_PER_EMIF_CLKCTRL);
+		if (wfi_flags & WFI_SAVE_EMIF)
+			am33xx_emif_restore();
+		else
+			am33xx_disable_sr();
+	}
+
+	/* We are back. Branch to the common CPU resume routine */
+	__cpu_resume_phys();
+}
+
+ARM_SRAM_RESUME(am33xx, am33xx_resume, sram_stack + ARRAY_SIZE(sram_stack));
+
+void am33xx_sram_init(void __iomem *emif_base, void __iomem *dram_sync)
+{
+	*kern_to_sram(&__abs_v7_flush_dcache_all) = v7_flush_dcache_all;
+	*kern_to_sram(&__cpu_resume_phys) = (void *) virt_to_phys(cpu_resume);
+	*kern_to_sram(&emif_virt_base) = emif_base;
+	*kern_to_sram(&dram_sync_addr) = dram_sync;
+}
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index 303c562..97b7f77 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -285,19 +285,6 @@ static inline int omap34xx_sram_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
-#ifdef CONFIG_SOC_AM33XX
-static inline int am33xx_sram_init(void)
-{
-	am33xx_push_sram_idle();
-	return 0;
-}
-#else
-static inline int am33xx_sram_init(void)
-{
-	return 0;
-}
-#endif
-
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
@@ -307,8 +294,6 @@ int __init omap_sram_init(void)
 		omap242x_sram_init();
 	else if (cpu_is_omap2430())
 		omap243x_sram_init();
-	else if (soc_is_am33xx())
-		am33xx_sram_init();
 	else if (cpu_is_omap34xx())
 		omap34xx_sram_init();
 
-- 
1.8.3.2

