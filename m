From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2 3/3] RX-51: Add platform data for bq24150a charger
Date: Tue, 19 Nov 2013 11:18:05 +0100
Message-ID: <1384856285-19593-4-git-send-email-pali.rohar@gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch will register bq24150a charger in RX-51 board data.

So finally charging battery on Nokia N900 (RX-51) working
automatically without any proprietary Nokia bits in userspace.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
index 70fcaff..95e6638 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -25,6 +25,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
 #include <linux/power/isp1704_charger.h>
+#include <linux/power/bq2415x_charger.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 #include <linux/hsi/hsi.h>
@@ -1275,6 +1276,16 @@ static struct aic3x_pdata rx51_aic3x_data2 =3D {
 	.gpio_reset =3D 60,
 };
=20
+static struct bq2415x_platform_data rx51_bq24150a_platform_data =3D {
+	.current_limit =3D 100,			/* mA */
+	.weak_battery_voltage =3D 3400,		/* mV */
+	.battery_regulation_voltage =3D 4200,	/* mV */
+	.charge_current =3D 650,			/* mA */
+	.termination_current =3D 100,		/* mA */
+	.resistor_sense =3D 68,			/* m ohm */
+	.notify_device =3D "isp1704",
+};
+
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_inf=
o_2[] =3D {
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
@@ -1302,7 +1313,11 @@ static struct i2c_board_info __initdata rx51_per=
ipherals_i2c_board_info_2[] =3D {
 	{
 		I2C_BOARD_INFO("tpa6130a2", 0x60),
 		.platform_data =3D &rx51_tpa6130a2_data,
-	}
+	},
+	{
+		I2C_BOARD_INFO("bq24150a", 0x6b),
+		.platform_data =3D &rx51_bq24150a_platform_data,
+	},
 };
=20
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_inf=
o_3[] =3D {
--=20
1.7.9.5
