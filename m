From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: Correct use of CONTROL_ regs for OMAP2
Date: Wed, 22 Aug 2007 13:36:53 -0700
Message-ID: <11878150131374-git-send-email-khilman@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

The system control module regs have a different base on 2420 and 2430.
Fix them to work on 2430.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/mach-omap2/board-h4.c       |    2 +-
 arch/arm/plat-omap/devices.c         |    4 ++--
 include/asm-arm/arch-omap/omap24xx.h |   10 +++++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index a4defbf..df26135 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -267,7 +267,7 @@ static struct platform_device *h4_devices[] __initdata = {
 /* 2420 Sysboot setup (2430 is different) */
 static u32 get_sysboot_value(void)
 {
-	return (omap_readl(OMAP24XX_CONTROL_STATUS) & 0xFFF);
+	return (omap_readl(OMAP2_CONTROL_STATUS) & 0xFFF);
 }
 
 /* FIXME: This function should be moved to some other file, gpmc.c? */
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 0c0ecd7..c2828fe 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -345,9 +345,9 @@ static void __init omap_init_mmc(void)
 			 * Module Input Clock selection
 			 */
 			if (cpu_is_omap24xx()) {
-				u32 v = omap_readl(OMAP24XX_CONTROL_DEVCONF);
+				u32 v = omap_readl(OMAP2_CONTROL_DEVCONF);
 				v |= (1 << 24);
-				omap_writel(v, OMAP24XX_CONTROL_DEVCONF);
+				omap_writel(v, OMAP2_CONTROL_DEVCONF);
 			}
 		}
 		mmc1_conf = *mmc;
diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arch-omap/omap24xx.h
index e552ce8..2e944a1 100644
--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
@@ -41,9 +41,6 @@
 #define OMAP24XX_IVA_INTC_BASE	0x40000000
 #define IRQ_SIR_IRQ		0x0040
 
-#define OMAP24XX_CONTROL_DEVCONF	(L4_24XX_BASE + 0x274)
-#define OMAP24XX_CONTROL_STATUS	(L4_24XX_BASE + 0x2f8)
-
 #define OMAP2420_CTRL_BASE	L4_24XX_BASE
 #define OMAP2420_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
 #define OMAP2420_PRCM_BASE	(L4_24XX_BASE + 0x8000)
@@ -106,5 +103,12 @@
 
 #endif
 
+/* Control module */
+#define OMAP2_CONTROL_DEVCONF0	(OMAP2_CTRL_BASE + 0x274)
+#define OMAP2_CONTROL_DEVCONF1	(OMAP2_CTRL_BASE + 0x2e8)
+#define OMAP2_CONTROL_DEVCONF   OMAP2_CONTROL_DEVCONF0
+
+#define OMAP2_CONTROL_STATUS	(OMAP2_CTRL_BASE + 0x2f8)
+
 #endif /* __ASM_ARCH_OMAP24XX_H */
 
-- 
1.5.2
