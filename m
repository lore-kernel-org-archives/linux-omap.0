From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/16] ARM: OMAP2+: Make display related init into device_initcall
Date: Mon, 23 Apr 2018 10:45:39 -0700
Message-ID: <20180423174549.57412-7-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

We can initialize almost everything at normal module_init time with
ti-sysc except for clocks and timers. To prepare for that, let's make
display init into device_initcall as otherwise we'll be calling
of_platform_populate() before the parent has probed.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-generic.c | 2 --
 arch/arm/mach-omap2/common.h        | 2 --
 arch/arm/mach-omap2/display.c       | 3 ++-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -31,8 +31,6 @@ static const struct of_device_id omap_dt_match_table[] __initconst = {
 static void __init __maybe_unused omap_generic_init(void)
 {
 	pdata_quirks_init(omap_dt_match_table);
-
-	omapdss_init_of();
 	omap_soc_device_init();
 }
 
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -352,7 +352,5 @@ extern int omap_dss_reset(struct omap_hwmod *);
 /* SoC specific clock initializer */
 int omap_clk_init(void);
 
-int __init omapdss_init_of(void);
-
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -385,7 +385,7 @@ static struct device_node * __init omapdss_find_dss_of_node(void)
 	return NULL;
 }
 
-int __init omapdss_init_of(void)
+static int __init omapdss_init_of(void)
 {
 	int r;
 	struct device_node *node;
@@ -415,3 +415,4 @@ int __init omapdss_init_of(void)
 
 	return omapdss_init_fbdev();
 }
+omap_device_initcall(omapdss_init_of);
-- 
2.17.0
