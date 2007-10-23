From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: Use dynamic detection for setting default sys_ck
Date: Mon, 22 Oct 2007 17:17:01 -0700
Message-ID: <20071023001701.324618342@mvista.com>
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

A cleaner way than my previous static fix...  Rather than setting a
static sys_ck.rate, detect the correct value at boot time.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/clock24xx.c |    1 +
 arch/arm/mach-omap2/clock24xx.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

Index: dev/arch/arm/mach-omap2/clock24xx.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/clock24xx.c
+++ dev/arch/arm/mach-omap2/clock24xx.c
@@ -475,6 +475,7 @@ int __init omap2_clk_init(void)
 	clk_init(&omap2_clk_functions);
 
 	omap2_osc_clk_recalc(&osc_ck);
+	omap2_sys_clk_recalc(&sys_ck);
 
 	for (clkp = onchip_24xx_clks;
 	     clkp < onchip_24xx_clks + ARRAY_SIZE(onchip_24xx_clks);
Index: dev/arch/arm/mach-omap2/clock24xx.h
===================================================================
--- dev.orig/arch/arm/mach-omap2/clock24xx.h
+++ dev/arch/arm/mach-omap2/clock24xx.h
@@ -581,7 +581,6 @@ static struct clk osc_ck = {		/* (*12, *
 /* With out modem likely 12MHz, with modem likely 13MHz */
 static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
-	.rate           = 13000000,
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | RATE_PROPAGATES,
--
