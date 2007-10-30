From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: compile-fixes for PM debug
Date: Tue, 30 Oct 2007 04:40:40 -0700
Message-ID: <20071030114040.829831127@mvista.com>
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

Fix compile problems in omap2_pm_debug()

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/mach-omap2/pm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: dev/arch/arm/mach-omap2/pm.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/pm.c
+++ dev/arch/arm/mach-omap2/pm.c
@@ -240,15 +240,15 @@ static void omap2_pm_dump(int mode, int 
 #endif
 #if 0
 		DUMP_CM_MOD_REG(CORE_MOD, CM_FCLKEN1);
-		DUMP_CM_MOD_REG(CORE_MOD, CM_FCLKEN2);
+		DUMP_CM_MOD_REG(CORE_MOD, OMAP24XX_CM_FCLKEN2);
 		DUMP_CM_MOD_REG(WKUP_MOD, CM_FCLKEN);
 		DUMP_CM_MOD_REG(CORE_MOD, CM_ICLKEN1);
 		DUMP_CM_MOD_REG(CORE_MOD, CM_ICLKEN2);
 		DUMP_CM_MOD_REG(WKUP_MOD, CM_ICLKEN);
-		DUMP_CM_MOD_REG(PLL_MOD, CM_CLKEN_PLL);
+		DUMP_CM_MOD_REG(PLL_MOD, CM_CLKEN);
 		DUMP_PRM_REG(OMAP24XX_PRCM_CLKEMUL_CTRL);
 		DUMP_CM_MOD_REG(PLL_MOD, CM_AUTOIDLE);
-		DUMP_PRM_MOD_REG(CORE_REG, PM_PWSTST);
+		DUMP_PRM_MOD_REG(CORE_MOD, PM_PWSTST);
 		DUMP_PRM_REG(OMAP24XX_PRCM_CLKSRC_CTRL);
 #endif
 #if 0
--
