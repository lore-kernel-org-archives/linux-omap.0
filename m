From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 4/6] power_supply: bq2415x_charger: Add of modalias and match table when CONFIG_OF is enabled
Date: Sun, 21 Feb 2016 12:28:21 +0100
Message-ID: <1456054103-19551-5-git-send-email-pali.rohar@gmail.com>
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
 drivers/power/bq2415x_charger.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_ch=
arger.c
index b0863f4..73e2f0b 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1779,9 +1779,29 @@ static const struct acpi_device_id bq2415x_i2c_a=
cpi_match[] =3D {
 MODULE_DEVICE_TABLE(acpi, bq2415x_i2c_acpi_match);
 #endif
=20
+#ifdef CONFIG_OF
+static const struct of_device_id bq2415x_of_match_table[] =3D {
+	{ .compatible =3D "ti,bq24150" },
+	{ .compatible =3D "ti,bq24150a" },
+	{ .compatible =3D "ti,bq24151" },
+	{ .compatible =3D "ti,bq24151a" },
+	{ .compatible =3D "ti,bq24152" },
+	{ .compatible =3D "ti,bq24153" },
+	{ .compatible =3D "ti,bq24153a" },
+	{ .compatible =3D "ti,bq24155" },
+	{ .compatible =3D "ti,bq24156" },
+	{ .compatible =3D "ti,bq24156a" },
+	{ .compatible =3D "ti,bq24157s" },
+	{ .compatible =3D "ti,bq24158" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bq2415x_of_match_table);
+#endif
+
 static struct i2c_driver bq2415x_driver =3D {
 	.driver =3D {
 		.name =3D "bq2415x-charger",
+		.of_match_table =3D of_match_ptr(bq2415x_of_match_table),
 		.acpi_match_table =3D ACPI_PTR(bq2415x_i2c_acpi_match),
 	},
 	.probe =3D bq2415x_probe,
--=20
1.7.9.5
