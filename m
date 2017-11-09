From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: [PATCH] Add support for bq27521 battery monitor
Date: Thu, 9 Nov 2017 22:06:15 +0100
Message-ID: <20171109210615.GA27638@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, afd-l0cyMroinI0@public.gmane.org, kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This adds basic support for BQ27521 battery monitor, used in Nokia N9
and N950. In particular, battery voltage is important to be able to
tell when the battery is almost empty. Emptying battery on N950 is
pretty painful, as flasher needs to be used to recover phone in such case.

Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/D=
ocumentation/devicetree/bindings/power/supply/bq27xxx.txt
index 6858e1a..615c1cb 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
@@ -15,6 +15,7 @@ Required properties:
  * "ti,bq27520g2" - BQ27520-g2
  * "ti,bq27520g3" - BQ27520-g3
  * "ti,bq27520g4" - BQ27520-g4
+ * "ti,bq27521" - BQ27521
  * "ti,bq27530" - BQ27530
  * "ti,bq27531" - BQ27531
  * "ti,bq27541" - BQ27541
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/=
bq27xxx_battery.c
index ed44439..ee2851a 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -381,6 +381,30 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
 		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
 		BQ27XXX_DM_REG_ROWS,
 	},
+	[BQ27521] =3D {				/* FIXME */
+		[BQ27XXX_REG_CTRL] =3D 0x02,
+		[BQ27XXX_REG_TEMP] =3D 0x0a,
+		[BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_VOLT] =3D 0x0c,
+		[BQ27XXX_REG_AI] =3D 0x0e,
+		[BQ27XXX_REG_FLAGS] =3D 0x08,
+		[BQ27XXX_REG_TTE] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTF] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_FCC] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_CYCT] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
+		[BQ27XXX_DM_CTRL] =3D INVALID_REG_ADDR,
+		[BQ27XXX_DM_CLASS] =3D INVALID_REG_ADDR,
+		[BQ27XXX_DM_BLOCK] =3D INVALID_REG_ADDR,
+		[BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
+		[BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
+	},
 	[BQ27530] =3D {
 		[BQ27XXX_REG_CTRL] =3D 0x00,
 		[BQ27XXX_REG_TEMP] =3D 0x06,
@@ -700,6 +724,15 @@ static enum power_supply_property bq27520g4_battery_pr=
ops[] =3D {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
=20
+static enum power_supply_property bq27521_battery_props[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+};
+
 static enum power_supply_property bq27530_battery_props[] =3D {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -792,6 +825,7 @@ static struct {
 	BQ27XXX_PROP(BQ27520G2, bq27520g2_battery_props),
 	BQ27XXX_PROP(BQ27520G3, bq27520g3_battery_props),
 	BQ27XXX_PROP(BQ27520G4, bq27520g4_battery_props),
+	BQ27XXX_PROP(BQ27521, bq27521_battery_props),
 	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
 	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
 	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
@@ -1529,6 +1563,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_d=
evice_info *di, u16 flags)
 	case BQ27520G2:
 	case BQ27520G3:
 	case BQ27520G4:
+	case BQ27521:
 	case BQ27541:
 	case BQ27545:
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/sup=
ply/bq27xxx_battery_i2c.c
index a597221..fd9b989 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -239,6 +239,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[=
] =3D {
 	{ "bq27520g2", BQ27520G2 },
 	{ "bq27520g3", BQ27520G3 },
 	{ "bq27520g4", BQ27520G4 },
+	{ "bq27521", BQ27521 },
 	{ "bq27530", BQ27530 },
 	{ "bq27531", BQ27530 },
 	{ "bq27541", BQ27541 },
@@ -269,6 +270,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of=
_match_table[] =3D {
 	{ .compatible =3D "ti,bq27520g2" },
 	{ .compatible =3D "ti,bq27520g3" },
 	{ .compatible =3D "ti,bq27520g4" },
+	{ .compatible =3D "ti,bq27521" },
 	{ .compatible =3D "ti,bq27530" },
 	{ .compatible =3D "ti,bq27531" },
 	{ .compatible =3D "ti,bq27541" },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq=
27xxx_battery.h
index 11e1168..1e80931 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -14,6 +14,7 @@ enum bq27xxx_chip {
 	BQ27520G2, /* bq27520G2 */
 	BQ27520G3, /* bq27520G3 */
 	BQ27520G4, /* bq27520G4 */
+	BQ27521, /* bq27521 */=09
 	BQ27530, /* bq27530, bq27531 */
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloEw0cACgkQMOfwapXb+vJ7oQCfcXPFMCOuX5oeB6z+HnJ++ArR
kjAAnjC8t2YaHQ1zev8H2s4O82189aIu
=iPOP
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
