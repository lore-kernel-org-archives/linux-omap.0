From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: clk_disable_unused: init section mismatch
Date: Thu, 01 Nov 2007 10:18:14 -0700
Message-ID: <20071101171814.725820430@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Fix the following warning when OMAP_RESET_CLOCKS is enabled:

WARNING: vmlinux.o(.data+0x33a0): Section mismatch: reference to .init.text:omap2_clk_disable_unused (between 'omap2_clk_functions' and 'osc_ck')

omap2_clk_disable_unused cannot be declared __init as it part of a
struct where the rest of the functions are not __init.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/clock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: dev/arch/arm/mach-omap2/clock.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/clock.c
+++ dev/arch/arm/mach-omap2/clock.c
@@ -739,7 +739,7 @@ int omap2_clk_set_parent(struct clk *clk
  *-------------------------------------------------------------------------*/
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
-void __init omap2_clk_disable_unused(struct clk *clk)
+void omap2_clk_disable_unused(struct clk *clk)
 {
 	u32 regval32, v;
 
--
