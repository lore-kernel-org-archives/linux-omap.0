From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] omap2: standardize clock.h enable_reg/enable_bit order
Date: Wed, 02 May 2007 12:33:21 -0600
Message-ID: <20070502183844.336483674@pwsan.com>
References: <20070502183320.656693735@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline;
	filename=fix-clock.h-enable-reg-enable-bit-order.patch
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

A few of the clock definitions in mach-omap2/clock.h list the 
.enable_bit member before .enable_reg.  This fixes those to conform
with the order used in the rest of the file.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap-2.6/arch/arm/mach-omap2/clock.h
@@ -1318,8 +1318,8 @@ static struct clk mcbsp1_ick = {
 	.name		= "mcbsp1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 15,
 	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit16 */
+	.enable_bit	= 15,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1327,8 +1327,8 @@ static struct clk mcbsp1_fck = {
 	.name		= "mcbsp1_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 15,
 	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 15,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1336,8 +1336,8 @@ static struct clk mcbsp2_ick = {
 	.name		= "mcbsp2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 16,
 	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 16,
 	.recalc		= &omap2_followparent_recalc,
 };
 
@@ -1345,8 +1345,8 @@ static struct clk mcbsp2_fck = {
 	.name		= "mcbsp2_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 16,
 	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 16,
 	.recalc		= &omap2_followparent_recalc,
 };
 

-- 
