From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v4 3/5] ARM: OMAP2+: Replace all __initdata with __initconst for const init
Date: Tue, 29 Apr 2014 16:35:11 +0530
Message-ID: <1398769513-8736-4-git-send-email-rnayak@ti.com>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43586 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964818AbaD2LHb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 07:07:31 -0400
In-Reply-To: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, nm@ti.com, arnd@arndb.de, s-anna@ti.com, Rajendra Nayak <rnayak@ti.com>

Use of const init definition must use __initconst so replace
all such instances where __initdata is used.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index b8920b6..90dbfdf 100644
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
@@ -240,7 +240,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_DRA7XX
-static const char *dra7xx_boards_compat[] __initdata = {
+static const char *dra7xx_boards_compat[] __initconst = {
 	"ti,dra7xx",
 	"ti,dra7",
 	NULL,
-- 
1.7.9.5

