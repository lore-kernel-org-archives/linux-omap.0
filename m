From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/22] omap2 clock: drop unnecessary variable in
	omap2_clk_round_rate()
Date: Thu, 02 Aug 2007 12:10:08 -0600
Message-ID: <20070802181142.002895558@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=other-clock.c-cleanups.patch
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

Drop an unnecessary variable, valid_rate, in omap2_clk_round_rate().

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -469,15 +469,12 @@ static u32 omap2_clksel_round_rate(struc
 static long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	u32 new_div = 0;
-	int valid_rate;
 
 	if (clk->flags & RATE_FIXED)
 		return clk->rate;
 
-	if (clk->flags & RATE_CKCTL) {
-		valid_rate = omap2_clksel_round_rate(clk, rate, &new_div);
-		return valid_rate;
-	}
+	if (clk->flags & RATE_CKCTL)
+		return omap2_clksel_round_rate(clk, rate, &new_div);
 
 	if (clk->round_rate != 0)
 		return clk->round_rate(clk, rate);

-- 
