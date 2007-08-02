From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/22] omap2 clock: move SDRC-related code from clock.c to
	memory.c
Date: Thu, 02 Aug 2007 12:10:11 -0600
Message-ID: <20070802181142.338459740@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=cleanup-clock.c-sdrc.patch
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

The clock framework contains two functions, omap2_dll_force_needed()
and omap2_reprogram_sdrc(), which are SDRC code, not really clock
code.  So, move these functions to memory.c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |   72 +++++---------------------------------
 arch/arm/mach-omap2/memory.c      |   50 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/memory.h      |    2 +
 include/asm-arm/arch-omap/clock.h |    6 +++
 4 files changed, 68 insertions(+), 62 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -35,7 +35,6 @@
 #include "prm_regbits_24xx.h"
 #include "cm.h"
 #include "cm_regbits_24xx.h"
-#include "sdrc.h"
 
 #undef DEBUG
 
@@ -43,10 +42,6 @@
 #define CLKSEL_VLYNQ_96MHZ		0
 #define CLKSEL_VLYNQ_CORECLK_16		0x10
 
-/* SET_PERFORMANCE_LEVEL PARAMETERS */
-#define PRCM_HALF_SPEED		1
-#define PRCM_FULL_SPEED		2
-
 //#define DOWN_VARIABLE_DPLL 1			/* Experimental */
 
 static struct prcm_config *curr_prcm_set;
@@ -482,53 +477,6 @@ static long omap2_clk_round_rate(struct 
 	return clk->rate;
 }
 
-/*
- * Check the DLL lock state, and return tue if running in unlock mode.
- * This is needed to compensate for the shifted DLL value in unlock mode.
- */
-static u32 omap2_dll_force_needed(void)
-{
-	/* dlla and dllb are a set */
-	u32 dll_state = sdrc_read_reg(SDRC_DLLA_CTRL);
-
-	if ((dll_state & (1 << 2)) == (1 << 2))
-		return 1;
-	else
-		return 0;
-}
-
-static u32 omap2_reprogram_sdrc(u32 level, u32 force)
-{
-	u32 slow_dll_ctrl, fast_dll_ctrl, m_type;
-	u32 prev = curr_perf_level, flags;
-
-	if ((curr_perf_level == level) && !force)
-		return prev;
-
-	m_type = omap2_memory_get_type();
-	slow_dll_ctrl = omap2_memory_get_slow_dll_ctrl();
-	fast_dll_ctrl = omap2_memory_get_fast_dll_ctrl();
-
-	if (level == PRCM_HALF_SPEED) {
-		local_irq_save(flags);
-		prm_write_reg(0xffff, OMAP24XX_PRCM_VOLTSETUP);
-		omap2_sram_reprogram_sdrc(PRCM_HALF_SPEED,
-					  slow_dll_ctrl, m_type);
-		curr_perf_level = PRCM_HALF_SPEED;
-		local_irq_restore(flags);
-	}
-	if (level == PRCM_FULL_SPEED) {
-		local_irq_save(flags);
-		prm_write_reg(0xffff, OMAP24XX_PRCM_VOLTSETUP);
-		omap2_sram_reprogram_sdrc(PRCM_FULL_SPEED,
-					  fast_dll_ctrl, m_type);
-		curr_perf_level = PRCM_FULL_SPEED;
-		local_irq_restore(flags);
-	}
-
-	return prev;
-}
-
 static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate)
 {
 	u32 flags, cur_rate, low, mult, div, valid_rate, done_rate;
@@ -542,9 +490,9 @@ static int omap2_reprogram_dpll(struct c
 	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
 
 	if ((rate == (cur_rate / 2)) && (mult == 2)) {
-		omap2_reprogram_sdrc(PRCM_HALF_SPEED, 1);
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL, 1);
 	} else if ((rate == (cur_rate * 2)) && (mult == 1)) {
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1);
 	} else if (rate != cur_rate) {
 		valid_rate = omap2_dpll_round_rate(rate);
 		if (valid_rate != rate)
@@ -564,11 +512,11 @@ static int omap2_reprogram_dpll(struct c
 		if (rate > low) {
 			tmpset.cm_clksel2_pll |= 0x2;
 			mult = ((rate / 2) / 1000000);
-			done_rate = PRCM_FULL_SPEED;
+			done_rate = CORE_CLK_SRC_DPLL_X2;
 		} else {
 			tmpset.cm_clksel2_pll |= 0x1;
 			mult = (rate / 1000000);
-			done_rate = PRCM_HALF_SPEED;
+			done_rate = CORE_CLK_SRC_DPLL;
 		}
 		tmpset.cm_clksel1_pll |= (div << OMAP24XX_DPLL_DIV_SHIFT);
 		tmpset.cm_clksel1_pll |= (mult << OMAP24XX_DPLL_MULT_SHIFT);
@@ -579,7 +527,7 @@ static int omap2_reprogram_dpll(struct c
 		if (rate == curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
 			bypass = 1;
 
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1); /* For init_mem */
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1); /* For init_mem */
 
 		/* Force dll lock mode */
 		omap2_set_prcm(tmpset.cm_clksel1_pll, tmpset.base_sdrc_rfr,
@@ -1039,9 +987,9 @@ static int omap2_select_table_rate(struc
 	cur_rate = omap2_get_dpll_rate(&dpll_ck);
 
 	if (prcm->dpll_speed == cur_rate / 2) {
-		omap2_reprogram_sdrc(PRCM_HALF_SPEED, 1);
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL, 1);
 	} else if (prcm->dpll_speed == cur_rate * 2) {
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1);
 	} else if (prcm->dpll_speed != cur_rate) {
 		local_irq_save(flags);
 
@@ -1049,9 +997,9 @@ static int omap2_select_table_rate(struc
 			bypass = 1;
 
 		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) == 2)
-			done_rate = PRCM_FULL_SPEED;
+			done_rate = CORE_CLK_SRC_DPLL_X2;
 		else
-			done_rate = PRCM_HALF_SPEED;
+			done_rate = CORE_CLK_SRC_DPLL;
 
 		/* MPU divider */
 		cm_write_mod_reg(prcm->cm_clksel_mpu, MPU_MOD, CM_CLKSEL);
@@ -1070,7 +1018,7 @@ static int omap2_select_table_rate(struc
 					 OMAP2430_MDM_MOD, CM_CLKSEL);
 
 		/* x2 to enter init_mem */
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1);
 
 		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
 			       bypass);
Index: linux-omap/arch/arm/mach-omap2/memory.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/memory.c
+++ linux-omap/arch/arm/mach-omap2/memory.c
@@ -27,12 +27,15 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
 
+#include "prm.h"
+
 #include "memory.h"
 #include "sdrc.h"
 
 #define SMS_SYSCONFIG			(OMAP2_SMS_BASE + 0x010)
 
 static struct memory_timings mem_timings;
+static u32 curr_perf_level = CORE_CLK_SRC_DPLL_X2;
 
 u32 omap2_memory_get_slow_dll_ctrl(void)
 {
@@ -49,6 +52,53 @@ u32 omap2_memory_get_type(void)
 	return mem_timings.m_type;
 }
 
+/*
+ * Check the DLL lock state, and return tue if running in unlock mode.
+ * This is needed to compensate for the shifted DLL value in unlock mode.
+ */
+u32 omap2_dll_force_needed(void)
+{
+	/* dlla and dllb are a set */
+	u32 dll_state = sdrc_read_reg(SDRC_DLLA_CTRL);
+
+	if ((dll_state & (1 << 2)) == (1 << 2))
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * 'level' is the value to store to CM_CLKSEL2_PLL.CORE_CLK_SRC.
+ * Practical values are CORE_CLK_SRC_DPLL (for CORE_CLK = DPLL_CLK) or
+ * CORE_CLK_SRC_DPLL_X2 (for CORE_CLK = * DPLL_CLK * 2)
+ */
+u32 omap2_reprogram_sdrc(u32 level, u32 force)
+{
+	u32 dll_ctrl, m_type;
+	u32 prev = curr_perf_level, flags;
+
+	if ((curr_perf_level == level) && !force)
+		return prev;
+
+	if (level == CORE_CLK_SRC_DPLL) {
+		dll_ctrl = omap2_memory_get_slow_dll_ctrl();
+	} else if (level == CORE_CLK_SRC_DPLL_X2) {
+		dll_ctrl = omap2_memory_get_fast_dll_ctrl();
+	} else {
+		return prev;
+	}
+
+	m_type = omap2_memory_get_type();
+
+	local_irq_save(flags);
+	prm_write_reg(0xffff, OMAP24XX_PRCM_VOLTSETUP);
+	omap2_sram_reprogram_sdrc(level, dll_ctrl, m_type);
+	curr_perf_level = level;
+	local_irq_restore(flags);
+
+	return prev;
+}
+
 void omap2_init_memory_params(u32 force_lock_to_unlock_mode)
 {
 	unsigned long dll_cnt;
Index: linux-omap/arch/arm/mach-omap2/memory.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/memory.h
+++ linux-omap/arch/arm/mach-omap2/memory.h
@@ -32,3 +32,5 @@ extern void omap2_init_memory_params(u32
 extern u32 omap2_memory_get_slow_dll_ctrl(void);
 extern u32 omap2_memory_get_fast_dll_ctrl(void);
 extern u32 omap2_memory_get_type(void);
+u32 omap2_dll_force_needed(void);
+u32 omap2_reprogram_sdrc(u32 level, u32 force);
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h
+++ linux-omap/include/asm-arm/arch-omap/clock.h
@@ -89,4 +89,10 @@ extern int clk_get_usecount(struct clk *
 #define CLOCK_IN_OMAP243X	(1 << 26)
 #define CLOCK_IN_OMAP343X	(1 << 27)
 
+
+/* CM_CLKSEL2_PLL.CORE_CLK_SRC options (24XX) */
+#define CORE_CLK_SRC_32K		0
+#define CORE_CLK_SRC_DPLL		1
+#define CORE_CLK_SRC_DPLL_X2		2
+
 #endif

-- 
