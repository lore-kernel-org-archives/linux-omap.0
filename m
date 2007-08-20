From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 28/28] omap2 clock: handle (almost) all clock autoidling via
	the clock framework
Date: Mon, 20 Aug 2007 03:54:15 -0600
Message-ID: <20070820095532.728389316@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=use_clk_framework_autoidle.patch
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

Existing OMAP2 code autoidles clocks via pm.c.  OMAP clock framework
already has some support for enabling autoidle mode via the allow_idle
function; however, this is currently unused.  Take advantage of this
support by adding autoidle register and bit information for each
clock, defining an omap2_clk_allow_idle() function, and adding a
framework-wide function, clk_allow_idle_all(), to autoidle all clocks,
intended to be called on init.  Remove all but the APLL/DPLL autoidle 
bit twiddling from pm.c -- we don't yet have generalized support for APLL
autoidle.  Handling autoidle via the clock framework ensures that we only
touch clocks that are currently configured.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c           |   34 +++++++++++
 arch/arm/mach-omap2/clock.h           |  103 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm_regbits_24xx.h |   50 ++++++++++++++++
 arch/arm/mach-omap2/pm.c              |   63 +-------------------
 arch/arm/plat-omap/clock.c            |    9 ++
 include/asm-arm/arch-omap/clock.h     |    3 
 6 files changed, 204 insertions(+), 58 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -165,6 +165,7 @@ static void omap2_fixed_divisor_recalc(s
 		propagate_rate(clk);
 }
 
+/* REVISIT: This is really autoidle control, not enable/disable */
 static int omap2_enable_osc_ck(struct clk *clk)
 {
 	u32 pcc;
@@ -177,6 +178,7 @@ static int omap2_enable_osc_ck(struct cl
 	return 0;
 }
 
+/* REVISIT: This is really autoidle control, not enable/disable */
 static void omap2_disable_osc_ck(struct clk *clk)
 {
 	u32 pcc;
@@ -1023,6 +1025,34 @@ static int omap2_select_table_rate(struc
 	return 0;
 }
 
+static void omap2_clk_allow_idle(struct clk *clk)
+{
+	u32 regval;
+	u8 shift;
+	const struct dpll_data *dd;
+
+	if (clk->auto_idle_reg) {
+		regval = cm_read_reg(clk->auto_idle_reg);
+
+		if (clk->dpll_data) {
+			/* Special handling for DPLLs */
+
+			dd = clk->dpll_data;
+			if (!dd->auto_idle_mask || !dd->auto_idle_val)
+				return;
+
+			shift = convert_mask_to_shift(dd->auto_idle_mask);
+			regval &= dd->auto_idle_mask;
+			regval |= dd->auto_idle_val << shift;
+
+		} else if (clk->auto_idle_bit) {
+			regval |= (1 << clk->auto_idle_bit);
+		}
+
+		cm_write_reg(regval, clk->auto_idle_reg);
+	}
+}
+
 /*-------------------------------------------------------------------------
  * Omap2 clock reset and init functions
  *-------------------------------------------------------------------------*/
@@ -1049,6 +1079,7 @@ static struct clk_functions omap2_clk_fu
 	.clk_round_rate		= omap2_clk_round_rate,
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
+	.clk_allow_idle		= omap2_clk_allow_idle,
 	.clk_disable_unused	= omap2_clk_disable_unused,
 };
 
@@ -1184,6 +1215,9 @@ int __init omap2_clk_init(void)
 	 */
 	clk_enable_init_clocks();
 
+	/* Autoidle all clocks that can be autoidled */
+	clk_allow_idle_all();
+
 	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
 	vclk = clk_get(NULL, "virt_prcm_set");
 	sclk = clk_get(NULL, "sys_ck");
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -1204,6 +1204,8 @@ static struct clk usb_l4_ick = {	/* FS-U
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_USB_MASK,
 	.clksel		= usb_l4_ick_clksel,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE2),
+	.auto_idle_bit	= OMAP24XX_AUTO_USB_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate
@@ -1395,6 +1397,8 @@ static struct clk ssi_l4_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),	/* bit 1 */
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE2),
+	.auto_idle_bit	= OMAP24XX_AUTO_SSI_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1439,6 +1443,8 @@ static struct clk dss_ick = {		/* Enable
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_DSS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1555,6 +1561,8 @@ static struct clk gpt2_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit4 */
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPT2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1577,6 +1585,8 @@ static struct clk gpt3_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit5 */
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPT3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1599,6 +1609,8 @@ static struct clk gpt4_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	/* Bit6 */
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPT4_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1621,6 +1633,8 @@ static struct clk gpt5_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* Bit7 */
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPT5_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1643,6 +1657,8 @@ static struct clk gpt6_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit8 */
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPT6_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1665,6 +1681,8 @@ static struct clk gpt7_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit9 */
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPT7_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1687,6 +1705,8 @@ static struct clk gpt8_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit10 */
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPT8_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1709,6 +1729,8 @@ static struct clk gpt9_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPT9_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1731,6 +1753,8 @@ static struct clk gpt10_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPT10_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1753,6 +1777,8 @@ static struct clk gpt11_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPT11_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1775,6 +1801,8 @@ static struct clk gpt12_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),	 /* bit14 */
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPT12_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1797,6 +1825,8 @@ static struct clk mcbsp1_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_MCBSP1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1815,6 +1845,8 @@ static struct clk mcbsp2_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_MCBSP2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1833,6 +1865,8 @@ static struct clk mcbsp3_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP2430_AUTO_MCBSP3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1851,6 +1885,8 @@ static struct clk mcbsp4_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE2),
+	.auto_idle_bit	= OMAP2430_AUTO_MCBSP4_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1869,6 +1905,8 @@ static struct clk mcbsp5_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE2),
+	.auto_idle_bit	= OMAP2430_AUTO_MCBSP5_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1888,6 +1926,8 @@ static struct clk mcspi1_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_MCSPI1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1908,6 +1948,8 @@ static struct clk mcspi2_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_MCSPI2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1928,6 +1970,8 @@ static struct clk mcspi3_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE2),
+	.auto_idle_bit	= OMAP2430_AUTO_MCSPI3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1947,6 +1991,8 @@ static struct clk uart1_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_UART1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1965,6 +2011,8 @@ static struct clk uart2_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_UART2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1983,6 +2031,8 @@ static struct clk uart3_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE2),
+	.auto_idle_bit	= OMAP24XX_AUTO_UART3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2070,6 +2120,8 @@ static struct clk cam_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_CAM_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2088,6 +2140,8 @@ static struct clk mailboxes_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MAILBOXES_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_MAILBOXES_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2097,6 +2151,8 @@ static struct clk wdt4_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_WDT4_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2115,6 +2171,8 @@ static struct clk wdt3_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP2420_AUTO_WDT3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2133,6 +2191,8 @@ static struct clk mspro_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_MSPRO_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2151,6 +2211,8 @@ static struct clk mmc_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP2420_AUTO_MMC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2169,6 +2231,8 @@ static struct clk fac_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_FAC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2187,6 +2251,8 @@ static struct clk eac_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP2420_AUTO_EAC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2205,6 +2271,8 @@ static struct clk hdq_ick = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_HDQ_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2224,6 +2292,8 @@ static struct clk i2c2_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_I2C2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2254,6 +2324,8 @@ static struct clk i2c1_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP24XX_AUTO_I2C1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2281,6 +2353,8 @@ static struct clk gpmc_fck = {
 	.name		= "gpmc_fck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_AUTOIDLE3),
+	.auto_idle_bit	= OMAP24XX_AUTO_GPMC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2288,6 +2362,8 @@ static struct clk sdma_fck = {
 	.name		= "sdma_fck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_AUTOIDLE3),
+	.auto_idle_bit	= OMAP24XX_AUTO_SDMA_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2295,6 +2371,8 @@ static struct clk sdma_ick = {
 	.name		= "sdma_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_AUTOIDLE3),
+	.auto_idle_bit	= OMAP24XX_AUTO_SDMA_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2304,6 +2382,8 @@ static struct clk vlynq_ick = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE1),
+	.auto_idle_bit	= OMAP2420_AUTO_VLYNQ_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2347,12 +2427,15 @@ static struct clk vlynq_fck = {
 	.set_rate	= &omap2_clksel_set_rate
 };
 
+/* sdrc_ick may also be in recent 2420 ES2 revisions */
 static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP2430_CM_ICLKEN3),
 	.enable_bit	= OMAP2430_EN_SDRC_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_AUTOIDLE3),
+	.auto_idle_bit	= OMAP24XX_AUTO_SDRC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2362,6 +2445,8 @@ static struct clk des_ick = {
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_DES_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_AUTOIDLE4),
+	.auto_idle_bit	= OMAP24XX_AUTO_DES_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2371,6 +2456,8 @@ static struct clk sha_ick = {
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_SHA_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_AUTOIDLE4),
+	.auto_idle_bit	= OMAP24XX_AUTO_SHA_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2380,6 +2467,8 @@ static struct clk rng_ick = {
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_RNG_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_AUTOIDLE4),
+	.auto_idle_bit	= OMAP24XX_AUTO_RNG_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2389,6 +2478,8 @@ static struct clk aes_ick = {
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_AES_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_AUTOIDLE4),
+	.auto_idle_bit	= OMAP24XX_AUTO_AES_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2398,6 +2489,8 @@ static struct clk pka_ick = {
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_PKA_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_AUTOIDLE4),
+	.auto_idle_bit	= OMAP24XX_AUTO_PKA_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2416,6 +2509,8 @@ static struct clk usbhs_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_USBHS_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE2),
+	.auto_idle_bit	= OMAP2430_AUTO_USBHS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2425,6 +2520,8 @@ static struct clk mmchs1_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE2),
+	.auto_idle_bit	= OMAP2430_AUTO_MMCHS1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2443,6 +2540,8 @@ static struct clk mmchs2_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE2),
+	.auto_idle_bit	= OMAP2430_AUTO_MMCHS2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2461,6 +2560,8 @@ static struct clk gpio5_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE2),
+	.auto_idle_bit	= OMAP2430_AUTO_GPIO5_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2479,6 +2580,8 @@ static struct clk mdm_intc_ick = {
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MDM_INTC_SHIFT,
+	.auto_idle_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_AUTOIDLE2),
+	.auto_idle_bit	= OMAP2430_AUTO_MDM_INTC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h
+++ linux-omap/include/asm-arm/arch-omap/clock.h
@@ -62,6 +62,8 @@ struct clk {
 	u32			clksel_mask;
 	const struct clksel	*clksel;
 	const struct dpll_data	*dpll_data;
+	void __iomem		*auto_idle_reg;
+	u8			auto_idle_bit;
 #else
 	__u8			rate_offset;
 	__u8			src_offset;
@@ -92,6 +94,7 @@ extern void clk_allow_idle(struct clk *c
 extern void clk_deny_idle(struct clk *clk);
 extern int clk_get_usecount(struct clk *clk);
 extern void clk_enable_init_clocks(void);
+extern void clk_allow_idle_all(void);
 
 /* Clock flags */
 #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */
Index: linux-omap/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/pm.c
+++ linux-omap/arch/arm/mach-omap2/pm.c
@@ -688,69 +688,16 @@ static void __init prcm_setup_regs(void)
 	cm_write_mod_reg(OMAP2420_AUTOSTATE_IVA | OMAP24XX_AUTOSTATE_DSP,
 			 OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
 
-	/* Enable clock autoidle for all domains */
-	cm_write_mod_reg(OMAP24XX_AUTO_CAM |
-			 OMAP24XX_AUTO_MAILBOXES |
-			 OMAP24XX_AUTO_WDT4 |
-			 OMAP2420_AUTO_WDT3 |
-			 OMAP24XX_AUTO_MSPRO |
-			 OMAP2420_AUTO_MMC |
-			 OMAP24XX_AUTO_FAC |
-			 OMAP2420_AUTO_EAC |
-			 OMAP24XX_AUTO_HDQ |
-			 OMAP24XX_AUTO_UART2 |
-			 OMAP24XX_AUTO_UART1 |
-			 OMAP24XX_AUTO_I2C2 |
-			 OMAP24XX_AUTO_I2C1 |
-			 OMAP24XX_AUTO_MCSPI2 |
-			 OMAP24XX_AUTO_MCSPI1 |
-			 OMAP24XX_AUTO_MCBSP2 |
-			 OMAP24XX_AUTO_MCBSP1 |
-			 OMAP24XX_AUTO_GPT12 |
-			 OMAP24XX_AUTO_GPT11 |
-			 OMAP24XX_AUTO_GPT10 |
-			 OMAP24XX_AUTO_GPT9 |
-			 OMAP24XX_AUTO_GPT8 |
-			 OMAP24XX_AUTO_GPT7 |
-			 OMAP24XX_AUTO_GPT6 |
-			 OMAP24XX_AUTO_GPT5 |
-			 OMAP24XX_AUTO_GPT4 |
-			 OMAP24XX_AUTO_GPT3 |
-			 OMAP24XX_AUTO_GPT2 |
-			 OMAP2420_AUTO_VLYNQ |
-			 OMAP24XX_AUTO_DSS,
-			 CORE_MOD, CM_AUTOIDLE1);
-	cm_write_mod_reg(OMAP24XX_AUTO_UART3 |
-			 OMAP24XX_AUTO_SSI |
-			 OMAP24XX_AUTO_USB,
-			 CORE_MOD, CM_AUTOIDLE2);
-	cm_write_mod_reg(OMAP24XX_AUTO_SDRC |
-			 OMAP24XX_AUTO_GPMC |
-			 OMAP24XX_AUTO_SDMA,
-			 CORE_MOD, OMAP24XX_CM_AUTOIDLE3);
-	cm_write_mod_reg(OMAP24XX_AUTO_PKA |
-			 OMAP24XX_AUTO_AES |
-			 OMAP24XX_AUTO_RNG |
-			 OMAP24XX_AUTO_SHA |
-			 OMAP24XX_AUTO_DES,
-			 CORE_MOD, OMAP24XX_CM_AUTOIDLE4);
-
-	cm_write_mod_reg(OMAP2420_AUTO_DSP_IPI, OMAP24XX_DSP_MOD, CM_AUTOIDLE);
-
-	/* Put DPLL and both APLLs into autoidle mode */
+	/*
+	 * Put DPLL and both APLLs into autoidle mode
+	 * REVISIT: we don't handle APLL autoidle yet in the clock framework,
+	 * so we leave this here
+	 */
 	cm_write_mod_reg((0x03 << OMAP24XX_AUTO_DPLL_SHIFT) |
 			 (0x03 << OMAP24XX_AUTO_96M_SHIFT) |
 			 (0x03 << OMAP24XX_AUTO_54M_SHIFT),
 			 PLL_MOD, CM_AUTOIDLE);
 
-	cm_write_mod_reg(OMAP24XX_AUTO_OMAPCTRL |
-			 OMAP24XX_AUTO_WDT1 |
-			 OMAP24XX_AUTO_MPU_WDT |
-			 OMAP24XX_AUTO_GPIOS |
-			 OMAP24XX_AUTO_32KSYNC |
-			 OMAP24XX_AUTO_GPT1,
-			 WKUP_MOD, CM_AUTOIDLE);
-
 	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
 	 * stabilisation */
 	prm_write_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_PRCM_CLKSSETUP);
Index: linux-omap/arch/arm/plat-omap/clock.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/clock.c
+++ linux-omap/arch/arm/plat-omap/clock.c
@@ -383,6 +383,15 @@ void clk_allow_idle(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_allow_idle);
 
+void clk_allow_idle_all(void)
+{
+	struct clk *clkp;
+
+	list_for_each_entry(clkp, &clocks, node)
+		clk_allow_idle(clkp);
+}
+EXPORT_SYMBOL(clk_allow_idle_all);
+
 void clk_enable_init_clocks(void)
 {
 	struct clk *clkp;
Index: linux-omap/arch/arm/mach-omap2/cm_regbits_24xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/cm_regbits_24xx.h
+++ linux-omap/arch/arm/mach-omap2/cm_regbits_24xx.h
@@ -141,61 +141,111 @@
 
 /* CM_AUTOIDLE1_CORE */
 #define OMAP24XX_AUTO_CAM				(1 << 31)
+#define OMAP24XX_AUTO_CAM_SHIFT				31
 #define OMAP24XX_AUTO_MAILBOXES				(1 << 30)
+#define OMAP24XX_AUTO_MAILBOXES_SHIFT			30
 #define OMAP24XX_AUTO_WDT4				(1 << 29)
+#define OMAP24XX_AUTO_WDT4_SHIFT			29
 #define OMAP2420_AUTO_WDT3				(1 << 28)
+#define OMAP2420_AUTO_WDT3_SHIFT			28
 #define OMAP24XX_AUTO_MSPRO				(1 << 27)
+#define OMAP24XX_AUTO_MSPRO_SHIFT			27
 #define OMAP2420_AUTO_MMC				(1 << 26)
+#define OMAP2420_AUTO_MMC_SHIFT				26
 #define OMAP24XX_AUTO_FAC				(1 << 25)
+#define OMAP24XX_AUTO_FAC_SHIFT				25
 #define OMAP2420_AUTO_EAC				(1 << 24)
+#define OMAP2420_AUTO_EAC_SHIFT				24
 #define OMAP24XX_AUTO_HDQ				(1 << 23)
+#define OMAP24XX_AUTO_HDQ_SHIFT				23
 #define OMAP24XX_AUTO_UART2				(1 << 22)
+#define OMAP24XX_AUTO_UART2_SHIFT			22
 #define OMAP24XX_AUTO_UART1				(1 << 21)
+#define OMAP24XX_AUTO_UART1_SHIFT			21
 #define OMAP24XX_AUTO_I2C2				(1 << 20)
+#define OMAP24XX_AUTO_I2C2_SHIFT			20
 #define OMAP24XX_AUTO_I2C1				(1 << 19)
+#define OMAP24XX_AUTO_I2C1_SHIFT			19
 #define OMAP24XX_AUTO_MCSPI2				(1 << 18)
+#define OMAP24XX_AUTO_MCSPI2_SHIFT			18
 #define OMAP24XX_AUTO_MCSPI1				(1 << 17)
+#define OMAP24XX_AUTO_MCSPI1_SHIFT			17
 #define OMAP24XX_AUTO_MCBSP2				(1 << 16)
+#define OMAP24XX_AUTO_MCBSP2_SHIFT			16
 #define OMAP24XX_AUTO_MCBSP1				(1 << 15)
+#define OMAP24XX_AUTO_MCBSP1_SHIFT			15
 #define OMAP24XX_AUTO_GPT12				(1 << 14)
+#define OMAP24XX_AUTO_GPT12_SHIFT			14
 #define OMAP24XX_AUTO_GPT11				(1 << 13)
+#define OMAP24XX_AUTO_GPT11_SHIFT			13
 #define OMAP24XX_AUTO_GPT10				(1 << 12)
+#define OMAP24XX_AUTO_GPT10_SHIFT			12
 #define OMAP24XX_AUTO_GPT9				(1 << 11)
+#define OMAP24XX_AUTO_GPT9_SHIFT			11
 #define OMAP24XX_AUTO_GPT8				(1 << 10)
+#define OMAP24XX_AUTO_GPT8_SHIFT			10
 #define OMAP24XX_AUTO_GPT7				(1 << 9)
+#define OMAP24XX_AUTO_GPT7_SHIFT			9
 #define OMAP24XX_AUTO_GPT6				(1 << 8)
+#define OMAP24XX_AUTO_GPT6_SHIFT			8
 #define OMAP24XX_AUTO_GPT5				(1 << 7)
+#define OMAP24XX_AUTO_GPT5_SHIFT			7
 #define OMAP24XX_AUTO_GPT4				(1 << 6)
+#define OMAP24XX_AUTO_GPT4_SHIFT			6
 #define OMAP24XX_AUTO_GPT3				(1 << 5)
+#define OMAP24XX_AUTO_GPT3_SHIFT			5
 #define OMAP24XX_AUTO_GPT2				(1 << 4)
+#define OMAP24XX_AUTO_GPT2_SHIFT			4
 #define OMAP2420_AUTO_VLYNQ				(1 << 3)
+#define OMAP2420_AUTO_VLYNQ_SHIFT			3
 #define OMAP24XX_AUTO_DSS				(1 << 0)
+#define OMAP24XX_AUTO_DSS_SHIFT				0
 
 /* CM_AUTOIDLE2_CORE */
 #define OMAP2430_AUTO_MDM_INTC				(1 << 11)
+#define OMAP2430_AUTO_MDM_INTC_SHIFT			11
 #define OMAP2430_AUTO_GPIO5				(1 << 10)
+#define OMAP2430_AUTO_GPIO5_SHIFT			10
 #define OMAP2430_AUTO_MCSPI3				(1 << 9)
+#define OMAP2430_AUTO_MCSPI3_SHIFT			9
 #define OMAP2430_AUTO_MMCHS2				(1 << 8)
+#define OMAP2430_AUTO_MMCHS2_SHIFT			8
 #define OMAP2430_AUTO_MMCHS1				(1 << 7)
+#define OMAP2430_AUTO_MMCHS1_SHIFT			7
 #define OMAP2430_AUTO_USBHS				(1 << 6)
+#define OMAP2430_AUTO_USBHS_SHIFT			6
 #define OMAP2430_AUTO_MCBSP5				(1 << 5)
+#define OMAP2430_AUTO_MCBSP5_SHIFT			5
 #define OMAP2430_AUTO_MCBSP4				(1 << 4)
+#define OMAP2430_AUTO_MCBSP4_SHIFT			4
 #define OMAP2430_AUTO_MCBSP3				(1 << 3)
+#define OMAP2430_AUTO_MCBSP3_SHIFT			3
 #define OMAP24XX_AUTO_UART3				(1 << 2)
+#define OMAP24XX_AUTO_UART3_SHIFT			2
 #define OMAP24XX_AUTO_SSI				(1 << 1)
+#define OMAP24XX_AUTO_SSI_SHIFT				1
 #define OMAP24XX_AUTO_USB				(1 << 0)
+#define OMAP24XX_AUTO_USB_SHIFT				0
 
 /* CM_AUTOIDLE3_CORE */
 #define OMAP24XX_AUTO_SDRC				(1 << 2)
+#define OMAP24XX_AUTO_SDRC_SHIFT			2
 #define OMAP24XX_AUTO_GPMC				(1 << 1)
+#define OMAP24XX_AUTO_GPMC_SHIFT			1
 #define OMAP24XX_AUTO_SDMA				(1 << 0)
+#define OMAP24XX_AUTO_SDMA_SHIFT			0
 
 /* CM_AUTOIDLE4_CORE */
 #define OMAP24XX_AUTO_PKA				(1 << 4)
+#define OMAP24XX_AUTO_PKA_SHIFT				4
 #define OMAP24XX_AUTO_AES				(1 << 3)
+#define OMAP24XX_AUTO_AES_SHIFT				3
 #define OMAP24XX_AUTO_RNG				(1 << 2)
+#define OMAP24XX_AUTO_RNG_SHIFT				2
 #define OMAP24XX_AUTO_SHA				(1 << 1)
+#define OMAP24XX_AUTO_SHA_SHIFT				1
 #define OMAP24XX_AUTO_DES				(1 << 0)
+#define OMAP24XX_AUTO_DES_SHIFT				0
 
 /* CM_CLKSEL1_CORE */
 #define OMAP24XX_CLKSEL_USB_SHIFT			25

-- 
