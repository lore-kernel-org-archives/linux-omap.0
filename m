From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Add sram34xx.S
Date: Thu, 15 May 2008 14:40:41 -0700
Message-ID: <20080515214040.GU8928@atomide.com>
References: <1206704800-6768-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RYJh/3oyKhIjGcML"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58312 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbYEOVkl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 17:40:41 -0400
Content-Disposition: inline
In-Reply-To: <1206704800-6768-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Dasu, Karthik P" <karthik-dp@ti.com>


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080328 04:46]:
> Hi all,
> 
> Following two patches add sram34xx.S based on Karthik's patch and what's
> at [1]. Looks like the sram code in [1] is newer so I've used that.
> Let me know if that's not the case.
> 
> Karthik, can you please check and ack? I've only compile tested them.
> 
> Regards,
> 
> Tony
> 
> [1] http://linux.omap.com/pub/kernel/3430zoom/linux-ldp-v1.0b.tar.gz

I'll push these two patches today meged into single patch below.

Tony

--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=omap3-sram

>From 8d00571b0ecb2fb21b35e5d13b2959a71142abfa Mon Sep 17 00:00:00 2001
From: Karthik Dasu <karthik-dp@ti.com>
Date: Thu, 15 May 2008 14:27:08 -0700
Subject: [PATCH] ARM: OMAP3: Add sram34xx.S

This patch adds sram34xx.S for programming the core DPLL.

It is based on Karthik's earlier patch and TI's sram-fn_34xxS from:

http://linux.omap.com/pub/kernel/3430zoom/linux-ldp-v1.0b.tar.gz

Patch modified by Tony for the new register access.

Signed-off-by: Karthik Dasu<karthik-dp@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 552664c..ea0cf43 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -9,6 +9,7 @@ obj-y := irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
 
 # Functions loaded to SRAM
 obj-$(CONFIG_ARCH_OMAP2)		+= sram24xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
 
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
new file mode 100644
index 0000000..74873df
--- /dev/null
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -0,0 +1,209 @@
+/*
+ * linux/arch/arm/mach-omap3/sram.S
+ *
+ * Omap3 specific functions that need to be run in internal SRAM
+ *
+ * (C) Copyright 2007
+ * Texas Instruments Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * (C) Copyright 2004
+ * Texas Instruments, <www.ti.com>
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/hardware.h>
+
+#include <asm/arch/io.h>
+
+#include "sdrc.h"
+#include "cm.h"
+
+	.text
+
+ENTRY(omap34xx_sram_ddr_init)
+	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
+	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
+ENTRY(omap34xx_sram_ddr_init_sz)
+	.word	. - omap34xx_sram_ddr_init
+
+ENTRY(omap34xx_sram_reprogram_sdrc)
+	stmfd	sp!, {r0 - r10, lr}	@ save registers on stack
+	ldmfd	sp!, {r0 - r10, pc}	@ restore regs and return
+ENTRY(omap34xx_sram_reprogram_sdrc_sz)
+	.word	. - omap34xx_sram_reprogram_sdrc
+
+/*
+ * Set dividers and pll. Also recalculate DLL value for DDR and unlock mode.
+ */
+ENTRY(omap34xx_sram_set_prcm)
+	stmfd	sp!, {r0-r12, lr}	@ regs to stack
+ENTRY(omap34xx_sram_set_prcm_sz)
+	.word	. - omap34xx_sram_set_prcm
+
+/*
+ * Change frequency of core dpll
+ * r0 = sdrc_rfr_ctrl r1 = sdrc_actim_ctrla r2 = sdrc_actim_ctrlb r3 = M2
+ */
+ENTRY(omap34xx_sram_configure_core_dpll)
+	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
+	cmp	r3, #0x2
+	blne	configure_sdrc
+	cmp	r3, #0x2
+	blne	lock_dll
+	cmp	r3, #0x1
+	blne	unlock_dll
+	bl	sdram_in_selfrefresh	@ put the SDRAM in self refresh
+	bl 	configure_core_dpll
+	bl	enable_sdrc
+	cmp	r3, #0x1
+	blne	wait_dll_unlock
+	cmp	r3, #0x2
+	blne	wait_dll_lock
+	cmp	r3, #0x1
+	blne	configure_sdrc
+	mov 	r0, #0 			@ return value
+	ldmfd	sp!, {r1-r12, pc}	@ restore regs and return
+unlock_dll:
+	ldr	r4, omap34xx_sdrc_dlla_ctrl
+	ldr	r5, [r4]
+	orr	r5, r5, #0x4
+	str	r5, [r4]
+	bx	lr
+lock_dll:
+	ldr	r4, omap34xx_sdrc_dlla_ctrl
+	ldr	r5, [r4]
+	bic	r5, r5, #0x4
+	str	r5, [r4]
+	bx	lr
+sdram_in_selfrefresh:
+	mov	r5, #0x0		@ Move 0 to R5
+	mcr	p15, 0, r5, c7, c10, 5	@ memory barrier
+	ldr	r4, omap34xx_sdrc_power	@ read the SDRC_POWER register
+	ldr	r5, [r4]		@ read the contents of SDRC_POWER
+	orr 	r5, r5, #0x40		@ enable self refresh on idle req
+	str 	r5, [r4]		@ write back to SDRC_POWER register
+	ldr	r4, omap34xx_cm_iclken1_core	@ read the CM_ICLKEN1_CORE reg
+	ldr	r5, [r4]
+	bic	r5, r5, #0x2		@ disable iclk bit for SRDC
+	str 	r5, [r4]
+wait_sdrc_idle:
+	ldr 	r4, omap34xx_cm_idlest1_core
+	ldr 	r5, [r4]
+	and 	r5, r5, #0x2		@ check for SDRC idle
+	cmp 	r5, #2
+	bne 	wait_sdrc_idle
+	bx 	lr
+configure_core_dpll:
+	ldr 	r4, omap34xx_cm_clksel1_pll
+	ldr	r5, [r4]
+	ldr	r6, core_m2_mask_val	@ modify m2 for core dpll
+	and	r5, r5, r6
+	orr	r5, r5, r3, lsl #0x1B	@ r3 contains the M2 val
+	str	r5, [r4]
+	mov 	r5, #0x800		@ wait for the clock to stabilise
+	cmp	r3, #2
+	bne	wait_clk_stable
+	bx	lr
+wait_clk_stable:
+	subs 	r5, r5, #1
+	bne	wait_clk_stable
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	bx	lr
+enable_sdrc:
+	ldr 	r4, omap34xx_cm_iclken1_core
+	ldr	r5, [r4]
+	orr 	r5, r5, #0x2		@ enable iclk bit for SDRC
+	str 	r5, [r4]
+wait_sdrc_idle1:
+	ldr 	r4, omap34xx_cm_idlest1_core
+	ldr	r5, [r4]
+	and 	r5, r5, #0x2
+	cmp	r5, #0
+	bne	wait_sdrc_idle1
+	ldr	r4, omap34xx_sdrc_power
+	ldr	r5, [r4]
+	bic 	r5, r5, #0x40
+	str 	r5, [r4]
+	bx	lr
+wait_dll_lock:
+	ldr	r4, omap34xx_sdrc_dlla_status
+	ldr	r5, [r4]
+	and 	r5, r5, #0x4
+	cmp	r5, #0x4
+	bne	wait_dll_lock
+	bx	lr
+wait_dll_unlock:
+	ldr	r4, omap34xx_sdrc_dlla_status
+	ldr	r5, [r4]
+	and	r5, r5, #0x4
+	cmp	r5, #0x0
+	bne	wait_dll_unlock
+	bx	lr
+configure_sdrc:
+	ldr	r4, omap34xx_sdrc_rfr_ctrl
+	str	r0, [r4]
+	ldr	r4, omap34xx_sdrc_actim_ctrla
+	str	r1, [r4]
+	ldr	r4, omap34xx_sdrc_actim_ctrlb
+	str	r2, [r4]
+	bx	lr
+
+omap34xx_sdrc_power:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
+omap34xx_cm_clksel1_pll:
+	.word OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKSEL1)
+omap34xx_cm_idlest1_core:
+	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
+omap34xx_cm_iclken1_core:
+	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
+omap34xx_sdrc_rfr_ctrl:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
+omap34xx_sdrc_actim_ctrla:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A)
+omap34xx_sdrc_actim_ctrlb:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B)
+omap34xx_sdrc_dlla_status:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
+omap34xx_sdrc_dlla_ctrl:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
+core_m2_mask_val:
+	.word 0xE7FFFFFF
+
+ENTRY(omap34xx_sram_configure_core_dpll_sz)
+	.word	. - omap34xx_sram_configure_core_dpll
+
+/*
+ * Reprogram GPMC
+ */
+ENTRY(omap34xx_sram_reprogram_gpmc)
+	stmfd	sp!, {r0-r12, lr}	@ regs to stack
+	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
+
+ENTRY(omap34xx_sram_reprogram_gpmc_sz)
+	.word	. - omap34xx_sram_reprogram_gpmc
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 2fc8f61..fb3f0d1 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -461,6 +461,67 @@ static inline int omap24xx_sram_init(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP3
+
+static u32 (*_omap2_sram_reprogram_gpmc)(u32 perf_level);
+u32 omap2_sram_reprogram_gpmc(u32 perf_level)
+{
+	if (!_omap2_sram_reprogram_gpmc)
+		omap_sram_error();
+
+	return _omap2_sram_reprogram_gpmc(perf_level);
+}
+
+static u32 (*_omap2_sram_configure_core_dpll)(u32 m, u32 n,
+						u32 freqsel, u32 m2);
+u32 omap2_sram_configure_core_dpll(u32 m, u32 n, u32 freqsel, u32 m2)
+{
+	if (!_omap2_sram_configure_core_dpll)
+		omap_sram_error();
+
+	return _omap2_sram_configure_core_dpll(m, n, freqsel, m2);
+}
+
+/* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
+void restore_sram_functions(void)
+{
+	omap_sram_ceil = omap_sram_base + omap_sram_size;
+
+	_omap2_sram_reprogram_gpmc = omap_sram_push(omap34xx_sram_reprogram_gpmc,
+		omap34xx_sram_reprogram_gpmc_sz);
+
+	_omap2_sram_configure_core_dpll =
+			omap_sram_push(omap34xx_sram_configure_core_dpll,
+					omap34xx_sram_configure_core_dpll_sz);
+}
+
+int __init omap34xx_sram_init(void)
+{
+	_omap2_sram_ddr_init = omap_sram_push(omap34xx_sram_ddr_init,
+					omap34xx_sram_ddr_init_sz);
+
+	_omap2_sram_reprogram_sdrc = omap_sram_push(omap34xx_sram_reprogram_sdrc,
+					omap34xx_sram_reprogram_sdrc_sz);
+
+	_omap2_set_prcm = omap_sram_push(omap34xx_sram_set_prcm,
+					omap34xx_sram_set_prcm_sz);
+
+	_omap2_sram_reprogram_gpmc = omap_sram_push(omap34xx_sram_reprogram_gpmc,
+					omap34xx_sram_reprogram_gpmc_sz);
+
+	_omap2_sram_configure_core_dpll =
+				omap_sram_push(omap34xx_sram_configure_core_dpll,
+					omap34xx_sram_configure_core_dpll_sz);
+
+	return 0;
+}
+#else
+static inline int omap34xx_sram_init(void)
+{
+	return 0;
+}
+#endif
+
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
@@ -470,6 +531,8 @@ int __init omap_sram_init(void)
 		omap1_sram_init();
 	else if (cpu_is_omap24xx())
 		omap24xx_sram_init();
+	else if (cpu_is_omap34xx())
+		omap34xx_sram_init();
 
 	return 0;
 }
diff --git a/include/asm-arm/arch-omap/sdrc.h b/include/asm-arm/arch-omap/sdrc.h
index 673b396..660da4d 100644
--- a/include/asm-arm/arch-omap/sdrc.h
+++ b/include/asm-arm/arch-omap/sdrc.h
@@ -25,6 +25,8 @@
 #define SDRC_DLLB_STATUS	0x06C
 #define SDRC_POWER		0x070
 #define SDRC_MR_0		0x084
+#define SDRC_ACTIM_CTRL_A	0x09c
+#define SDRC_ACTIM_CTRL_B	0x0a0
 #define SDRC_RFR_CTRL_0		0x0a4
 
 /*
diff --git a/include/asm-arm/arch-omap/sram.h b/include/asm-arm/arch-omap/sram.h
index cc57dab..830e0fa 100644
--- a/include/asm-arm/arch-omap/sram.h
+++ b/include/asm-arm/arch-omap/sram.h
@@ -43,4 +43,23 @@ extern void omap24xx_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
 						u32 mem_type);
 extern unsigned long omap24xx_sram_reprogram_sdrc_sz;
 
+
+extern void omap34xx_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
+						u32 base_cs, u32 force_unlock);
+extern unsigned long omap34xx_sram_ddr_init_sz;
+
+extern void omap34xx_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
+						u32 mem_type);
+extern unsigned long omap34xx_sram_reprogram_sdrc_sz;
+
+extern u32 omap34xx_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
+						int bypass);
+extern unsigned long omap34xx_sram_set_prcm_sz;
+
+extern u32 omap34xx_sram_reprogram_gpmc(u32 perf_level);
+extern unsigned long omap34xx_sram_reprogram_gpmc_sz;
+
+extern u32 omap34xx_sram_configure_core_dpll(u32 m, u32 n, u32 freqsel, u32 m2);
+extern unsigned long omap34xx_sram_configure_core_dpll_sz;
+
 #endif

--RYJh/3oyKhIjGcML--
