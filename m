From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/22] omap2 clock: fix incorrect rate calculation for
	osc_ck, sys_ck
Date: Thu, 02 Aug 2007 12:10:04 -0600
Message-ID: <20070802181141.557025493@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=fix_get_crystal_rate_error.patch
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

omap2_get_crystal_rate() calculates osc_ck and sys_ck rates
incorrectly.  osc_ck runs at the same rate as the external clock
source.  Also, sys_ck's rate derives from osc_ck's rate, divided (not
multiplied) by PRCM_CLKSRC_CTRL:SYSCLKDIV.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -1126,8 +1126,8 @@ static void __init omap2_get_crystal_rat
 	div &= OMAP_SYSCLKDIV_MASK;
 	div >>= sys->rate_offset;
 
-	osc->rate = sclk * div;
-	sys->rate = sclk;
+	osc->rate = sclk;
+	sys->rate = osc->rate / div;
 }
 
 /*

-- 
