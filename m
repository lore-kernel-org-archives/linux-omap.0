From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] omap2: fix clock.h rate_offset whitespace
Date: Wed, 02 May 2007 12:33:22 -0600
Message-ID: <20070502183844.429627889@pwsan.com>
References: <20070502183320.656693735@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=fix-clock.h-indenting.patch
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

Some of the .rate_offset lines in clock.h have whitespace problems; 
fix them.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap-2.6/arch/arm/mach-omap2/clock.h
@@ -832,7 +832,7 @@ static struct clk dsp_ick = {
 	.parent		= &dsp_fck,
 	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
 				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset = 5,
+	.rate_offset	= 5,
 	.enable_reg	= (void __iomem *)&CM_ICLKEN_DSP,
 	.enable_bit	= 1,		/* for ipi */
 	.recalc		= &omap2_clksel_recalc,
@@ -843,7 +843,7 @@ static struct clk iva1_ifck = {
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 | RATE_CKCTL |
 			CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
-	.rate_offset= 8,
+	.rate_offset	= 8,
 	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
 	.enable_bit	= 10,
 	.recalc		= &omap2_clksel_recalc,
@@ -897,7 +897,7 @@ static struct clk usb_l4_ick = {	/* FS-U
 				CONFIG_PARTICIPANT,
 	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
 	.enable_bit	= 0,
-	.rate_offset = 25,
+	.rate_offset	= 25,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -916,7 +916,7 @@ static struct clk ssi_ssr_sst_fck = {
 				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,	/* bit 1 */
 	.enable_bit	= 1,
-	.rate_offset = 20,
+	.rate_offset	= 20,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -938,7 +938,7 @@ static struct clk gfx_3d_fck = {
 				RATE_CKCTL | CM_GFX_SEL1,
 	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
 	.enable_bit	= 2,
-	.rate_offset= 0,
+	.rate_offset	= 0,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -949,7 +949,7 @@ static struct clk gfx_2d_fck = {
 				RATE_CKCTL | CM_GFX_SEL1,
 	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
 	.enable_bit	= 1,
-	.rate_offset= 0,
+	.rate_offset	= 0,
 	.recalc		= &omap2_clksel_recalc,
 };
 

-- 
