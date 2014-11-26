From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap2: rx51-peripherals: fix build warning
Date: Wed, 26 Nov 2014 14:27:35 -0600
Message-ID: <1417033655-32332-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42153 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbaKZU1w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2014 15:27:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
si4713 platform data) updated board-rx51-peripherals.c
so that si4713 could be easily used on DT boot, but
it ended up introducing a build warning whenever
si4713 isn't enabled.

This patches fixes that warning:

arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning: \
	=E2=80=98rx51_si4713_platform_data=E2=80=99 defined but not used [-Wun=
used-variable]
 static struct si4713_platform_data rx51_si4713_platform_data =3D {

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
index d18a5cf..bda20c5 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -997,9 +997,11 @@ static struct aic3x_pdata rx51_aic3x_data2 =3D {
 	.gpio_reset =3D 60,
 };
=20
+#if IS_ENABLED(CONFIG_I2C_SI4713) && IS_ENABLED(CONFIG_PLATFORM_SI4713=
)
 static struct si4713_platform_data rx51_si4713_platform_data =3D {
 	.is_platform_device =3D true
 };
+#endif
=20
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_inf=
o_2[] =3D {
 #if IS_ENABLED(CONFIG_I2C_SI4713) && IS_ENABLED(CONFIG_PLATFORM_SI4713=
)
--=20
2.1.0.GIT

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
