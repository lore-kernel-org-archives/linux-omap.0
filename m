From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP: RX-51: add missing regulator supply definitions for lis3lv02d
Date: Mon,  1 Apr 2013 23:04:04 +0300
Message-ID: <1364846644-5302-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:39948 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759695Ab3DAUEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 16:04:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

Add missing regulator definitions for lis3lv02d accelerometer. Fixes
the following probe issue:

[   57.737518] lis3lv02d_i2c 3-001d: Failed to get supply 'Vdd': -517
[   57.747100] i2c 3-001d: Driver lis3lv02d_i2c requests probe deferral

Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---

	The patch was discussed in this thread...

		http://marc.info/?t=3D136105842400001&r=3D1&w=3D2

	...and now sending it to relevant mailing lists.

 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
index 3a077df..1a88467 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -547,12 +547,16 @@ static struct regulator_consumer_supply rx51_vio_=
supplies[] =3D {
 	REGULATOR_SUPPLY("DVDD", "2-0019"),
 	/* Si4713 IO supply */
 	REGULATOR_SUPPLY("vio", "2-0063"),
+	/* lis3lv02d */
+	REGULATOR_SUPPLY("Vdd_IO", "3-001d"),
 };
=20
 static struct regulator_consumer_supply rx51_vaux1_consumers[] =3D {
 	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
 	/* Si4713 supply */
 	REGULATOR_SUPPLY("vdd", "2-0063"),
+	/* lis3lv02d */
+	REGULATOR_SUPPLY("Vdd", "3-001d"),
 };
=20
 static struct regulator_init_data rx51_vaux1 =3D {
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
