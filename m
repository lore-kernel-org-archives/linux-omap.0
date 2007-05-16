From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/5] omap2: use OMAP24XX_32KSYNCT_BASE in place of
	OMAP_32KSYNCT_BASE
Date: Wed, 16 May 2007 16:58:52 -0600
Message-ID: <20070516231342.227719185@pwsan.com>
References: <20070516225850.075133914@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0002-omap2-use-OMAP24XX_32KSYNCT_BASE-in-place-of-OMAP_3.patch
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

Change users of OMAP24XX_32KSYNCT_BASE to use OMAP_32KSYNCT_BASE, in
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

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 13d05a5..0c84a18 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -158,7 +158,7 @@ static inline u32 prcm_read_reg(int idx)
 
 static u32 omap2_read_32k_sync_counter(void)
 {
-        return omap_readl(0x48004010);
+        return omap_readl(OMAP_32KSYNCT_BASE + 0x0010);
 }
 
 #ifdef CONFIG_PM_DEBUG
diff --git a/arch/arm/mach-omap2/sram-fn.S b/arch/arm/mach-omap2/sram-fn.S
index b275766..9109b02 100644
--- a/arch/arm/mach-omap2/sram-fn.S
+++ b/arch/arm/mach-omap2/sram-fn.S
@@ -29,7 +29,7 @@
 
 #include "prcm-regs.h"
 
-#define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP24XX_32KSYNCT_BASE + 0x010)
+#define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP_32KSYNCT_BASE + 0x010)
 
 #define CM_CLKSEL2_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x544)
 #define PRCM_VOLTCTRL_V		IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x050)
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index e03ace4..e9ebdd8 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -192,7 +192,7 @@ console_initcall(omap_add_serial_console);
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
 #elif defined(CONFIG_ARCH_OMAP24XX)
-#define TIMER_32K_SYNCHRONIZED		(OMAP24XX_32KSYNCT_BASE + 0x10)
+#define TIMER_32K_SYNCHRONIZED		(OMAP_32KSYNCT_BASE + 0x10)
 #endif
 
 #ifdef	TIMER_32K_SYNCHRONIZED
diff --git a/arch/arm/plat-omap/timer32k.c b/arch/arm/plat-omap/timer32k.c
index 2474597..10fa89d 100644
--- a/arch/arm/plat-omap/timer32k.c
+++ b/arch/arm/plat-omap/timer32k.c
@@ -71,7 +71,7 @@ struct sys_timer omap_timer;
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
 #elif defined(CONFIG_ARCH_OMAP24XX)
-#define TIMER_32K_SYNCHRONIZED		(OMAP24XX_32KSYNCT_BASE + 0x10)
+#define TIMER_32K_SYNCHRONIZED		(OMAP_32KSYNCT_BASE + 0x10)
 #else
 #error OMAP 32KHz timer does not currently work on 15XX!
 #endif
diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arch-omap/omap24xx.h
index 249438d..a56a431 100644
--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
@@ -73,7 +73,6 @@
 #endif
 
 /* Temporary defines to be cleaned up in following patches */
-#define OMAP24XX_32KSYNCT_BASE	OMAP_32KSYNCT_BASE
 #define OMAP24XX_SDRC_BASE	SDRC_BASE
 #define OMAP24XX_PRCM_BASE	PRCM_BASE
 #define OMAP24XX_CTRL_BASE	CTRL_BASE
-- 
1.5.1.3

-- 
