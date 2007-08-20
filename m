From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 21/28] omap2 clock: call clock-specific enable/disable
	functions if present
Date: Mon, 20 Aug 2007 03:54:08 -0600
Message-ID: <20070820095532.037562844@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add_clk_specific_enable_disable.patch
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

Call clock-specific enable/disable functions if .enable/.disable function
pointer fields are present in struct clk.  Similar to OMAP1 clock code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>


---
 arch/arm/mach-omap2/clock.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -276,6 +276,9 @@ static int _omap2_clk_enable(struct clk 
 		return 0;
 	}
 
+	if (clk->enable)
+		return clk->enable(clk);
+
 	if (unlikely(clk->enable_reg == 0)) {
 		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
 		       clk->name);
@@ -315,6 +318,11 @@ static void _omap2_clk_disable(struct cl
 	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
 		return;
 
+	if (clk->disable) {
+	        clk->disable(clk);
+		return;
+	}
+
 	if (unlikely(clk == &osc_ck)) {
 		omap2_set_osc_ck(0);
 		return;

-- 
