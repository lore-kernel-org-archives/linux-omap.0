From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/22] omap2 clock: clean up dss2_fck clock flags
Date: Thu, 02 Aug 2007 12:10:10 -0600
Message-ID: <20070802181142.221017165@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=cleanup_dss2_fck.patch
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

dss2_fck is not a fixed-rate clock; its rate is dependent on its parent's
rate.  So, drop the .rate assignment and drop the RATE_FIXED clock flag.  
It also is a leaf clock - no clocks have it as a parent - so it can't 
propagate its rate anywhere.  So, drop the RATE_PROPAGATES and fix the
recalc function pointer accordingly.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -1059,12 +1059,10 @@ static struct clk dss2_fck = {		/* Alt c
 static struct clk dss_54m_fck = {	/* Alt clk used in power management */
 	.name		= "dss_54m_fck",	/* 54m tv clk */
 	.parent		= &func_54m_ck,
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_TV_SHIFT,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &omap2_followparent_recalc,
 };
 
 /*

-- 
