From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/5] omap2: use PRCM_BASE in place of OMAP24XX_PRCM_BASE
Date: Wed, 16 May 2007 16:58:53 -0600
Message-ID: <20070516231342.320294053@pwsan.com>
References: <20070516225850.075133914@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0003-omap2-use-PRCM_BASE-in-place-of-OMAP24XX_PRCM_BASE.patch
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

Change users of OMAP24XX_PRCM_BASE to use PRCM_BASE.  Remove
the OMAP24XX_PRCM_BASE define.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/mmu.c            |    2 +-
 arch/arm/mach-omap2/pm.c             |    2 +-
 arch/arm/mach-omap2/prcm-regs.h      |    2 +-
 arch/arm/mach-omap2/sram-fn.S        |   12 ++++++------
 include/asm-arm/arch-omap/omap24xx.h |    1 -
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/mmu.c b/arch/arm/mach-omap2/mmu.c
index 2a52907..1f68d15 100644
--- a/arch/arm/mach-omap2/mmu.c
+++ b/arch/arm/mach-omap2/mmu.c
@@ -96,7 +96,7 @@ static int exmap_setup_preserved_entries(struct omap_mmu *mmu)
 
 	exmap_setup_preserved_mem_page(mmu, dspvect_page, DSP_INIT_PAGE, n++);
 
-	exmap_setup_iomap_page(mmu, OMAP24XX_PRCM_BASE, 0x7000, n++);
+	exmap_setup_iomap_page(mmu, PRCM_BASE, 0x7000, n++);
 	exmap_setup_iomap_page(mmu, OMAP24XX_MAILBOX_BASE, 0x11000, n++);
 
 	if (cpu_is_omap2420()) {
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 0c84a18..ad70280 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -144,7 +144,7 @@ static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(int dllctrl);
 static void (*saved_idle)(void);
 
-static u32 prcm_base = IO_ADDRESS(OMAP24XX_PRCM_BASE);
+static u32 prcm_base = IO_ADDRESS(PRCM_BASE);
 
 static inline void prcm_write_reg(int idx, u32 val)
 {
diff --git a/arch/arm/mach-omap2/prcm-regs.h b/arch/arm/mach-omap2/prcm-regs.h
index 4672a2c..c5bb9b6 100644
--- a/arch/arm/mach-omap2/prcm-regs.h
+++ b/arch/arm/mach-omap2/prcm-regs.h
@@ -29,7 +29,7 @@
 
 #ifndef __ASSEMBLER__
 
-#define PRCM_REG32(offset)	__REG32(OMAP24XX_PRCM_BASE + (offset))
+#define PRCM_REG32(offset)	__REG32(PRCM_BASE + (offset))
 
 #define PRCM_REVISION		PRCM_REG32(0x000)
 #define PRCM_SYSCONFIG		PRCM_REG32(0x010)
diff --git a/arch/arm/mach-omap2/sram-fn.S b/arch/arm/mach-omap2/sram-fn.S
index 9109b02..c9c53e6 100644
--- a/arch/arm/mach-omap2/sram-fn.S
+++ b/arch/arm/mach-omap2/sram-fn.S
@@ -31,12 +31,12 @@
 
 #define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP_32KSYNCT_BASE + 0x010)
 
-#define CM_CLKSEL2_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x544)
-#define PRCM_VOLTCTRL_V		IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x050)
-#define PRCM_CLKCFG_CTRL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x080)
-#define CM_CLKEN_PLL_V		IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x500)
-#define CM_IDLEST_CKGEN_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x520)
-#define CM_CLKSEL1_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x540)
+#define CM_CLKSEL2_PLL_V	IO_ADDRESS(PRCM_BASE + 0x544)
+#define PRCM_VOLTCTRL_V		IO_ADDRESS(PRCM_BASE + 0x050)
+#define PRCM_CLKCFG_CTRL_V	IO_ADDRESS(PRCM_BASE + 0x080)
+#define CM_CLKEN_PLL_V		IO_ADDRESS(PRCM_BASE + 0x500)
+#define CM_IDLEST_CKGEN_V	IO_ADDRESS(PRCM_BASE + 0x520)
+#define CM_CLKSEL1_PLL_V	IO_ADDRESS(PRCM_BASE + 0x540)
 
 #define SDRC_DLLA_CTRL_V	IO_ADDRESS(OMAP24XX_SDRC_BASE + 0x060)
 #define SDRC_RFR_CTRL_V		IO_ADDRESS(OMAP24XX_SDRC_BASE + 0x0a4)
diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arch-omap/omap24xx.h
index a56a431..5f5b40b 100644
--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
@@ -74,7 +74,6 @@
 
 /* Temporary defines to be cleaned up in following patches */
 #define OMAP24XX_SDRC_BASE	SDRC_BASE
-#define OMAP24XX_PRCM_BASE	PRCM_BASE
 #define OMAP24XX_CTRL_BASE	CTRL_BASE
 
 #endif /* __ASM_ARCH_OMAP24XX_H */
-- 
1.5.1.3

-- 
