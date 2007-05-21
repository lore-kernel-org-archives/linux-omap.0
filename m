From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] omap2: use OMAP2_SDRC_BASE in place of
	OMAP24XX_SDRC_BASE
Date: Mon, 21 May 2007 16:59:27 -0600
Message-ID: <20070521230014.815712284@pwsan.com>
References: <20070521225923.223790635@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0004-omap2-use-OMAP2_SDRC_BASE-in-place-of-OMAP24XX_SDRC.patch
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

Change users of OMAP24XX_SDRC_BASE to use OMAP2_SDRC_BASE.  Remove the
OMAP24XX_SDRC_BASE define.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm-regs.h      |   14 +++++++-------
 arch/arm/mach-omap2/sleep.S          |   10 ++++++----
 arch/arm/mach-omap2/sram-fn.S        |    4 ++--
 include/asm-arm/arch-omap/io.h       |    2 +-
 include/asm-arm/arch-omap/omap24xx.h |    1 -
 5 files changed, 16 insertions(+), 15 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/prcm-regs.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/prcm-regs.h
+++ linux-omap/arch/arm/mach-omap2/prcm-regs.h
@@ -199,7 +199,7 @@
 #define UART1_SYSCONFIG		__REG32(OMAP24XX_L4_IO_BASE + 0x6A054)
 #define UART2_SYSCONFIG		__REG32(OMAP24XX_L4_IO_BASE + 0x6C054)
 #define UART3_SYSCONFIG		__REG32(OMAP24XX_L4_IO_BASE + 0x6E054)
-#define SDRC_SYSCONFIG		__REG32(OMAP24XX_SDRC_BASE + 0x10)
+#define SDRC_SYSCONFIG		__REG32(OMAP2_SDRC_BASE + 0x10)
 #define OMAP24XX_SMS_BASE	(L3_24XX_BASE + 0x8000)
 #define SMS_SYSCONFIG		__REG32(OMAP24XX_SMS_BASE + 0x10)
 #define SSI_SYSCONFIG		__REG32(DISP_BASE + 0x8010)
@@ -263,12 +263,12 @@
 #define GPTIMER3_TISR		__REG32(OMAP24XX_L4_IO_BASE + 0x78018)
 
 /* SDRC */
-#define SDRC_DLLA_CTRL		__REG32(OMAP24XX_SDRC_BASE + 0x060)
-#define SDRC_DLLA_STATUS	__REG32(OMAP24XX_SDRC_BASE + 0x064)
-#define SDRC_DLLB_CTRL		__REG32(OMAP24XX_SDRC_BASE + 0x068)
-#define SDRC_DLLB_STATUS	__REG32(OMAP24XX_SDRC_BASE + 0x06C)
-#define SDRC_POWER		__REG32(OMAP24XX_SDRC_BASE + 0x070)
-#define SDRC_MR_0		__REG32(OMAP24XX_SDRC_BASE + 0x084)
+#define SDRC_DLLA_CTRL		__REG32(OMAP2_SDRC_BASE + 0x060)
+#define SDRC_DLLA_STATUS	__REG32(OMAP2_SDRC_BASE + 0x064)
+#define SDRC_DLLB_CTRL		__REG32(OMAP2_SDRC_BASE + 0x068)
+#define SDRC_DLLB_STATUS	__REG32(OMAP2_SDRC_BASE + 0x06C)
+#define SDRC_POWER		__REG32(OMAP2_SDRC_BASE + 0x070)
+#define SDRC_MR_0		__REG32(OMAP2_SDRC_BASE + 0x084)
 
 /* GPIO 1 */
 #define GPIO1_BASE		GPIOX_BASE(1)
Index: linux-omap/arch/arm/mach-omap2/sleep.S
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sleep.S
+++ linux-omap/arch/arm/mach-omap2/sleep.S
@@ -30,11 +30,13 @@
 #include <asm/arch/io.h>
 #include <asm/arch/pm.h>
 
-#define A_SDRC_DLLA_CTRL_V	IO_ADDRESS(OMAP24XX_SDRC_BASE+0x60)
-#define	A_SDRC_POWER_V		IO_ADDRESS(OMAP24XX_SDRC_BASE+0x70)
-#define A_SDRC_RFR_CTRL_V	IO_ADDRESS(OMAP24XX_SDRC_BASE+0xA4)
+#include <asm/arch/omap24xx.h>
+
+#define A_SDRC_DLLA_CTRL_V	IO_ADDRESS(OMAP2_SDRC_BASE + 0x60)
+#define	A_SDRC_POWER_V		IO_ADDRESS(OMAP2_SDRC_BASE + 0x70)
+#define A_SDRC_RFR_CTRL_V	IO_ADDRESS(OMAP2_SDRC_BASE + 0xA4)
 #define A_SDRC0_V		(0xC0000000)
-#define A_SDRC_MANUAL_V		IO_ADDRESS(OMAP24XX_SDRC_BASE+0xA8)
+#define A_SDRC_MANUAL_V		IO_ADDRESS(OMAP2_SDRC_BASE + 0xA8)
 
 	.text
 
Index: linux-omap/arch/arm/mach-omap2/sram-fn.S
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sram-fn.S
+++ linux-omap/arch/arm/mach-omap2/sram-fn.S
@@ -38,8 +38,8 @@
 #define CM_IDLEST_CKGEN_V	IO_ADDRESS(OMAP2_PRCM_BASE + 0x520)
 #define CM_CLKSEL1_PLL_V	IO_ADDRESS(OMAP2_PRCM_BASE + 0x540)
 
-#define SDRC_DLLA_CTRL_V	IO_ADDRESS(OMAP24XX_SDRC_BASE + 0x060)
-#define SDRC_RFR_CTRL_V		IO_ADDRESS(OMAP24XX_SDRC_BASE + 0x0a4)
+#define SDRC_DLLA_CTRL_V	IO_ADDRESS(OMAP2_SDRC_BASE + 0x060)
+#define SDRC_RFR_CTRL_V		IO_ADDRESS(OMAP2_SDRC_BASE + 0x0a4)
 
 	.text
 
Index: linux-omap/include/asm-arm/arch-omap/io.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/io.h
+++ linux-omap/include/asm-arm/arch-omap/io.h
@@ -80,7 +80,7 @@
 #define OMAP243X_GPMC_PHYS	OMAP243X_GPMC_BASE	/* 0x49000000 */
 #define OMAP243X_GPMC_VIRT	0xFE000000
 #define OMAP243X_GPMC_SIZE	SZ_1M
-#define OMAP243X_SDRC_PHYS	OMAP24XX_SDRC_BASE
+#define OMAP243X_SDRC_PHYS	OMAP243X_SDRC_BASE
 #define OMAP243X_SDRC_VIRT	0xFD000000
 #define OMAP243X_SDRC_SIZE	SZ_1M
 #define OMAP243X_SMS_PHYS	OMAP243X_SMS_BASE
Index: linux-omap/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap24xx.h
+++ linux-omap/include/asm-arm/arch-omap/omap24xx.h
@@ -73,7 +73,6 @@
 #endif
 
 /* Temporary defines to be cleaned up in following patches */
-#define OMAP24XX_SDRC_BASE	OMAP2_SDRC_BASE
 #define OMAP24XX_CTRL_BASE	OMAP2_CTRL_BASE
 
 #endif /* __ASM_ARCH_OMAP24XX_H */

-- 
