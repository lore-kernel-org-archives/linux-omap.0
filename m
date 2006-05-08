From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] Add PRCM scheme I on omap2420
Date: Mon, 08 May 2006 15:02:39 +0900
Message-ID: <038101c67265$02e89c60$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

This patch add PRCM scheme I on omap2420.

The Apollon can run with 660MHz with SDRAM 166MHz.

please check the setting values. 

Thank you
Kyungmin Park

--

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 6c78d47..94ded7b 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -174,7 +174,7 @@ struct prcm_config {
 #define RII_CLKSEL_DSP			(3 << 0)	/* c5x - 200MHz */
 #define RII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 100MHz */
 #define RII_SYNC_DSP			(0 << 7)	/* Bypass sync */
-#define RII_CLKSEL_IVA			(6 << 8)	/* iva1 - 200MHz */
+#define RII_CLKSEL_IVA			(3 << 8)	/* iva1 - 200MHz */
 #define RII_SYNC_IVA			(0 << 13)	/* Bypass sync */
 #define RII_CM_CLKSEL_DSP_VAL		RII_SYNC_IVA | RII_CLKSEL_IVA | \
 					RII_SYNC_DSP | RII_CLKSEL_DSP_IF | \
@@ -182,6 +182,27 @@ struct prcm_config {
 #define RII_CLKSEL_GFX			(2 << 0)	/* 50MHz */
 #define RII_CM_CLKSEL_GFX_VAL		RII_CLKSEL_GFX
 
+/* 2420-PRCM I 660MHz core */
+#define RI_CLKSEL_L3			(4 << 0)	/* 165MHz */
+#define RI_CLKSEL_L4			(2 << 5)	/* 82.5MHz */
+#define RI_CLKSEL_USB			(4 << 25)	/* 41.25MHz */
+#define RI_CM_CLKSEL1_CORE_VAL		RI_CLKSEL_USB | \
+					RXX_CLKSEL_SSI | RXX_CLKSEL_VLYNQ |
\
+					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
+					RI_CLKSEL_L4 | RI_CLKSEL_L3
+#define RI_CLKSEL_MPU			(2 << 0)	/* 330MHz */
+#define RI_CM_CLKSEL_MPU_VAL		RI_CLKSEL_MPU
+#define RI_CLKSEL_DSP			(3 << 0)	/* c5x - 220MHz */
+#define RI_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 110MHz */
+#define RI_SYNC_DSP			(1 << 7)	/* Activate sync */
+#define RI_CLKSEL_IVA			(4 << 8)	/* iva1 - 165MHz */
+#define RI_SYNC_IVA			(0 << 13)	/* Bypass sync */
+#define RI_CM_CLKSEL_DSP_VAL		RI_SYNC_IVA | RI_CLKSEL_IVA | \
+					RI_SYNC_DSP | RI_CLKSEL_DSP_IF | \
+					RI_CLKSEL_DSP
+#define RI_CLKSEL_GFX			(1 << 0)	/* 165MHz */
+#define RI_CM_CLKSEL_GFX_VAL		RI_CLKSEL_GFX
+
 /* 2420-PRCM VII (boot) */
 #define RVII_CLKSEL_L3			(1 << 0)
 #define RVII_CLKSEL_L4			(1 << 5)
@@ -300,6 +321,13 @@ struct prcm_config {
  * boot (boot)
  */
 
+/* PRCM I target DPLL = 2*330MHz = 660MHz */
+#define MI_DPLL_MULT_12			(55 << 12)
+#define MI_DPLL_DIV_12			(1 << 8)
+#define MI_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
+					MI_DPLL_DIV_12 | MI_DPLL_MULT_12 | \
+					MX_APLLS_CLIKIN_12
+
 /*
  * 2420 Equivalent - mode registers
  * PRCM II , target DPLL = 2*300MHz = 600MHz
@@ -352,6 +380,7 @@ struct prcm_config {
  * By having the boot loader boot up in the fastest L4 speed available
likely
  * will result in something which you can switch between.
  */
+#define V24XX_SDRC_RFR_CTRL_166MHz	(0x00044c00 | 1)
 #define V24XX_SDRC_RFR_CTRL_133MHz	(0x0003de00 | 1)
 #define V24XX_SDRC_RFR_CTRL_100MHz	(0x0002da01 | 1)
 #define V24XX_SDRC_RFR_CTRL_110MHz	(0x0002da01 | 1) /* Need to calc */
@@ -394,6 +423,13 @@ struct prcm_config {
  * Note: This table needs to be sorted, fastest to slowest.
  *-------------------------------------------------------------------------
*/
 static struct prcm_config rate_table[] = {
+	/* PRCM I - FAST */
+	{S12M, S660M, S330M, RI_CM_CLKSEL_MPU_VAL,		/* 330MHz
ARM */
+		RI_CM_CLKSEL_DSP_VAL, RI_CM_CLKSEL_GFX_VAL,
+		RI_CM_CLKSEL1_CORE_VAL, MI_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_166MHz,
+		RATE_IN_242X},
+
 	/* PRCM II - FAST */
 	{S12M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz
ARM */
 		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
