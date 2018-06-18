From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Charge counter on droid 4
Date: Mon, 18 Jun 2018 11:34:59 +0200
Message-ID: <20180618093459.GA21391@amd>
References: <20180615080014.GA29192@amd>
 <20180615083156.GA32102@amd>
 <20180618065827.GN112168@atomide.com>
 <20180618074023.GA16955@amd>
 <20180618082858.GO112168@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180618082858.GO112168@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-06-18 01:28:58, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180618 07:43]:
> >=20
> > So... there are mA, mAh values. Those come from hardware, and I
> > believe we should keep them.
> >=20
> > But there are also mW, mWh values, which are synthetic. Userland can
> > compute them from mV, mA values... and it is confusing that kernel
> > provides them. (My tendency was to start computing these synthetic
> > values in userland, to compare them with "real hardware" values from
> > kernel. But then I looked at kernel implementation, and realized they
> > are synthetic, tooo...)
>=20
> Hmm mWh value is based on the hardware sampled shunt
> values and number of samples gathered between the
> two readings. I'd rather call the calculated values
> based on userland reading mV and mA values "synthetic" :)

As far as I know, shunt resistors provide you with current (mA) not
power (mW) measurement... and cpcap-battery computes power_now as
voltage * current. I'd rather have kernel tell me "hardware can't
measure power" and do "voltage*current" computation in userspace.

So I'm proposing to apply patch below.

Best regards,
								Pavel


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

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsnfMMACgkQMOfwapXb+vIFfwCcCLCZwXLZWeQUuqjd5jI1NaSm
E0gAoMLIkykEZ+W2nhRRwBpsl2CM8zwn
=LJt3
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
