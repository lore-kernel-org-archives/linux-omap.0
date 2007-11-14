From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/5] SRAM patcher: convert omap24xx_sram_suspend to use
	runtime SRAM patcher
Date: Wed, 14 Nov 2007 01:30:12 -0700
Message-ID: <20071114083104.552426269@pwsan.com>
References: <20071114083010.938764990@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=sp-patch-omap24xx-sram-suspend.patch
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
omap24xx_sram_suspend.  The long symbol names are intended to help
disambiguate the symbols, now that they are global.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/pm.c    |   13 +++++++++++++
 arch/arm/mach-omap2/sleep.S |   21 +++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/pm.c	2007-11-14 01:28:52.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/pm.c	2007-11-14 01:29:02.000000000 -0700
@@ -52,6 +52,10 @@
 #include "cm_regbits_24xx.h"
 #include "sdrc.h"
 
+/* These addrs are in assembly language code to be patched at runtime */
+extern void *omap2_ocs_sdrc_power;
+extern void *omap2_ocs_sdrc_dlla_ctrl;
+
 static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(void __iomem *dllctrl);
 static void (*saved_idle)(void);
@@ -803,9 +807,18 @@
 	 */
 	omap2_sram_idle = omap_sram_push(omap24xx_idle_loop_suspend,
 					 omap24xx_idle_loop_suspend_sz);
+
 	omap2_sram_suspend = omap_sram_push(omap24xx_cpu_suspend,
 					    omap24xx_cpu_suspend_sz);
 
+	/* Patch in the correct register addresses for multiboot */
+	omap_sram_patch_va(omap24xx_cpu_suspend, &omap2_ocs_sdrc_power,
+			   omap2_sram_suspend,
+			   OMAP_SDRC_REGADDR(SDRC_POWER));
+	omap_sram_patch_va(omap24xx_cpu_suspend, &omap2_ocs_sdrc_dlla_ctrl,
+			   omap2_sram_suspend,
+			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
+
 	suspend_set_ops(&omap_pm_ops);
 	pm_idle = omap2_pm_idle;
 
Index: linux-omap/arch/arm/mach-omap2/sleep.S
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sleep.S	2007-11-14 01:28:52.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/sleep.S	2007-11-14 01:29:33.000000000 -0700
@@ -26,17 +26,15 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/poison.h>	/* for SRAM_VA_MAGIC */
 #include <asm/assembler.h>
 #include <asm/arch/io.h>
 #include <asm/arch/pm.h>
 
 #include <asm/arch/omap24xx.h>
 
-#define A_SDRC_DLLA_CTRL_V	IO_ADDRESS(OMAP2_SDRC_BASE + 0x60)
-#define	A_SDRC_POWER_V		IO_ADDRESS(OMAP2_SDRC_BASE + 0x70)
-#define A_SDRC_RFR_CTRL_V	IO_ADDRESS(OMAP2_SDRC_BASE + 0xA4)
+/* First address of reserved address space?  apparently valid for OMAP2 & 3 */
 #define A_SDRC0_V		(0xC0000000)
-#define A_SDRC_MANUAL_V		IO_ADDRESS(OMAP2_SDRC_BASE + 0xA8)
 
 	.text
 
@@ -88,7 +86,7 @@
 	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, hope SDR/DDR finished
 	nop
 	nop
-	ldr	r3, A_SDRC_POWER	@ addr of sdrc power
+	ldr	r3, omap2_ocs_sdrc_power	@ addr of sdrc power
 	ldr	r4, [r3]		@ value of sdrc power
 	orr	r4, r4, #0x40		@ enable self refresh on idle req
 	mov	r5, #0x2000		@ set delay (DPLL relock + DLL relock)
@@ -108,7 +106,7 @@
 	ldr	r4, [r4]
 	nop				@ start auto refresh only after clk ok
 	movs	r0, r0			@ see if DDR or SDR
-	ldrne	r1, A_SDRC_DLLA_CTRL_S	@ get addr of DLL ctrl
+	ldrne	r1, omap2_ocs_sdrc_dlla_ctrl	@ get addr of DLL ctrl
 	strne	r0, [r1]		@ rewrite DLLA to force DLL reload
 	addne	r1, r1, #0x8		@ move to DLLB
 	strne	r0, [r1]		@ rewrite DLLB to force DLL reload
@@ -120,12 +118,15 @@
 	/* resume*/
 	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
 
-A_SDRC_POWER:
-	.word A_SDRC_POWER_V
+	.globl	omap2_ocs_sdrc_power
+	.globl	omap2_ocs_sdrc_dlla_ctrl
+
+omap2_ocs_sdrc_power:
+	.word SRAM_VA_MAGIC
 A_SDRC0:
 	.word A_SDRC0_V
-A_SDRC_DLLA_CTRL_S:
-	.word A_SDRC_DLLA_CTRL_V
+omap2_ocs_sdrc_dlla_ctrl:
+	.word SRAM_VA_MAGIC
 
 ENTRY(omap24xx_cpu_suspend_sz)
 	.word	. - omap24xx_cpu_suspend

-- 
