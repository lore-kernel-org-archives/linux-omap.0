From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Charge counter on droid 4
Date: Fri, 15 Jun 2018 10:31:56 +0200
Message-ID: <20180615083156.GA32102@amd>
References: <20180615080014.GA29192@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180615080014.GA29192@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-15 10:00:14, Pavel Machek wrote:
> Hi!
>=20
> Droid 4 has non-removable battery, yet the charge counter is reset to
> near zero on each boot of linux.
>=20
> Unfortunately, that makes charge counter pretty much useless on d4, as
> the "battery full" and "battery empty" limits will be different during
> each boot.

Hmm, and could we refrain from providing "power" values?

I was thinking great, we have hardware that does proper power
measuerement for us. No.... it is driver providing synthetic
values. As userland has enough information to do that itself, I
believe we should not do this in kernel.

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cp=
cap-battery.c
index 839e365..1610026 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -490,24 +490,6 @@ static int cpcap_battery_get_property(struct power_sup=
ply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		val->intval =3D latest->counter_uah;
 		break;
-	case POWER_SUPPLY_PROP_POWER_NOW:
-		tmp =3D (latest->voltage / 10000) * latest->current_ua;
-		val->intval =3D div64_s64(tmp, 100);
-		break;
-	case POWER_SUPPLY_PROP_POWER_AVG:
-		if (cached) {
-			tmp =3D cpcap_battery_cc_get_avg_current(ddata);
-			tmp *=3D (latest->voltage / 10000);
-			val->intval =3D div64_s64(tmp, 100);
-			break;
-		}
-		sample =3D latest->cc.sample - previous->cc.sample;
-		accumulator =3D latest->cc.accumulator - previous->cc.accumulator;
-		tmp =3D cpcap_battery_cc_to_ua(ddata, sample, accumulator,
-					     latest->cc.offset);
-		tmp *=3D ((latest->voltage + previous->voltage) / 20000);
-		val->intval =3D div64_s64(tmp, 100);
-		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		if (cpcap_battery_full(ddata))
 			val->intval =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAlsjeXwACgkQMOfwapXb+vKlswCggDsZ+YFfzrNvJtdguoJDCIfX
Dk0AlRrUXv0GnMx05KgyILmEEasa/4U=
=wJlv
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
