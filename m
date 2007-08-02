From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/22] omap2 clock: drop meaningless RATE_CKCTLs
Date: Thu, 02 Aug 2007 12:10:03 -0600
Message-ID: <20070802181141.445634441@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=drop_meaningless_rate_ckctls.patch
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

Drop the RATE_CKCTL clock flag from iva1_mpu_int_ifck, gfx_ick, ssi_l4_ick,
and dss_ick.  These clocks are not source-selectable, which is the practical
meaning of RATE_CKCTL in the 2420 clock framework.  

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -861,7 +861,7 @@ static struct clk iva1_ifck = {
 static struct clk iva1_mpu_int_ifck = {
 	.name		= "iva1_mpu_int_ifck",
 	.parent		= &iva1_ifck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1,
+	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_MPU_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
@@ -964,8 +964,7 @@ static struct clk gfx_2d_fck = {
 static struct clk gfx_ick = {
 	.name		= "gfx_ick",		/* From l3 */
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),	/* bit 0 */
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
@@ -1018,7 +1017,7 @@ static struct clk l4_ck = {		/* used bot
 static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),	/* bit 1 */
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
@@ -1035,7 +1034,7 @@ static struct clk ssi_l4_ick = {
 static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 	.name		= "dss_ick",
 	.parent		= &l4_ck,	/* really both l3 and l4 */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,

-- 
