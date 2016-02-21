From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 5/6] power_supply: bq27xxx_battery: Add of modalias and match table when CONFIG_OF is enabled
Date: Sun, 21 Feb 2016 12:28:22 +0100
Message-ID: <1456054103-19551-6-git-send-email-pali.rohar@gmail.com>
References: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/power/bq27xxx_battery.c     |   12 ++++++++++++
 drivers/power/bq27xxx_battery_i2c.c |   24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_ba=
ttery.c
index 6b027a4..45f6ebf 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -46,6 +46,7 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
+#include <linux/of.h>
=20
 #include <linux/power/bq27xxx_battery.h>
=20
@@ -1090,16 +1091,27 @@ static const struct platform_device_id bq27xxx_=
battery_platform_id_table[] =3D {
 };
 MODULE_DEVICE_TABLE(platform, bq27xxx_battery_platform_id_table);
=20
+#ifdef CONFIG_OF
+static const struct of_device_id bq27xxx_battery_platform_of_match_tab=
le[] =3D {
+	{ .compatible =3D "ti,bq27000" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bq27xxx_battery_platform_of_match_table);
+#endif
+
 static struct platform_driver bq27xxx_battery_platform_driver =3D {
 	.probe	=3D bq27xxx_battery_platform_probe,
 	.remove =3D bq27xxx_battery_platform_remove,
 	.driver =3D {
 		.name =3D "bq27000-battery",
+		.of_match_table =3D of_match_ptr(bq27xxx_battery_platform_of_match_t=
able),
 	},
 	.id_table =3D bq27xxx_battery_platform_id_table,
 };
 module_platform_driver(bq27xxx_battery_platform_driver);
=20
+MODULE_ALIAS("platform:bq27000-battery");
+
 MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
 MODULE_DESCRIPTION("BQ27xxx battery monitor driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/power/bq27xxx_battery_i2c.c b/drivers/power/bq27xx=
x_battery_i2c.c
index 9429e66..b810e08 100644
--- a/drivers/power/bq27xxx_battery_i2c.c
+++ b/drivers/power/bq27xxx_battery_i2c.c
@@ -135,9 +135,33 @@ static const struct i2c_device_id bq27xxx_i2c_id_t=
able[] =3D {
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
=20
+#ifdef CONFIG_OF
+static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] =
=3D {
+	{ .compatible =3D "ti,bq27200" },
+	{ .compatible =3D "ti,bq27210" },
+	{ .compatible =3D "ti,bq27500" },
+	{ .compatible =3D "ti,bq27510" },
+	{ .compatible =3D "ti,bq27520" },
+	{ .compatible =3D "ti,bq27530" },
+	{ .compatible =3D "ti,bq27531" },
+	{ .compatible =3D "ti,bq27541" },
+	{ .compatible =3D "ti,bq27542" },
+	{ .compatible =3D "ti,bq27546" },
+	{ .compatible =3D "ti,bq27742" },
+	{ .compatible =3D "ti,bq27545" },
+	{ .compatible =3D "ti,bq27421" },
+	{ .compatible =3D "ti,bq27425" },
+	{ .compatible =3D "ti,bq27441" },
+	{ .compatible =3D "ti,bq27621" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
+#endif
+
 static struct i2c_driver bq27xxx_battery_i2c_driver =3D {
 	.driver =3D {
 		.name =3D "bq27xxx-battery",
+		.of_match_table =3D of_match_ptr(bq27xxx_battery_i2c_of_match_table)=
,
 	},
 	.probe =3D bq27xxx_battery_i2c_probe,
 	.remove =3D bq27xxx_battery_i2c_remove,
--=20
1.7.9.5
