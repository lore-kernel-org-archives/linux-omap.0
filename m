From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/28] omap2 clock: mark onchip_clks as __initdata
Date: Mon, 20 Aug 2007 03:53:50 -0600
Message-ID: <20070820095530.246459867@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=mark_onchip_clks_initdata.patch
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

The onchip_clks array is only used during init, so, mark it __initdata.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -1988,7 +1988,7 @@ static struct clk virt_prcm_set = {
 	.round_rate	= &omap2_round_to_table_rate,
 };
 
-static struct clk *onchip_clks[] = {
+static struct clk *onchip_clks[] __initdata = {
 	/* external root sources */
 	&func_32k_ck,
 	&osc_ck,

-- 
