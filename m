From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/14] ARM: OMAP: Split sram24xx.S into sram242x.S and sram243x.S
Date: Tue, 27 May 2008 21:20:12 -0700
Message-ID: <1211948418-16455-9-git-send-email-tony@atomide.com>
References: multi-omap-2008-05-27-212014
 <1211948418-16455-1-git-send-email-tony@atomide.com>
 <1211948418-16455-2-git-send-email-tony@atomide.com>
 <1211948418-16455-3-git-send-email-tony@atomide.com>
 <1211948418-16455-4-git-send-email-tony@atomide.com>
 <1211948418-16455-5-git-send-email-tony@atomide.com>
 <1211948418-16455-6-git-send-email-tony@atomide.com>
 <1211948418-16455-7-git-send-email-tony@atomide.com>
 <1211948418-16455-8-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64594 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbYE1EUc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 00:20:32 -0400
In-Reply-To: <1211948418-16455-8-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Split sram24xx.S into sram242x.S and sram243x.S

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile      |    3 +-
 arch/arm/mach-omap2/clock.c       |    7 +-
 arch/arm/mach-omap2/pm24xx.c      |    4 +-
 arch/arm/mach-omap2/prcm-common.h |    1 +
 arch/arm/mach-omap2/prm.h         |   19 ++-
 arch/arm/mach-omap2/sram242x.S    |  321 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sram243x.S    |  321 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sram24xx.S    |  337 -------------------------------------
 arch/arm/plat-omap/sram.c         |  121 ++++----------
 include/asm-arm/arch-omap/sram.h  |   25 ++-
 10 files changed, 723 insertions(+), 436 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sram242x.S
 create mode 100644 arch/arm/mach-omap2/sram243x.S
 delete mode 100644 arch/arm/mach-omap2/sram24xx.S

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index db82eb1..ad99039 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -8,7 +8,8 @@ obj-y := irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
 		clockdomain.o
 
 # Functions loaded to SRAM
-obj-$(CONFIG_ARCH_OMAP2)		+= sram24xx.o
+obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
+obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
 obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
 
 # Power Management
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 0742359..d53d81f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -652,7 +652,8 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 	clk->rate = clk->parent->rate / new_div;
 
 	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
-		__raw_writel(OMAP24XX_VALID_CONFIG, OMAP24XX_PRCM_CLKCFG_CTRL);
+		prm_write_mod_reg(OMAP24XX_VALID_CONFIG,
+			OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
 		wmb();
 	}
 
@@ -748,8 +749,8 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	wmb();
 
 	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
-		__raw_writel(OMAP24XX_VALID_CONFIG,
-			      OMAP24XX_PRCM_CLKCFG_CTRL);
+		prm_write_mod_reg(OMAP24XX_VALID_CONFIG,
+			OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
 		wmb();
 	}
 
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index aab079e..10088e0 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -437,12 +437,12 @@ static void __init prcm_setup_regs(void)
 
 	/* Configure automatic voltage transition */
 	__raw_writel(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_PRCM_VOLTSETUP);
-	__raw_writel(OMAP24XX_AUTO_EXTVOLT |
+	prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT |
 		      (0x1 << OMAP24XX_SETOFF_LEVEL_SHIFT) |
 		      OMAP24XX_MEMRETCTRL |
 		      (0x1 << OMAP24XX_SETRET_LEVEL_SHIFT) |
 		      (0x0 << OMAP24XX_VOLT_LEVEL_SHIFT),
-		      OMAP24XX_PRCM_VOLTCTRL);
+		      OMAP24XX_GR_MOD, OMAP24XX_PRCM_VOLTCTRL_OFFSET);
 
 	/* Enable wake-up events */
 	prm_write_mod_reg(OMAP24XX_EN_GPIOS | OMAP24XX_EN_GPT1,
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 99a582d..4a32822 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -32,6 +32,7 @@
 
 
 /* Chip-specific module offsets */
+#define OMAP24XX_GR_MOD					OCP_MOD
 #define OMAP24XX_DSP_MOD				0x800
 
 #define OMAP2430_MDM_MOD				0xc00
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 27d44e2..478a8d2 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -38,18 +38,33 @@
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
 #define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0078)
-#define OMAP24XX_PRCM_CLKCFG_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0080)
 #define OMAP24XX_PRCM_CLKCFG_STATUS	OMAP_PRM_REGADDR(OCP_MOD, 0x0084)
 #define OMAP24XX_PRCM_VOLTSETUP		OMAP_PRM_REGADDR(OCP_MOD, 0x0090)
 #define OMAP24XX_PRCM_CLKSSETUP		OMAP_PRM_REGADDR(OCP_MOD, 0x0094)
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
new file mode 100644
index 0000000..4c27451
--- /dev/null
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -0,0 +1,321 @@
+/*
+ * linux/arch/arm/mach-omap2/sram242x.S
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
+ENTRY(omap242x_sram_ddr_init)
+	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
+
+	mov	r12, r2			@ capture CS1 vs CS0
+	mov	r8, r3			@ capture force parameter
+
+	/* frequency shift down */
+	ldr	r2, omap242x_sdi_cm_clksel2_pll	@ get address of dpllout reg
+	mov	r3, #0x1		@ value for 1x operation
+	str	r3, [r2]		@ go to L1-freq operation
+
+	/* voltage shift down */
+	mov r9, #0x1			@ set up for L1 voltage call
+	bl voltage_shift		@ go drop voltage
+
+	/* dll lock mode */
+	ldr	r11, omap242x_sdi_sdrc_dlla_ctrl	@ addr of dlla ctrl
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
+	ldr	r4, omap242x_sdi_prcm_voltctrl	@ get addr of volt ctrl.
+	ldr	r5, [r4]		@ get value.
+	ldr	r6, prcm_mask_val	@ get value of mask
+	and	r5, r5, r6		@ apply mask to clear bits
+	orr	r5, r5, r9		@ bulld value for L0/L1-volt operation.
+	str	r5, [r4]		@ set up for change.
+	mov	r3, #0x4000		@ get val for force
+	orr	r5, r5, r3		@ build value for force
+	str	r5, [r4]		@ Force transition to L1
+
+	ldr	r3, omap242x_sdi_timer_32ksynct_cr	@ get addr of counter
+	ldr	r5, [r3]		@ get value
+	add	r5, r5, #0x3		@ give it at most 93uS
+volt_delay:
+	ldr	r7, [r3]		@ get timer value
+	cmp	r5, r7			@ time up?
+	bhi	volt_delay		@ not yet->branch
+	mov	pc, lr			@ back to caller.
+
+omap242x_sdi_cm_clksel2_pll:
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
+omap242x_sdi_sdrc_dlla_ctrl:
+	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
+omap242x_sdi_prcm_voltctrl:
+	.word OMAP242X_PRCM_VOLTCTRL
+prcm_mask_val:
+	.word 0xFFFF3FFC
+omap242x_sdi_timer_32ksynct_cr:
+	.word IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
+ENTRY(omap242x_sram_ddr_init_sz)
+	.word	. - omap242x_sram_ddr_init
+
+/*
+ * Reprograms memory timings.
+ * r0 = [PRCM_FULL | PRCM_HALF] r1 = SDRC_DLLA_CTRL value r2 = [DDR | SDR]
+ * PRCM_FULL = 2, PRCM_HALF = 1, DDR = 1, SDR = 0
+ */
+ENTRY(omap242x_sram_reprogram_sdrc)
+	stmfd	sp!, {r0 - r10, lr}	@ save registers on stack
+	mov	r3, #0x0		@ clear for mrc call
+	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, finish ARM SDR/DDR
+	nop
+	nop
+	ldr	r6, omap242x_srs_sdrc_rfr_ctrl	@ get addr of refresh reg
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
+	ldr	r4, omap242x_srs_cm_clksel2_pll	@ get address of out reg
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
+	ldr	r2, omap242x_srs_sdrc_dlla_ctrl	@ addr of dlla ctrl
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
+	ldr	r10, omap242x_srs_prcm_voltctrl	@ get addr of volt ctrl
+	ldr	r8, [r10]		@ get value
+	ldr	r7, ddr_prcm_mask_val	@ get value of mask
+	and	r8, r8, r7		@ apply mask to clear bits
+	orr	r8, r8, r9		@ bulld value for L0/L1-volt operation.
+	str	r8, [r10]		@ set up for change.
+	mov	r7, #0x4000		@ get val for force
+	orr	r8, r8, r7		@ build value for force
+	str	r8, [r10]		@ Force transition to L1
+
+	ldr	r10, omap242x_srs_timer_32ksynct	@ get addr of counter
+	ldr	r8, [r10]		@ get value
+	add	r8, r8, #0x2		@ give it at most 62uS (min 31+)
+volt_delay_c:
+	ldr	r7, [r10]		@ get timer value
+	cmp	r8, r7			@ time up?
+	bhi	volt_delay_c		@ not yet->branch
+	mov	pc, lr			@ back to caller
+
+omap242x_srs_cm_clksel2_pll:
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
+omap242x_srs_sdrc_dlla_ctrl:
+	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
+omap242x_srs_sdrc_rfr_ctrl:
+	.word OMAP242X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
+omap242x_srs_prcm_voltctrl:
+	.word OMAP242X_PRCM_VOLTCTRL
+ddr_prcm_mask_val:
+	.word 0xFFFF3FFC
+omap242x_srs_timer_32ksynct:
+	.word IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
+
+ENTRY(omap242x_sram_reprogram_sdrc_sz)
+	.word	. - omap242x_sram_reprogram_sdrc
+
+/*
+ * Set dividers and pll. Also recalculate DLL value for DDR and unlock mode.
+ */
+ENTRY(omap242x_sram_set_prcm)
+	stmfd	sp!, {r0-r12, lr}	@ regs to stack
+	adr	r4, pbegin		@ addr of preload start
+	adr	r8, pend		@ addr of preload end
+	mcrr	p15, 1, r8, r4, c12	@ preload into icache
+pbegin:
+	/* move into fast relock bypass */
+	ldr	r8, omap242x_ssp_pll_ctl	@ get addr
+	ldr	r5, [r8]		@ get val
+	mvn	r6, #0x3		@ clear mask
+	and	r5, r5, r6		@ clear field
+	orr	r7, r5, #0x2		@ fast relock val
+	str	r7, [r8]		@ go to fast relock
+	ldr	r4, omap242x_ssp_pll_stat	@ addr of stat
+block:
+	/* wait for bypass */
+	ldr	r8, [r4]		@ stat value
+	and	r8, r8, #0x3		@ mask for stat
+	cmp	r8, #0x1		@ there yet
+	bne	block			@ loop if not
+
+	/* set new dpll dividers _after_ in bypass */
+	ldr	r4, omap242x_ssp_pll_div	@ get addr
+	str	r0, [r4]		@ set dpll ctrl val
+
+	ldr	r4, omap242x_ssp_set_config	@ get addr
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
+	ldr	r5, omap242x_ssp_pll_stat	@ get addr
+	ldr	r4, omap242x_ssp_pll_ctl	@ get addr
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
+	ldr	r4, omap242x_ssp_sdrc_rfr	@ get addr
+	str	r1, [r4]		@ update refresh timing
+	ldr	r11, omap242x_ssp_dlla_ctrl	@ get addr of DLLA ctrl
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
+omap242x_ssp_set_config:
+	.word OMAP242X_PRCM_CLKCFG_CTRL
+omap242x_ssp_pll_ctl:
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKEN)
+omap242x_ssp_pll_stat:
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_IDLEST)
+omap242x_ssp_pll_div:
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL1)
+omap242x_ssp_sdrc_rfr:
+	.word OMAP242X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
+omap242x_ssp_dlla_ctrl:
+	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
+
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
diff --git a/arch/arm/mach-omap2/sram24xx.S b/arch/arm/mach-omap2/sram24xx.S
deleted file mode 100644
index 5f1a305..0000000
--- a/arch/arm/mach-omap2/sram24xx.S
+++ /dev/null
@@ -1,337 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/sram-fn.S
- *
- * Omap2 specific functions that need to be run in internal SRAM
- *
- * (C) Copyright 2004
- * Texas Instruments, <www.ti.com>
- * Richard Woodruff <r-woodruff2@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <asm/arch/io.h>
-#include <asm/hardware.h>
-#include <linux/poison.h>
-
-	.text
-
-ENTRY(omap24xx_sram_ddr_init)
-	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
-
-	mov	r12, r2			@ capture CS1 vs CS0
-	mov	r8, r3			@ capture force parameter
-
-	/* frequency shift down */
-	ldr	r2, omap24xx_sdi_cm_clksel2_pll	@ get address of dpllout reg
-	mov	r3, #0x1		@ value for 1x operation
-	str	r3, [r2]		@ go to L1-freq operation
-
-	/* voltage shift down */
-	mov r9, #0x1			@ set up for L1 voltage call
-	bl voltage_shift		@ go drop voltage
-
-	/* dll lock mode */
-	ldr	r11, omap24xx_sdi_sdrc_dlla_ctrl	@ addr of dlla ctrl
-	ldr	r10, [r11]		@ get current val
-	cmp	r12, #0x1		@ cs1 base (2422 es2.05/1)
-	addeq	r11, r11, #0x8		@ if cs1 base, move to DLLB
-	mvn	r9, #0x4		@ mask to get clear bit2
-	and	r10, r10, r9		@ clear bit2 for lock mode.
-	orr	r10, r10, #0x8		@ make sure DLL on (es2 bit pos)
-	orr	r10, r10, #0x2		@ 90 degree phase for all below 133Mhz
-	str	r10, [r11]		@ commit to DLLA_CTRL
-	bl	i_dll_wait		@ wait for dll to lock
-
-	/* get dll value */
-	add	r11, r11, #0x4		@ get addr of status reg
-	ldr	r10, [r11]		@ get locked value
-
-	/* voltage shift up */
-	mov r9, #0x0			@ shift back to L0-voltage
-	bl voltage_shift		@ go raise voltage
-
-	/* frequency shift up */
-	mov	r3, #0x2		@ value for 2x operation
-	str	r3, [r2]		@ go to L0-freq operation
-
-	/* reset entry mode for dllctrl */
-	sub	r11, r11, #0x4		@ move from status to ctrl
-	cmp	r12, #0x1		@ normalize if cs1 based
-	subeq	r11, r11, #0x8		@ possibly back to DLLA
-	cmp	r8, #0x1		@ if forced unlock exit
-	orreq	r1, r1, #0x4		@ make sure exit with unlocked value
-	str	r1, [r11]		@ restore DLLA_CTRL high value
-	add	r11, r11, #0x8		@ move to DLLB_CTRL addr
-	str	r1, [r11]		@ set value DLLB_CTRL
-	bl	i_dll_wait		@ wait for possible lock
-
-	/* set up for return, DDR should be good */
-	str r10, [r0]			@ write dll_status and return counter
-	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
-
-	/* ensure the DLL has relocked */
-i_dll_wait:
-	mov	r4, #0x800		@ delay DLL relock, min 0x400 L3 clocks
-i_dll_delay:
-	subs	r4, r4, #0x1
-	bne	i_dll_delay
-	mov	pc, lr
-
-	/*
-	 * shift up or down voltage, use R9 as input to tell level.
-	 * wait for it to finish, use 32k sync counter, 1tick=31uS.
-	 */
-voltage_shift:
-	ldr	r4, omap24xx_sdi_prcm_voltctrl	@ get addr of volt ctrl.
-	ldr	r5, [r4]		@ get value.
-	ldr	r6, prcm_mask_val	@ get value of mask
-	and	r5, r5, r6		@ apply mask to clear bits
-	orr	r5, r5, r9		@ bulld value for L0/L1-volt operation.
-	str	r5, [r4]		@ set up for change.
-	mov	r3, #0x4000		@ get val for force
-	orr	r5, r5, r3		@ build value for force
-	str	r5, [r4]		@ Force transition to L1
-
-	ldr	r3, omap24xx_sdi_timer_32ksynct_cr	@ get addr of counter
-	ldr	r5, [r3]		@ get value
-	add	r5, r5, #0x3		@ give it at most 93uS
-volt_delay:
-	ldr	r7, [r3]		@ get timer value
-	cmp	r5, r7			@ time up?
-	bhi	volt_delay		@ not yet->branch
-	mov	pc, lr			@ back to caller.
-
-/* relative load constants */
-	.globl omap24xx_sdi_cm_clksel2_pll
-	.globl omap24xx_sdi_sdrc_dlla_ctrl
-	.globl omap24xx_sdi_prcm_voltctrl
-	.globl omap24xx_sdi_timer_32ksynct_cr
-
-omap24xx_sdi_cm_clksel2_pll:
-	.word SRAM_VA_MAGIC
-omap24xx_sdi_sdrc_dlla_ctrl:
-	.word SRAM_VA_MAGIC
-omap24xx_sdi_prcm_voltctrl:
-	.word SRAM_VA_MAGIC
-prcm_mask_val:
-	.word 0xFFFF3FFC
-omap24xx_sdi_timer_32ksynct_cr:
-	.word SRAM_VA_MAGIC
-ENTRY(omap24xx_sram_ddr_init_sz)
-	.word	. - omap24xx_sram_ddr_init
-
-/*
- * Reprograms memory timings.
- * r0 = [PRCM_FULL | PRCM_HALF] r1 = SDRC_DLLA_CTRL value r2 = [DDR | SDR]
- * PRCM_FULL = 2, PRCM_HALF = 1, DDR = 1, SDR = 0
- */
-ENTRY(omap24xx_sram_reprogram_sdrc)
-	stmfd	sp!, {r0 - r10, lr}	@ save registers on stack
-	mov	r3, #0x0		@ clear for mrc call
-	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, finish ARM SDR/DDR
-	nop
-	nop
-	ldr	r6, omap24xx_srs_sdrc_rfr_ctrl	@ get addr of refresh reg
-	ldr	r5, [r6]		@ get value
-	mov	r5, r5, lsr #8		@ isolate rfr field and drop burst
-
-	cmp	r0, #0x1		@ going to half speed?
-	movne	r9, #0x0		@ if up set flag up for pre up, hi volt
-
-	blne	voltage_shift_c		@ adjust voltage
-
-	cmp	r0, #0x1		@ going to half speed (post branch link)
-	moveq	r5, r5, lsr #1		@ divide by 2 if to half
-	movne	r5, r5, lsl #1		@ mult by 2 if to full
-	mov	r5, r5, lsl #8		@ put rfr field back into place
-	add	r5, r5, #0x1		@ turn on burst of 1
-	ldr	r4, omap24xx_srs_cm_clksel2_pll	@ get address of out reg
-	ldr	r3, [r4]		@ get curr value
-	orr	r3, r3, #0x3
-	bic	r3, r3, #0x3		@ clear lower bits
-	orr	r3, r3, r0		@ new state value
-	str	r3, [r4]		@ set new state (pll/x, x=1 or 2)
-	nop
-	nop
-
-	moveq	r9, #0x1		@ if speed down, post down, drop volt
-	bleq	voltage_shift_c
-
-	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier
-	str	r5, [r6]		@ set new RFR_1 value
-	add	r6, r6, #0x30		@ get RFR_2 addr
-	str	r5, [r6]		@ set RFR_2
-	nop
-	cmp	r2, #0x1		@ (SDR or DDR) do we need to adjust DLL
-	bne	freq_out		@ leave if SDR, no DLL function
-
-	/* With DDR, we need to take care of the DLL for the frequency change */
-	ldr	r2, omap24xx_srs_sdrc_dlla_ctrl	@ addr of dlla ctrl
-	str	r1, [r2]		@ write out new SDRC_DLLA_CTRL
-	add	r2, r2, #0x8		@ addr to SDRC_DLLB_CTRL
-	str	r1, [r2]		@ commit to SDRC_DLLB_CTRL
-	mov	r1, #0x2000		@ wait DLL relock, min 0x400 L3 clocks
-dll_wait:
-	subs	r1, r1, #0x1
-	bne	dll_wait
-freq_out:
-	ldmfd	sp!, {r0 - r10, pc}	@ restore regs and return
-
-    /*
-     * shift up or down voltage, use R9 as input to tell level.
-     *	wait for it to finish, use 32k sync counter, 1tick=31uS.
-     */
-voltage_shift_c:
-	ldr	r10, omap24xx_srs_prcm_voltctrl	@ get addr of volt ctrl
-	ldr	r8, [r10]		@ get value
-	ldr	r7, ddr_prcm_mask_val	@ get value of mask
-	and	r8, r8, r7		@ apply mask to clear bits
-	orr	r8, r8, r9		@ bulld value for L0/L1-volt operation.
-	str	r8, [r10]		@ set up for change.
-	mov	r7, #0x4000		@ get val for force
-	orr	r8, r8, r7		@ build value for force
-	str	r8, [r10]		@ Force transition to L1
-
-	ldr	r10, omap24xx_srs_timer_32ksynct	@ get addr of counter
-	ldr	r8, [r10]		@ get value
-	add	r8, r8, #0x2		@ give it at most 62uS (min 31+)
-volt_delay_c:
-	ldr	r7, [r10]		@ get timer value
-	cmp	r8, r7			@ time up?
-	bhi	volt_delay_c		@ not yet->branch
-	mov	pc, lr			@ back to caller
-
-	.globl omap24xx_srs_cm_clksel2_pll
-	.globl omap24xx_srs_sdrc_dlla_ctrl
-	.globl omap24xx_srs_sdrc_rfr_ctrl
-	.globl omap24xx_srs_prcm_voltctrl
-	.globl omap24xx_srs_timer_32ksynct
-
-omap24xx_srs_cm_clksel2_pll:
-	.word SRAM_VA_MAGIC
-omap24xx_srs_sdrc_dlla_ctrl:
-	.word SRAM_VA_MAGIC
-omap24xx_srs_sdrc_rfr_ctrl:
-	.word SRAM_VA_MAGIC
-omap24xx_srs_prcm_voltctrl:
-	.word SRAM_VA_MAGIC
-ddr_prcm_mask_val:
-	.word 0xFFFF3FFC
-omap24xx_srs_timer_32ksynct:
-	.word SRAM_VA_MAGIC
-
-ENTRY(omap24xx_sram_reprogram_sdrc_sz)
-	.word	. - omap24xx_sram_reprogram_sdrc
-
-/*
- * Set dividers and pll. Also recalculate DLL value for DDR and unlock mode.
- */
-ENTRY(omap24xx_sram_set_prcm)
-	stmfd	sp!, {r0-r12, lr}	@ regs to stack
-	adr	r4, pbegin		@ addr of preload start
-	adr	r8, pend		@ addr of preload end
-	mcrr	p15, 1, r8, r4, c12	@ preload into icache
-pbegin:
-	/* move into fast relock bypass */
-	ldr	r8, omap24xx_ssp_pll_ctl	@ get addr
-	ldr	r5, [r8]		@ get val
-	mvn	r6, #0x3		@ clear mask
-	and	r5, r5, r6		@ clear field
-	orr	r7, r5, #0x2		@ fast relock val
-	str	r7, [r8]		@ go to fast relock
-	ldr	r4, omap24xx_ssp_pll_stat	@ addr of stat
-block:
-	/* wait for bypass */
-	ldr	r8, [r4]		@ stat value
-	and	r8, r8, #0x3		@ mask for stat
-	cmp	r8, #0x1		@ there yet
-	bne	block			@ loop if not
-
-	/* set new dpll dividers _after_ in bypass */
-	ldr	r4, omap24xx_ssp_pll_div	@ get addr
-	str	r0, [r4]		@ set dpll ctrl val
-
-	ldr	r4, omap24xx_ssp_set_config	@ get addr
-	mov	r8, #1			@ valid cfg msk
-	str	r8, [r4]		@ make dividers take
-
-	mov	r4, #100		@ dead spin a bit
-wait_a_bit:
-	subs	r4, r4, #1		@ dec loop
-	bne	wait_a_bit		@ delay done?
-
-	/* check if staying in bypass */
-	cmp	r2, #0x1		@ stay in bypass?
-	beq	pend			@ jump over dpll relock
-
-	/* relock DPLL with new vals */
-	ldr	r5, omap24xx_ssp_pll_stat	@ get addr
-	ldr	r4, omap24xx_ssp_pll_ctl	@ get addr
-	orr	r8, r7, #0x3		@ val for lock dpll
-	str	r8, [r4]		@ set val
-	mov	r0, #1000		@ dead spin a bit
-wait_more:
-	subs	r0, r0, #1		@ dec loop
-	bne	wait_more		@ delay done?
-wait_lock:
-	ldr	r8, [r5]		@ get lock val
-	and	r8, r8, #3		@ isolate field
-	cmp	r8, #2			@ locked?
-	bne	wait_lock		@ wait if not
-pend:
-	/* update memory timings & briefly lock dll */
-	ldr	r4, omap24xx_ssp_sdrc_rfr	@ get addr
-	str	r1, [r4]		@ update refresh timing
-	ldr	r11, omap24xx_ssp_dlla_ctrl	@ get addr of DLLA ctrl
-	ldr	r10, [r11]		@ get current val
-	mvn	r9, #0x4		@ mask to get clear bit2
-	and	r10, r10, r9		@ clear bit2 for lock mode
-	orr	r10, r10, #0x8		@ make sure DLL on (es2 bit pos)
-	str	r10, [r11]		@ commit to DLLA_CTRL
-	add	r11, r11, #0x8		@ move to dllb
-	str	r10, [r11]		@ hit DLLB also
-
-	mov	r4, #0x800		@ relock time (min 0x400 L3 clocks)
-wait_dll_lock:
-	subs	r4, r4, #0x1
-	bne	wait_dll_lock
-	nop
-	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
-
-	.globl omap24xx_ssp_set_config
-	.globl omap24xx_ssp_pll_ctl
-	.globl omap24xx_ssp_pll_stat
-	.globl omap24xx_ssp_pll_div
-	.globl omap24xx_ssp_sdrc_rfr
-	.globl omap24xx_ssp_dlla_ctrl
-
-omap24xx_ssp_set_config:
-	.word SRAM_VA_MAGIC
-omap24xx_ssp_pll_ctl:
-	.word SRAM_VA_MAGIC
-omap24xx_ssp_pll_stat:
-	.word SRAM_VA_MAGIC
-omap24xx_ssp_pll_div:
-	.word SRAM_VA_MAGIC
-omap24xx_ssp_sdrc_rfr:
-	.word SRAM_VA_MAGIC
-omap24xx_ssp_dlla_ctrl:
-	.word SRAM_VA_MAGIC
-
-ENTRY(omap24xx_sram_set_prcm_sz)
-	.word	. - omap24xx_sram_set_prcm
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index fb3f0d1..388ecfc 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -76,24 +76,6 @@ extern unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
 					 unsigned long pstart_avail,
 					 unsigned long size_avail);
 
-/* Global symbols in sram-fn.S to be patched with omap_sram_patch_va() */
-extern void *omap24xx_sdi_cm_clksel2_pll;
-extern void *omap24xx_sdi_sdrc_dlla_ctrl;
-extern void *omap24xx_sdi_prcm_voltctrl;
-extern void *omap24xx_sdi_timer_32ksynct_cr;
-extern void *omap24xx_srs_cm_clksel2_pll;
-extern void *omap24xx_srs_sdrc_dlla_ctrl;
-extern void *omap24xx_srs_sdrc_rfr_ctrl;
-extern void *omap24xx_srs_prcm_voltctrl;
-extern void *omap24xx_srs_timer_32ksynct;
-extern void *omap24xx_ssp_set_config;
-extern void *omap24xx_ssp_pll_ctl;
-extern void *omap24xx_ssp_pll_stat;
-extern void *omap24xx_ssp_pll_div;
-extern void *omap24xx_ssp_sdrc_rfr;
-extern void *omap24xx_ssp_dlla_ctrl;
-
-
 /*
  * Depending on the target RAMFS firewall setup, the public usable amount of
  * SRAM varies.  The default accessible size for all device types is 2k. A GP
@@ -386,76 +368,43 @@ u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass)
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2
-int __init omap24xx_sram_init(void)
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
 {
-	_omap2_sram_ddr_init = omap_sram_push(omap24xx_sram_ddr_init,
-					omap24xx_sram_ddr_init_sz);
-
-	/* Patch in the correct register addresses for multiboot */
-	omap_sram_patch_va(omap24xx_sram_ddr_init, &omap24xx_sdi_cm_clksel2_pll,
-			   _omap2_sram_ddr_init,
-			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2));
-	omap_sram_patch_va(omap24xx_sram_ddr_init, &omap24xx_sdi_sdrc_dlla_ctrl,
-			   _omap2_sram_ddr_init,
-			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
-	omap_sram_patch_va(omap24xx_sram_ddr_init, &omap24xx_sdi_prcm_voltctrl,
-			   _omap2_sram_ddr_init, OMAP24XX_PRCM_VOLTCTRL);
-	omap_sram_patch_va(omap24xx_sram_ddr_init,
-			   &omap24xx_sdi_timer_32ksynct_cr,
-			   _omap2_sram_ddr_init,
-			   (void __iomem *)IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010));
-
-	_omap2_sram_reprogram_sdrc = omap_sram_push(omap24xx_sram_reprogram_sdrc,
-						    omap24xx_sram_reprogram_sdrc_sz);
-
-	omap_sram_patch_va(omap24xx_sram_reprogram_sdrc,
-			   &omap24xx_srs_cm_clksel2_pll,
-			   _omap2_sram_reprogram_sdrc,
-			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2));
-	omap_sram_patch_va(omap24xx_sram_reprogram_sdrc,
-			   &omap24xx_srs_sdrc_dlla_ctrl,
-			   _omap2_sram_reprogram_sdrc,
-			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
-	omap_sram_patch_va(omap24xx_sram_reprogram_sdrc,
-			   &omap24xx_srs_sdrc_rfr_ctrl,
-			   _omap2_sram_reprogram_sdrc,
-			   OMAP_SDRC_REGADDR(SDRC_RFR_CTRL_0));
-	omap_sram_patch_va(omap24xx_sram_reprogram_sdrc,
-			   &omap24xx_srs_prcm_voltctrl,
-			   _omap2_sram_reprogram_sdrc,
-			   OMAP24XX_PRCM_VOLTCTRL);
-	omap_sram_patch_va(omap24xx_sram_reprogram_sdrc,
-			   &omap24xx_srs_timer_32ksynct,
-			   _omap2_sram_reprogram_sdrc,
-			   (void __iomem *)IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010));
-
-	_omap2_set_prcm = omap_sram_push(omap24xx_sram_set_prcm,
-					 omap24xx_sram_set_prcm_sz);
-
-	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_set_config,
-			   _omap2_set_prcm,
-			   OMAP24XX_PRCM_CLKCFG_CTRL);
-	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_pll_ctl,
-			   _omap2_set_prcm,
-			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN));
-	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_pll_stat,
-			   _omap2_set_prcm,
-			   OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST));
-	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_pll_div,
-			   _omap2_set_prcm,
-			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1));
-	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_sdrc_rfr,
-			   _omap2_set_prcm,
-			   OMAP_SDRC_REGADDR(SDRC_RFR_CTRL_0));
-	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_dlla_ctrl,
-			   _omap2_set_prcm,
-			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
+	_omap2_sram_ddr_init = omap_sram_push(omap243x_sram_ddr_init,
+					omap243x_sram_ddr_init_sz);
+
+	_omap2_sram_reprogram_sdrc = omap_sram_push(omap243x_sram_reprogram_sdrc,
+					    omap243x_sram_reprogram_sdrc_sz);
+
+	_omap2_set_prcm = omap_sram_push(omap243x_sram_set_prcm,
+					 omap243x_sram_set_prcm_sz);
 
 	return 0;
 }
 #else
-static inline int omap24xx_sram_init(void)
+static inline int omap243x_sram_init(void)
 {
 	return 0;
 }
@@ -529,8 +478,10 @@ int __init omap_sram_init(void)
 
 	if (!(cpu_class_is_omap2()))
 		omap1_sram_init();
-	else if (cpu_is_omap24xx())
-		omap24xx_sram_init();
+	else if (cpu_is_omap242x())
+		omap242x_sram_init();
+	else if (cpu_is_omap2430())
+		omap243x_sram_init();
 	else if (cpu_is_omap34xx())
 		omap34xx_sram_init();
 
diff --git a/include/asm-arm/arch-omap/sram.h b/include/asm-arm/arch-omap/sram.h
index 830e0fa..866b864 100644
--- a/include/asm-arm/arch-omap/sram.h
+++ b/include/asm-arm/arch-omap/sram.h
@@ -31,17 +31,30 @@ extern unsigned long omap1_sram_reprogram_clock_sz;
 extern void omap24xx_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
 extern unsigned long omap24xx_sram_reprogram_clock_sz;
 
-extern void omap24xx_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
+extern void omap242x_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 						u32 base_cs, u32 force_unlock);
-extern unsigned long omap24xx_sram_ddr_init_sz;
+extern unsigned long omap242x_sram_ddr_init_sz;
 
-extern u32 omap24xx_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
+extern u32 omap242x_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
 						int bypass);
-extern unsigned long omap24xx_sram_set_prcm_sz;
+extern unsigned long omap242x_sram_set_prcm_sz;
 
-extern void omap24xx_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
+extern void omap242x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
 						u32 mem_type);
-extern unsigned long omap24xx_sram_reprogram_sdrc_sz;
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
 
 
 extern void omap34xx_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
-- 
1.5.3.6

