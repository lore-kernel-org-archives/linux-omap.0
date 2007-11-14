From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] SRAM patcher: convert sram_reprogram_sdrc to use
	runtime SRAM patcher
Date: Wed, 14 Nov 2007 01:30:14 -0700
Message-ID: <20071114083104.762325178@pwsan.com>
References: <20071114083010.938764990@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=sp-patch-sram-reprogram-sdrc.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Use the runtime SRAM patcher to set register addresses in
sram_reprogram_sdrc.  The long symbol names are intended to help
disambiguate the symbols, now that they are global.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/sdrc.h    |    2 +-
 arch/arm/mach-omap2/sram-fn.S |   40 +++++++++++++++++++++-------------------
 arch/arm/plat-omap/sram.c     |   22 ++++++++++++++++++++++
 3 files changed, 44 insertions(+), 20 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/sram-fn.S
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sram-fn.S	2007-11-14 00:37:08.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/sram-fn.S	2007-11-14 00:41:21.000000000 -0700
@@ -28,10 +28,6 @@
 #include <asm/hardware.h>
 #include <linux/poison.h>
 
-#define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
-
-#define CM_CLKSEL2_PLL_V	IO_ADDRESS(OMAP2_CM_BASE + 0x544)
-#define PRCM_VOLTCTRL_V		IO_ADDRESS(OMAP2_PRM_BASE + 0x050)
 #define PRCM_CLKCFG_CTRL_V	IO_ADDRESS(OMAP2_PRM_BASE + 0x080)
 #define CM_CLKEN_PLL_V		IO_ADDRESS(OMAP2_CM_BASE + 0x500)
 #define CM_IDLEST_CKGEN_V	IO_ADDRESS(OMAP2_CM_BASE + 0x520)
@@ -158,7 +154,7 @@
 	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, finish ARM SDR/DDR
 	nop
 	nop
-	ldr	r6, ddr_sdrc_rfr_ctrl	@ get addr of refresh reg
+	ldr	r6, omap2_srs_sdrc_rfr_ctrl	@ get addr of refresh reg
 	ldr	r5, [r6]		@ get value
 	mov	r5, r5, lsr #8		@ isolate rfr field and drop burst
 
@@ -172,7 +168,7 @@
 	movne	r5, r5, lsl #1		@ mult by 2 if to full
 	mov	r5, r5, lsl #8		@ put rfr field back into place
 	add	r5, r5, #0x1		@ turn on burst of 1
-	ldr	r4, ddr_cm_clksel2_pll	@ get address of out reg
+	ldr	r4, omap2_srs_cm_clksel2_pll	@ get address of out reg
 	ldr	r3, [r4]		@ get curr value
 	orr	r3, r3, #0x3
 	bic	r3, r3, #0x3		@ clear lower bits
@@ -193,7 +189,7 @@
 	bne	freq_out		@ leave if SDR, no DLL function
 
 	/* With DDR, we need to take care of the DLL for the frequency change */
-	ldr	r2, ddr_sdrc_dlla_ctrl	@ addr of dlla ctrl
+	ldr	r2, omap2_srs_sdrc_dlla_ctrl	@ addr of dlla ctrl
 	str	r1, [r2]		@ write out new SDRC_DLLA_CTRL
 	add	r2, r2, #0x8		@ addr to SDRC_DLLB_CTRL
 	str	r1, [r2]		@ commit to SDRC_DLLB_CTRL
@@ -209,7 +205,7 @@
      *	wait for it to finish, use 32k sync counter, 1tick=31uS.
      */
 voltage_shift_c:
-	ldr	r10, ddr_prcm_voltctrl	@ get addr of volt ctrl
+	ldr	r10, omap2_srs_prcm_voltctrl	@ get addr of volt ctrl
 	ldr	r8, [r10]		@ get value
 	ldr	r7, ddr_prcm_mask_val	@ get value of mask
 	and	r8, r8, r7		@ apply mask to clear bits
@@ -219,7 +215,7 @@
 	orr	r8, r8, r7		@ build value for force
 	str	r8, [r10]		@ Force transition to L1
 
-	ldr	r10, ddr_timer_32ksynct	@ get addr of counter
+	ldr	r10, omap2_srs_timer_32ksynct	@ get addr of counter
 	ldr	r8, [r10]		@ get value
 	add	r8, r8, #0x2		@ give it at most 62uS (min 31+)
 volt_delay_c:
@@ -228,18 +224,24 @@
 	bhi	volt_delay_c		@ not yet->branch
 	mov	pc, lr			@ back to caller
 
-ddr_cm_clksel2_pll:
-	.word CM_CLKSEL2_PLL_V
-ddr_sdrc_dlla_ctrl:
-	.word SDRC_DLLA_CTRL_V
-ddr_sdrc_rfr_ctrl:
-	.word SDRC_RFR_CTRL_V
-ddr_prcm_voltctrl:
-	.word PRCM_VOLTCTRL_V
+	.globl omap2_srs_cm_clksel2_pll
+	.globl omap2_srs_sdrc_dlla_ctrl
+	.globl omap2_srs_sdrc_rfr_ctrl
+	.globl omap2_srs_prcm_voltctrl
+	.globl omap2_srs_timer_32ksynct
+
+omap2_srs_cm_clksel2_pll:
+	.word SRAM_VA_MAGIC
+omap2_srs_sdrc_dlla_ctrl:
+	.word SRAM_VA_MAGIC
+omap2_srs_sdrc_rfr_ctrl:
+	.word SRAM_VA_MAGIC
+omap2_srs_prcm_voltctrl:
+	.word SRAM_VA_MAGIC
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
-ddr_timer_32ksynct:
-	.word TIMER_32KSYNCT_CR_V
+omap2_srs_timer_32ksynct:
+	.word SRAM_VA_MAGIC
 
 ENTRY(sram_reprogram_sdrc_sz)
 	.word	. - sram_reprogram_sdrc
Index: linux-omap/arch/arm/plat-omap/sram.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/sram.c	2007-11-14 00:37:26.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/sram.c	2007-11-14 00:41:42.000000000 -0700
@@ -69,6 +69,11 @@
 extern void *omap2_sdi_sdrc_dlla_ctrl;
 extern void *omap2_sdi_prcm_voltctrl;
 extern void *omap2_sdi_timer_32ksynct_cr;
+extern void *omap2_srs_cm_clksel2_pll;
+extern void *omap2_srs_sdrc_dlla_ctrl;
+extern void *omap2_srs_sdrc_rfr_ctrl;
+extern void *omap2_srs_prcm_voltctrl;
+extern void *omap2_srs_timer_32ksynct;
 
 
 /*
@@ -353,6 +358,23 @@
 
 	_omap2_sram_reprogram_sdrc = omap_sram_push(sram_reprogram_sdrc,
 						    sram_reprogram_sdrc_sz);
+
+	omap_sram_patch_va(sram_reprogram_sdrc, &omap2_srs_cm_clksel2_pll,
+			   _omap2_sram_reprogram_sdrc,
+			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2));
+	omap_sram_patch_va(sram_reprogram_sdrc, &omap2_srs_sdrc_dlla_ctrl,
+			   _omap2_sram_reprogram_sdrc,
+			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
+	omap_sram_patch_va(sram_reprogram_sdrc, &omap2_srs_sdrc_rfr_ctrl,
+			   _omap2_sram_reprogram_sdrc,
+			   OMAP_SDRC_REGADDR(SDRC_RFR_CTRL_0));
+	omap_sram_patch_va(sram_reprogram_sdrc, &omap2_srs_prcm_voltctrl,
+			   _omap2_sram_reprogram_sdrc,
+			   OMAP24XX_PRCM_VOLTCTRL);
+	omap_sram_patch_va(sram_reprogram_sdrc, &omap2_srs_timer_32ksynct,
+			   _omap2_sram_reprogram_sdrc,
+			   (void __iomem *)IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010));
+
 	_omap2_set_prcm = omap_sram_push(sram_set_prcm, sram_set_prcm_sz);
 
 	return 0;
Index: linux-omap/arch/arm/mach-omap2/sdrc.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sdrc.h	2007-11-14 00:26:05.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/sdrc.h	2007-11-14 00:37:34.000000000 -0700
@@ -29,7 +29,7 @@
 #define SDRC_DLLB_STATUS	0x06C
 #define SDRC_POWER		0x070
 #define SDRC_MR_0		0x084
-
+#define SDRC_RFR_CTRL_0		0x0a4
 
 /* SDRC global register get/set */
 

-- 
