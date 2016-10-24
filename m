From: Pavel Machek <pavel@ucw.cz>
Subject: [RFC] shutdown machine when li-ion battery goes below 3V
Date: Mon, 24 Oct 2016 23:22:50 +0200
Message-ID: <20161024212250.GA31336@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

What about something like this? N900 will drain the battery down to
system crash, which is quite uncool.

									Pavel


diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/=
bq27xxx_battery.c
index 0fe278b..8eb2f8f 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/of.h>
=20
@@ -740,6 +741,9 @@ void bq27xxx_battery_update(struct bq27xxx_device_info =
*di)
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
=20
+static int bq27xxx_battery_protect(struct bq27xxx_device_info *di);
+
+
 static void bq27xxx_battery_poll(struct work_struct *work)
 {
 	struct bq27xxx_device_info *di =3D
@@ -747,6 +751,7 @@ static void bq27xxx_battery_poll(struct work_struct *wo=
rk)
 				     work.work);
=20
 	bq27xxx_battery_update(di);
+	bq27xxx_battery_protect(di);
=20
 	if (poll_interval > 0)
 		schedule_delayed_work(&di->work, poll_interval * HZ);
@@ -958,6 +963,41 @@ static int bq27xxx_battery_get_property(struct power_s=
upply *psy,
 	return ret;
 }
=20
+static int bq27xxx_battery_protect(struct bq27xxx_device_info *di)
+{
+	union power_supply_propval val;
+	int mV, mA, mOhm =3D 430, mVadj;
+	int res;
+
+	printk(KERN_INFO "Main battery check\n");
+
+	res =3D bq27xxx_battery_voltage(di, &val);
+	if (res)
+		return res;
+
+	mV =3D val.intval / 1000;
+=09
+	if (mV < 2950) {
+		printk(KERN_ALERT "Main battery below 2.95V, forcing shutdown.\n");
+		orderly_poweroff(true);
+	}
+
+	res =3D bq27xxx_battery_current(di, &val);
+	if (res)
+		return res;
+=09
+	mA =3D val.intval / 1000;
+	mVadj =3D mV + (mA * mOhm) / 1000;
+
+	if (mVadj < 3150) {
+		printk(KERN_ALERT "Main battery internal voltage below 3.15, shutdown.\n=
");
+		orderly_poweroff(true);
+	}
+	printk(KERN_INFO "Main battery %d mV, internal voltage %d mV\n",
+	       mV, mVadj);
+	return 0;
+}
+
 static void bq27xxx_external_power_changed(struct power_supply *psy)
 {
 	struct bq27xxx_device_info *di =3D power_supply_get_drvdata(psy);
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 226b0b4ac..bcdc1f8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -444,7 +444,7 @@ static void handle_critical_trips(struct thermal_zone_d=
evice *tz,
=20
 	if (trip_type =3D=3D THERMAL_TRIP_CRITICAL) {
 		dev_emerg(&tz->device,
-			  "critical temperature reached(%d C),shutting down\n",
+			  "critical temperature reached(%d C), shutting down\n",
 			  tz->temperature / 1000);
 		orderly_poweroff(true);
 	}

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgOe6oACgkQMOfwapXb+vKNlwCfXr6h0Orvbf0otT7BRQbsTt5v
e3kAnRbstJmTqSfPtsHOOAr4cGcrGS+o
=N9KX
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
