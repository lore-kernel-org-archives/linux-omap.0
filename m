From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] ARM: omap2: make arrays containing machine compatible strings const
Date: Thu, 11 Sep 2014 21:29:01 +0200
Message-ID: <1410463741-29202-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47261 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767AbaIKT3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 15:29:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: kernel@pengutronix.de, linux-omap@vger.kernel.org

The definition

	static const char *omap3_boards_compat[] __initconst =3D {

defines a changable array of constant strings. That is you must not do:

	*omap3_boards_compat[0] =3D 'f';

but

	omap3_boards_compat[0] =3D "another string";

is fine. So the annotation __initconst is wrong and yields a compiler
error when other really const variables are added with __initconst.

As the struct machine_desc member dt_compat is declared as

	const char *const *dt_compat;

making the arrays const is the better alternative over changing all
annotations to __initdata.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap2/board-generic.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/=
board-generic.c
index 5827abb080e4..0b311d51425f 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -43,7 +43,7 @@ static void __init omap_generic_init(void)
 }
=20
 #ifdef CONFIG_SOC_OMAP2420
-static const char *omap242x_boards_compat[] __initconst =3D {
+static const char *const omap242x_boards_compat[] __initconst =3D {
 	"ti,omap2420",
 	NULL,
 };
@@ -62,7 +62,7 @@ MACHINE_END
 #endif
=20
 #ifdef CONFIG_SOC_OMAP2430
-static const char *omap243x_boards_compat[] __initconst =3D {
+static const char *const omap243x_boards_compat[] __initconst =3D {
 	"ti,omap2430",
 	NULL,
 };
@@ -81,7 +81,7 @@ MACHINE_END
 #endif
=20
 #ifdef CONFIG_ARCH_OMAP3
-static const char *omap3_boards_compat[] __initconst =3D {
+static const char *const omap3_boards_compat[] __initconst =3D {
 	"ti,omap3430",
 	"ti,omap3",
 	NULL,
@@ -100,7 +100,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattene=
d Device Tree)")
 	.restart	=3D omap3xxx_restart,
 MACHINE_END
=20
-static const char *omap36xx_boards_compat[] __initconst =3D {
+static const char *const omap36xx_boards_compat[] __initconst =3D {
 	"ti,omap36xx",
 	NULL,
 };
@@ -118,7 +118,7 @@ DT_MACHINE_START(OMAP36XX_DT, "Generic OMAP36xx (Fl=
attened Device Tree)")
 	.restart	=3D omap3xxx_restart,
 MACHINE_END
=20
-static const char *omap3_gp_boards_compat[] __initconst =3D {
+static const char *const omap3_gp_boards_compat[] __initconst =3D {
 	"ti,omap3-beagle",
 	"timll,omap3-devkit8000",
 	NULL,
@@ -137,7 +137,7 @@ DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Fl=
attened Device Tree)")
 	.restart	=3D omap3xxx_restart,
 MACHINE_END
=20
-static const char *am3517_boards_compat[] __initconst =3D {
+static const char *const am3517_boards_compat[] __initconst =3D {
 	"ti,am3517",
 	NULL,
 };
@@ -157,7 +157,7 @@ MACHINE_END
 #endif
=20
 #ifdef CONFIG_SOC_AM33XX
-static const char *am33xx_boards_compat[] __initconst =3D {
+static const char *const am33xx_boards_compat[] __initconst =3D {
 	"ti,am33xx",
 	NULL,
 };
@@ -177,7 +177,7 @@ MACHINE_END
 #endif
=20
 #ifdef CONFIG_ARCH_OMAP4
-static const char *omap4_boards_compat[] __initconst =3D {
+static const char *const omap4_boards_compat[] __initconst =3D {
 	"ti,omap4460",
 	"ti,omap4430",
 	"ti,omap4",
@@ -199,7 +199,7 @@ MACHINE_END
 #endif
=20
 #ifdef CONFIG_SOC_OMAP5
-static const char *omap5_boards_compat[] __initconst =3D {
+static const char *const omap5_boards_compat[] __initconst =3D {
 	"ti,omap5432",
 	"ti,omap5430",
 	"ti,omap5",
@@ -221,7 +221,7 @@ MACHINE_END
 #endif
=20
 #ifdef CONFIG_SOC_AM43XX
-static const char *am43_boards_compat[] __initconst =3D {
+static const char *const am43_boards_compat[] __initconst =3D {
 	"ti,am4372",
 	"ti,am43",
 	NULL,
@@ -240,7 +240,7 @@ MACHINE_END
 #endif
=20
 #ifdef CONFIG_SOC_DRA7XX
-static const char *dra74x_boards_compat[] __initconst =3D {
+static const char *const dra74x_boards_compat[] __initconst =3D {
 	"ti,dra742",
 	"ti,dra7",
 	NULL,
@@ -259,7 +259,7 @@ DT_MACHINE_START(DRA74X_DT, "Generic DRA74X (Flatte=
ned Device Tree)")
 	.restart	=3D omap44xx_restart,
 MACHINE_END
=20
-static const char *dra72x_boards_compat[] __initconst =3D {
+static const char *const dra72x_boards_compat[] __initconst =3D {
 	"ti,dra722",
 	NULL,
 };
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
