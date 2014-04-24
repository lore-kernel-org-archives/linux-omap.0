From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 3/4] ARM: OMAP2+: Add machine entry for dra72x devices
Date: Thu, 24 Apr 2014 15:36:26 +0530
Message-ID: <1398333987-19454-4-git-send-email-rnayak@ti.com>
References: <1398333987-19454-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57727 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755665AbaDXKI1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:08:27 -0400
In-Reply-To: <1398333987-19454-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, nm@ti.com, arnd@arndb.de, Rajendra Nayak <rnayak@ti.com>

The only difference from the dra74x devices is the missing .smp entry.

While at it, also fix the use of __initdata (across the file) and replace them
with __initconst as reported by checkpatch

ERROR: Use of const init definition must use __initconst
+static const char *dra72x_boards_compat[] __initdata = {

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |   45 ++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index b8920b6..dabb9f6 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -43,7 +43,7 @@ static void __init omap_generic_init(void)
 }
 
 #ifdef CONFIG_SOC_OMAP2420
-static const char *omap242x_boards_compat[] __initdata = {
+static const char *omap242x_boards_compat[] __initconst = {
 	"ti,omap2420",
 	NULL,
 };
@@ -62,7 +62,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_OMAP2430
-static const char *omap243x_boards_compat[] __initdata = {
+static const char *omap243x_boards_compat[] __initconst = {
 	"ti,omap2430",
 	NULL,
 };
@@ -81,7 +81,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-static const char *omap3_boards_compat[] __initdata = {
+static const char *omap3_boards_compat[] __initconst = {
 	"ti,omap3430",
 	"ti,omap3",
 	NULL,
@@ -100,7 +100,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.restart	= omap3xxx_restart,
 MACHINE_END
 
-static const char *omap36xx_boards_compat[] __initdata = {
+static const char *omap36xx_boards_compat[] __initconst = {
 	"ti,omap36xx",
 	NULL,
 };
@@ -118,7 +118,7 @@ DT_MACHINE_START(OMAP36XX_DT, "Generic OMAP36xx (Flattened Device Tree)")
 	.restart	= omap3xxx_restart,
 MACHINE_END
 
-static const char *omap3_gp_boards_compat[] __initdata = {
+static const char *omap3_gp_boards_compat[] __initconst = {
 	"ti,omap3-beagle",
 	"timll,omap3-devkit8000",
 	NULL,
@@ -137,7 +137,7 @@ DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
 	.restart	= omap3xxx_restart,
 MACHINE_END
 
-static const char *am3517_boards_compat[] __initdata = {
+static const char *am3517_boards_compat[] __initconst = {
 	"ti,am3517",
 	NULL,
 };
@@ -157,7 +157,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_AM33XX
-static const char *am33xx_boards_compat[] __initdata = {
+static const char *am33xx_boards_compat[] __initconst = {
 	"ti,am33xx",
 	NULL,
 };
@@ -177,7 +177,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-static const char *omap4_boards_compat[] __initdata = {
+static const char *omap4_boards_compat[] __initconst = {
 	"ti,omap4460",
 	"ti,omap4430",
 	"ti,omap4",
@@ -199,7 +199,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_OMAP5
-static const char *omap5_boards_compat[] __initdata = {
+static const char *omap5_boards_compat[] __initconst = {
 	"ti,omap5432",
 	"ti,omap5430",
 	"ti,omap5",
@@ -221,7 +221,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_AM43XX
-static const char *am43_boards_compat[] __initdata = {
+static const char *am43_boards_compat[] __initconst = {
 	"ti,am4372",
 	"ti,am43",
 	NULL,
@@ -240,13 +240,13 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_DRA7XX
-static const char *dra7xx_boards_compat[] __initdata = {
-	"ti,dra7xx",
+static const char *dra74x_boards_compat[] __initconst = {
+	"ti,dra74",
 	"ti,dra7",
 	NULL,
 };
 
-DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
+DT_MACHINE_START(DRA74X_DT, "Generic DRA74X (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.smp		= smp_ops(omap4_smp_ops),
 	.map_io		= omap5_map_io,
@@ -255,7 +255,24 @@ DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
 	.init_irq	= omap_gic_of_init,
 	.init_machine	= omap_generic_init,
 	.init_time	= omap5_realtime_timer_init,
-	.dt_compat	= dra7xx_boards_compat,
+	.dt_compat	= dra74x_boards_compat,
+	.restart	= omap44xx_restart,
+MACHINE_END
+
+static const char *dra72x_boards_compat[] __initconst = {
+	"ti,dra72",
+	NULL,
+};
+
+DT_MACHINE_START(DRA72_DT, "Generic DRA72X (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap5_map_io,
+	.init_early	= dra7xx_init_early,
+	.init_late	= dra7xx_init_late,
+	.init_irq	= omap_gic_of_init,
+	.init_machine	= omap_generic_init,
+	.init_time	= omap5_realtime_timer_init,
+	.dt_compat	= dra72x_boards_compat,
 	.restart	= omap44xx_restart,
 MACHINE_END
 #endif
-- 
1.7.9.5

