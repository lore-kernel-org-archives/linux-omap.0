From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] bq24190: Simplify code in property_is_writeable
Date: Wed, 27 Dec 2017 10:20:42 +0100
Message-ID: <20171227092041.GA14507@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify function that should be trivial.

Signed-off-by: Pavel machek <pavel@ucw.cz>

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/=
bq24190_charger.c
index 35ff406..4ea8f0a 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1193,8 +1193,6 @@ static int bq24190_charger_set_property(struct power_=
supply *psy,
 static int bq24190_charger_property_is_writeable(struct power_supply *psy,
 		enum power_supply_property psp)
 {
-	int ret;
-
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
 	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
@@ -1202,13 +1200,10 @@ static int bq24190_charger_property_is_writeable(st=
ruct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		ret =3D 1;
-		break;
+		return 1;
 	default:
-		ret =3D 0;
+		return 0;
 	}
-
-	return ret;
 }
=20
 static void bq24190_input_current_limit_work(struct work_struct *work)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpDZekACgkQMOfwapXb+vLTcgCfV+9s5i7jEKZbPc9yCPqfQe4X
MdsAoKinRoq6w0LGo9r5UZBbiJoT3OpO
=qkqz
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
