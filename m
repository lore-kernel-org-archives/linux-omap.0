From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 16/18] omap2: convert DSP code to use new PRCM functions &
	defines
Date: Wed, 16 May 2007 18:11:48 -0600
Message-ID: <20070517005444.675356053@pwsan.com>
References: <20070517001132.652728079@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0016-omap2-convert-DSP-code-to-use-new-PRCM-functions.patch
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

Convert the OMAP2-specific code in plat-omap/dsp to use the new PRCM
read/write functions and symbolic constants for registers and register
bits.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/dsp/dsp_common.h |   39 ++++++++++++++++++++++++++---------
 arch/arm/plat-omap/dsp/omap2_dsp.h  |    1 -
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-omap/dsp/dsp_common.h b/arch/arm/plat-omap/dsp/dsp_common.h
index 898c9ea..2369dad 100644
--- a/arch/arm/plat-omap/dsp/dsp_common.h
+++ b/arch/arm/plat-omap/dsp/dsp_common.h
@@ -28,6 +28,11 @@
 #include <asm/arch/mmu.h>
 #include "hardware_dsp.h"
 
+#include "../../mach-omap2/prm.h"
+#include "../../mach-omap2/prm_regbits_24xx.h"
+#include "../../mach-omap2/cm.h"
+#include "../../mach-omap2/cm_regbits_24xx.h"
+
 #define DSPSPACE_SIZE	0x1000000
 
 #define omap_set_bit_regw(b,r) \
@@ -97,17 +102,21 @@
 #ifdef CONFIG_ARCH_OMAP2
 /*
  * PRCM / IPI control logic
+ *
+ * REVISIT: these macros should probably be static inline functions
  */
-#define RSTCTRL_RST1_DSP	0x00000001
-#define RSTCTRL_RST2_DSP	0x00000002
 #define __dsp_core_enable() \
-	do { RM_RSTCTRL_DSP &= ~RSTCTRL_RST1_DSP; } while (0)
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     & ~OMAP24XX_RST1_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
 #define __dsp_core_disable() \
-	do { RM_RSTCTRL_DSP |= RSTCTRL_RST1_DSP; } while (0)
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     | OMAP24XX_RST1_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
 #define __dsp_per_enable() \
-	do { RM_RSTCTRL_DSP &= ~RSTCTRL_RST2_DSP; } while (0)
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     & ~OMAP24XX_RST2_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
 #define __dsp_per_disable() \
-	do { RM_RSTCTRL_DSP |= RSTCTRL_RST2_DSP; } while (0)
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     | OMAP24XX_RST2_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
 #endif /* CONFIG_ARCH_OMAP2 */
 
 typedef u32 dsp_long_t;	/* must have ability to carry TADD_ABORTADR */
@@ -150,10 +159,19 @@ static inline void dsp_clk_disable(void) {}
 #elif defined(CONFIG_ARCH_OMAP2)
 static inline void dsp_clk_enable(void)
 {
+	u32 r;
+
 	/*XXX should be handled in mach-omap[1,2] XXX*/
-	PM_PWSTCTRL_DSP = (1 << 18) | (1 << 0);
-	CM_AUTOIDLE_DSP |= (1 << 1);
-	CM_CLKSTCTRL_DSP |= (1 << 0);
+	prm_write_mod_reg(OMAP24XX_FORCESTATE | (1 << OMAP_POWERSTATE_SHIFT),
+			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
+
+	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
+	r |= OMAP2420_AUTO_DSP_IPI;
+	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_AUTOIDLE);
+
+	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
+	r |= OMAP24XX_AUTOSTATE_DSP;
+	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
 
 	clk_enable(dsp_fck_handle);
 	clk_enable(dsp_ick_handle);
@@ -165,7 +183,8 @@ static inline void dsp_clk_disable(void)
 	clk_disable(dsp_ick_handle);
 	clk_disable(dsp_fck_handle);
 
-	PM_PWSTCTRL_DSP = (1 << 18) | (3 << 0);
+	prm_write_mod_reg(OMAP24XX_FORCESTATE | (3 << OMAP_POWERSTATE_SHIFT),
+			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
 }
 #endif
 
diff --git a/arch/arm/plat-omap/dsp/omap2_dsp.h b/arch/arm/plat-omap/dsp/omap2_dsp.h
index 28a98ad..2e90835 100644
--- a/arch/arm/plat-omap/dsp/omap2_dsp.h
+++ b/arch/arm/plat-omap/dsp/omap2_dsp.h
@@ -32,7 +32,6 @@
 #endif
 
 #include <asm/arch/hardware.h>
-#include "../../mach-omap2/prcm-regs.h"
 
 /*
  * DSP IPI registers: mapped to 0xe1000000 -- use readX(), writeX()
-- 
1.5.1.3

-- 
