From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/10] ARM: OMAP2: Rename 24xx specific SRAM functions
Date: Wed, 12 Mar 2008 12:45:43 +0200
Message-ID: <1205318750-9596-4-git-send-email-tony@atomide.com>
References: 34xx-2008-03-12
 <1205318750-9596-1-git-send-email-tony@atomide.com>
 <1205318750-9596-2-git-send-email-tony@atomide.com>
 <1205318750-9596-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:50678 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbYCLKqG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 06:46:06 -0400
In-Reply-To: <1205318750-9596-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

This is needed to make room for 34xx specific SRAM functions.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sram24xx.S   |  112 +++++++++++++++++++-------------------
 arch/arm/plat-omap/sram.c        |  102 +++++++++++++++++++---------------
 include/asm-arm/arch-omap/sram.h |   20 ++++---
 3 files changed, 124 insertions(+), 110 deletions(-)

diff --git a/arch/arm/mach-omap2/sram24xx.S b/arch/arm/mach-omap2/sram24xx.S
index ba1e005..5f1a305 100644
--- a/arch/arm/mach-omap2/sram24xx.S
+++ b/arch/arm/mach-omap2/sram24xx.S
@@ -30,14 +30,14 @@
 
 	.text
 
-ENTRY(sram_ddr_init)
+ENTRY(omap24xx_sram_ddr_init)
 	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
 
 	mov	r12, r2			@ capture CS1 vs CS0
 	mov	r8, r3			@ capture force parameter
 
 	/* frequency shift down */
-	ldr	r2, omap2_sdi_cm_clksel2_pll	@ get address of dpllout reg
+	ldr	r2, omap24xx_sdi_cm_clksel2_pll	@ get address of dpllout reg
 	mov	r3, #0x1		@ value for 1x operation
 	str	r3, [r2]		@ go to L1-freq operation
 
@@ -46,7 +46,7 @@ ENTRY(sram_ddr_init)
 	bl voltage_shift		@ go drop voltage
 
 	/* dll lock mode */
-	ldr	r11, omap2_sdi_sdrc_dlla_ctrl	@ addr of dlla ctrl
+	ldr	r11, omap24xx_sdi_sdrc_dlla_ctrl	@ addr of dlla ctrl
 	ldr	r10, [r11]		@ get current val
 	cmp	r12, #0x1		@ cs1 base (2422 es2.05/1)
 	addeq	r11, r11, #0x8		@ if cs1 base, move to DLLB
@@ -97,7 +97,7 @@ i_dll_delay:
 	 * wait for it to finish, use 32k sync counter, 1tick=31uS.
 	 */
 voltage_shift:
-	ldr	r4, omap2_sdi_prcm_voltctrl	@ get addr of volt ctrl.
+	ldr	r4, omap24xx_sdi_prcm_voltctrl	@ get addr of volt ctrl.
 	ldr	r5, [r4]		@ get value.
 	ldr	r6, prcm_mask_val	@ get value of mask
 	and	r5, r5, r6		@ apply mask to clear bits
@@ -107,7 +107,7 @@ voltage_shift:
 	orr	r5, r5, r3		@ build value for force
 	str	r5, [r4]		@ Force transition to L1
 
-	ldr	r3, omap2_sdi_timer_32ksynct_cr	@ get addr of counter
+	ldr	r3, omap24xx_sdi_timer_32ksynct_cr	@ get addr of counter
 	ldr	r5, [r3]		@ get value
 	add	r5, r5, #0x3		@ give it at most 93uS
 volt_delay:
@@ -117,36 +117,36 @@ volt_delay:
 	mov	pc, lr			@ back to caller.
 
 /* relative load constants */
-	.globl omap2_sdi_cm_clksel2_pll
-	.globl omap2_sdi_sdrc_dlla_ctrl
-	.globl omap2_sdi_prcm_voltctrl
-	.globl omap2_sdi_timer_32ksynct_cr
+	.globl omap24xx_sdi_cm_clksel2_pll
+	.globl omap24xx_sdi_sdrc_dlla_ctrl
+	.globl omap24xx_sdi_prcm_voltctrl
+	.globl omap24xx_sdi_timer_32ksynct_cr
 
-omap2_sdi_cm_clksel2_pll:
+omap24xx_sdi_cm_clksel2_pll:
 	.word SRAM_VA_MAGIC
-omap2_sdi_sdrc_dlla_ctrl:
+omap24xx_sdi_sdrc_dlla_ctrl:
 	.word SRAM_VA_MAGIC
-omap2_sdi_prcm_voltctrl:
+omap24xx_sdi_prcm_voltctrl:
 	.word SRAM_VA_MAGIC
 prcm_mask_val:
 	.word 0xFFFF3FFC
-omap2_sdi_timer_32ksynct_cr:
+omap24xx_sdi_timer_32ksynct_cr:
 	.word SRAM_VA_MAGIC
-ENTRY(sram_ddr_init_sz)
-	.word	. - sram_ddr_init
+ENTRY(omap24xx_sram_ddr_init_sz)
+	.word	. - omap24xx_sram_ddr_init
 
 /*
  * Reprograms memory timings.
  * r0 = [PRCM_FULL | PRCM_HALF] r1 = SDRC_DLLA_CTRL value r2 = [DDR | SDR]
  * PRCM_FULL = 2, PRCM_HALF = 1, DDR = 1, SDR = 0
  */
-ENTRY(sram_reprogram_sdrc)
+ENTRY(omap24xx_sram_reprogram_sdrc)
 	stmfd	sp!, {r0 - r10, lr}	@ save registers on stack
 	mov	r3, #0x0		@ clear for mrc call
 	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, finish ARM SDR/DDR
 	nop
 	nop
-	ldr	r6, omap2_srs_sdrc_rfr_ctrl	@ get addr of refresh reg
+	ldr	r6, omap24xx_srs_sdrc_rfr_ctrl	@ get addr of refresh reg
 	ldr	r5, [r6]		@ get value
 	mov	r5, r5, lsr #8		@ isolate rfr field and drop burst
 
@@ -160,7 +160,7 @@ ENTRY(sram_reprogram_sdrc)
 	movne	r5, r5, lsl #1		@ mult by 2 if to full
 	mov	r5, r5, lsl #8		@ put rfr field back into place
 	add	r5, r5, #0x1		@ turn on burst of 1
-	ldr	r4, omap2_srs_cm_clksel2_pll	@ get address of out reg
+	ldr	r4, omap24xx_srs_cm_clksel2_pll	@ get address of out reg
 	ldr	r3, [r4]		@ get curr value
 	orr	r3, r3, #0x3
 	bic	r3, r3, #0x3		@ clear lower bits
@@ -181,7 +181,7 @@ ENTRY(sram_reprogram_sdrc)
 	bne	freq_out		@ leave if SDR, no DLL function
 
 	/* With DDR, we need to take care of the DLL for the frequency change */
-	ldr	r2, omap2_srs_sdrc_dlla_ctrl	@ addr of dlla ctrl
+	ldr	r2, omap24xx_srs_sdrc_dlla_ctrl	@ addr of dlla ctrl
 	str	r1, [r2]		@ write out new SDRC_DLLA_CTRL
 	add	r2, r2, #0x8		@ addr to SDRC_DLLB_CTRL
 	str	r1, [r2]		@ commit to SDRC_DLLB_CTRL
@@ -197,7 +197,7 @@ freq_out:
      *	wait for it to finish, use 32k sync counter, 1tick=31uS.
      */
 voltage_shift_c:
-	ldr	r10, omap2_srs_prcm_voltctrl	@ get addr of volt ctrl
+	ldr	r10, omap24xx_srs_prcm_voltctrl	@ get addr of volt ctrl
 	ldr	r8, [r10]		@ get value
 	ldr	r7, ddr_prcm_mask_val	@ get value of mask
 	and	r8, r8, r7		@ apply mask to clear bits
@@ -207,7 +207,7 @@ voltage_shift_c:
 	orr	r8, r8, r7		@ build value for force
 	str	r8, [r10]		@ Force transition to L1
 
-	ldr	r10, omap2_srs_timer_32ksynct	@ get addr of counter
+	ldr	r10, omap24xx_srs_timer_32ksynct	@ get addr of counter
 	ldr	r8, [r10]		@ get value
 	add	r8, r8, #0x2		@ give it at most 62uS (min 31+)
 volt_delay_c:
@@ -216,45 +216,45 @@ volt_delay_c:
 	bhi	volt_delay_c		@ not yet->branch
 	mov	pc, lr			@ back to caller
 
-	.globl omap2_srs_cm_clksel2_pll
-	.globl omap2_srs_sdrc_dlla_ctrl
-	.globl omap2_srs_sdrc_rfr_ctrl
-	.globl omap2_srs_prcm_voltctrl
-	.globl omap2_srs_timer_32ksynct
+	.globl omap24xx_srs_cm_clksel2_pll
+	.globl omap24xx_srs_sdrc_dlla_ctrl
+	.globl omap24xx_srs_sdrc_rfr_ctrl
+	.globl omap24xx_srs_prcm_voltctrl
+	.globl omap24xx_srs_timer_32ksynct
 
-omap2_srs_cm_clksel2_pll:
+omap24xx_srs_cm_clksel2_pll:
 	.word SRAM_VA_MAGIC
-omap2_srs_sdrc_dlla_ctrl:
+omap24xx_srs_sdrc_dlla_ctrl:
 	.word SRAM_VA_MAGIC
-omap2_srs_sdrc_rfr_ctrl:
+omap24xx_srs_sdrc_rfr_ctrl:
 	.word SRAM_VA_MAGIC
-omap2_srs_prcm_voltctrl:
+omap24xx_srs_prcm_voltctrl:
 	.word SRAM_VA_MAGIC
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
-omap2_srs_timer_32ksynct:
+omap24xx_srs_timer_32ksynct:
 	.word SRAM_VA_MAGIC
 
-ENTRY(sram_reprogram_sdrc_sz)
-	.word	. - sram_reprogram_sdrc
+ENTRY(omap24xx_sram_reprogram_sdrc_sz)
+	.word	. - omap24xx_sram_reprogram_sdrc
 
 /*
  * Set dividers and pll. Also recalculate DLL value for DDR and unlock mode.
  */
-ENTRY(sram_set_prcm)
+ENTRY(omap24xx_sram_set_prcm)
 	stmfd	sp!, {r0-r12, lr}	@ regs to stack
 	adr	r4, pbegin		@ addr of preload start
 	adr	r8, pend		@ addr of preload end
 	mcrr	p15, 1, r8, r4, c12	@ preload into icache
 pbegin:
 	/* move into fast relock bypass */
-	ldr	r8, omap2_ssp_pll_ctl	@ get addr
+	ldr	r8, omap24xx_ssp_pll_ctl	@ get addr
 	ldr	r5, [r8]		@ get val
 	mvn	r6, #0x3		@ clear mask
 	and	r5, r5, r6		@ clear field
 	orr	r7, r5, #0x2		@ fast relock val
 	str	r7, [r8]		@ go to fast relock
-	ldr	r4, omap2_ssp_pll_stat	@ addr of stat
+	ldr	r4, omap24xx_ssp_pll_stat	@ addr of stat
 block:
 	/* wait for bypass */
 	ldr	r8, [r4]		@ stat value
@@ -263,10 +263,10 @@ block:
 	bne	block			@ loop if not
 
 	/* set new dpll dividers _after_ in bypass */
-	ldr	r4, omap2_ssp_pll_div	@ get addr
+	ldr	r4, omap24xx_ssp_pll_div	@ get addr
 	str	r0, [r4]		@ set dpll ctrl val
 
-	ldr	r4, omap2_ssp_set_config	@ get addr
+	ldr	r4, omap24xx_ssp_set_config	@ get addr
 	mov	r8, #1			@ valid cfg msk
 	str	r8, [r4]		@ make dividers take
 
@@ -280,8 +280,8 @@ wait_a_bit:
 	beq	pend			@ jump over dpll relock
 
 	/* relock DPLL with new vals */
-	ldr	r5, omap2_ssp_pll_stat	@ get addr
-	ldr	r4, omap2_ssp_pll_ctl	@ get addr
+	ldr	r5, omap24xx_ssp_pll_stat	@ get addr
+	ldr	r4, omap24xx_ssp_pll_ctl	@ get addr
 	orr	r8, r7, #0x3		@ val for lock dpll
 	str	r8, [r4]		@ set val
 	mov	r0, #1000		@ dead spin a bit
@@ -295,9 +295,9 @@ wait_lock:
 	bne	wait_lock		@ wait if not
 pend:
 	/* update memory timings & briefly lock dll */
-	ldr	r4, omap2_ssp_sdrc_rfr	@ get addr
+	ldr	r4, omap24xx_ssp_sdrc_rfr	@ get addr
 	str	r1, [r4]		@ update refresh timing
-	ldr	r11, omap2_ssp_dlla_ctrl	@ get addr of DLLA ctrl
+	ldr	r11, omap24xx_ssp_dlla_ctrl	@ get addr of DLLA ctrl
 	ldr	r10, [r11]		@ get current val
 	mvn	r9, #0x4		@ mask to get clear bit2
 	and	r10, r10, r9		@ clear bit2 for lock mode
@@ -313,25 +313,25 @@ wait_dll_lock:
 	nop
 	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
 
-	.globl omap2_ssp_set_config
-	.globl omap2_ssp_pll_ctl
-	.globl omap2_ssp_pll_stat
-	.globl omap2_ssp_pll_div
-	.globl omap2_ssp_sdrc_rfr
-	.globl omap2_ssp_dlla_ctrl
+	.globl omap24xx_ssp_set_config
+	.globl omap24xx_ssp_pll_ctl
+	.globl omap24xx_ssp_pll_stat
+	.globl omap24xx_ssp_pll_div
+	.globl omap24xx_ssp_sdrc_rfr
+	.globl omap24xx_ssp_dlla_ctrl
 
-omap2_ssp_set_config:
+omap24xx_ssp_set_config:
 	.word SRAM_VA_MAGIC
-omap2_ssp_pll_ctl:
+omap24xx_ssp_pll_ctl:
 	.word SRAM_VA_MAGIC
-omap2_ssp_pll_stat:
+omap24xx_ssp_pll_stat:
 	.word SRAM_VA_MAGIC
-omap2_ssp_pll_div:
+omap24xx_ssp_pll_div:
 	.word SRAM_VA_MAGIC
-omap2_ssp_sdrc_rfr:
+omap24xx_ssp_sdrc_rfr:
 	.word SRAM_VA_MAGIC
-omap2_ssp_dlla_ctrl:
+omap24xx_ssp_dlla_ctrl:
 	.word SRAM_VA_MAGIC
 
-ENTRY(sram_set_prcm_sz)
-	.word	. - sram_set_prcm
+ENTRY(omap24xx_sram_set_prcm_sz)
+	.word	. - omap24xx_sram_set_prcm
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 204cd81..6b1ce47 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -46,9 +46,9 @@
 #define SRAM_BOOTLOADER_SZ	0x80
 #endif
 
-#define VA_REQINFOPERM0		IO_ADDRESS(0x68005048)
-#define VA_READPERM0		IO_ADDRESS(0x68005050)
-#define VA_WRITEPERM0		IO_ADDRESS(0x68005058)
+#define OMAP24XX_VA_REQINFOPERM0	IO_ADDRESS(0x68005048)
+#define OMAP24XX_VA_READPERM0		IO_ADDRESS(0x68005050)
+#define OMAP24XX_VA_WRITEPERM0		IO_ADDRESS(0x68005058)
 #define GP_DEVICE		0x300
 
 #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
@@ -65,21 +65,21 @@ extern unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
 					 unsigned long size_avail);
 
 /* Global symbols in sram-fn.S to be patched with omap_sram_patch_va() */
-extern void *omap2_sdi_cm_clksel2_pll;
-extern void *omap2_sdi_sdrc_dlla_ctrl;
-extern void *omap2_sdi_prcm_voltctrl;
-extern void *omap2_sdi_timer_32ksynct_cr;
-extern void *omap2_srs_cm_clksel2_pll;
-extern void *omap2_srs_sdrc_dlla_ctrl;
-extern void *omap2_srs_sdrc_rfr_ctrl;
-extern void *omap2_srs_prcm_voltctrl;
-extern void *omap2_srs_timer_32ksynct;
-extern void *omap2_ssp_set_config;
-extern void *omap2_ssp_pll_ctl;
-extern void *omap2_ssp_pll_stat;
-extern void *omap2_ssp_pll_div;
-extern void *omap2_ssp_sdrc_rfr;
-extern void *omap2_ssp_dlla_ctrl;
+extern void *omap24xx_sdi_cm_clksel2_pll;
+extern void *omap24xx_sdi_sdrc_dlla_ctrl;
+extern void *omap24xx_sdi_prcm_voltctrl;
+extern void *omap24xx_sdi_timer_32ksynct_cr;
+extern void *omap24xx_srs_cm_clksel2_pll;
+extern void *omap24xx_srs_sdrc_dlla_ctrl;
+extern void *omap24xx_srs_sdrc_rfr_ctrl;
+extern void *omap24xx_srs_prcm_voltctrl;
+extern void *omap24xx_srs_timer_32ksynct;
+extern void *omap24xx_ssp_set_config;
+extern void *omap24xx_ssp_pll_ctl;
+extern void *omap24xx_ssp_pll_stat;
+extern void *omap24xx_ssp_pll_div;
+extern void *omap24xx_ssp_sdrc_rfr;
+extern void *omap24xx_ssp_dlla_ctrl;
 
 
 /*
@@ -98,9 +98,9 @@ static int is_sram_locked(void)
 	if (type == GP_DEVICE) {
 		/* RAMFW: R/W access to all initiators for all qualifier sets */
 		if (cpu_is_omap242x()) {
-			__raw_writel(0xFF, VA_REQINFOPERM0); /* all q-vects */
-			__raw_writel(0xCFDE, VA_READPERM0);  /* all i-read */
-			__raw_writel(0xCFDE, VA_WRITEPERM0); /* all i-write */
+			__raw_writel(0xFF, OMAP24XX_VA_REQINFOPERM0); /* all q-vects */
+			__raw_writel(0xCFDE, OMAP24XX_VA_READPERM0);  /* all i-read */
+			__raw_writel(0xCFDE, OMAP24XX_VA_WRITEPERM0); /* all i-write */
 		}
 		return 0;
 	} else
@@ -345,69 +345,81 @@ u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass)
 
 	return _omap2_set_prcm(dpll_ctrl_val, sdrc_rfr_val, bypass);
 }
+#endif
 
-int __init omap2_sram_init(void)
+#ifdef CONFIG_ARCH_OMAP2
+int __init omap24xx_sram_init(void)
 {
-	_omap2_sram_ddr_init = omap_sram_push(sram_ddr_init, sram_ddr_init_sz);
+	_omap2_sram_ddr_init = omap_sram_push(omap24xx_sram_ddr_init,
+					omap24xx_sram_ddr_init_sz);
 
 	/* Patch in the correct register addresses for multiboot */
-	omap_sram_patch_va(sram_ddr_init, &omap2_sdi_cm_clksel2_pll,
+	omap_sram_patch_va(omap24xx_sram_ddr_init, &omap24xx_sdi_cm_clksel2_pll,
 			   _omap2_sram_ddr_init,
 			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2));
-	omap_sram_patch_va(sram_ddr_init, &omap2_sdi_sdrc_dlla_ctrl,
+	omap_sram_patch_va(omap24xx_sram_ddr_init, &omap24xx_sdi_sdrc_dlla_ctrl,
 			   _omap2_sram_ddr_init,
 			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
-	omap_sram_patch_va(sram_ddr_init, &omap2_sdi_prcm_voltctrl,
+	omap_sram_patch_va(omap24xx_sram_ddr_init, &omap24xx_sdi_prcm_voltctrl,
 			   _omap2_sram_ddr_init, OMAP24XX_PRCM_VOLTCTRL);
-	omap_sram_patch_va(sram_ddr_init, &omap2_sdi_timer_32ksynct_cr,
+	omap_sram_patch_va(omap24xx_sram_ddr_init,
+			   &omap24xx_sdi_timer_32ksynct_cr,
 			   _omap2_sram_ddr_init,
 			   (void __iomem *)IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010));
 
-	_omap2_sram_reprogram_sdrc = omap_sram_push(sram_reprogram_sdrc,
-						    sram_reprogram_sdrc_sz);
+	_omap2_sram_reprogram_sdrc = omap_sram_push(omap24xx_sram_reprogram_sdrc,
+						    omap24xx_sram_reprogram_sdrc_sz);
 
-	omap_sram_patch_va(sram_reprogram_sdrc, &omap2_srs_cm_clksel2_pll,
+	omap_sram_patch_va(omap24xx_sram_reprogram_sdrc,
+			   &omap24xx_srs_cm_clksel2_pll,
 			   _omap2_sram_reprogram_sdrc,
 			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2));
-	omap_sram_patch_va(sram_reprogram_sdrc, &omap2_srs_sdrc_dlla_ctrl,
+	omap_sram_patch_va(omap24xx_sram_reprogram_sdrc,
+			   &omap24xx_srs_sdrc_dlla_ctrl,
 			   _omap2_sram_reprogram_sdrc,
 			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
-	omap_sram_patch_va(sram_reprogram_sdrc, &omap2_srs_sdrc_rfr_ctrl,
+	omap_sram_patch_va(omap24xx_sram_reprogram_sdrc,
+			   &omap24xx_srs_sdrc_rfr_ctrl,
 			   _omap2_sram_reprogram_sdrc,
 			   OMAP_SDRC_REGADDR(SDRC_RFR_CTRL_0));
-	omap_sram_patch_va(sram_reprogram_sdrc, &omap2_srs_prcm_voltctrl,
+	omap_sram_patch_va(omap24xx_sram_reprogram_sdrc,
+			   &omap24xx_srs_prcm_voltctrl,
 			   _omap2_sram_reprogram_sdrc,
 			   OMAP24XX_PRCM_VOLTCTRL);
-	omap_sram_patch_va(sram_reprogram_sdrc, &omap2_srs_timer_32ksynct,
+	omap_sram_patch_va(omap24xx_sram_reprogram_sdrc,
+			   &omap24xx_srs_timer_32ksynct,
 			   _omap2_sram_reprogram_sdrc,
 			   (void __iomem *)IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010));
 
-	_omap2_set_prcm = omap_sram_push(sram_set_prcm, sram_set_prcm_sz);
+	_omap2_set_prcm = omap_sram_push(omap24xx_sram_set_prcm,
+					 omap24xx_sram_set_prcm_sz);
 
-	/* REVISIT: prefix all these symbols with omap2_sram_ */
-	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_set_config,
+	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_set_config,
 			   _omap2_set_prcm,
 			   OMAP24XX_PRCM_CLKCFG_CTRL);
-	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_pll_ctl,
+	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_pll_ctl,
 			   _omap2_set_prcm,
 			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN));
-	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_pll_stat,
+	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_pll_stat,
 			   _omap2_set_prcm,
 			   OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST));
-	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_pll_div,
+	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_pll_div,
 			   _omap2_set_prcm,
 			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1));
-	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_sdrc_rfr,
+	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_sdrc_rfr,
 			   _omap2_set_prcm,
 			   OMAP_SDRC_REGADDR(SDRC_RFR_CTRL_0));
-	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_dlla_ctrl,
+	omap_sram_patch_va(omap24xx_sram_set_prcm, &omap24xx_ssp_dlla_ctrl,
 			   _omap2_set_prcm,
 			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
 
 	return 0;
 }
 #else
-#define omap2_sram_init()	do {} while (0)
+static inline int omap24xx_sram_init(void)
+{
+	return 0;
+}
 #endif
 
 int __init omap_sram_init(void)
@@ -417,8 +429,8 @@ int __init omap_sram_init(void)
 
 	if (!(cpu_class_is_omap2()))
 		omap1_sram_init();
-	else
-		omap2_sram_init();
+	else if (cpu_is_omap24xx())
+		omap24xx_sram_init();
 
 	return 0;
 }
diff --git a/include/asm-arm/arch-omap/sram.h b/include/asm-arm/arch-omap/sram.h
index 5bfbe37..2b7f103 100644
--- a/include/asm-arm/arch-omap/sram.h
+++ b/include/asm-arm/arch-omap/sram.h
@@ -24,17 +24,19 @@ extern void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
 extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
 
 /* Do not use these */
-extern void sram_reprogram_clock(u32 ckctl, u32 dpllctl);
-extern unsigned long sram_reprogram_clock_sz;
+extern void omap24xx_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
+extern unsigned long omap24xx_sram_reprogram_clock_sz;
 
-extern void sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
-			  u32 base_cs, u32 force_unlock);
-extern unsigned long sram_ddr_init_sz;
+extern void omap24xx_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
+						u32 base_cs, u32 force_unlock);
+extern unsigned long omap24xx_sram_ddr_init_sz;
 
-extern u32 sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
-extern unsigned long sram_set_prcm_sz;
+extern u32 omap24xx_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
+						int bypass);
+extern unsigned long omap24xx_sram_set_prcm_sz;
 
-extern void sram_reprogram_sdrc(u32 perf_level, u32 dll_val, u32 mem_type);
-extern unsigned long sram_reprogram_sdrc_sz;
+extern void omap24xx_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
+						u32 mem_type);
+extern unsigned long omap24xx_sram_reprogram_sdrc_sz;
 
 #endif
-- 
1.5.3.6

