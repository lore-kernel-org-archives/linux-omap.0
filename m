From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: Use known good PRCM rate-table entries for 2430
Date: Wed, 24 Oct 2007 17:52:59 -0700
Message-ID: <20071025005259.658741340@mvista.com>
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

Follow the lead of the TI kernels by removing PRCM #2 and adding PRCM
#3 and #4 to the rate-table entries.  According to TI, having #2 and
#3 together is known to be a bad combination.

Also, change the default divider values for the PRCM #5a setting to
match those of the TI kernel, which use 264MHz intstead of 266.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/clock24xx.h |  102 ++++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 18 deletions(-)

Index: dev/arch/arm/mach-omap2/clock24xx.h
===================================================================
--- dev.orig/arch/arm/mach-omap2/clock24xx.h
+++ dev/arch/arm/mach-omap2/clock24xx.h
@@ -244,7 +244,6 @@ struct prcm_config {
 
 /*
  * 2430 - standalone, 2*ref*M/(n+1), M/N is for exactness not relock speed
- * #2	(ratio1) baseport-target
  * #5a	(ratio1) baseport-target, target DPLL = 266*2 = 532MHz
  */
 #define M5A_DPLL_MULT_12		(133 << 12)
@@ -252,13 +251,13 @@ struct prcm_config {
 #define M5A_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M5A_DPLL_DIV_12 | M5A_DPLL_MULT_12 | \
 					MX_APLLS_CLIKIN_12
-#define M5A_DPLL_MULT_13		(266 << 12)
-#define M5A_DPLL_DIV_13			(12 << 8)
+#define M5A_DPLL_MULT_13		(61 << 12)
+#define M5A_DPLL_DIV_13			(2 << 8)
 #define M5A_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M5A_DPLL_DIV_13 | M5A_DPLL_MULT_13 | \
 					MX_APLLS_CLIKIN_13
-#define M5A_DPLL_MULT_19		(180 << 12)
-#define M5A_DPLL_DIV_19			(12 << 8)
+#define M5A_DPLL_MULT_19		(55 << 12)
+#define M5A_DPLL_DIV_19			(3 << 8)
 #define M5A_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M5A_DPLL_DIV_19 | M5A_DPLL_MULT_19 | \
 					MX_APLLS_CLIKIN_19_2
@@ -280,7 +279,27 @@ struct prcm_config {
 					M5B_DPLL_DIV_19 | M5B_DPLL_MULT_19 | \
 					MX_APLLS_CLIKIN_19_2
 /*
- * #4	(ratio2)
+ * #4	(ratio2), DPLL = 399*2 = 798MHz, L3=133MHz
+ */
+#define M4_DPLL_MULT_12			(133 << 12)
+#define M4_DPLL_DIV_12			(3 << 8)
+#define M4_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M4_DPLL_DIV_12 | M4_DPLL_MULT_12 | \
+					MX_APLLS_CLIKIN_12
+
+#define M4_DPLL_MULT_13			(399 << 12)
+#define M4_DPLL_DIV_13			(12 << 8)
+#define M4_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M4_DPLL_DIV_13 | M4_DPLL_MULT_13 | \
+					MX_APLLS_CLIKIN_13
+
+#define M4_DPLL_MULT_19			(145 << 12)
+#define M4_DPLL_DIV_19			(6 << 8)
+#define M4_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M4_DPLL_DIV_19 | M4_DPLL_MULT_19 | \
+					MX_APLLS_CLIKIN_19_2
+
+/*
  * #3	(ratio2) baseport-target, target DPLL = 330*2 = 660MHz
  */
 #define M3_DPLL_MULT_12			(55 << 12)
@@ -288,16 +307,41 @@ struct prcm_config {
 #define M3_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M3_DPLL_DIV_12 | M3_DPLL_MULT_12 | \
 					MX_APLLS_CLIKIN_12
-#define M3_DPLL_MULT_13			(330 << 12)
-#define M3_DPLL_DIV_13			(12 << 8)
+#define M3_DPLL_MULT_13			(76 << 12)
+#define M3_DPLL_DIV_13			(2 << 8)
 #define M3_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M3_DPLL_DIV_13 | M3_DPLL_MULT_13 | \
 					MX_APLLS_CLIKIN_13
-#define M3_DPLL_MULT_19			(275 << 12)
-#define M3_DPLL_DIV_19			(15 << 8)
+#define M3_DPLL_MULT_19			(17 << 12)
+#define M3_DPLL_DIV_19			(0 << 8)
 #define M3_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M3_DPLL_DIV_19 | M3_DPLL_MULT_19 | \
 					MX_APLLS_CLIKIN_19_2
+
+/*
+ * #2   (ratio1) DPLL = 330*2 = 660MHz, L3=165MHz
+ */
+#define M2_DPLL_MULT_12		        (55 << 12)
+#define M2_DPLL_DIV_12		        (1 << 8)
+#define M2_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M2_DPLL_DIV_12 | M2_DPLL_MULT_12 | \
+					MX_APLLS_CLIKIN_12
+
+/* Speed changes - Used 658.7MHz instead of 660MHz for LP-Refresh M=76 N=2,
+ * relock time issue */
+/* Core frequency changed from 330/165 to 329/164 MHz*/
+#define M2_DPLL_MULT_13		        (76 << 12)
+#define M2_DPLL_DIV_13		        (2 << 8)
+#define M2_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M2_DPLL_DIV_13 | M2_DPLL_MULT_13 | \
+					MX_APLLS_CLIKIN_13
+
+#define M2_DPLL_MULT_19		        (17 << 12)
+#define M2_DPLL_DIV_19		        (0 << 8)
+#define M2_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M2_DPLL_DIV_19 | M2_DPLL_MULT_19 | \
+					MX_APLLS_CLIKIN_19_2
+
 /* boot (boot) */
 #define MB_DPLL_MULT			(1 << 12)
 #define MB_DPLL_DIV			(0 << 8)
@@ -370,15 +414,21 @@ struct prcm_config {
 #define S100M	100000000
 #define S133M	133000000
 #define S150M	150000000
+#define S164M	164000000
 #define S165M	165000000
+#define S199M	199000000
 #define S200M	200000000
 #define S266M	266000000
 #define S300M	300000000
+#define S329M	329000000
 #define S330M	330000000
+#define S399M	399000000
 #define S400M	400000000
 #define S532M	532000000
 #define S600M	600000000
+#define S658M	658000000
 #define S660M	660000000
+#define S798M	798000000
 
 /*-------------------------------------------------------------------------
  * Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
@@ -472,12 +522,20 @@ static struct prcm_config rate_table[] =
 		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_BYPASS,
 		RATE_IN_242X},
 
-	/* PRCM #3 - ratio2 (ES2) - FAST */
-	{S13M, S660M, S330M, R2_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
+	/* PRCM #4 - ratio2 (ES2.1) - FAST */
+	{S13M, S798M, S399M, R2_CM_CLKSEL_MPU_VAL,		/* 399MHz ARM */
 		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
-		R2_CM_CLKSEL1_CORE_VAL, M3_CM_CLKSEL1_PLL_13_VAL,
+		R2_CM_CLKSEL1_CORE_VAL, M4_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, R2_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_110MHz,
+		V24XX_SDRC_RFR_CTRL_133MHz,
+		RATE_IN_243X},
+
+	/* PRCM #2 - ratio1 (ES2) - FAST */
+	{S13M, S658M, S329M, R1_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M2_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		V24XX_SDRC_RFR_CTRL_165MHz,
 		RATE_IN_243X},
 
 	/* PRCM #5a - ratio1 - FAST */
@@ -496,12 +554,20 @@ static struct prcm_config rate_table[] =
 		SDRC_RFR_CTRL_100MHz,
 		RATE_IN_243X},
 
-	/* PRCM #3 - ratio2 (ES2) - SLOW */
-	{S13M, S330M, S165M, R2_CM_CLKSEL_MPU_VAL,		/* 165MHz ARM */
+	/* PRCM #4 - ratio1 (ES2.1) - SLOW */
+	{S13M, S399M, S199M, R2_CM_CLKSEL_MPU_VAL,		/* 200MHz ARM */
 		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
-		R2_CM_CLKSEL1_CORE_VAL, M3_CM_CLKSEL1_PLL_13_VAL,
+		R2_CM_CLKSEL1_CORE_VAL, M4_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_1x_VAL, R2_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_110MHz,
+		V24XX_SDRC_RFR_CTRL_133MHz,
+		RATE_IN_243X},
+
+	/* PRCM #2 - ratio1 (ES2) - SLOW */
+	{S13M, S329M, S164M, R1_CM_CLKSEL_MPU_VAL,		/* 165MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M2_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		V24XX_SDRC_RFR_CTRL_165MHz,
 		RATE_IN_243X},
 
 	/* PRCM #5a - ratio1 - SLOW */
--
