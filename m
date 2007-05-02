From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] omap2: merge CONTROL_STATUS defines
Date: Wed, 02 May 2007 12:33:23 -0600
Message-ID: <20070502183844.522873513@pwsan.com>
References: <20070502183320.656693735@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=hoist-control-status-define.patch
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

The *_CONTROL_STATUS defines in include/asm-arm/arch-omap/omap24xx.h
are shared between 2420 and 2430, so merge and rename those 
defines to reflect that.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/board-h4.c       |    2 +-
 include/asm-arm/arch-omap/omap24xx.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/board-h4.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-h4.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-h4.c
@@ -265,7 +265,7 @@ static struct platform_device *h4_device
 /* 2420 Sysboot setup (2430 is different) */
 static u32 get_sysboot_value(void)
 {
-	return (omap_readl(OMAP242X_CONTROL_STATUS) & 0xFFF);
+	return (omap_readl(OMAP24XX_CONTROL_STATUS) & 0xFFF);
 }
 
 /* FIXME: This function should be moved to some other file, gpmc.c? */
Index: linux-omap-2.6/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/omap24xx.h
+++ linux-omap-2.6/include/asm-arm/arch-omap/omap24xx.h
@@ -17,17 +17,17 @@
 #define OMAP24XX_IVA_INTC_BASE	0x40000000
 #define IRQ_SIR_IRQ		0x0040
 
+#define OMAP24XX_CONTROL_STATUS	(L4_24XX_BASE + 0x2f8)
+
 #ifdef CONFIG_ARCH_OMAP2420
 #define OMAP24XX_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
 #define OMAP24XX_PRCM_BASE	(L4_24XX_BASE + 0x8000)
 #define OMAP24XX_SDRC_BASE	(L3_24XX_BASE + 0x9000)
-#define OMAP242X_CONTROL_STATUS	(L4_24XX_BASE + 0x2f8)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2430
 #define OMAP24XX_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
 #define OMAP24XX_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
-#define OMAP242X_CONTROL_STATUS	(L4_24XX_BASE + 0x2f8)
 #define OMAP243X_SMS_BASE	0x6C000000
 #define OMAP24XX_SDRC_BASE	0x6D000000
 #define OMAP243X_GPMC_BASE	0x6E000000

-- 
