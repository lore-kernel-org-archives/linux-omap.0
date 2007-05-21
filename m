From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/5] omap2: use OMAP2_32KSYNCT_BASE in place of
	OMAP24XX_32KSYNCT_BASE
Date: Mon, 21 May 2007 16:59:25 -0600
Message-ID: <20070521230014.635898932@pwsan.com>
References: <20070521225923.223790635@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0002-omap2-use-OMAP2_32KSYNCT_BASE-in-place-of-OMAP24XX_.patch
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

Change users of OMAP24XX_32KSYNCT_BASE to use OMAP2_32KSYNCT_BASE, in
preparation to remove OMAP24XX_32KSYNCT_BASE.  Convert the 32K sync timer
reference in pm.c to use a symbolic constant rather than a magic number.
Remove the OMAP24XX_32KSYNCT_BASE define.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm.c             |    2 +-
 arch/arm/mach-omap2/sram-fn.S        |    2 +-
 arch/arm/plat-omap/common.c          |    2 +-
 arch/arm/plat-omap/timer32k.c        |    2 +-
 include/asm-arm/arch-omap/omap24xx.h |    1 -
 5 files changed, 4 insertions(+), 5 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/pm.c
+++ linux-omap/arch/arm/mach-omap2/pm.c
@@ -158,7 +158,7 @@ static inline u32 prcm_read_reg(int idx)
 
 static u32 omap2_read_32k_sync_counter(void)
 {
-        return omap_readl(0x48004010);
+        return omap_readl(OMAP2_32KSYNCT_BASE + 0x0010);
 }
 
 #ifdef CONFIG_PM_DEBUG
Index: linux-omap/arch/arm/mach-omap2/sram-fn.S
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sram-fn.S
+++ linux-omap/arch/arm/mach-omap2/sram-fn.S
@@ -29,7 +29,7 @@
 
 #include "prcm-regs.h"
 
-#define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP24XX_32KSYNCT_BASE + 0x010)
+#define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
 
 #define CM_CLKSEL2_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x544)
 #define PRCM_VOLTCTRL_V		IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x050)
Index: linux-omap/arch/arm/plat-omap/common.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/common.c
+++ linux-omap/arch/arm/plat-omap/common.c
@@ -192,7 +192,7 @@ console_initcall(omap_add_serial_console
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
 #elif defined(CONFIG_ARCH_OMAP24XX)
-#define TIMER_32K_SYNCHRONIZED		(OMAP24XX_32KSYNCT_BASE + 0x10)
+#define TIMER_32K_SYNCHRONIZED		(OMAP2_32KSYNCT_BASE + 0x10)
 #endif
 
 #ifdef	TIMER_32K_SYNCHRONIZED
Index: linux-omap/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/timer32k.c
+++ linux-omap/arch/arm/plat-omap/timer32k.c
@@ -71,7 +71,7 @@ struct sys_timer omap_timer;
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
 #elif defined(CONFIG_ARCH_OMAP24XX)
-#define TIMER_32K_SYNCHRONIZED		(OMAP24XX_32KSYNCT_BASE + 0x10)
+#define TIMER_32K_SYNCHRONIZED		(OMAP2_32KSYNCT_BASE + 0x10)
 #else
 #error OMAP 32KHz timer does not currently work on 15XX!
 #endif
Index: linux-omap/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap24xx.h
+++ linux-omap/include/asm-arm/arch-omap/omap24xx.h
@@ -73,7 +73,6 @@
 #endif
 
 /* Temporary defines to be cleaned up in following patches */
-#define OMAP24XX_32KSYNCT_BASE	OMAP2_32KSYNCT_BASE
 #define OMAP24XX_SDRC_BASE	OMAP2_SDRC_BASE
 #define OMAP24XX_PRCM_BASE	OMAP2_PRCM_BASE
 #define OMAP24XX_CTRL_BASE	OMAP2_CTRL_BASE

-- 
