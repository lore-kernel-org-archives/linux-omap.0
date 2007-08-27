From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 21/27] omap2 clock: call clock-specific enable/disable
	functions if present
Date: Mon, 27 Aug 2007 02:39:17 -0600
Message-ID: <20070827084124.171830260@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
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
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:42.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:42.000000000 -0600
@@ -277,6 +277,9 @@
 		return 0;
 	}
 
+	if (clk->enable)
+		return clk->enable(clk);
+
 	if (unlikely(clk->enable_reg == 0)) {
 		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
 		       clk->name);
@@ -316,6 +319,11 @@
 	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
 		return;
 
+	if (clk->disable) {
+		clk->disable(clk);
+		return;
+	}
+
 	if (unlikely(clk == &osc_ck)) {
 		omap2_set_osc_ck(0);
 		return;

-- 
