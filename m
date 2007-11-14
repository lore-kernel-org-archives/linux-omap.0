From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/5] SRAM patcher: convert sram_ddr_init to use runtime SRAM
	patcher
Date: Wed, 14 Nov 2007 01:30:13 -0700
Message-ID: <20071114083104.666729818@pwsan.com>
References: <20071114083010.938764990@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=sp-patch-sram-ddr-init.patch
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
sram_ddr_init.  The long symbol names are intended to help
disambiguate the symbols, now that they are global.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/sram-fn.S |   30 ++++++++++++++++++------------
 arch/arm/plat-omap/sram.c     |   26 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 12 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/sram-fn.S
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sram-fn.S	2007-11-14 00:34:56.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/sram-fn.S	2007-11-14 00:37:08.000000000 -0700
@@ -26,6 +26,7 @@
 #include <asm/assembler.h>
 #include <asm/arch/io.h>
 #include <asm/hardware.h>
+#include <linux/poison.h>
 
 #define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
 
@@ -48,7 +49,7 @@
 	mov	r8, r3			@ capture force parameter
 
 	/* frequency shift down */
-	ldr	r2, cm_clksel2_pll	@ get address of dpllout reg
+	ldr	r2, omap2_sdi_cm_clksel2_pll	@ get address of dpllout reg
 	mov	r3, #0x1		@ value for 1x operation
 	str	r3, [r2]		@ go to L1-freq operation
 
@@ -57,7 +58,7 @@
 	bl voltage_shift		@ go drop voltage
 
 	/* dll lock mode */
-	ldr	r11, sdrc_dlla_ctrl	@ addr of dlla ctrl
+	ldr	r11, omap2_sdi_sdrc_dlla_ctrl	@ addr of dlla ctrl
 	ldr	r10, [r11]		@ get current val
 	cmp	r12, #0x1		@ cs1 base (2422 es2.05/1)
 	addeq	r11, r11, #0x8		@ if cs1 base, move to DLLB
@@ -108,7 +109,7 @@
 	 * wait for it to finish, use 32k sync counter, 1tick=31uS.
 	 */
 voltage_shift:
-	ldr	r4, prcm_voltctrl	@ get addr of volt ctrl.
+	ldr	r4, omap2_sdi_prcm_voltctrl	@ get addr of volt ctrl.
 	ldr	r5, [r4]		@ get value.
 	ldr	r6, prcm_mask_val	@ get value of mask
 	and	r5, r5, r6		@ apply mask to clear bits
@@ -118,7 +119,7 @@
 	orr	r5, r5, r3		@ build value for force
 	str	r5, [r4]		@ Force transition to L1
 
-	ldr	r3, timer_32ksynct_cr	@ get addr of counter
+	ldr	r3, omap2_sdi_timer_32ksynct_cr	@ get addr of counter
 	ldr	r5, [r3]		@ get value
 	add	r5, r5, #0x3		@ give it at most 93uS
 volt_delay:
@@ -128,16 +129,21 @@
 	mov	pc, lr			@ back to caller.
 
 /* relative load constants */
-cm_clksel2_pll:
-	.word CM_CLKSEL2_PLL_V
-sdrc_dlla_ctrl:
-	.word SDRC_DLLA_CTRL_V
-prcm_voltctrl:
-	.word PRCM_VOLTCTRL_V
+	.globl omap2_sdi_cm_clksel2_pll
+	.globl omap2_sdi_sdrc_dlla_ctrl
+	.globl omap2_sdi_prcm_voltctrl
+	.globl omap2_sdi_timer_32ksynct_cr
+
+omap2_sdi_cm_clksel2_pll:
+	.word SRAM_VA_MAGIC
+omap2_sdi_sdrc_dlla_ctrl:
+	.word SRAM_VA_MAGIC
+omap2_sdi_prcm_voltctrl:
+	.word SRAM_VA_MAGIC
 prcm_mask_val:
 	.word 0xFFFF3FFC
-timer_32ksynct_cr:
-	.word TIMER_32KSYNCT_CR_V
+omap2_sdi_timer_32ksynct_cr:
+	.word SRAM_VA_MAGIC
 ENTRY(sram_ddr_init_sz)
 	.word	. - sram_ddr_init
 
Index: linux-omap/arch/arm/plat-omap/sram.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/sram.c	2007-11-14 00:34:56.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/sram.c	2007-11-14 00:37:26.000000000 -0700
@@ -25,6 +25,12 @@
 #include <asm/arch/sram.h>
 #include <asm/arch/board.h>
 
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+# include "../mach-omap2/prm.h"
+# include "../mach-omap2/cm.h"
+# include "../mach-omap2/sdrc.h"
+#endif
+
 #define OMAP1_SRAM_PA		0x20000000
 #define OMAP1_SRAM_VA		0xd0000000
 #define OMAP2_SRAM_PA		0x40200000
@@ -58,6 +64,13 @@
 					 unsigned long pstart_avail,
 					 unsigned long size_avail);
 
+/* Global symbols in sram-fn.S to be patched with omap_sram_patch_va() */
+extern void *omap2_sdi_cm_clksel2_pll;
+extern void *omap2_sdi_sdrc_dlla_ctrl;
+extern void *omap2_sdi_prcm_voltctrl;
+extern void *omap2_sdi_timer_32ksynct_cr;
+
+
 /*
  * Depending on the target RAMFS firewall setup, the public usable amount of
  * SRAM varies.  The default accessible size for all device types is 2k. A GP
@@ -325,6 +338,19 @@
 {
 	_omap2_sram_ddr_init = omap_sram_push(sram_ddr_init, sram_ddr_init_sz);
 
+	/* Patch in the correct register addresses for multiboot */
+	omap_sram_patch_va(sram_ddr_init, &omap2_sdi_cm_clksel2_pll,
+			   _omap2_sram_ddr_init,
+			   OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2));
+	omap_sram_patch_va(sram_ddr_init, &omap2_sdi_sdrc_dlla_ctrl,
+			   _omap2_sram_ddr_init,
+			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
+	omap_sram_patch_va(sram_ddr_init, &omap2_sdi_prcm_voltctrl,
+			   _omap2_sram_ddr_init, OMAP24XX_PRCM_VOLTCTRL);
+	omap_sram_patch_va(sram_ddr_init, &omap2_sdi_timer_32ksynct_cr,
+			   _omap2_sram_ddr_init,
+			   (void __iomem *)IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010));
+
 	_omap2_sram_reprogram_sdrc = omap_sram_push(sram_reprogram_sdrc,
 						    sram_reprogram_sdrc_sz);
 	_omap2_set_prcm = omap_sram_push(sram_set_prcm, sram_set_prcm_sz);

-- 
