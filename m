From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/22] omap2 clock: get rid of sleep_ck
Date: Thu, 02 Aug 2007 12:10:09 -0600
Message-ID: <20070802181142.112945862@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=drop_sleep_ck.patch
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

According to the 2420 TRM rev J, SLEEP_CLK doesn't have any registers
or bits associated with it, so it's outside software control.  It's
also a leaf clock - no software-controllable clocks use it as a
parent.  There's nothing we can do with it in software.  So, drop it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h |    9 ---------
 1 file changed, 9 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -684,14 +684,6 @@ static struct clk core_ck = {
 	.recalc		= &omap2_propagate_rate,
 };
 
-static struct clk sleep_ck = {		/* sys_clk or 32k */
-	.name		= "sleep_ck",
-	.parent		= &func_32k_ck,
-	.rate		= 32000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.recalc		= &omap2_propagate_rate,
-};
-
 static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
 	.parent		= &apll96_ck,
@@ -2017,7 +2009,6 @@ static struct clk *onchip_clks[] = {
 	/* internal prcm root sources */
 	&func_54m_ck,
 	&core_ck,
-	&sleep_ck,
 	&func_96m_ck,
 	&func_48m_ck,
 	&func_12m_ck,

-- 
