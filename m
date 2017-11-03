From: Pavel Machek <pavel@ucw.cz>
Subject: Battery charging, battery status on Nokia N9, N950
Date: Fri, 3 Nov 2017 22:03:49 +0100
Message-ID: <20171103210349.GA14071@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm fighting with battery status & battery charging on Nokia
N9/N950. https://elinux.org/N950 contains enough info to get battery
status (and below is first attempt at kernel implementation), but I'm
not sure what needs to be done to charge the battery (or at least
power phone from USB).

Any ideas?

Thanks,
							Pavel

commit ef0a23a4d522489c4aa7be114bbc1acb604b35b6
Author: Pavel <pavel@ucw.cz>
Date:   Fri Nov 3 21:34:53 2017 +0100

    Add support for bq27521 battery gauge.
   =20
    Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3=
-n950-n9.dtsi
index 6fc1acc..b42a265 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -276,6 +276,26 @@
=20
 &i2c2 {
 	clock-frequency =3D <400000>;
+
+	bq27521: bq27521@55 {
+		compatible =3D "ti,bq27521";
+		reg =3D <0x55>;
+	};
+
+
+	bq24153a@6b {
+		compatible =3D "ti,bq24150a";
+ 		reg =3D <0x6b>;
+
+                ti,current-limit =3D <100>;
+ 		ti,weak-battery-voltage =3D <3400>;
+ 		ti,battery-regulation-voltage =3D <4000>; /* FIXME: 4200 */
+ 		ti,charge-current =3D <500>; /* FIXME: 650 */
+ 		ti,termination-current =3D <100>;
+
+		ti,resistor-sense =3D <68>;
+ 		ti,usb-charger-detection =3D <&twl_power>;
+	};
 };
=20
 &i2c3 {
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/=
bq27xxx_battery.c
index ed44439..4ab2bfc 100644
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
+		[BQ27XXX_REG_AI] =3D INVALID_REG_ADDR,
+		[BQ27XXX_REG_FLAGS] =3D INVALID_REG_ADDR,
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
@@ -1594,6 +1629,11 @@ void bq27xxx_battery_update(struct bq27xxx_device_in=
fo *di)
 	bool has_ci_flag =3D di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010;
 	bool has_singe_flag =3D di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ2701=
0;
=20
+	if (di->chip =3D=3D BQ27521) {
+		di->cache.flags =3D 0;
+		return;
+	}
+
 	cache.flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
 	if ((cache.flags & 0xff) =3D=3D 0xff)
 		cache.flags =3D -1; /* read error */
@@ -1792,11 +1832,14 @@ static int bq27xxx_battery_get_property(struct powe=
r_supply *psy,
 	if (psp !=3D POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
 		return -ENODEV;
=20
+	printk("bq27: get property %d\n", psp);
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		ret =3D bq27xxx_battery_status(di, val);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		printk("bq27: get voltage\n");
 		ret =3D bq27xxx_battery_voltage(di, val);
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -1998,8 +2041,12 @@ static int bq27xxx_battery_platform_probe(struct pla=
tform_device *pdev)
=20
 	platform_set_drvdata(pdev, di);
=20
+	printk("bq27: probe\n");
 	di->dev =3D &pdev->dev;
 	di->chip =3D pdata->chip;
+	printk("bq27: probe chip %d\n", di->chip);
+	di->chip =3D BQ27521;
+	printk("bq27: probe chip %d\n", di->chip);=09
 	di->name =3D pdata->name ?: dev_name(&pdev->dev);
 	di->bus.read =3D bq27xxx_battery_platform_read;
=20
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

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAln82bUACgkQMOfwapXb+vL0YACgqVax8nM/DhhdW9sEIHSAihMy
z+MAnAkdv320v9H2H1PSKCLeg2Q9xPPc
=6Pqv
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
