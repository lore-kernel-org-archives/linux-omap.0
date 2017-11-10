From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: [PATCH v4.14] Add support for bq27521 battery monitor
Date: Fri, 10 Nov 2017 11:39:37 +0100
Message-ID: <20171110103937.GA29900@amd>
References: <20171109210615.GA27638@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171109210615.GA27638@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, afd-l0cyMroinI0@public.gmane.org, kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=20
This adds basic support for BQ27521 battery monitor, used in Nokia N9
and N950. In particular, battery voltage is important to be able to
tell when the battery is almost empty. Emptying battery on N950 is
pretty painful, as flasher needs to be used to recover phone in such case.

Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/=
bq27xxx_battery.c
index 51f0961..f684288 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -323,6 +323,30 @@ static u8
 		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
 		BQ27XXX_DM_REG_ROWS,
 	},
+	bq27521_regs[BQ27XXX_REG_MAX] =3D {
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
 	bq27530_regs[BQ27XXX_REG_MAX] =3D {
 		[BQ27XXX_REG_CTRL] =3D 0x00,
 		[BQ27XXX_REG_TEMP] =3D 0x06,
@@ -557,6 +581,15 @@ static enum power_supply_property bq27520g4_props[] =
=3D {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
=20
+static enum power_supply_property bq27521_props[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+};
+
 static enum power_supply_property bq27530_props[] =3D {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -671,6 +704,7 @@ static struct bq27xxx_dm_reg bq27500_dm_regs[] =3D {
 #define bq27520g2_dm_regs 0
 #define bq27520g3_dm_regs 0
 #define bq27520g4_dm_regs 0
+#define bq27521_dm_regs 0
 #define bq27530_dm_regs 0
 #define bq27531_dm_regs 0
 #define bq27541_dm_regs 0
@@ -717,8 +751,8 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {
 #endif
=20
 #define BQ27XXX_O_ZERO	0x00000001
-#define BQ27XXX_O_OTDC	0x00000002
-#define BQ27XXX_O_UTOT  0x00000004
+#define BQ27XXX_O_OTDC	0x00000002 /* has OTC/OTD overtemperature flags */
+#define BQ27XXX_O_UTOT  0x00000004 /* has OT overtemperature flag */
 #define BQ27XXX_O_CFGUP	0x00000008
 #define BQ27XXX_O_RAM	0x00000010
=20
@@ -751,6 +785,7 @@ static struct {
 	[BQ27520G2] =3D BQ27XXX_DATA(bq27520g2, 0         , BQ27XXX_O_OTDC),
 	[BQ27520G3] =3D BQ27XXX_DATA(bq27520g3, 0         , BQ27XXX_O_OTDC),
 	[BQ27520G4] =3D BQ27XXX_DATA(bq27520g4, 0         , BQ27XXX_O_OTDC),
+	[BQ27521]   =3D BQ27XXX_DATA(bq27521,   0         , 0),
 	[BQ27530]   =3D BQ27XXX_DATA(bq27530,   0         , BQ27XXX_O_UTOT),
 	[BQ27531]   =3D BQ27XXX_DATA(bq27531,   0         , BQ27XXX_O_UTOT),
 	[BQ27541]   =3D BQ27XXX_DATA(bq27541,   0         , BQ27XXX_O_OTDC),
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/sup=
ply/bq27xxx_battery_i2c.c
index 0b11ed4..6b25e5f 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -239,6 +239,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[=
] =3D {
 	{ "bq27520g2", BQ27520G2 },
 	{ "bq27520g3", BQ27520G3 },
 	{ "bq27520g4", BQ27520G4 },
+	{ "bq27521", BQ27521 },
 	{ "bq27530", BQ27530 },
 	{ "bq27531", BQ27531 },
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
diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
index 9ad7828..6547d30 100644
--- a/include/linux/mfd/twl.h
+++ b/include/linux/mfd/twl.h
@@ -70,6 +70,7 @@ enum twl4030_module_ids {
 	TWL4030_MODULE_INT,
=20
 	TWL5031_MODULE_ACCESSORY,
+	TWL5031_MODULE_BCC,
 	TWL5031_MODULE_INTERRUPTS,
=20
 	TWL4030_MODULE_LAST,
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq=
27xxx_battery.h
index 43194e0..d8d127a 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -15,6 +15,7 @@ enum bq27xxx_chip {
 	BQ27520G2, /* bq27520G2 */
 	BQ27520G3, /* bq27520G3 */
 	BQ27520G4, /* bq27520G4 */
+	BQ27521, /* bq27521 */=09
 	BQ27530, /* bq27530, bq27531 */
 	BQ27531,
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloFgekACgkQMOfwapXb+vIRtQCgg0G9hMgfRhu8b40A09LMOdOE
Z50An1rLvh7VgCKuXuq+Rij1NEyF6UWL
=kgq5
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
