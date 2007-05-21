From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/5] omap2: use OMAP2_PRCM_BASE in place of
	OMAP24XX_PRCM_BASE
Date: Mon, 21 May 2007 16:59:26 -0600
Message-ID: <20070521230014.729603278@pwsan.com>
References: <20070521225923.223790635@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline;
	filename=0003-omap2-use-OMAP2_PRCM_BASE-in-place-of-OMAP24XX_PRCM.patch
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

Change users of OMAP24XX_PRCM_BASE to use OMAP2_PRCM_BASE.  Remove
the OMAP24XX_PRCM_BASE define.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/mmu.c            |    3 ++-
 arch/arm/mach-omap2/pm.c             |    2 +-
 arch/arm/mach-omap2/prcm-regs.h      |    2 +-
 arch/arm/mach-omap2/sram-fn.S        |   12 ++++++------
 include/asm-arm/arch-omap/omap24xx.h |    1 -
 5 files changed, 10 insertions(+), 10 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/mmu.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/mmu.c
+++ linux-omap/arch/arm/mach-omap2/mmu.c
@@ -96,7 +96,8 @@ static int exmap_setup_preserved_entries
 
 	exmap_setup_preserved_mem_page(mmu, dspvect_page, DSP_INIT_PAGE, n++);
 
-	exmap_setup_iomap_page(mmu, OMAP24XX_PRCM_BASE, 0x7000, n++);
+	/* REVISIT: This will need to be revisited for 3430 */
+	exmap_setup_iomap_page(mmu, OMAP2_PRCM_BASE, 0x7000, n++);
 	exmap_setup_iomap_page(mmu, OMAP24XX_MAILBOX_BASE, 0x11000, n++);
 
 	if (cpu_is_omap2420()) {
Index: linux-omap/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/pm.c
+++ linux-omap/arch/arm/mach-omap2/pm.c
@@ -144,7 +144,7 @@ static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(int dllctrl);
 static void (*saved_idle)(void);
 
-static u32 prcm_base = IO_ADDRESS(OMAP24XX_PRCM_BASE);
+static u32 prcm_base = IO_ADDRESS(OMAP2_PRCM_BASE);
 
 static inline void prcm_write_reg(int idx, u32 val)
 {
Index: linux-omap/arch/arm/mach-omap2/prcm-regs.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/prcm-regs.h
+++ linux-omap/arch/arm/mach-omap2/prcm-regs.h
@@ -29,7 +29,7 @@
 
 #ifndef __ASSEMBLER__
 
-#define PRCM_REG32(offset)	__REG32(OMAP24XX_PRCM_BASE + (offset))
+#define PRCM_REG32(offset)	__REG32(OMAP2_PRCM_BASE + (offset))
 
 #define PRCM_REVISION		PRCM_REG32(0x000)
 #define PRCM_SYSCONFIG		PRCM_REG32(0x010)
Index: linux-omap/arch/arm/mach-omap2/sram-fn.S
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sram-fn.S
+++ linux-omap/arch/arm/mach-omap2/sram-fn.S
@@ -31,12 +31,12 @@
 
 #define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
 
-#define CM_CLKSEL2_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x544)
-#define PRCM_VOLTCTRL_V		IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x050)
-#define PRCM_CLKCFG_CTRL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x080)
-#define CM_CLKEN_PLL_V		IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x500)
-#define CM_IDLEST_CKGEN_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x520)
-#define CM_CLKSEL1_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x540)
+#define CM_CLKSEL2_PLL_V	IO_ADDRESS(OMAP2_PRCM_BASE + 0x544)
+#define PRCM_VOLTCTRL_V		IO_ADDRESS(OMAP2_PRCM_BASE + 0x050)
+#define PRCM_CLKCFG_CTRL_V	IO_ADDRESS(OMAP2_PRCM_BASE + 0x080)
+#define CM_CLKEN_PLL_V		IO_ADDRESS(OMAP2_PRCM_BASE + 0x500)
+#define CM_IDLEST_CKGEN_V	IO_ADDRESS(OMAP2_PRCM_BASE + 0x520)
+#define CM_CLKSEL1_PLL_V	IO_ADDRESS(OMAP2_PRCM_BASE + 0x540)
 
 #define SDRC_DLLA_CTRL_V	IO_ADDRESS(OMAP24XX_SDRC_BASE + 0x060)
 #define SDRC_RFR_CTRL_V		IO_ADDRESS(OMAP24XX_SDRC_BASE + 0x0a4)
Index: linux-omap/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap24xx.h
+++ linux-omap/include/asm-arm/arch-omap/omap24xx.h
@@ -74,7 +74,6 @@
 
 /* Temporary defines to be cleaned up in following patches */
 #define OMAP24XX_SDRC_BASE	OMAP2_SDRC_BASE
-#define OMAP24XX_PRCM_BASE	OMAP2_PRCM_BASE
 #define OMAP24XX_CTRL_BASE	OMAP2_CTRL_BASE
 
 #endif /* __ASM_ARCH_OMAP24XX_H */

-- 
