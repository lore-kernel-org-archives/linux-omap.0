From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 21/22] omap2 clock: remove fixed rate from mdm_osc_ck
Date: Thu, 02 Aug 2007 12:10:23 -0600
Message-ID: <20070802181143.702074311@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=convert_mdm_osc_ck_to_omap2_propagate_rate.patch
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

mdm_osc_ck has a preinitialized rate and is marked as RATE_FIXED, but rather
than using omap2_propagate_rate() as its recalc function, which accounts
for RATE_FIXED clocks, it uses omap2_followparent_recalc(), which sets the 
rate to the parent clock's rate.  After reviewing the 2430 TRM, fix this
inconsistency by removing the fixed rate declarations (TRM says that this 
clock is 'typically' 26MHz).

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -960,6 +960,7 @@ static struct clk gfx_ick = {
  *	CLOCKS:
  *		MDM_OSC_CLK
  *		MDM_ICLK
+ * These clocks are usable in chassis mode only.
  */
 static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
@@ -974,9 +975,8 @@ static struct clk mdm_ick = {		/* used b
 
 static struct clk mdm_osc_ck = {
 	.name		= "mdm_osc_ck",
-	.rate		= 26000000,
 	.parent		= &osc_ck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_FIXED,
+	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, OMAP24XX_CM_FCLKEN),
 	.enable_bit	= OMAP2430_EN_OSC_SHIFT,
 	.recalc		= &omap2_followparent_recalc,

-- 
