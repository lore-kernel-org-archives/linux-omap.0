From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 4/4] wip: fix section mismatches in omap1_defconfig
Date: Wed,  9 Feb 2011 21:40:10 +0100
Message-ID: <1297284010-2286-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110209192727.GC20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50672 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab1BIUkk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 15:40:40 -0500
In-Reply-To: <20110209192727.GC20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

after these changes omap1_defconfig and omap2plus_defconfig don't have =
any
section mismatches any more, making it plausible that the patches earli=
er
in this series are OK.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap1/board-ams-delta.c |    4 ++--
 arch/arm/mach-omap1/board-fsample.c   |    2 +-
 drivers/usb/otg/isp1301_omap.c        |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap=
1/board-ams-delta.c
index 22cc8c8..560e33f 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -175,7 +175,7 @@ static struct omap_usb_config ams_delta_usb_config =
__initdata =3D {
 	.pins[0]	=3D 2,
 };
=20
-static struct omap_board_config_kernel ams_delta_config[] =3D {
+static struct omap_board_config_kernel ams_delta_config[] __initdata =3D=
 {
 	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 };
=20
@@ -259,7 +259,7 @@ static int ams_delta_camera_power(struct device *de=
v, int power)
 #define ams_delta_camera_power	NULL
 #endif
=20
-static struct soc_camera_link __initdata ams_delta_iclink =3D {
+static struct soc_camera_link ams_delta_iclink =3D {
 	.bus_id         =3D 0,	/* OMAP1 SoC camera bus */
 	.i2c_adapter_id =3D 1,
 	.board_info     =3D &ams_delta_camera_board_info[0],
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/=
board-fsample.c
index 0efb9db..6b98eef 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -291,7 +291,7 @@ static struct omap_lcd_config fsample_lcd_config __=
initdata =3D {
 	.ctrl_name	=3D "internal",
 };
=20
-static struct omap_board_config_kernel fsample_config[] =3D {
+static struct omap_board_config_kernel fsample_config[] __initdata =3D=
 {
 	{ OMAP_TAG_LCD,		&fsample_lcd_config },
 };
=20
diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_o=
map.c
index e00fa1b..8c6fdef 100644
--- a/drivers/usb/otg/isp1301_omap.c
+++ b/drivers/usb/otg/isp1301_omap.c
@@ -1510,7 +1510,7 @@ isp1301_start_hnp(struct otg_transceiver *dev)
=20
 /*--------------------------------------------------------------------=
-----*/
=20
-static int __init
+static int __devinit
 isp1301_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 {
 	int			status;
--=20
1.7.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
