From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/5] SRAM patcher: convert omap2_set_prcm to use runtime
	SRAM patcher
Date: Wed, 14 Nov 2007 01:30:15 -0700
Message-ID: <20071114083104.855730928@pwsan.com>
References: <20071114083010.938764990@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=sp-patch-omap2-set-prcm.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Use the runtime SRAM patcher to set register addresses in
omap2_set_prcm.  The long symbol names are intended to help
disambiguate the symbols, now that they are global.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/sram-fn.S |   55 ++++++++++++++++++++----------------------
 arch/arm/plat-omap/sram.c     |   26 +++++++++++++++++++
 2 files changed, 53 insertions(+), 28 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/sram-fn.S
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sram-fn.S	2007-11-14 00:41:21.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/sram-fn.S	2007-11-14 00:41:46.000000000 -0700
@@ -28,14 +28,6 @@
 #include <asm/hardware.h>
 #include <linux/poison.h>
 
-#define PRCM_CLKCFG_CTRL_V	IO_ADDRESS(OMAP2_PRM_BASE + 0x080)
-#define CM_CLKEN_PLL_V		IO_ADDRESS(OMAP2_CM_BASE + 0x500)
-#define CM_IDLEST_CKGEN_V	IO_ADDRESS(OMAP2_CM_BASE + 0x520)
-#define CM_CLKSEL1_PLL_V	IO_ADDRESS(OMAP2_CM_BASE + 0x540)
-
-#define SDRC_DLLA_CTRL_V	IO_ADDRESS(OMAP2_SDRC_BASE + 0x060)
-#define SDRC_RFR_CTRL_V		IO_ADDRESS(OMAP2_SDRC_BASE + 0x0a4)
-
 	.text
 
 ENTRY(sram_ddr_init)
@@ -256,13 +248,13 @@
 	mcrr	p15, 1, r8, r4, c12	@ preload into icache
 pbegin:
 	/* move into fast relock bypass */
-	ldr	r8, pll_ctl		@ get addr
+	ldr	r8, omap2_ssp_pll_ctl	@ get addr
 	ldr	r5, [r8]		@ get val
 	mvn	r6, #0x3		@ clear mask
 	and	r5, r5, r6		@ clear field
 	orr	r7, r5, #0x2		@ fast relock val
 	str	r7, [r8]		@ go to fast relock
-	ldr	r4, pll_stat		@ addr of stat
+	ldr	r4, omap2_ssp_pll_stat	@ addr of stat
 block:
 	/* wait for bypass */
 	ldr	r8, [r4]		@ stat value
@@ -271,10 +263,10 @@
 	bne	block			@ loop if not
 
 	/* set new dpll dividers _after_ in bypass */
-	ldr	r4, pll_div		@ get addr
+	ldr	r4, omap2_ssp_pll_div	@ get addr
 	str	r0, [r4]		@ set dpll ctrl val
 
-	ldr	r4, set_config		@ get addr
+	ldr	r4, omap2_ssp_set_config	@ get addr
 	mov	r8, #1			@ valid cfg msk
 	str	r8, [r4]		@ make dividers take
 
@@ -288,8 +280,8 @@
 	beq	pend			@ jump over dpll relock
 
 	/* relock DPLL with new vals */
-	ldr	r5, pll_stat		@ get addr
-	ldr	r4, pll_ctl		@ get addr
+	ldr	r5, omap2_ssp_pll_stat	@ get addr
+	ldr	r4, omap2_ssp_pll_ctl	@ get addr
 	orr	r8, r7, #0x3		@ val for lock dpll
 	str	r8, [r4]		@ set val
 	mov	r0, #1000		@ dead spin a bit
@@ -303,9 +295,9 @@
 	bne	wait_lock		@ wait if not
 pend:
 	/* update memory timings & briefly lock dll */
-	ldr	r4, sdrc_rfr		@ get addr
+	ldr	r4, omap2_ssp_sdrc_rfr	@ get addr
 	str	r1, [r4]		@ update refresh timing
-	ldr	r11, dlla_ctrl		@ get addr of DLLA ctrl
+	ldr	r11, omap2_ssp_dlla_ctrl	@ get addr of DLLA ctrl
 	ldr	r10, [r11]		@ get current val
 	mvn	r9, #0x4		@ mask to get clear bit2
 	and	r10, r10, r9		@ clear bit2 for lock mode
@@ -321,18 +313,25 @@
 	nop
 	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
 
-set_config:
-	.word PRCM_CLKCFG_CTRL_V
-pll_ctl:
-	.word CM_CLKEN_PLL_V
-pll_stat:
-	.word CM_IDLEST_CKGEN_V
-pll_div:
-	.word CM_CLKSEL1_PLL_V
-sdrc_rfr:
-	.word SDRC_RFR_CTRL_V
-dlla_ctrl:
-	.word SDRC_DLLA_CTRL_V
+	.globl omap2_ssp_set_config
+	.globl omap2_ssp_pll_ctl
+	.globl omap2_ssp_pll_stat
+	.globl omap2_ssp_pll_div
+	.globl omap2_ssp_sdrc_rfr
+	.globl omap2_ssp_dlla_ctrl
+
+omap2_ssp_set_config:
+	.word SRAM_VA_MAGIC
+omap2_ssp_pll_ctl:
+	.word SRAM_VA_MAGIC
+omap2_ssp_pll_stat:
+	.word SRAM_VA_MAGIC
+omap2_ssp_pll_div:
+	.word SRAM_VA_MAGIC
+omap2_ssp_sdrc_rfr:
+	.word SRAM_VA_MAGIC
+omap2_ssp_dlla_ctrl:
+	.word SRAM_VA_MAGIC
 
 ENTRY(sram_set_prcm_sz)
 	.word	. - sram_set_prcm
Index: linux-omap/arch/arm/plat-omap/sram.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/sram.c	2007-11-14 00:41:42.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/sram.c	2007-11-14 00:42:20.000000000 -0700
@@ -74,6 +74,12 @@
 extern void *omap2_srs_sdrc_rfr_ctrl;
 extern void *omap2_srs_prcm_voltctrl;
 extern void *omap2_srs_timer_32ksynct;
+extern void *omap2_ssp_set_config;
+extern void *omap2_ssp_pll_ctl;
+extern void *omap2_ssp_pll_stat;
+extern void *omap2_ssp_pll_div;
+extern void *omap2_ssp_sdrc_rfr;
+extern void *omap2_ssp_dlla_ctrl;
 
 
 /*
@@ -377,6 +383,26 @@
 
 	_omap2_set_prcm = omap_sram_push(sram_set_prcm, sram_set_prcm_sz);
 
+	/* REVISIT: prefix all these symbols with omap2_sram_ */
+	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_set_config,
+			   _omap2_set_prcm,
+			   OMAP24XX_PRCM_CLKCFG_CTRL);
+	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_pll_ctl,
+			   _omap2_set_prcm,
+			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN));
+	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_pll_stat,
+			   _omap2_set_prcm,
+			   OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST));
+	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_pll_div,
+			   _omap2_set_prcm,
+			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1));
+	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_sdrc_rfr,
+			   _omap2_set_prcm,
+			   OMAP_SDRC_REGADDR(SDRC_RFR_CTRL_0));
+	omap_sram_patch_va(sram_set_prcm, &omap2_ssp_dlla_ctrl,
+			   _omap2_set_prcm,
+			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
+
 	return 0;
 }
 #else

-- 
