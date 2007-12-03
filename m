From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] 24xx clock: Fix 54MHz APLL readiness test
Date: Mon, 03 Dec 2007 16:24:29 -0700
Message-ID: <20071203232727.752667192@pwsan.com>
References: <20071203232426.775904267@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=fix_apll_54m_readiness_test.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

omap2_clk_fixed_enable() was checking the wrong bit to determine if
the 54MHz APLL was ready, causing a "Clock apll54_ck didn't enable in
100000 tries" warning message on 2430SDP:

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock24xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap/arch/arm/mach-omap2/clock24xx.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock24xx.c	2007-11-21 00:26:06.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/clock24xx.c	2007-12-03 16:07:46.000000000 -0700
@@ -115,7 +115,7 @@
 	if (clk == &apll96_ck)
 		cval = OMAP24XX_ST_96M_APLL;
 	else if (clk == &apll54_ck)
-		cval = OMAP24XX_ST_54M_CLK;
+		cval = OMAP24XX_ST_54M_APLL;
 
 	omap2_wait_clock_ready(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), cval,
 			    clk->name);

-- 
