From: Pavel Machek <pavel@ucw.cz>
Subject: bq27xxx: add battery protection
Date: Mon, 25 Sep 2017 10:18:11 +0200
Message-ID: <20170925081810.GA32216@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Add battery protection for bq27xxx. Note that thresholds are very low,
so this only kills system long after reasonable userspace should have
reacted.

Signed-off-by: Pavel Machek <pavel@ucw.cz>


diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/=
bq27xxx_battery.c
index 51f0961..08dc193 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -53,6 +53,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/of.h>
=20
@@ -1580,6 +1577,56 @@ void bq27xxx_battery_update(struct bq27xxx_device_in=
fo *di)
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
=20
+static void shutdown(char *reason)
+{
+	pr_alert("Forcing shutdown: %s\n", reason);
+	orderly_poweroff(true);
+}
+
+static int generic_protect(struct power_supply *psy)
+{
+	union power_supply_propval val;
+	int res;
+	int mV, mA, mVadj =3D 0;
+	const int mOhm =3D 430;
+	const int mV_limit =3D 2950;
+	const int mV_open_limit =3D 3150;
+
+	res =3D psy->desc->get_property(psy, POWER_SUPPLY_PROP_HEALTH, &val);
+	if (res)
+		return res;
+
+	if (val.intval =3D=3D POWER_SUPPLY_HEALTH_OVERHEAT)
+		shutdown("Battery overheat.");
+	if (val.intval =3D=3D POWER_SUPPLY_HEALTH_DEAD)
+		shutdown("Battery dead.");
+
+	res =3D psy->desc->get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW, &val);
+	if (res)
+		return res;
+	mV =3D val.intval / 1000;
+
+	if (mV < mV_limit) {
+		pr_alert("Battery below %d mV.", mV_limit);
+		orderly_poweroff(true);
+	}
+
+	res =3D psy->desc->get_property(psy, POWER_SUPPLY_PROP_CURRENT_NOW, &val);
+	if (res)
+		return res;
+	mA =3D val.intval / 1000;
+	mVadj =3D mV + (mA * mOhm) / 1000;
+
+	if (mVadj < mV_open_limit) {
+		pr_alert("Battery open circuit voltage below %d mV.", mV_open_limit);
+		orderly_poweroff(true);
+	}
+=09
+	printk(KERN_INFO "Main battery %d mV, open circuit voltage %d mV\n",
+	       mV, mVadj);
+	return 0;
+}
+
 static void bq27xxx_battery_poll(struct work_struct *work)
 {
 	struct bq27xxx_device_info *di =3D
@@ -1592,6 +1639,16 @@ static void bq27xxx_battery_poll(struct work_struct =
*work)
 		schedule_delayed_work(&di->work, poll_interval * HZ);
 }
=20
+static void bq27xxx_battery_poll_protect(struct work_struct *work)
+{
+	struct bq27xxx_device_info *di =3D
+			container_of(work, struct bq27xxx_device_info,
+				     work.work);
+
+	bq27xxx_battery_poll(work);
+	generic_protect(di->bat);
+}
+
 /*
  * Return the battery average current in =B5A
  * Note that current can be negative signed as well
@@ -1684,8 +1741,8 @@ static int bq27xxx_battery_capacity_level(struct bq27=
xxx_device_info *di,
 }
=20
 /*
- * Return the battery Voltage in millivolts
- * Or < 0 if something fails.
+ * Set val->intval to the battery Voltage in millivolts.
+ * Return < 0 if something fails.
  */
 static int bq27xxx_battery_voltage(struct bq27xxx_device_info *di,
 				   union power_supply_propval *val)
@@ -1821,7 +1878,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info =
*di)
 		.drv_data =3D di,
 	};
=20
-	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
+	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll_protect);
 	mutex_init(&di->lock);
=20
 	di->regs       =3D bq27xxx_chip_data[di->chip].regs;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnIu8IACgkQMOfwapXb+vKCYQCfaDjPCkBfv7bES9SwXiaHxDDr
2joAn1BYE2CLDOEyQmjt8Piztu0JxE9e
=SQYk
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
