From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] omap2 clock: move SDRC autorefresh counter defines into
	sdrc.h
Date: Wed, 12 Sep 2007 00:01:42 -0600
Message-ID: <20070912063300.632097641@pwsan.com>
References: <20070912060141.645853958@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=move-sdrc-rfr-defines-to-sdrc.patch
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

Move the SDRC autorefresh counter defines from clock.h into sdrc.h,
a more logical place for them.  Expand the comments to add more explanation
as to how those values are derived.  

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |    2 -
 arch/arm/mach-omap2/clock.h |   62 ++++++++++++++------------------------------
 arch/arm/mach-omap2/sdrc.h  |   31 ++++++++++++++++++++++
 3 files changed, 52 insertions(+), 43 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/sdrc.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/sdrc.h	2007-09-05 02:07:47.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/sdrc.h	2007-09-05 02:07:48.000000000 -0600
@@ -46,4 +46,35 @@
 	return __raw_readl(OMAP_SDRC_REGADDR(reg));
 }
 
+/*
+ * These values represent the number of memory clock cycles between
+ * autorefresh initiation.  They assume 1 refresh per 64 ms (JEDEC), 8192
+ * rows per device, and include a subtraction of a 50 cycle window in the
+ * event that the autorefresh command is delayed due to other SDRC activity.
+ * The '| 1' sets the ARE field to send one autorefresh when the autorefresh
+ * counter reaches 0.
+ *
+ * These represent optimal values for common parts, it won't work for all.
+ * As long as you scale down, most parameters are still work, they just
+ * become sub-optimal. The RFR value goes in the opposite direction. If you
+ * don't adjust it down as your clock period increases the refresh interval
+ * will not be met. Setting all parameters for complete worst case may work,
+ * but may cut memory performance by 2x. Due to errata the DLLs need to be
+ * unlocked and their value needs run time calibration.	A dynamic call is
+ * need for that as no single right value exists acorss production samples.
+ *
+ * Only the FULL speed values are given. Current code is such that rate
+ * changes must be made at DPLLoutx2. The actual value adjustment for low
+ * frequency operation will be handled by omap_set_performance()
+ *
+ * By having the boot loader boot up in the fastest L4 speed available likely
+ * will result in something which you can switch between.
+ */
+#define SDRC_RFR_CTRL_165MHz	(0x00044c00 | 1)
+#define SDRC_RFR_CTRL_133MHz	(0x0003de00 | 1)
+#define SDRC_RFR_CTRL_100MHz	(0x0002da01 | 1)
+#define SDRC_RFR_CTRL_110MHz	(0x0002da01 | 1) /* Need to calc */
+#define SDRC_RFR_CTRL_BYPASS	(0x00005000 | 1) /* Need to calc */
+
+
 #endif
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-09-05 02:07:47.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-09-05 02:07:48.000000000 -0600
@@ -623,7 +623,7 @@
 		tmpset.cm_clksel1_pll |= (mult << mask_to_shift(dd->div1_mask));
 
 		/* Worst case */
-		tmpset.base_sdrc_rfr = V24XX_SDRC_RFR_CTRL_BYPASS;
+		tmpset.base_sdrc_rfr = SDRC_RFR_CTRL_BYPASS;
 
 		if (rate == curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
 			bypass = 1;
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2007-09-05 02:07:47.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2007-09-05 02:07:48.000000000 -0600
@@ -25,6 +25,7 @@
 #include "cm.h"
 #include "prm_regbits_24xx.h"
 #include "cm_regbits_24xx.h"
+#include "sdrc.h"
 
 static void omap2_clksel_recalc(struct clk * clk);
 static void omap2_table_mpu_recalc(struct clk *clk);
@@ -368,29 +369,6 @@
 #define MX_CLKSEL2_PLL_2x_VAL		(2 << 0)
 #define MX_CLKSEL2_PLL_1x_VAL		(1 << 0)
 
-/*
- * These represent optimal values for common parts, it won't work for all.
- * As long as you scale down, most parameters are still work, they just
- * become sub-optimal. The RFR value goes in the opposite direction. If you
- * don't adjust it down as your clock period increases the refresh interval
- * will not be met. Setting all parameters for complete worst case may work,
- * but may cut memory performance by 2x. Due to errata the DLLs need to be
- * unlocked and their value needs run time calibration.	A dynamic call is
- * need for that as no single right value exists acorss production samples.
- *
- * Only the FULL speed values are given. Current code is such that rate
- * changes must be made at DPLLoutx2. The actual value adjustment for low
- * frequency operation will be handled by omap_set_performance()
- *
- * By having the boot loader boot up in the fastest L4 speed available likely
- * will result in something which you can switch between.
- */
-#define V24XX_SDRC_RFR_CTRL_165MHz	(0x00044c00 | 1)
-#define V24XX_SDRC_RFR_CTRL_133MHz	(0x0003de00 | 1)
-#define V24XX_SDRC_RFR_CTRL_100MHz	(0x0002da01 | 1)
-#define V24XX_SDRC_RFR_CTRL_110MHz	(0x0002da01 | 1) /* Need to calc */
-#define V24XX_SDRC_RFR_CTRL_BYPASS	(0x00005000 | 1) /* Need to calc */
-
 /* MPU speed defines */
 #define S12M	12000000
 #define S13M	13000000
@@ -432,73 +410,73 @@
 	{S12M, S660M, S330M, RI_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
 		RI_CM_CLKSEL_DSP_VAL, RI_CM_CLKSEL_GFX_VAL,
 		RI_CM_CLKSEL1_CORE_VAL, MI_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_165MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_165MHz,
 		RATE_IN_242X},
 
 	/* PRCM II - FAST */
 	{S12M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
 		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
 		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
 		RATE_IN_242X},
 
 	{S13M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
 		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
 		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
 		RATE_IN_242X},
 
 	/* PRCM III - FAST */
 	{S12M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
 		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
 		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
 		RATE_IN_242X},
 
 	{S13M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
 		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
 		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
 		RATE_IN_242X},
 
 	/* PRCM II - SLOW */
 	{S12M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
 		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
 		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
 		RATE_IN_242X},
 
 	{S13M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
 		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
 		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
 		RATE_IN_242X},
 
 	/* PRCM III - SLOW */
 	{S12M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
 		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
 		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
 		RATE_IN_242X},
 
 	{S13M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
 		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
 		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
 		RATE_IN_242X},
 
 	/* PRCM-VII (boot-bypass) */
 	{S12M, S12M, S12M, RVII_CM_CLKSEL_MPU_VAL,		/* 12MHz ARM*/
 		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
 		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_BYPASS,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_BYPASS,
 		RATE_IN_242X},
 
 	/* PRCM-VII (boot-bypass) */
 	{S13M, S13M, S13M, RVII_CM_CLKSEL_MPU_VAL,		/* 13MHz ARM */
 		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
 		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_BYPASS,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_BYPASS,
 		RATE_IN_242X},
 
 	/* PRCM #3 - ratio2 (ES2) - FAST */
@@ -506,7 +484,7 @@
 		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
 		R2_CM_CLKSEL1_CORE_VAL, M3_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, R2_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_110MHz,
+		SDRC_RFR_CTRL_110MHz,
 		RATE_IN_243X},
 
 	/* PRCM #5a - ratio1 - FAST */
@@ -514,7 +492,7 @@
 		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
 		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_133MHz,
+		SDRC_RFR_CTRL_133MHz,
 		RATE_IN_243X},
 
 	/* PRCM #5b - ratio1 - FAST */
@@ -522,7 +500,7 @@
 		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
 		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_100MHz,
+		SDRC_RFR_CTRL_100MHz,
 		RATE_IN_243X},
 
 	/* PRCM #3 - ratio2 (ES2) - SLOW */
@@ -530,7 +508,7 @@
 		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
 		R2_CM_CLKSEL1_CORE_VAL, M3_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_1x_VAL, R2_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_110MHz,
+		SDRC_RFR_CTRL_110MHz,
 		RATE_IN_243X},
 
 	/* PRCM #5a - ratio1 - SLOW */
@@ -538,7 +516,7 @@
 		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
 		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_133MHz,
+		SDRC_RFR_CTRL_133MHz,
 		RATE_IN_243X},
 
 	/* PRCM #5b - ratio1 - SLOW*/
@@ -546,7 +524,7 @@
 		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
 		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_100MHz,
+		SDRC_RFR_CTRL_100MHz,
 		RATE_IN_243X},
 
 	/* PRCM-boot/bypass */
@@ -554,7 +532,7 @@
 		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
 		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_BYPASS,
+		SDRC_RFR_CTRL_BYPASS,
 		RATE_IN_243X},
 
 	/* PRCM-boot/bypass */
@@ -562,7 +540,7 @@
 		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
 		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_12_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_BYPASS,
+		SDRC_RFR_CTRL_BYPASS,
 		RATE_IN_243X},
 
 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},

-- 
