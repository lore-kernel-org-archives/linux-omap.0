From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 06/10] input: touchscreen: edt-ft5x06: fix driver autoprobing
Date: Tue, 18 Nov 2014 12:07:04 -0600
Message-ID: <1416334028-7766-6-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <lw@karo-electronics.de>, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

i2c devices match against struct i2c_device_id
even for CONFIG_OF case, so adding a struct of_device_id
doesn't change anything. As a result, currently, edt-ft5x06
will not autoprobe if built as a module.

To fix the issue and still maintain backwards compatibility
with all DTS files currently in tree, we're just moving
all ids from of_device_id to i2c_device_id while also
adding the following specific ids which should be used
from now on:

	{ "edt-ft5206", 0, }
	{ "edt-ft5306", 0, }
	{ "edt-ft5406", 0, }

Cc: Lothar Wa=C3=9Fmann <lw@karo-electronics.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <devicetree@vger.kernel.org>
Cc: <linux-input@vger.kernel.org>
Cc: <stable@vger.kernel.org> # v3.15+
=46ixes: dac90dc2 (Input: edt-ft5x06 - add DT support)
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 .../bindings/input/touchscreen/edt-ft5x06.txt           |  9 ++++++---
 drivers/input/touchscreen/edt-ft5x06.c                  | 17 ++++++---=
--------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft=
5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x=
06.txt
index 76db967..50bd5d2 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.tx=
t
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.tx=
t
@@ -14,9 +14,12 @@ bindings.
=20
=20
 Required properties:
- - compatible:  "edt,edt-ft5206"
-           or:  "edt,edt-ft5306"
-           or:  "edt,edt-ft5406"
+ - compatible:  "edt-ft5206"
+	   or:  "edt-ft5306"
+	   or:  "edt-ft5406"
+	   or:  "edt,edt-ft5206" (deprecated)
+           or:  "edt,edt-ft5306" (deprecated)
+           or:  "edt,edt-ft5406" (deprecated)
=20
  - reg:         I2C slave address of the chip (0x38)
  - interrupt-parent: a phandle pointing to the interrupt controller
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/tou=
chscreen/edt-ft5x06.c
index ee3434f..f161ff9 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1119,25 +1119,20 @@ static SIMPLE_DEV_PM_OPS(edt_ft5x06_ts_pm_ops,
=20
 static const struct i2c_device_id edt_ft5x06_ts_id[] =3D {
 	{ "edt-ft5x06", 0, },
+	{ "edt-ft5206", 0, },
+	{ "edt-ft5306", 0, },
+	{ "edt-ft5406", 0, },
+	{ "edt,edt-ft5206", 0, },
+	{ "edt,edt-ft5306", 0, },
+	{ "edt,edt-ft5406", 0, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, edt_ft5x06_ts_id);
=20
-#ifdef CONFIG_OF
-static const struct of_device_id edt_ft5x06_of_match[] =3D {
-	{ .compatible =3D "edt,edt-ft5206", },
-	{ .compatible =3D "edt,edt-ft5306", },
-	{ .compatible =3D "edt,edt-ft5406", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, edt_ft5x06_of_match);
-#endif
-
 static struct i2c_driver edt_ft5x06_ts_driver =3D {
 	.driver =3D {
 		.owner =3D THIS_MODULE,
 		.name =3D "edt_ft5x06",
-		.of_match_table =3D of_match_ptr(edt_ft5x06_of_match),
 		.pm =3D &edt_ft5x06_ts_pm_ops,
 	},
 	.id_table =3D edt_ft5x06_ts_id,
--=20
2.1.0.GIT

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
