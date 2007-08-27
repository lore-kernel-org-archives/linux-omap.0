From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 19/27] omap2 clock: drop RATE_CKCTL from all OMAP2 clocks
Date: Mon, 27 Aug 2007 02:39:15 -0600
Message-ID: <20070827084123.971986127@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=nuke_rate_ckctl.patch
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

RATE_CKCTL is no longer meaningful in the OMAP2 clock framework, so, drop it
from all clocks.  We keep the flag around since it's still used by OMAP1.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h |   45 ++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2007-08-27 02:19:40.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2007-08-27 02:19:41.000000000 -0600
@@ -641,8 +641,7 @@
 	.name		= "dpll_ck",
 	.parent		= &sys_ck,		/* Can be func_32k also */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | RATE_CKCTL | CM_PLL_SEL1 |
-				ALWAYS_ENABLED,
+				RATE_PROPAGATES | CM_PLL_SEL1 |	ALWAYS_ENABLED,
 	.recalc		= &omap2_dpll_recalc,
 	.set_rate	= &omap2_reprogram_dpll,
 };
@@ -834,8 +833,7 @@
 	.name		= "sys_clkout_src",
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | RATE_CKCTL |
-				RATE_PROPAGATES,
+				CM_SYSCLKOUT_SEL1 | RATE_PROPAGATES,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -865,8 +863,7 @@
 	.name		= "sys_clkout",
 	.parent		= &sys_clkout_src,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | RATE_CKCTL |
-				PARENT_CONTROLS_CLOCK,
+				CM_SYSCLKOUT_SEL1 | PARENT_CONTROLS_CLOCK,
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
@@ -879,7 +876,7 @@
 static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
 	.parent		= &func_54m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 | RATE_CKCTL |
+	.flags		= CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 |
 				RATE_PROPAGATES,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
@@ -901,7 +898,7 @@
 static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
 	.parent		= &sys_clkout2_src,
-	.flags		= CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 | RATE_CKCTL |
+	.flags		= CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 |
 				PARENT_CONTROLS_CLOCK,
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
@@ -948,7 +945,7 @@
 static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL |
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | CM_MPU_SEL1 | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.init		= &omap2_init_clksel_parent,
@@ -990,7 +987,7 @@
 static struct clk iva2_1_fck = {
 	.name		= "iva2_1_fck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
+	.flags		= CLOCK_IN_OMAP243X | CM_DSP_SEL1 |
 				DELAYED_APP | RATE_PROPAGATES |
 				CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
@@ -1019,7 +1016,7 @@
 static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
 	.parent		= &iva2_1_fck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
+	.flags		= CLOCK_IN_OMAP243X | CM_DSP_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
@@ -1054,7 +1051,7 @@
 static struct clk dsp_fck = {
 	.name		= "dsp_fck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
+	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 |
 			DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
@@ -1081,7 +1078,7 @@
 static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
+	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,		/* for ipi */
@@ -1110,7 +1107,7 @@
 static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 | RATE_CKCTL |
+	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 |
 			CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
@@ -1172,7 +1169,7 @@
 	.name		= "core_l3_ck",
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
+				ALWAYS_ENABLED | CM_CORE_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT |
 				RATE_PROPAGATES,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
@@ -1200,7 +1197,7 @@
 	.name		= "usb_l4_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP |
+				CM_CORE_SEL1 | DELAYED_APP |
 				CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
@@ -1240,7 +1237,7 @@
 	.name		= "ssi_fck",
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
+				CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),	/* bit 1 */
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
@@ -1285,7 +1282,7 @@
 	.name		= "gfx_3d_fck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_GFX_SEL1,
+				CM_GFX_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
@@ -1300,7 +1297,7 @@
 	.name		= "gfx_2d_fck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_GFX_SEL1,
+				CM_GFX_SEL1,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
@@ -1343,7 +1340,7 @@
 static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_MODEM_SEL1 |
+	.flags		= CLOCK_IN_OMAP243X | CM_MODEM_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
@@ -1386,7 +1383,7 @@
 	.name		= "l4_ck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
+				ALWAYS_ENABLED | CM_CORE_SEL1 |
 				DELAYED_APP | RATE_PROPAGATES,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
@@ -1453,7 +1450,7 @@
 	.name		= "dss1_fck",
 	.parent		= &core_ck,		/* Core or sys */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
+				CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -1485,7 +1482,7 @@
 	.name		= "dss2_fck",
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
+				CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -2333,7 +2330,7 @@
 static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X  | RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
+	.flags		= CLOCK_IN_OMAP242X | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
 	.init		= &omap2_init_clksel_parent,

-- 
