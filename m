From: "Girish" <girishsg@ti.com>
Subject: [PATCH 3/3: Resending]  arch:omap[2/3]4xx.h macro-defines cleanup
Date: Mon, 5 Nov 2007 21:36:21 +0530
Message-ID: <012a01c81fc5$cf046810$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

Hi 
This patch needed to be rebased on latest GIT. So, resending this patch ( of the series "[PATCH Resending 0/3]OMAP:id/silicon rev
check and omap24xx.h cleanup"). 

This cleans up omap24xx.h macro defines and to sync up with 12x tree. All
the dependent files also been modified.

Signed-off-by: Girish S G <girishsg@ti.com>
---
 arch/arm/mach-omap2/clock34xx.h      |   12 ++++++------
 arch/arm/plat-omap/devices.c         |    4 ++--
 include/asm-arm/arch-omap/omap24xx.h |    9 +++++++--
 include/asm-arm/arch-omap/omap34xx.h |    8 ++++----
 4 files changed, 19 insertions(+), 14 deletions(-)

Index: linux-omap-git/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap-git.orig/arch/arm/mach-omap2/clock34xx.h	2007-11-05 20:20:24.000000000 +0530
+++ linux-omap-git/arch/arm/mach-omap2/clock34xx.h	2007-11-05 20:41:28.000000000 +0530
@@ -23,7 +23,7 @@
 /* CONTROL_DEVCONF0 bits */
 #define OMAP3430_MCBSP2_CLKS_MASK		    (1 << 6)
 #define OMAP3430_MCBSP1_CLKS_MASK		    (1 << 2)
-/* OMAP34XX_CONTROL_DEVCONF1 bits */
+/* OMAP2_CONTROL_DEVCONF1 bits */
 #define OMAP3430_MCBSP5_CLKS_MASK		    (1 << 4)
 #define OMAP3430_MCBSP4_CLKS_MASK		    (1 << 2)
 #define OMAP3430_MCBSP3_CLKS_MASK		    (1 << 0)
@@ -913,7 +913,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
-	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF1),
+	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP2_CONTROL_DEVCONF1),
 	.clksel_mask	= OMAP3430_MCBSP5_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -925,7 +925,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
-	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF0),
+	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP2_CONTROL_DEVCONF0),
 	.clksel_mask	= OMAP3430_MCBSP1_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -1970,7 +1970,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
-	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF0),
+	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP2_CONTROL_DEVCONF0),
 	.clksel_mask	= OMAP3430_MCBSP2_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -1982,7 +1982,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
-	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF1),
+	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP2_CONTROL_DEVCONF1),
 	.clksel_mask	= OMAP3430_MCBSP3_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -1994,7 +1994,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
-	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF1),
+	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP2_CONTROL_DEVCONF1),
 	.clksel_mask	= OMAP3430_MCBSP4_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
Index: linux-omap-git/arch/arm/plat-omap/devices.c
===================================================================
--- linux-omap-git.orig/arch/arm/plat-omap/devices.c	2007-11-05 20:20:25.000000000 +0530
+++ linux-omap-git/arch/arm/plat-omap/devices.c	2007-11-05 20:41:28.000000000 +0530
@@ -345,9 +345,9 @@
 			 * Module Input Clock selection
 			 */
 			if (cpu_is_omap24xx()) {
-				u32 v = omap_readl(OMAP2_CONTROL_DEVCONF);
+				u32 v = omap_readl(OMAP2_CONTROL_DEVCONF0);
 				v |= (1 << 24);
-				omap_writel(v, OMAP2_CONTROL_DEVCONF);
+				omap_writel(v, OMAP2_CONTROL_DEVCONF0);
 			}
 		}
 		mmc1_conf = *mmc;
Index: linux-omap-git/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap-git.orig/include/asm-arm/arch-omap/omap24xx.h	2007-11-05 20:21:14.000000000 +0530
+++ linux-omap-git/include/asm-arm/arch-omap/omap24xx.h	2007-11-05 20:45:32.000000000 +0530
@@ -99,19 +99,24 @@
 #define OMAP2_SMS_BASE		OMAP243X_SMS_BASE
 #define OMAP2_L4_BASE		L4_24XX_BASE
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
-#define OMAP2_CTRL_BASE		OMAP243X_CTRL_BASE
+#define OMAP2_CTRL_BASE 	OMAP243X_CTRL_BASE
+#define OMAP2_CONTROL_PBIAS_1	L4_WK_243X_BASE + 0x24A0
 
 #else
 /* FIXME: These will go away soon */
 #define OMAP2_CTRL_BASE		L4_24XX_BASE
 #endif
 
+#if defined(CONFIG_ARCH_OMAP24XX)
+
 /* Control module */
 #define OMAP2_CONTROL_DEVCONF0	(OMAP2_CTRL_BASE + 0x274)
 #define OMAP2_CONTROL_DEVCONF1	(OMAP2_CTRL_BASE + 0x2e8)
-#define OMAP2_CONTROL_DEVCONF   OMAP2_CONTROL_DEVCONF0
 
 #define OMAP2_CONTROL_STATUS	(OMAP2_CTRL_BASE + 0x2f8)
+#define OMAP2_HDQ_BASE		(OMAP2_L4_BASE + 0xb2000)
+
+#endif
 
 #endif /* __ASM_ARCH_OMAP24XX_H */
 
Index: linux-omap-git/include/asm-arm/arch-omap/omap34xx.h
===================================================================
--- linux-omap-git.orig/include/asm-arm/arch-omap/omap34xx.h	2007-11-05 20:20:31.000000000 +0530
+++ linux-omap-git/include/asm-arm/arch-omap/omap34xx.h	2007-11-05 20:41:29.000000000 +0530
@@ -53,7 +53,7 @@
 #define IRQ_SIR_IRQ		0x0040
 
 
-#if defined(CONFIG_ARCH_OMAP3430)
+#if defined(CONFIG_ARCH_OMAP34XX)
 
 /*
  * REVISIT: OMAP3430 has two CONTROL_DEVCONF registers, CONTROL_DEVCONF0
@@ -68,9 +68,9 @@
 #define OMAP2_SMS_BASE			OMAP343X_SMS_BASE
 #define OMAP2_L4_BASE			L4_34XX_BASE
 #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
-#define OMAP2_CTRL_BASE			OMAP3430_CTRL_BASE
-#define OMAP34XX_CONTROL_DEVCONF0	(L4_34XX_BASE + 0x2274)
-#define OMAP34XX_CONTROL_DEVCONF1	(L4_34XX_BASE + 0x22D8)
+#define OMAP2_CTRL_BASE 		OMAP3430_CTRL_BASE
+#define OMAP2_CONTROL_DEVCONF0		(L4_34XX_BASE + 0x2274)
+#define OMAP2_CONTROL_DEVCONF1		(L4_34XX_BASE + 0x22D8)
 #define OMAP2_CONTROL_STATUS		(OMAP2_CTRL_BASE + 0x2f0)
 
 #endif
