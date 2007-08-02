From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/22] omap2 clock: fix some clocks incorrectly marked as
	present on OMAP2430
Date: Thu, 02 Aug 2007 12:10:13 -0600
Message-ID: <20070802181142.567475486@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=fix-2420-only-clocks.patch
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

Several clocks are marked as present on OMAP2430, even though they are 
2420-only.  Drop CLOCK_IN_OMAP243X from those clocks' flags.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -742,8 +742,7 @@ static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
 	.parent		= &func_54m_ck,
 	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
+	.flags		= CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
 	.src_offset	= OMAP2420_CLKOUT2_SOURCE_SHIFT,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
@@ -1740,7 +1739,7 @@ static struct clk i2c2_ick = {
 	.name		= "i2c_ick",
 	.id		= 2,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
@@ -1750,7 +1749,7 @@ static struct clk i2c2_fck = {
 	.name		= "i2c_fck",
 	.id		= 2,
 	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
@@ -1770,7 +1769,7 @@ static struct clk i2c1_ick = {
 	.name		= "i2c_ick",
 	.id		= 1,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,
@@ -1780,7 +1779,7 @@ static struct clk i2c1_fck = {
 	.name		= "i2c_fck",
 	.id		= 1,
 	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
 	.recalc		= &omap2_followparent_recalc,

-- 
