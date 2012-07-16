From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH RFT] regulator: twl: Fix list_voltate for twl6030ldo_ops
Date: Mon, 16 Jul 2012 18:31:10 +0800
Message-ID: <1342434670.4717.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, loml <linux-omap@vger.kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

According to the datasheet, the voltage for twl6030ldo_ops is not linea=
r for
all cases. Linear mapping is only for the selection code from
00000001 to 00011000.

Table 9. LDO Output Voltage Selection Code
CODE     VOUT(V)    COD      VOUT(V)    CODE     VOUT(V)    CODE     VO=
UT(V)
00000000 0          00001000 1.7        00010000 2.5        00011000 3.=
3
00000001 1.0        00001001 1.8        00010001 2.6        00011001 Re=
served
00000010 1.1        00001010 1.9        00010010 2.7        00011010 Re=
served
00000011 1.2        00001011 2.0        00010011 2.8        00011011 Re=
served
00000100 1.3        00001100 2.1        00010100 2.9        00011100 Re=
served
00000101 1.4        00001101 2.2        00010101 3.0        00011101 Re=
served
00000110 1.5        00001110 2.3        00010110 3.1        00011110 Re=
served
00000111 1.6        00001111 2.4        00010111 3.2        00011111 2.=
75

This patch implements the list_voltage callback based on above table.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/regulator/twl-regulator.c |   31 ++++++++++++++++++++++++-----=
--
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-=
regulator.c
index de99b78..242fe90 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -559,6 +559,27 @@ static struct regulator_ops twl6030coresmps_ops =3D=
 {
 	.get_voltage	=3D twl6030coresmps_get_voltage,
 };
=20
+static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsigne=
d sel)
+{
+	struct twlreg_info *info =3D rdev_get_drvdata(rdev);
+
+	switch (sel) {
+	case 0:
+		return 0;
+	case 1 ... 24:
+		/* Linear mapping from 00000001 to 00011000:
+		 * Absolute voltage value =3D 1.0 V + 0.1 V =C3=97 (sel =E2=80=93 00=
000001)
+		 */
+		return (info->min_mV + 100 * (sel - 1)) * 1000;
+	case 25 ... 30:
+		return -EINVAL;
+	case 31:
+		return 2750000;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int
 twl6030ldo_set_voltage_sel(struct regulator_dev *rdev, unsigned select=
or)
 {
@@ -577,7 +598,7 @@ static int twl6030ldo_get_voltage_sel(struct regula=
tor_dev *rdev)
 }
=20
 static struct regulator_ops twl6030ldo_ops =3D {
-	.list_voltage	=3D regulator_list_voltage_linear,
+	.list_voltage	=3D twl6030ldo_list_voltage,
=20
 	.set_voltage_sel =3D twl6030ldo_set_voltage_sel,
 	.get_voltage_sel =3D twl6030ldo_get_voltage_sel,
@@ -906,12 +927,10 @@ static struct twlreg_info TWL6030_INFO_##label =3D=
 { \
 	.desc =3D { \
 		.name =3D #label, \
 		.id =3D TWL6030_REG_##label, \
-		.n_voltages =3D (max_mVolts - min_mVolts)/100 + 1, \
+		.n_voltages =3D 32, \
 		.ops =3D &twl6030ldo_ops, \
 		.type =3D REGULATOR_VOLTAGE, \
 		.owner =3D THIS_MODULE, \
-		.min_uV =3D min_mVolts * 1000, \
-		.uV_step =3D 100 * 1000, \
 		}, \
 	}
=20
@@ -923,12 +942,10 @@ static struct twlreg_info TWL6025_INFO_##label =3D=
 { \
 	.desc =3D { \
 		.name =3D #label, \
 		.id =3D TWL6025_REG_##label, \
-		.n_voltages =3D ((max_mVolts - min_mVolts)/100) + 1, \
+		.n_voltages =3D 32, \
 		.ops =3D &twl6030ldo_ops, \
 		.type =3D REGULATOR_VOLTAGE, \
 		.owner =3D THIS_MODULE, \
-		.min_uV =3D min_mVolts * 1000, \
-		.uV_step =3D 100 * 1000, \
 		}, \
 	}
=20
--=20
1.7.9.5
