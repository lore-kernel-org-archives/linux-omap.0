From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 22/22] omap2 clock: get rid of omap2_followparent_recalc()
Date: Thu, 02 Aug 2007 12:10:24 -0600
Message-ID: <20070802181143.816754386@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=nuke_omap2_followparent_recalc.patch
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

omap2_followparent_recalc() just calls followparent_recalc(), so,
get rid of omap2_followparent_recalc().

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |    5 -
 arch/arm/mach-omap2/clock.h |  205 +++++++++++++++++++++-----------------------
 2 files changed, 102 insertions(+), 108 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -129,11 +129,6 @@ static u32 omap2_get_dpll_rate(struct cl
 	return dpll_clk;
 }
 
-static void omap2_followparent_recalc(struct clk *clk)
-{
-	followparent_recalc(clk);
-}
-
 /*
  * Used for clocks that have the same value as the parent clock,
  * divided by some factor
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -24,7 +24,6 @@
 
 static void omap2_sys_clk_recalc(struct clk * clk);
 static void omap2_clksel_recalc(struct clk * clk);
-static void omap2_followparent_recalc(struct clk * clk);
 static void omap2_propagate_rate(struct clk * clk);
 static void omap2_mpu_recalc(struct clk * clk);
 static int omap2_select_table_rate(struct clk * clk, unsigned long rate);
@@ -716,7 +715,7 @@ static struct clk wdt1_osc_ck = {
 	.name		= "ck_wdt1_osc",
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk sys_clkout = {
@@ -952,7 +951,7 @@ static struct clk gfx_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),	/* bit 0 */
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -979,7 +978,7 @@ static struct clk mdm_osc_ck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP2430_EN_OSC_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -1005,7 +1004,7 @@ static struct clk ssi_l4_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),	/* bit 1 */
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -1022,7 +1021,7 @@ static struct clk dss_ick = {		/* Enable
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk dss1_fck = {
@@ -1046,7 +1045,7 @@ static struct clk dss2_fck = {		/* Alt c
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_DSS2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk dss_54m_fck = {	/* Alt clk used in power management */
@@ -1055,7 +1054,7 @@ static struct clk dss_54m_fck = {	/* Alt
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_TV_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -1070,7 +1069,7 @@ static struct clk gpt1_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),	/* Bit0 */
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt1_fck = {
@@ -1081,7 +1080,7 @@ static struct clk gpt1_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),	/* Bit0 */
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt2_ick = {
@@ -1090,7 +1089,7 @@ static struct clk gpt2_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit4 */
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt2_fck = {
@@ -1101,7 +1100,7 @@ static struct clk gpt2_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt3_ick = {
@@ -1110,7 +1109,7 @@ static struct clk gpt3_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit5 */
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt3_fck = {
@@ -1121,7 +1120,7 @@ static struct clk gpt3_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT3_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt4_ick = {
@@ -1130,7 +1129,7 @@ static struct clk gpt4_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit6 */
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt4_fck = {
@@ -1141,7 +1140,7 @@ static struct clk gpt4_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT4_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt5_ick = {
@@ -1150,7 +1149,7 @@ static struct clk gpt5_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* Bit7 */
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt5_fck = {
@@ -1161,7 +1160,7 @@ static struct clk gpt5_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT5_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt6_ick = {
@@ -1170,7 +1169,7 @@ static struct clk gpt6_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit8 */
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt6_fck = {
@@ -1181,7 +1180,7 @@ static struct clk gpt6_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT6_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt7_ick = {
@@ -1190,7 +1189,7 @@ static struct clk gpt7_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit9 */
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt7_fck = {
@@ -1201,7 +1200,7 @@ static struct clk gpt7_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT7_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt8_ick = {
@@ -1210,7 +1209,7 @@ static struct clk gpt8_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit10 */
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt8_fck = {
@@ -1221,7 +1220,7 @@ static struct clk gpt8_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT8_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt9_ick = {
@@ -1230,7 +1229,7 @@ static struct clk gpt9_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt9_fck = {
@@ -1241,7 +1240,7 @@ static struct clk gpt9_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT9_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt10_ick = {
@@ -1250,7 +1249,7 @@ static struct clk gpt10_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt10_fck = {
@@ -1261,7 +1260,7 @@ static struct clk gpt10_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT10_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt11_ick = {
@@ -1270,7 +1269,7 @@ static struct clk gpt11_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt11_fck = {
@@ -1281,7 +1280,7 @@ static struct clk gpt11_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT11_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt12_ick = {
@@ -1290,7 +1289,7 @@ static struct clk gpt12_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit14 */
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt12_fck = {
@@ -1301,7 +1300,7 @@ static struct clk gpt12_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT12_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 /* REVISIT: bit comment below wrong? */
@@ -1311,7 +1310,7 @@ static struct clk mcbsp1_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit16 */
 	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp1_fck = {
@@ -1320,7 +1319,7 @@ static struct clk mcbsp1_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp2_ick = {
@@ -1329,7 +1328,7 @@ static struct clk mcbsp2_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp2_fck = {
@@ -1338,7 +1337,7 @@ static struct clk mcbsp2_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp3_ick = {
@@ -1347,7 +1346,7 @@ static struct clk mcbsp3_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp3_fck = {
@@ -1356,7 +1355,7 @@ static struct clk mcbsp3_fck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp4_ick = {
@@ -1365,7 +1364,7 @@ static struct clk mcbsp4_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp4_fck = {
@@ -1374,7 +1373,7 @@ static struct clk mcbsp4_fck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp5_ick = {
@@ -1383,7 +1382,7 @@ static struct clk mcbsp5_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp5_fck = {
@@ -1392,7 +1391,7 @@ static struct clk mcbsp5_fck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi1_ick = {
@@ -1402,7 +1401,7 @@ static struct clk mcspi1_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi1_fck = {
@@ -1412,7 +1411,7 @@ static struct clk mcspi1_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi2_ick = {
@@ -1422,7 +1421,7 @@ static struct clk mcspi2_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi2_fck = {
@@ -1432,7 +1431,7 @@ static struct clk mcspi2_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi3_ick = {
@@ -1442,7 +1441,7 @@ static struct clk mcspi3_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi3_fck = {
@@ -1452,7 +1451,7 @@ static struct clk mcspi3_fck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart1_ick = {
@@ -1461,7 +1460,7 @@ static struct clk uart1_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart1_fck = {
@@ -1470,7 +1469,7 @@ static struct clk uart1_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart2_ick = {
@@ -1479,7 +1478,7 @@ static struct clk uart2_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart2_fck = {
@@ -1488,7 +1487,7 @@ static struct clk uart2_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart3_ick = {
@@ -1497,7 +1496,7 @@ static struct clk uart3_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart3_fck = {
@@ -1506,7 +1505,7 @@ static struct clk uart3_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpios_ick = {
@@ -1515,7 +1514,7 @@ static struct clk gpios_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpios_fck = {
@@ -1524,7 +1523,7 @@ static struct clk gpios_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mpu_wdt_ick = {
@@ -1533,7 +1532,7 @@ static struct clk mpu_wdt_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mpu_wdt_fck = {
@@ -1542,7 +1541,7 @@ static struct clk mpu_wdt_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk sync_32k_ick = {
@@ -1551,7 +1550,7 @@ static struct clk sync_32k_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_32KSYNC_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
@@ -1559,7 +1558,7 @@ static struct clk wdt1_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_WDT1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
@@ -1567,7 +1566,7 @@ static struct clk omapctrl_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_OMAPCTRL_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 static struct clk icr_ick = {
 	.name		= "icr_ick",
@@ -1575,7 +1574,7 @@ static struct clk icr_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_EN_ICR_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk cam_ick = {
@@ -1584,7 +1583,7 @@ static struct clk cam_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk cam_fck = {
@@ -1593,7 +1592,7 @@ static struct clk cam_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mailboxes_ick = {
@@ -1602,7 +1601,7 @@ static struct clk mailboxes_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MAILBOXES_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt4_ick = {
@@ -1611,7 +1610,7 @@ static struct clk wdt4_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt4_fck = {
@@ -1620,7 +1619,7 @@ static struct clk wdt4_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt3_ick = {
@@ -1629,7 +1628,7 @@ static struct clk wdt3_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt3_fck = {
@@ -1638,7 +1637,7 @@ static struct clk wdt3_fck = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mspro_ick = {
@@ -1647,7 +1646,7 @@ static struct clk mspro_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mspro_fck = {
@@ -1656,7 +1655,7 @@ static struct clk mspro_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmc_ick = {
@@ -1665,7 +1664,7 @@ static struct clk mmc_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmc_fck = {
@@ -1674,7 +1673,7 @@ static struct clk mmc_fck = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk fac_ick = {
@@ -1683,7 +1682,7 @@ static struct clk fac_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk fac_fck = {
@@ -1692,7 +1691,7 @@ static struct clk fac_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk eac_ick = {
@@ -1701,7 +1700,7 @@ static struct clk eac_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk eac_fck = {
@@ -1710,7 +1709,7 @@ static struct clk eac_fck = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk hdq_ick = {
@@ -1719,7 +1718,7 @@ static struct clk hdq_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk hdq_fck = {
@@ -1728,7 +1727,7 @@ static struct clk hdq_fck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c2_ick = {
@@ -1738,7 +1737,7 @@ static struct clk i2c2_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c2_fck = {
@@ -1748,7 +1747,7 @@ static struct clk i2c2_fck = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2chs2_fck = {
@@ -1758,7 +1757,7 @@ static struct clk i2chs2_fck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_I2CHS2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c1_ick = {
@@ -1768,7 +1767,7 @@ static struct clk i2c1_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c1_fck = {
@@ -1778,7 +1777,7 @@ static struct clk i2c1_fck = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2chs1_fck = {
@@ -1788,7 +1787,7 @@ static struct clk i2chs1_fck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_I2CHS1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk vlynq_ick = {
@@ -1797,7 +1796,7 @@ static struct clk vlynq_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk vlynq_fck = {
@@ -1816,7 +1815,7 @@ static struct clk sdrc_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP2430_CM_ICLKEN3),
 	.enable_bit	= OMAP2430_EN_SDRC_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk des_ick = {
@@ -1825,7 +1824,7 @@ static struct clk des_ick = {
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_DES_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk sha_ick = {
@@ -1834,7 +1833,7 @@ static struct clk sha_ick = {
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_SHA_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk rng_ick = {
@@ -1843,7 +1842,7 @@ static struct clk rng_ick = {
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_RNG_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk aes_ick = {
@@ -1852,7 +1851,7 @@ static struct clk aes_ick = {
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_AES_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk pka_ick = {
@@ -1861,7 +1860,7 @@ static struct clk pka_ick = {
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_PKA_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk usb_fck = {
@@ -1870,7 +1869,7 @@ static struct clk usb_fck = {
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk usbhs_ick = {
@@ -1879,7 +1878,7 @@ static struct clk usbhs_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_USBHS_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs1_ick = {
@@ -1888,7 +1887,7 @@ static struct clk mmchs1_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs1_fck = {
@@ -1897,7 +1896,7 @@ static struct clk mmchs1_fck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs2_ick = {
@@ -1906,7 +1905,7 @@ static struct clk mmchs2_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs2_fck = {
@@ -1915,7 +1914,7 @@ static struct clk mmchs2_fck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpio5_ick = {
@@ -1924,7 +1923,7 @@ static struct clk gpio5_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpio5_fck = {
@@ -1933,7 +1932,7 @@ static struct clk gpio5_fck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mdm_intc_ick = {
@@ -1942,7 +1941,7 @@ static struct clk mdm_intc_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MDM_INTC_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchsdb1_fck = {
@@ -1951,7 +1950,7 @@ static struct clk mmchsdb1_fck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHSDB1_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchsdb2_fck = {
@@ -1960,7 +1959,7 @@ static struct clk mmchsdb2_fck = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHSDB2_SHIFT,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
 };
 
 /*

-- 
