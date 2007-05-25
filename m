From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 13/18] omap2: convert sram-fn.S to use OMAP2_{PRM,
	CM}_BASE rather than OMAP2_PRCM_BASE
Date: Fri, 25 May 2007 02:23:35 -0600
Message-ID: <20070525082502.379307424@pwsan.com>
References: <20070525082322.168056647@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0013-omap2-convert-sram-fn.S-to-use-OMAP2_-PRM-CM-_BASE.patch
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

Use OMAP2_PRM_BASE and OMAP2_CM_BASE in sram-fn.s to prepare for the
OMAP3430 conversion.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/sram-fn.S |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/sram-fn.S b/arch/arm/mach-omap2/sram-fn.S
index b0e8952..9514645 100644
--- a/arch/arm/mach-omap2/sram-fn.S
+++ b/arch/arm/mach-omap2/sram-fn.S
@@ -27,16 +27,14 @@
 #include <asm/arch/io.h>
 #include <asm/hardware.h>
 
-#include "prcm-regs.h"
-
 #define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
 
-#define CM_CLKSEL2_PLL_V	IO_ADDRESS(OMAP2_PRCM_BASE + 0x544)
-#define PRCM_VOLTCTRL_V		IO_ADDRESS(OMAP2_PRCM_BASE + 0x050)
-#define PRCM_CLKCFG_CTRL_V	IO_ADDRESS(OMAP2_PRCM_BASE + 0x080)
-#define CM_CLKEN_PLL_V		IO_ADDRESS(OMAP2_PRCM_BASE + 0x500)
-#define CM_IDLEST_CKGEN_V	IO_ADDRESS(OMAP2_PRCM_BASE + 0x520)
-#define CM_CLKSEL1_PLL_V	IO_ADDRESS(OMAP2_PRCM_BASE + 0x540)
+#define CM_CLKSEL2_PLL_V	IO_ADDRESS(OMAP2_CM_BASE + 0x544)
+#define PRCM_VOLTCTRL_V		IO_ADDRESS(OMAP2_PRM_BASE + 0x050)
+#define PRCM_CLKCFG_CTRL_V	IO_ADDRESS(OMAP2_PRM_BASE + 0x080)
+#define CM_CLKEN_PLL_V		IO_ADDRESS(OMAP2_CM_BASE + 0x500)
+#define CM_IDLEST_CKGEN_V	IO_ADDRESS(OMAP2_CM_BASE + 0x520)
+#define CM_CLKSEL1_PLL_V	IO_ADDRESS(OMAP2_CM_BASE + 0x540)
 
 #define SDRC_DLLA_CTRL_V	IO_ADDRESS(OMAP2_SDRC_BASE + 0x060)
 #define SDRC_RFR_CTRL_V		IO_ADDRESS(OMAP2_SDRC_BASE + 0x0a4)
-- 
1.5.1.3

-- 
