From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/5] omap2: modify omap24xx.h to improve constant names and
	prepare for multi-arch kernels
Date: Mon, 21 May 2007 16:59:24 -0600
Message-ID: <20070521230014.545006526@pwsan.com>
References: <20070521225923.223790635@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0001-omap2-modify-omap24xx.h-to-improve-constant-names-a.patch
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

Redo the defines in omap24xx.h to fix poorly-named defines, such as
OMAP24XX_SDRC_BASE, which is different between 2420 and 2430.  Also,
prepare for future multi-architecture kernels by removing the
architecture prefixes from several of the defines.  (Presumably in the
future these will be assigned to 'static void __iomem *'s by runtime
init code depending on the CPU type.)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 include/asm-arm/arch-omap/entry-macro.S |    2 
 include/asm-arm/arch-omap/io.h          |    6 +-
 include/asm-arm/arch-omap/omap24xx.h    |   74 +++++++++++++++++++++-----------
 3 files changed, 53 insertions(+), 29 deletions(-)

Index: linux-omap/include/asm-arm/arch-omap/io.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/io.h
+++ linux-omap/include/asm-arm/arch-omap/io.h
@@ -95,13 +95,13 @@
 #define io_v2p(va)	((va) - IO_OFFSET)	/* Works for L3 and L4 */
 
 /* DSP */
-#define DSP_MEM_24XX_PHYS	OMAP24XX_DSP_MEM_BASE	/* 0x58000000 */
+#define DSP_MEM_24XX_PHYS	OMAP2420_DSP_MEM_BASE	/* 0x58000000 */
 #define DSP_MEM_24XX_VIRT	0xe0000000
 #define DSP_MEM_24XX_SIZE	0x28000
-#define DSP_IPI_24XX_PHYS	OMAP24XX_DSP_IPI_BASE	/* 0x59000000 */
+#define DSP_IPI_24XX_PHYS	OMAP2420_DSP_IPI_BASE	/* 0x59000000 */
 #define DSP_IPI_24XX_VIRT	0xe1000000
 #define DSP_IPI_24XX_SIZE	SZ_4K
-#define DSP_MMU_24XX_PHYS	OMAP24XX_DSP_MMU_BASE	/* 0x5a000000 */
+#define DSP_MMU_24XX_PHYS	OMAP2420_DSP_MMU_BASE	/* 0x5a000000 */
 #define DSP_MMU_24XX_VIRT	0xe2000000
 #define DSP_MMU_24XX_SIZE	SZ_4K
 
Index: linux-omap/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap24xx.h
+++ linux-omap/include/asm-arm/arch-omap/omap24xx.h
@@ -13,46 +13,70 @@
 
 /* interrupt controller */
 #define OMAP24XX_IC_BASE	(L4_24XX_BASE + 0xfe000)
-#define VA_IC_BASE		IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP24XX_IVA_INTC_BASE	0x40000000
 #define IRQ_SIR_IRQ		0x0040
 
 #define OMAP24XX_CONTROL_STATUS	(L4_24XX_BASE + 0x2f8)
 
-#ifdef CONFIG_ARCH_OMAP2420
-#define OMAP24XX_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
-#define OMAP24XX_PRCM_BASE	(L4_24XX_BASE + 0x8000)
-#define OMAP24XX_SDRC_BASE	(L3_24XX_BASE + 0x9000)
-#define OMAP24XX_CTRL_BASE	L4_24XX_BASE
-#endif
+#define OMAP2420_CTRL_BASE	L4_24XX_BASE
+#define OMAP2420_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
+#define OMAP2420_PRCM_BASE	(L4_24XX_BASE + 0x8000)
+#define OMAP2420_SDRC_BASE	(L3_24XX_BASE + 0x9000)
+#define OMAP2420_SMS_BASE	0x68008000
+
+#define OMAP2430_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
+#define OMAP2430_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
 
-#ifdef CONFIG_ARCH_OMAP2430
-#define OMAP24XX_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
-#define OMAP24XX_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
 #define OMAP243X_SMS_BASE	0x6C000000
-#define OMAP24XX_SDRC_BASE	0x6D000000
+#define OMAP243X_SDRC_BASE	0x6D000000
 #define OMAP243X_GPMC_BASE	0x6E000000
 #define OMAP243X_SCM_BASE	(L4_WK_243X_BASE + 0x2000)
-#define OMAP24XX_CTRL_BASE	OMAP243X_SCM_BASE
+#define OMAP243X_CTRL_BASE	OMAP243X_SCM_BASE
 #define OMAP243X_HS_BASE	(L4_24XX_BASE + 0x000ac000)
-#endif
 
 /* DSP SS */
-#ifdef CONFIG_ARCH_OMAP2420
-#define OMAP24XX_DSP_BASE	0x58000000
-#define OMAP24XX_DSP_MEM_BASE	(OMAP24XX_DSP_BASE + 0x0)
-#define OMAP24XX_DSP_IPI_BASE	(OMAP24XX_DSP_BASE + 0x1000000)
-#define OMAP24XX_DSP_MMU_BASE	(OMAP24XX_DSP_BASE + 0x2000000)
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2430
-#define OMAP24XX_DSP_BASE	0x5C000000
-#define OMAP24XX_DSP_MEM_BASE	(OMAP24XX_DSP_BASE + 0x0)
-#define OMAP24XX_DSP_MMU_BASE	(OMAP24XX_DSP_BASE + 0x1000000)
-#endif
+#define OMAP2420_DSP_BASE	0x58000000
+#define OMAP2420_DSP_MEM_BASE	(OMAP2420_DSP_BASE + 0x0)
+#define OMAP2420_DSP_IPI_BASE	(OMAP2420_DSP_BASE + 0x1000000)
+#define OMAP2420_DSP_MMU_BASE	(OMAP2420_DSP_BASE + 0x2000000)
+
+#define OMAP243X_DSP_BASE	0x5C000000
+#define OMAP243X_DSP_MEM_BASE	(OMAP243X_DSP_BASE + 0x0)
+#define OMAP243X_DSP_MMU_BASE	(OMAP243X_DSP_BASE + 0x1000000)
 
 /* Mailbox */
 #define OMAP24XX_MAILBOX_BASE	(L4_24XX_BASE + 0x94000)
 
+
+#if defined(CONFIG_ARCH_OMAP2420)
+
+#define OMAP2_32KSYNCT_BASE	OMAP2420_32KSYNCT_BASE
+#define OMAP2_PRCM_BASE		OMAP2420_PRCM_BASE
+#define OMAP2_SDRC_BASE		OMAP2420_SDRC_BASE
+#define OMAP2_SMS_BASE		OMAP2420_SMS_BASE
+#define OMAP2_L4_BASE		L4_24XX_BASE
+#define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
+#define OMAP2_CTRL_BASE		OMAP2420_CTRL_BASE
+
+#elif defined(CONFIG_ARCH_OMAP2430)
+
+#define OMAP2_32KSYNCT_BASE	OMAP2430_32KSYNCT_BASE
+#define OMAP2_PRCM_BASE		OMAP2430_PRCM_BASE
+#define OMAP2_SDRC_BASE		OMAP243X_SDRC_BASE
+#define OMAP2_SMS_BASE		OMAP243X_SMS_BASE
+#define OMAP2_L4_BASE		L4_24XX_BASE
+#define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
+#define OMAP2_CTRL_BASE		OMAP243X_CTRL_BASE
+
+#else
+#error "Unknown architecture"
+#endif
+
+/* Temporary defines to be cleaned up in following patches */
+#define OMAP24XX_32KSYNCT_BASE	OMAP2_32KSYNCT_BASE
+#define OMAP24XX_SDRC_BASE	OMAP2_SDRC_BASE
+#define OMAP24XX_PRCM_BASE	OMAP2_PRCM_BASE
+#define OMAP24XX_CTRL_BASE	OMAP2_CTRL_BASE
+
 #endif /* __ASM_ARCH_OMAP24XX_H */
 
Index: linux-omap/include/asm-arm/arch-omap/entry-macro.S
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/entry-macro.S
+++ linux-omap/include/asm-arm/arch-omap/entry-macro.S
@@ -68,7 +68,7 @@
 		.endm
 
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =VA_IC_BASE
+		ldr	\base, =OMAP2_VA_IC_BASE
 		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
 		cmp	\irqnr, #0x0
 		bne	2222f

-- 
