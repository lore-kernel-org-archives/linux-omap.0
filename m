From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] shutdown machine when li-ion battery goes below 3V
Date: Tue, 25 Oct 2016 13:27:57 +0200
Message-ID: <20161025112757.GC25855@amd>
References: <20161024212250.GA31336@amd>
 <20161024212932.uhjz752z2cy5hohl@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161024212932.uhjz752z2cy5hohl@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-10-24 14:29:33, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [161024 14:24]:
> > Hi!
> >=20
> > What about something like this? N900 will drain the battery down to
> > system crash, which is quite uncool.
>=20
> Can't we make that generic and configurable for the voltage somehow?
>=20
> Also, the shutdown voltage can depend on external devices connected.
> It could be for example 3.3V depending on eMMC on some devices while
> devices with no eMMC could have it at 3.0V.

Actually, do we need to make it configurable? It looks like we should
respect hardware telling us battery is dead, and only use (low)
hardcoded voltages as a fallback.

Currently patch looks like this. generic_protect() should work for
other batteries drivers, too.

								Pavel

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/=
bq27xxx_battery.c
index 0fe278b..04094ad 100644
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
@@ -679,10 +680,10 @@ static int bq27xxx_battery_read_health(struct bq27xxx=
_device_info *di)
 	/* Unlikely but important to return first */
 	if (unlikely(bq27xxx_battery_overtemp(di, flags)))
 		return POWER_SUPPLY_HEALTH_OVERHEAT;
-	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
-		return POWER_SUPPLY_HEALTH_COLD;
 	if (unlikely(bq27xxx_battery_dead(di, flags)))
 		return POWER_SUPPLY_HEALTH_DEAD;
+	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
+		return POWER_SUPPLY_HEALTH_COLD;
=20
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
@@ -740,6 +741,49 @@ void bq27xxx_battery_update(struct bq27xxx_device_info=
 *di)
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
=20
+static void shutdown(char *reason)
+{
+	pr_alert("%s Forcing shutdown\n", reason);
+	orderly_poweroff(true);
+}
+
+static int generic_protect(struct power_supply *psy)
+{
+	union power_supply_propval val;
+	int res;
+	int mV, mA, mOhm =3D 430, mVadj =3D 0;
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
+	if (mV < 2950)
+		shutdown("Battery below 2.95V.");
+
+	res =3D psy->desc->get_property(psy, POWER_SUPPLY_PROP_CURRENT_NOW, &val);
+	if (res)
+		return res;
+	mA =3D val.intval / 1000;
+	mVadj =3D mV + (mA * mOhm) / 1000;
+
+	if (mVadj < 3150)
+		shutdown("Battery internal voltage below 3.15.");
+=09
+	printk(KERN_INFO "Main battery %d mV, internal voltage %d mV\n",
+	       mV, mVadj);
+	return 0;
+}
+
 static void bq27xxx_battery_poll(struct work_struct *work)
 {
 	struct bq27xxx_device_info *di =3D
@@ -747,6 +791,7 @@ static void bq27xxx_battery_poll(struct work_struct *wo=
rk)
 				     work.work);
=20
 	bq27xxx_battery_update(di);
+	generic_protect(di->bat);
=20
 	if (poll_interval > 0)
 		schedule_delayed_work(&di->work, poll_interval * HZ);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgPQb0ACgkQMOfwapXb+vIoNQCfRMpb2gk4BTZTGzczILL0vGmt
IrMAn3wFCDRNoxkivhoWOeaBbaeETlhT
=mc1+
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
