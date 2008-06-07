From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/21] ARM: OMAP: SRAM: Split sram24xx.S into sram242x.S and sram243x.S
Date: Fri,  6 Jun 2008 18:30:41 -0700
Message-ID: <1212802253-17797-10-git-send-email-tony@atomide.com>
References: omap-upstream-2008-06-06-183049
 <1212802253-17797-1-git-send-email-tony@atomide.com>
 <1212802253-17797-2-git-send-email-tony@atomide.com>
 <1212802253-17797-3-git-send-email-tony@atomide.com>
 <1212802253-17797-4-git-send-email-tony@atomide.com>
 <1212802253-17797-5-git-send-email-tony@atomide.com>
 <1212802253-17797-6-git-send-email-tony@atomide.com>
 <1212802253-17797-7-git-send-email-tony@atomide.com>
 <1212802253-17797-8-git-send-email-tony@atomide.com>
 <1212802253-17797-9-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55374 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757472AbYFGBbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:16 -0400
In-Reply-To: <1212802253-17797-9-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Split sram24xx.S into sram242x.S and sram243x.S

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/sram.S b/arch/arm/mach-omap1/sram.S
index 9e1813c..126d252 100644
--- a/arch/arm/mach-omap1/sram.S
+++ b/arch/arm/mach-omap1/sram.S
@@ -18,7 +18,7 @@
 /*
  * Reprograms ULPD and CKCTL.
  */
-ENTRY(sram_reprogram_clock)
+ENTRY(omap1_sram_reprogram_clock)
 	stmfd	sp!, {r0 - r12, lr}		@ save registers on stack
 
 	mov	r2, #IO_ADDRESS(DPLL_CTL) & 0xff000000
@@ -53,5 +53,5 @@ lock:	ldrh	r4, [r2], #0			@ read back dpll value
 
 out:
 	ldmfd	sp!, {r0 - r12, pc}		@ restore regs and return
-ENTRY(sram_reprogram_clock_sz)
-	.word	. - sram_reprogram_clock
+ENTRY(omap1_sram_reprogram_clock_sz)
+	.word	. - omap1_sram_reprogram_clock
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6c59b26..c247742 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,9 +3,13 @@
 #
 
 # Common support
-obj-y := irq.o id.o io.o sram242x.o memory.o control.o prcm.o clock.o mux.o \
+obj-y := irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
 		devices.o serial.o gpmc.o timer-gp.o
 
+# Functions loaded to SRAM
+obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
+obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
+
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o
 
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ab9fc57..0243480 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -603,7 +603,8 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 	clk->rate = clk->parent->rate / new_div;
 
 	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
-		__raw_writel(OMAP24XX_VALID_CONFIG, OMAP24XX_PRCM_CLKCFG_CTRL);
+		prm_write_mod_reg(OMAP24XX_VALID_CONFIG,
+			OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
 		wmb();
 	}
 
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index cacb340..54c32f4 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -32,6 +32,7 @@
 
 
 /* Chip-specific module offsets */
+#define OMAP24XX_GR_MOD					OCP_MOD
 #define OMAP24XX_DSP_MOD				0x800
 
 #define OMAP2430_MDM_MOD				0xc00
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 618f811..dcdb35b 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -38,13 +38,29 @@
  *
  */
 
+/* Global 24xx registers in GR_MOD (Same as OCP_MOD for 24xx) */
+#define OMAP24XX_PRCM_VOLTCTRL_OFFSET		0x0050
+#define OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET	0x0080
+
+/* 242x GR_MOD registers, use these only for assembly code */
+#define OMAP242X_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OMAP24XX_GR_MOD,	\
+						OMAP24XX_PRCM_VOLTCTRL_OFFSET)
+#define OMAP242X_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OMAP24XX_GR_MOD,	\
+						OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET)
+
+/* 243x GR_MOD registers, use these only for assembly code */
+#define OMAP243X_PRCM_VOLTCTRL		OMAP2430_PRM_REGADDR(OMAP24XX_GR_MOD,	\
+						OMAP24XX_PRCM_VOLTCTRL_OFFSET)
+#define OMAP243X_PRCM_CLKCFG_CTRL	OMAP2430_PRM_REGADDR(OMAP24XX_GR_MOD,	\
+						OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET)
+
+/* These will disappear */
 #define OMAP24XX_PRCM_REVISION		OMAP_PRM_REGADDR(OCP_MOD, 0x0000)
 #define OMAP24XX_PRCM_SYSCONFIG		OMAP_PRM_REGADDR(OCP_MOD, 0x0010)
 
 #define OMAP24XX_PRCM_IRQSTATUS_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x0018)
 #define OMAP24XX_PRCM_IRQENABLE_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x001c)
 
-#define OMAP24XX_PRCM_VOLTCTRL		OMAP_PRM_REGADDR(OCP_MOD, 0x0050)
 #define OMAP24XX_PRCM_VOLTST		OMAP_PRM_REGADDR(OCP_MOD, 0x0054)
 #define OMAP24XX_PRCM_CLKSRC_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0060)
 #define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0070)
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index 4a9e491..4c27451 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-omap2/sram-fn.S
+ * linux/arch/arm/mach-omap2/sram242x.S
  *
  * Omap2 specific functions that need to be run in internal SRAM
  *
@@ -27,22 +27,20 @@
 #include <asm/arch/io.h>
 #include <asm/hardware.h>
 
-#include "sdrc.h"
 #include "prm.h"
 #include "cm.h"
-
-#define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
+#include "sdrc.h"
 
 	.text
 
-ENTRY(sram_ddr_init)
+ENTRY(omap242x_sram_ddr_init)
 	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
 
 	mov	r12, r2			@ capture CS1 vs CS0
 	mov	r8, r3			@ capture force parameter
 
 	/* frequency shift down */
-	ldr	r2, cm_clksel2_pll	@ get address of dpllout reg
+	ldr	r2, omap242x_sdi_cm_clksel2_pll	@ get address of dpllout reg
 	mov	r3, #0x1		@ value for 1x operation
 	str	r3, [r2]		@ go to L1-freq operation
 
@@ -51,7 +49,7 @@ ENTRY(sram_ddr_init)
 	bl voltage_shift		@ go drop voltage
 
 	/* dll lock mode */
-	ldr	r11, sdrc_dlla_ctrl	@ addr of dlla ctrl
+	ldr	r11, omap242x_sdi_sdrc_dlla_ctrl	@ addr of dlla ctrl
 	ldr	r10, [r11]		@ get current val
 	cmp	r12, #0x1		@ cs1 base (2422 es2.05/1)
 	addeq	r11, r11, #0x8		@ if cs1 base, move to DLLB
@@ -102,7 +100,7 @@ i_dll_delay:
 	 * wait for it to finish, use 32k sync counter, 1tick=31uS.
 	 */
 voltage_shift:
-	ldr	r4, prcm_voltctrl	@ get addr of volt ctrl.
+	ldr	r4, omap242x_sdi_prcm_voltctrl	@ get addr of volt ctrl.
 	ldr	r5, [r4]		@ get value.
 	ldr	r6, prcm_mask_val	@ get value of mask
 	and	r5, r5, r6		@ apply mask to clear bits
@@ -112,7 +110,7 @@ voltage_shift:
 	orr	r5, r5, r3		@ build value for force
 	str	r5, [r4]		@ Force transition to L1
 
-	ldr	r3, timer_32ksynct_cr	@ get addr of counter
+	ldr	r3, omap242x_sdi_timer_32ksynct_cr	@ get addr of counter
 	ldr	r5, [r3]		@ get value
 	add	r5, r5, #0x3		@ give it at most 93uS
 volt_delay:
@@ -121,32 +119,31 @@ volt_delay:
 	bhi	volt_delay		@ not yet->branch
 	mov	pc, lr			@ back to caller.
 
-/* relative load constants */
-cm_clksel2_pll:
+omap242x_sdi_cm_clksel2_pll:
 	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
-sdrc_dlla_ctrl:
+omap242x_sdi_sdrc_dlla_ctrl:
 	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
-prcm_voltctrl:
-	.word OMAP2420_PRM_REGADDR(OCP_MOD, 0x50)
+omap242x_sdi_prcm_voltctrl:
+	.word OMAP242X_PRCM_VOLTCTRL
 prcm_mask_val:
 	.word 0xFFFF3FFC
-timer_32ksynct_cr:
-	.word TIMER_32KSYNCT_CR_V
-ENTRY(sram_ddr_init_sz)
-	.word	. - sram_ddr_init
+omap242x_sdi_timer_32ksynct_cr:
+	.word IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
+ENTRY(omap242x_sram_ddr_init_sz)
+	.word	. - omap242x_sram_ddr_init
 
 /*
  * Reprograms memory timings.
  * r0 = [PRCM_FULL | PRCM_HALF] r1 = SDRC_DLLA_CTRL value r2 = [DDR | SDR]
  * PRCM_FULL = 2, PRCM_HALF = 1, DDR = 1, SDR = 0
  */
-ENTRY(sram_reprogram_sdrc)
+ENTRY(omap242x_sram_reprogram_sdrc)
 	stmfd	sp!, {r0 - r10, lr}	@ save registers on stack
 	mov	r3, #0x0		@ clear for mrc call
 	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, finish ARM SDR/DDR
 	nop
 	nop
-	ldr	r6, ddr_sdrc_rfr_ctrl	@ get addr of refresh reg
+	ldr	r6, omap242x_srs_sdrc_rfr_ctrl	@ get addr of refresh reg
 	ldr	r5, [r6]		@ get value
 	mov	r5, r5, lsr #8		@ isolate rfr field and drop burst
 
@@ -160,7 +157,7 @@ ENTRY(sram_reprogram_sdrc)
 	movne	r5, r5, lsl #1		@ mult by 2 if to full
 	mov	r5, r5, lsl #8		@ put rfr field back into place
 	add	r5, r5, #0x1		@ turn on burst of 1
-	ldr	r4, ddr_cm_clksel2_pll	@ get address of out reg
+	ldr	r4, omap242x_srs_cm_clksel2_pll	@ get address of out reg
 	ldr	r3, [r4]		@ get curr value
 	orr	r3, r3, #0x3
 	bic	r3, r3, #0x3		@ clear lower bits
@@ -181,7 +178,7 @@ ENTRY(sram_reprogram_sdrc)
 	bne	freq_out		@ leave if SDR, no DLL function
 
 	/* With DDR, we need to take care of the DLL for the frequency change */
-	ldr	r2, ddr_sdrc_dlla_ctrl	@ addr of dlla ctrl
+	ldr	r2, omap242x_srs_sdrc_dlla_ctrl	@ addr of dlla ctrl
 	str	r1, [r2]		@ write out new SDRC_DLLA_CTRL
 	add	r2, r2, #0x8		@ addr to SDRC_DLLB_CTRL
 	str	r1, [r2]		@ commit to SDRC_DLLB_CTRL
@@ -197,7 +194,7 @@ freq_out:
      *	wait for it to finish, use 32k sync counter, 1tick=31uS.
      */
 voltage_shift_c:
-	ldr	r10, ddr_prcm_voltctrl	@ get addr of volt ctrl
+	ldr	r10, omap242x_srs_prcm_voltctrl	@ get addr of volt ctrl
 	ldr	r8, [r10]		@ get value
 	ldr	r7, ddr_prcm_mask_val	@ get value of mask
 	and	r8, r8, r7		@ apply mask to clear bits
@@ -207,7 +204,7 @@ voltage_shift_c:
 	orr	r8, r8, r7		@ build value for force
 	str	r8, [r10]		@ Force transition to L1
 
-	ldr	r10, ddr_timer_32ksynct	@ get addr of counter
+	ldr	r10, omap242x_srs_timer_32ksynct	@ get addr of counter
 	ldr	r8, [r10]		@ get value
 	add	r8, r8, #0x2		@ give it at most 62uS (min 31+)
 volt_delay_c:
@@ -216,39 +213,39 @@ volt_delay_c:
 	bhi	volt_delay_c		@ not yet->branch
 	mov	pc, lr			@ back to caller
 
-ddr_cm_clksel2_pll:
+omap242x_srs_cm_clksel2_pll:
 	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
-ddr_sdrc_dlla_ctrl:
+omap242x_srs_sdrc_dlla_ctrl:
 	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
-ddr_sdrc_rfr_ctrl:
+omap242x_srs_sdrc_rfr_ctrl:
 	.word OMAP242X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
-ddr_prcm_voltctrl:
-	.word OMAP2420_PRM_REGADDR(OCP_MOD, 0x50)
+omap242x_srs_prcm_voltctrl:
+	.word OMAP242X_PRCM_VOLTCTRL
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
-ddr_timer_32ksynct:
-	.word TIMER_32KSYNCT_CR_V
+omap242x_srs_timer_32ksynct:
+	.word IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
 
-ENTRY(sram_reprogram_sdrc_sz)
-	.word	. - sram_reprogram_sdrc
+ENTRY(omap242x_sram_reprogram_sdrc_sz)
+	.word	. - omap242x_sram_reprogram_sdrc
 
 /*
  * Set dividers and pll. Also recalculate DLL value for DDR and unlock mode.
  */
-ENTRY(sram_set_prcm)
+ENTRY(omap242x_sram_set_prcm)
 	stmfd	sp!, {r0-r12, lr}	@ regs to stack
 	adr	r4, pbegin		@ addr of preload start
 	adr	r8, pend		@ addr of preload end
 	mcrr	p15, 1, r8, r4, c12	@ preload into icache
 pbegin:
 	/* move into fast relock bypass */
-	ldr	r8, pll_ctl		@ get addr
+	ldr	r8, omap242x_ssp_pll_ctl	@ get addr
 	ldr	r5, [r8]		@ get val
 	mvn	r6, #0x3		@ clear mask
 	and	r5, r5, r6		@ clear field
 	orr	r7, r5, #0x2		@ fast relock val
 	str	r7, [r8]		@ go to fast relock
-	ldr	r4, pll_stat		@ addr of stat
+	ldr	r4, omap242x_ssp_pll_stat	@ addr of stat
 block:
 	/* wait for bypass */
 	ldr	r8, [r4]		@ stat value
@@ -257,10 +254,10 @@ block:
 	bne	block			@ loop if not
 
 	/* set new dpll dividers _after_ in bypass */
-	ldr	r4, pll_div		@ get addr
+	ldr	r4, omap242x_ssp_pll_div	@ get addr
 	str	r0, [r4]		@ set dpll ctrl val
 
-	ldr	r4, set_config		@ get addr
+	ldr	r4, omap242x_ssp_set_config	@ get addr
 	mov	r8, #1			@ valid cfg msk
 	str	r8, [r4]		@ make dividers take
 
@@ -274,8 +271,8 @@ wait_a_bit:
 	beq	pend			@ jump over dpll relock
 
 	/* relock DPLL with new vals */
-	ldr	r5, pll_stat		@ get addr
-	ldr	r4, pll_ctl		@ get addr
+	ldr	r5, omap242x_ssp_pll_stat	@ get addr
+	ldr	r4, omap242x_ssp_pll_ctl	@ get addr
 	orr	r8, r7, #0x3		@ val for lock dpll
 	str	r8, [r4]		@ set val
 	mov	r0, #1000		@ dead spin a bit
@@ -289,9 +286,9 @@ wait_lock:
 	bne	wait_lock		@ wait if not
 pend:
 	/* update memory timings & briefly lock dll */
-	ldr	r4, sdrc_rfr		@ get addr
+	ldr	r4, omap242x_ssp_sdrc_rfr	@ get addr
 	str	r1, [r4]		@ update refresh timing
-	ldr	r11, dlla_ctrl		@ get addr of DLLA ctrl
+	ldr	r11, omap242x_ssp_dlla_ctrl	@ get addr of DLLA ctrl
 	ldr	r10, [r11]		@ get current val
 	mvn	r9, #0x4		@ mask to get clear bit2
 	and	r10, r10, r9		@ clear bit2 for lock mode
@@ -307,18 +304,18 @@ wait_dll_lock:
 	nop
 	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
 
-set_config:
-	.word OMAP2420_PRM_REGADDR(OCP_MOD, 0x80)
-pll_ctl:
-	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_FCLKEN1)
-pll_stat:
-	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_IDLEST1)
-pll_div:
-	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL)
-sdrc_rfr:
+omap242x_ssp_set_config:
+	.word OMAP242X_PRCM_CLKCFG_CTRL
+omap242x_ssp_pll_ctl:
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKEN)
+omap242x_ssp_pll_stat:
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_IDLEST)
+omap242x_ssp_pll_div:
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL1)
+omap242x_ssp_sdrc_rfr:
 	.word OMAP242X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
-dlla_ctrl:
+omap242x_ssp_dlla_ctrl:
 	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
 
-ENTRY(sram_set_prcm_sz)
-	.word	. - sram_set_prcm
+ENTRY(omap242x_sram_set_prcm_sz)
+	.word	. - omap242x_sram_set_prcm
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
new file mode 100644
index 0000000..a3fa48d
--- /dev/null
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -0,0 +1,321 @@
+/*
+ * linux/arch/arm/mach-omap2/sram243x.S
+ *
+ * Omap2 specific functions that need to be run in internal SRAM
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
+#include <asm/arch/io.h>
+#include <asm/hardware.h>
+
+#include "prm.h"
+#include "cm.h"
+#include "sdrc.h"
+
+	.text
+
+ENTRY(omap243x_sram_ddr_init)
+	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
+
+	mov	r12, r2			@ capture CS1 vs CS0
+	mov	r8, r3			@ capture force parameter
+
+	/* frequency shift down */
+	ldr	r2, omap243x_sdi_cm_clksel2_pll	@ get address of dpllout reg
+	mov	r3, #0x1		@ value for 1x operation
+	str	r3, [r2]		@ go to L1-freq operation
+
+	/* voltage shift down */
+	mov r9, #0x1			@ set up for L1 voltage call
+	bl voltage_shift		@ go drop voltage
+
+	/* dll lock mode */
+	ldr	r11, omap243x_sdi_sdrc_dlla_ctrl	@ addr of dlla ctrl
+	ldr	r10, [r11]		@ get current val
+	cmp	r12, #0x1		@ cs1 base (2422 es2.05/1)
+	addeq	r11, r11, #0x8		@ if cs1 base, move to DLLB
+	mvn	r9, #0x4		@ mask to get clear bit2
+	and	r10, r10, r9		@ clear bit2 for lock mode.
+	orr	r10, r10, #0x8		@ make sure DLL on (es2 bit pos)
+	orr	r10, r10, #0x2		@ 90 degree phase for all below 133Mhz
+	str	r10, [r11]		@ commit to DLLA_CTRL
+	bl	i_dll_wait		@ wait for dll to lock
+
+	/* get dll value */
+	add	r11, r11, #0x4		@ get addr of status reg
+	ldr	r10, [r11]		@ get locked value
+
+	/* voltage shift up */
+	mov r9, #0x0			@ shift back to L0-voltage
+	bl voltage_shift		@ go raise voltage
+
+	/* frequency shift up */
+	mov	r3, #0x2		@ value for 2x operation
+	str	r3, [r2]		@ go to L0-freq operation
+
+	/* reset entry mode for dllctrl */
+	sub	r11, r11, #0x4		@ move from status to ctrl
+	cmp	r12, #0x1		@ normalize if cs1 based
+	subeq	r11, r11, #0x8		@ possibly back to DLLA
+	cmp	r8, #0x1		@ if forced unlock exit
+	orreq	r1, r1, #0x4		@ make sure exit with unlocked value
+	str	r1, [r11]		@ restore DLLA_CTRL high value
+	add	r11, r11, #0x8		@ move to DLLB_CTRL addr
+	str	r1, [r11]		@ set value DLLB_CTRL
+	bl	i_dll_wait		@ wait for possible lock
+
+	/* set up for return, DDR should be good */
+	str r10, [r0]			@ write dll_status and return counter
+	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
+
+	/* ensure the DLL has relocked */
+i_dll_wait:
+	mov	r4, #0x800		@ delay DLL relock, min 0x400 L3 clocks
+i_dll_delay:
+	subs	r4, r4, #0x1
+	bne	i_dll_delay
+	mov	pc, lr
+
+	/*
+	 * shift up or down voltage, use R9 as input to tell level.
+	 * wait for it to finish, use 32k sync counter, 1tick=31uS.
+	 */
+voltage_shift:
+	ldr	r4, omap243x_sdi_prcm_voltctrl	@ get addr of volt ctrl.
+	ldr	r5, [r4]		@ get value.
+	ldr	r6, prcm_mask_val	@ get value of mask
+	and	r5, r5, r6		@ apply mask to clear bits
+	orr	r5, r5, r9		@ bulld value for L0/L1-volt operation.
+	str	r5, [r4]		@ set up for change.
+	mov	r3, #0x4000		@ get val for force
+	orr	r5, r5, r3		@ build value for force
+	str	r5, [r4]		@ Force transition to L1
+
+	ldr	r3, omap243x_sdi_timer_32ksynct_cr	@ get addr of counter
+	ldr	r5, [r3]		@ get value
+	add	r5, r5, #0x3		@ give it at most 93uS
+volt_delay:
+	ldr	r7, [r3]		@ get timer value
+	cmp	r5, r7			@ time up?
+	bhi	volt_delay		@ not yet->branch
+	mov	pc, lr			@ back to caller.
+
+omap243x_sdi_cm_clksel2_pll:
+	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
+omap243x_sdi_sdrc_dlla_ctrl:
+	.word OMAP243X_SDRC_REGADDR(SDRC_DLLA_CTRL)
+omap243x_sdi_prcm_voltctrl:
+	.word OMAP243X_PRCM_VOLTCTRL
+prcm_mask_val:
+	.word 0xFFFF3FFC
+omap243x_sdi_timer_32ksynct_cr:
+	.word IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
+ENTRY(omap243x_sram_ddr_init_sz)
+	.word	. - omap243x_sram_ddr_init
+
+/*
+ * Reprograms memory timings.
+ * r0 = [PRCM_FULL | PRCM_HALF] r1 = SDRC_DLLA_CTRL value r2 = [DDR | SDR]
+ * PRCM_FULL = 2, PRCM_HALF = 1, DDR = 1, SDR = 0
+ */
+ENTRY(omap243x_sram_reprogram_sdrc)
+	stmfd	sp!, {r0 - r10, lr}	@ save registers on stack
+	mov	r3, #0x0		@ clear for mrc call
+	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, finish ARM SDR/DDR
+	nop
+	nop
+	ldr	r6, omap243x_srs_sdrc_rfr_ctrl	@ get addr of refresh reg
+	ldr	r5, [r6]		@ get value
+	mov	r5, r5, lsr #8		@ isolate rfr field and drop burst
+
+	cmp	r0, #0x1		@ going to half speed?
+	movne	r9, #0x0		@ if up set flag up for pre up, hi volt
+
+	blne	voltage_shift_c		@ adjust voltage
+
+	cmp	r0, #0x1		@ going to half speed (post branch link)
+	moveq	r5, r5, lsr #1		@ divide by 2 if to half
+	movne	r5, r5, lsl #1		@ mult by 2 if to full
+	mov	r5, r5, lsl #8		@ put rfr field back into place
+	add	r5, r5, #0x1		@ turn on burst of 1
+	ldr	r4, omap243x_srs_cm_clksel2_pll	@ get address of out reg
+	ldr	r3, [r4]		@ get curr value
+	orr	r3, r3, #0x3
+	bic	r3, r3, #0x3		@ clear lower bits
+	orr	r3, r3, r0		@ new state value
+	str	r3, [r4]		@ set new state (pll/x, x=1 or 2)
+	nop
+	nop
+
+	moveq	r9, #0x1		@ if speed down, post down, drop volt
+	bleq	voltage_shift_c
+
+	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier
+	str	r5, [r6]		@ set new RFR_1 value
+	add	r6, r6, #0x30		@ get RFR_2 addr
+	str	r5, [r6]		@ set RFR_2
+	nop
+	cmp	r2, #0x1		@ (SDR or DDR) do we need to adjust DLL
+	bne	freq_out		@ leave if SDR, no DLL function
+
+	/* With DDR, we need to take care of the DLL for the frequency change */
+	ldr	r2, omap243x_srs_sdrc_dlla_ctrl	@ addr of dlla ctrl
+	str	r1, [r2]		@ write out new SDRC_DLLA_CTRL
+	add	r2, r2, #0x8		@ addr to SDRC_DLLB_CTRL
+	str	r1, [r2]		@ commit to SDRC_DLLB_CTRL
+	mov	r1, #0x2000		@ wait DLL relock, min 0x400 L3 clocks
+dll_wait:
+	subs	r1, r1, #0x1
+	bne	dll_wait
+freq_out:
+	ldmfd	sp!, {r0 - r10, pc}	@ restore regs and return
+
+    /*
+     * shift up or down voltage, use R9 as input to tell level.
+     *	wait for it to finish, use 32k sync counter, 1tick=31uS.
+     */
+voltage_shift_c:
+	ldr	r10, omap243x_srs_prcm_voltctrl	@ get addr of volt ctrl
+	ldr	r8, [r10]		@ get value
+	ldr	r7, ddr_prcm_mask_val	@ get value of mask
+	and	r8, r8, r7		@ apply mask to clear bits
+	orr	r8, r8, r9		@ bulld value for L0/L1-volt operation.
+	str	r8, [r10]		@ set up for change.
+	mov	r7, #0x4000		@ get val for force
+	orr	r8, r8, r7		@ build value for force
+	str	r8, [r10]		@ Force transition to L1
+
+	ldr	r10, omap243x_srs_timer_32ksynct	@ get addr of counter
+	ldr	r8, [r10]		@ get value
+	add	r8, r8, #0x2		@ give it at most 62uS (min 31+)
+volt_delay_c:
+	ldr	r7, [r10]		@ get timer value
+	cmp	r8, r7			@ time up?
+	bhi	volt_delay_c		@ not yet->branch
+	mov	pc, lr			@ back to caller
+
+omap243x_srs_cm_clksel2_pll:
+	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
+omap243x_srs_sdrc_dlla_ctrl:
+	.word OMAP243X_SDRC_REGADDR(SDRC_DLLA_CTRL)
+omap243x_srs_sdrc_rfr_ctrl:
+	.word OMAP243X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
+omap243x_srs_prcm_voltctrl:
+	.word OMAP243X_PRCM_VOLTCTRL
+ddr_prcm_mask_val:
+	.word 0xFFFF3FFC
+omap243x_srs_timer_32ksynct:
+	.word IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
+
+ENTRY(omap243x_sram_reprogram_sdrc_sz)
+	.word	. - omap243x_sram_reprogram_sdrc
+
+/*
+ * Set dividers and pll. Also recalculate DLL value for DDR and unlock mode.
+ */
+ENTRY(omap243x_sram_set_prcm)
+	stmfd	sp!, {r0-r12, lr}	@ regs to stack
+	adr	r4, pbegin		@ addr of preload start
+	adr	r8, pend		@ addr of preload end
+	mcrr	p15, 1, r8, r4, c12	@ preload into icache
+pbegin:
+	/* move into fast relock bypass */
+	ldr	r8, omap243x_ssp_pll_ctl	@ get addr
+	ldr	r5, [r8]		@ get val
+	mvn	r6, #0x3		@ clear mask
+	and	r5, r5, r6		@ clear field
+	orr	r7, r5, #0x2		@ fast relock val
+	str	r7, [r8]		@ go to fast relock
+	ldr	r4, omap243x_ssp_pll_stat	@ addr of stat
+block:
+	/* wait for bypass */
+	ldr	r8, [r4]		@ stat value
+	and	r8, r8, #0x3		@ mask for stat
+	cmp	r8, #0x1		@ there yet
+	bne	block			@ loop if not
+
+	/* set new dpll dividers _after_ in bypass */
+	ldr	r4, omap243x_ssp_pll_div	@ get addr
+	str	r0, [r4]		@ set dpll ctrl val
+
+	ldr	r4, omap243x_ssp_set_config	@ get addr
+	mov	r8, #1			@ valid cfg msk
+	str	r8, [r4]		@ make dividers take
+
+	mov	r4, #100		@ dead spin a bit
+wait_a_bit:
+	subs	r4, r4, #1		@ dec loop
+	bne	wait_a_bit		@ delay done?
+
+	/* check if staying in bypass */
+	cmp	r2, #0x1		@ stay in bypass?
+	beq	pend			@ jump over dpll relock
+
+	/* relock DPLL with new vals */
+	ldr	r5, omap243x_ssp_pll_stat	@ get addr
+	ldr	r4, omap243x_ssp_pll_ctl	@ get addr
+	orr	r8, r7, #0x3		@ val for lock dpll
+	str	r8, [r4]		@ set val
+	mov	r0, #1000		@ dead spin a bit
+wait_more:
+	subs	r0, r0, #1		@ dec loop
+	bne	wait_more		@ delay done?
+wait_lock:
+	ldr	r8, [r5]		@ get lock val
+	and	r8, r8, #3		@ isolate field
+	cmp	r8, #2			@ locked?
+	bne	wait_lock		@ wait if not
+pend:
+	/* update memory timings & briefly lock dll */
+	ldr	r4, omap243x_ssp_sdrc_rfr	@ get addr
+	str	r1, [r4]		@ update refresh timing
+	ldr	r11, omap243x_ssp_dlla_ctrl	@ get addr of DLLA ctrl
+	ldr	r10, [r11]		@ get current val
+	mvn	r9, #0x4		@ mask to get clear bit2
+	and	r10, r10, r9		@ clear bit2 for lock mode
+	orr	r10, r10, #0x8		@ make sure DLL on (es2 bit pos)
+	str	r10, [r11]		@ commit to DLLA_CTRL
+	add	r11, r11, #0x8		@ move to dllb
+	str	r10, [r11]		@ hit DLLB also
+
+	mov	r4, #0x800		@ relock time (min 0x400 L3 clocks)
+wait_dll_lock:
+	subs	r4, r4, #0x1
+	bne	wait_dll_lock
+	nop
+	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
+
+omap243x_ssp_set_config:
+	.word OMAP243X_PRCM_CLKCFG_CTRL
+omap243x_ssp_pll_ctl:
+	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_CLKEN)
+omap243x_ssp_pll_stat:
+	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_IDLEST)
+omap243x_ssp_pll_div:
+	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_CLKSEL1)
+omap243x_ssp_sdrc_rfr:
+	.word OMAP243X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
+omap243x_ssp_dlla_ctrl:
+	.word OMAP243X_SDRC_REGADDR(SDRC_DLLA_CTRL)
+
+ENTRY(omap243x_sram_set_prcm_sz)
+	.word	. - omap243x_sram_set_prcm
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 1f23f04..554ee58 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -10,6 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#undef DEBUG
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -24,25 +25,43 @@
 #include <asm/arch/sram.h>
 #include <asm/arch/board.h>
 
+#include <asm/arch/control.h>
+
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+# include "../mach-omap2/prm.h"
+# include "../mach-omap2/cm.h"
+# include "../mach-omap2/sdrc.h"
+#endif
+
 #define OMAP1_SRAM_PA		0x20000000
-#define OMAP1_SRAM_VA		0xd0000000
+#define OMAP1_SRAM_VA		VMALLOC_END
 #define OMAP2_SRAM_PA		0x40200000
 #define OMAP2_SRAM_PUB_PA	0x4020f800
-#define OMAP2_SRAM_VA		0xd0000000
-#define OMAP2_SRAM_PUB_VA	0xd0000800
-
-#if defined(CONFIG_ARCH_OMAP24XX)
+#define OMAP2_SRAM_VA		VMALLOC_END
+#define OMAP2_SRAM_PUB_VA	(VMALLOC_END + 0x800)
+#define OMAP3_SRAM_PA           0x40200000
+#define OMAP3_SRAM_VA           0xd7000000
+#define OMAP3_SRAM_PUB_PA       0x40208000
+#define OMAP3_SRAM_PUB_VA       0xd7008000
+
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ	0x00
 #else
 #define SRAM_BOOTLOADER_SZ	0x80
 #endif
 
-#define VA_REQINFOPERM0		IO_ADDRESS(0x68005048)
-#define VA_READPERM0		IO_ADDRESS(0x68005050)
-#define VA_WRITEPERM0		IO_ADDRESS(0x68005058)
-#define VA_CONTROL_STAT		IO_ADDRESS(0x480002F8)
+#define OMAP24XX_VA_REQINFOPERM0	IO_ADDRESS(0x68005048)
+#define OMAP24XX_VA_READPERM0		IO_ADDRESS(0x68005050)
+#define OMAP24XX_VA_WRITEPERM0		IO_ADDRESS(0x68005058)
+
+#define OMAP34XX_VA_REQINFOPERM0	IO_ADDRESS(0x68012848)
+#define OMAP34XX_VA_READPERM0		IO_ADDRESS(0x68012850)
+#define OMAP34XX_VA_WRITEPERM0		IO_ADDRESS(0x68012858)
+#define OMAP34XX_VA_ADDR_MATCH2		IO_ADDRESS(0x68012880)
+#define OMAP34XX_VA_SMS_RG_ATT0		IO_ADDRESS(0x6C000048)
+#define OMAP34XX_VA_CONTROL_STAT	IO_ADDRESS(0x480022F0)
+
 #define GP_DEVICE		0x300
-#define TYPE_MASK		0x700
 
 #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
 
@@ -68,14 +87,21 @@ static int is_sram_locked(void)
 	int type = 0;
 
 	if (cpu_is_omap242x())
-		type = __raw_readl(VA_CONTROL_STAT) & TYPE_MASK;
+		type = system_rev & OMAP2_DEVICETYPE_MASK;
 
 	if (type == GP_DEVICE) {
 		/* RAMFW: R/W access to all initiators for all qualifier sets */
 		if (cpu_is_omap242x()) {
-			__raw_writel(0xFF, VA_REQINFOPERM0); /* all q-vects */
-			__raw_writel(0xCFDE, VA_READPERM0);  /* all i-read */
-			__raw_writel(0xCFDE, VA_WRITEPERM0); /* all i-write */
+			__raw_writel(0xFF, OMAP24XX_VA_REQINFOPERM0); /* all q-vects */
+			__raw_writel(0xCFDE, OMAP24XX_VA_READPERM0);  /* all i-read */
+			__raw_writel(0xCFDE, OMAP24XX_VA_WRITEPERM0); /* all i-write */
+		}
+		if (cpu_is_omap34xx()) {
+			__raw_writel(0xFFFF, OMAP34XX_VA_REQINFOPERM0); /* all q-vects */
+			__raw_writel(0xFFFF, OMAP34XX_VA_READPERM0);  /* all i-read */
+			__raw_writel(0xFFFF, OMAP34XX_VA_WRITEPERM0); /* all i-write */
+			__raw_writel(0x0, OMAP34XX_VA_ADDR_MATCH2);
+			__raw_writel(0xFFFFFFFF, OMAP34XX_VA_SMS_RG_ATT0);
 		}
 		return 0;
 	} else
@@ -92,18 +118,30 @@ void __init omap_detect_sram(void)
 {
 	unsigned long reserved;
 
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		if (is_sram_locked()) {
-			omap_sram_base = OMAP2_SRAM_PUB_VA;
-			omap_sram_start = OMAP2_SRAM_PUB_PA;
-			omap_sram_size = 0x800; /* 2K */
+			if (cpu_is_omap34xx()) {
+				omap_sram_base = OMAP3_SRAM_PUB_VA;
+				omap_sram_start = OMAP3_SRAM_PUB_PA;
+				omap_sram_size = 0x8000; /* 32K */
+			} else {
+				omap_sram_base = OMAP2_SRAM_PUB_VA;
+				omap_sram_start = OMAP2_SRAM_PUB_PA;
+				omap_sram_size = 0x800; /* 2K */
+			}
 		} else {
-			omap_sram_base = OMAP2_SRAM_VA;
-			omap_sram_start = OMAP2_SRAM_PA;
-			if (cpu_is_omap242x())
-				omap_sram_size = 0xa0000; /* 640K */
-			else if (cpu_is_omap243x())
+			if (cpu_is_omap34xx()) {
+				omap_sram_base = OMAP3_SRAM_VA;
+				omap_sram_start = OMAP3_SRAM_PA;
 				omap_sram_size = 0x10000; /* 64K */
+			} else {
+				omap_sram_base = OMAP2_SRAM_VA;
+				omap_sram_start = OMAP2_SRAM_PA;
+				if (cpu_is_omap242x())
+					omap_sram_size = 0xa0000; /* 640K */
+				else if (cpu_is_omap243x())
+					omap_sram_size = 0x10000; /* 64K */
+			}
 		}
 	} else {
 		omap_sram_base = OMAP1_SRAM_VA;
@@ -157,6 +195,13 @@ void __init omap_map_sram(void)
 		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
 	}
 
+	if (cpu_is_omap34xx()) {
+		omap_sram_io_desc[0].virtual = OMAP3_SRAM_VA;
+		base = OMAP3_SRAM_PA;
+		base = ROUND_DOWN(base, PAGE_SIZE);
+		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
+	}
+
 	omap_sram_io_desc[0].length = 1024 * 1024;	/* Use section desc */
 	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
 
@@ -191,6 +236,7 @@ void * omap_sram_push(void * start, unsigned long size)
 	omap_sram_ceil -= size;
 	omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
 	memcpy((void *)omap_sram_ceil, start, size);
+	flush_icache_range((unsigned long)start, (unsigned long)(start + size));
 
 	return (void *)omap_sram_ceil;
 }
@@ -214,8 +260,9 @@ void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl)
 
 int __init omap1_sram_init(void)
 {
-	_omap_sram_reprogram_clock = omap_sram_push(sram_reprogram_clock,
-						    sram_reprogram_clock_sz);
+	_omap_sram_reprogram_clock =
+			omap_sram_push(omap1_sram_reprogram_clock,
+					omap1_sram_reprogram_clock_sz);
 
 	return 0;
 }
@@ -224,7 +271,7 @@ int __init omap1_sram_init(void)
 #define omap1_sram_init()	do {} while (0)
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 
 static void (*_omap2_sram_ddr_init)(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 			      u32 base_cs, u32 force_unlock);
@@ -259,19 +306,109 @@ u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass)
 
 	return _omap2_set_prcm(dpll_ctrl_val, sdrc_rfr_val, bypass);
 }
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2420
+int __init omap242x_sram_init(void)
+{
+	_omap2_sram_ddr_init = omap_sram_push(omap242x_sram_ddr_init,
+					omap242x_sram_ddr_init_sz);
+
+	_omap2_sram_reprogram_sdrc = omap_sram_push(omap242x_sram_reprogram_sdrc,
+					    omap242x_sram_reprogram_sdrc_sz);
+
+	_omap2_set_prcm = omap_sram_push(omap242x_sram_set_prcm,
+					 omap242x_sram_set_prcm_sz);
+
+	return 0;
+}
+#else
+static inline int omap242x_sram_init(void)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+int __init omap243x_sram_init(void)
+{
+	_omap2_sram_ddr_init = omap_sram_push(omap243x_sram_ddr_init,
+					omap243x_sram_ddr_init_sz);
+
+	_omap2_sram_reprogram_sdrc = omap_sram_push(omap243x_sram_reprogram_sdrc,
+					    omap243x_sram_reprogram_sdrc_sz);
+
+	_omap2_set_prcm = omap_sram_push(omap243x_sram_set_prcm,
+					 omap243x_sram_set_prcm_sz);
+
+	return 0;
+}
+#else
+static inline int omap243x_sram_init(void)
+{
+	return 0;
+}
+#endif
+
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
 
-int __init omap2_sram_init(void)
+/* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
+void restore_sram_functions(void)
 {
-	_omap2_sram_ddr_init = omap_sram_push(sram_ddr_init, sram_ddr_init_sz);
+	omap_sram_ceil = omap_sram_base + omap_sram_size;
 
-	_omap2_sram_reprogram_sdrc = omap_sram_push(sram_reprogram_sdrc,
-						    sram_reprogram_sdrc_sz);
-	_omap2_set_prcm = omap_sram_push(sram_set_prcm, sram_set_prcm_sz);
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
 
 	return 0;
 }
 #else
-#define omap2_sram_init()	do {} while (0)
+static inline int omap34xx_sram_init(void)
+{
+	return 0;
+}
 #endif
 
 int __init omap_sram_init(void)
@@ -279,10 +416,14 @@ int __init omap_sram_init(void)
 	omap_detect_sram();
 	omap_map_sram();
 
-	if (!cpu_is_omap24xx())
+	if (!(cpu_class_is_omap2()))
 		omap1_sram_init();
-	else
-		omap2_sram_init();
+	else if (cpu_is_omap242x())
+		omap242x_sram_init();
+	else if (cpu_is_omap2430())
+		omap243x_sram_init();
+	else if (cpu_is_omap34xx())
+		omap34xx_sram_init();
 
 	return 0;
 }
diff --git a/include/asm-arm/arch-omap/sram.h b/include/asm-arm/arch-omap/sram.h
index bb9bb3f..be59f4a 100644
--- a/include/asm-arm/arch-omap/sram.h
+++ b/include/asm-arm/arch-omap/sram.h
@@ -11,6 +11,7 @@
 #ifndef __ARCH_ARM_OMAP_SRAM_H
 #define __ARCH_ARM_OMAP_SRAM_H
 
+extern int __init omap_sram_init(void);
 extern void * omap_sram_push(void * start, unsigned long size);
 extern void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl);
 
@@ -21,17 +22,35 @@ extern void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
 extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
 
 /* Do not use these */
-extern void sram_reprogram_clock(u32 ckctl, u32 dpllctl);
-extern unsigned long sram_reprogram_clock_sz;
+extern void omap1_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
+extern unsigned long omap1_sram_reprogram_clock_sz;
 
-extern void sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
-			  u32 base_cs, u32 force_unlock);
-extern unsigned long sram_ddr_init_sz;
+extern void omap24xx_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
+extern unsigned long omap24xx_sram_reprogram_clock_sz;
 
-extern u32 sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
-extern unsigned long sram_set_prcm_sz;
+extern void omap242x_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
+						u32 base_cs, u32 force_unlock);
+extern unsigned long omap242x_sram_ddr_init_sz;
 
-extern void sram_reprogram_sdrc(u32 perf_level, u32 dll_val, u32 mem_type);
-extern unsigned long sram_reprogram_sdrc_sz;
+extern u32 omap242x_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
+						int bypass);
+extern unsigned long omap242x_sram_set_prcm_sz;
+
+extern void omap242x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
+						u32 mem_type);
+extern unsigned long omap242x_sram_reprogram_sdrc_sz;
+
+
+extern void omap243x_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
+						u32 base_cs, u32 force_unlock);
+extern unsigned long omap243x_sram_ddr_init_sz;
+
+extern u32 omap243x_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
+						int bypass);
+extern unsigned long omap243x_sram_set_prcm_sz;
+
+extern void omap243x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
+						u32 mem_type);
+extern unsigned long omap243x_sram_reprogram_sdrc_sz;
 
 #endif
