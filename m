From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/18] omap2: convert prcm.c to use symbolic register &
	register bit constants
Date: Fri, 25 May 2007 02:23:34 -0600
Message-ID: <20070525082502.290025313@pwsan.com>
References: <20070525082322.168056647@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0012-omap2-convert-prcm.c-to-use-symbolic-register-reg.patch
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

Replace magic numbers and prcm-regs.h-sourced defines, for readability
and in preparation to remove prcm-regs.h.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 90f5305..9af8848 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -17,19 +17,22 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 
-#include "prcm-regs.h"
+#include "prm.h"
+#include "prm_regbits_24xx.h"
 
 extern void omap2_clk_prepare_for_reboot(void);
 
 u32 omap_prcm_get_reset_sources(void)
 {
-	return RM_RSTST_WKUP & 0x7f;
+	return prm_read_mod_reg(WKUP_MOD, RM_RSTST) & 0x7f;
 }
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
 
 /* Resets clock rates and reboots the system. Only called from system.h */
 void omap_prcm_arch_reset(char mode)
 {
+	u32 wkup;
 	omap2_clk_prepare_for_reboot();
-	RM_RSTCTRL_WKUP |= 2;
+	wkup = prm_read_mod_reg(WKUP_MOD, RM_RSTCTRL) | OMAP_RST_DPLL3;
+	prm_write_mod_reg(wkup, WKUP_MOD, RM_RSTCTRL);
 }
-- 
1.5.1.3

-- 
