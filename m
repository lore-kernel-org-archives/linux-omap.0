From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 3/6] power_supply: bq2415x_charger: Do not add acpi modalias when CONFIG_ACPI is not enabled
Date: Sun, 21 Feb 2016 12:28:20 +0100
Message-ID: <1456054103-19551-4-git-send-email-pali.rohar@gmail.com>
References: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/power/bq2415x_charger.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_ch=
arger.c
index 27e8953..b0863f4 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1759,6 +1759,7 @@ static const struct i2c_device_id bq2415x_i2c_id_=
table[] =3D {
 };
 MODULE_DEVICE_TABLE(i2c, bq2415x_i2c_id_table);
=20
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id bq2415x_i2c_acpi_match[] =3D {
 	{ "BQ2415X", BQUNKNOWN },
 	{ "BQ241500", BQ24150 },
@@ -1776,6 +1777,7 @@ static const struct acpi_device_id bq2415x_i2c_ac=
pi_match[] =3D {
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, bq2415x_i2c_acpi_match);
+#endif
=20
 static struct i2c_driver bq2415x_driver =3D {
 	.driver =3D {
--=20
1.7.9.5

