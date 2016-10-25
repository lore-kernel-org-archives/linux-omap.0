From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] shutdown machine when li-ion battery goes below 3V
Date: Tue, 25 Oct 2016 12:24:35 +0200
Message-ID: <20161025102435.GA6916@amd>
References: <20161024212250.GA31336@amd>
 <20161024212932.uhjz752z2cy5hohl@atomide.com>
 <20161024214152.GA32310@amd>
 <201610242348.47484@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201610242348.47484@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-10-24 23:48:47, Pali Roh=E1r wrote:
> On Monday 24 October 2016 23:41:52 Pavel Machek wrote:
> > On Mon 2016-10-24 14:29:33, Tony Lindgren wrote:
> > > Also, the shutdown voltage can depend on external devices
> > > connected. It could be for example 3.3V depending on eMMC on some
> > > devices while devices with no eMMC could have it at 3.0V.
> >=20
> > Actually, I'd like to shutdown at 3.3V or more (like 3.5V), because
> > going below that is pretty mean to the battery. But if I set
> > threshold too high, GSM activity will push it below that for a very
> > short while, and I'll shutdown too soon.
> >=20
> > Ideas welcome...
>=20
> bq27x00 has EDVF flag which means that battery is empty. Maemo with=20
> bq27x00 driver is configured to issue system shutdown when EDVF is set.
>=20
> Maybe kernel should issue emergency shutdown e.g. after minute or two=20
> after EDVF flag is set?

Thanks for pointer.

EDVF seems to be exposed as health. ... but only if battery is
calibrated, AFAICT.

 if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) {
      dev_info_once(di->dev, "battery is not calibrated! ignoring capacity =
values\n");
      ...
      cache.health =3D -ENODATA;

Plus, it prioritizes battery cold over battery dead. IMO we don't need
to shutdown on battery cold (we just may not charge the battery), but
we need to shutdown on battery dead.

So something like this?

								Pavel

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/=
bq27xxx_battery.c
index 8eb2f8f..5ddf6d7 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -680,10 +680,10 @@ static int bq27xxx_battery_read_health(struct bq27xxx=
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


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgPMuMACgkQMOfwapXb+vIq7gCdEqdyx0MBDU3992IQT6z7HEV4
GWgAmwRTsaBkCFVaJkey0vX+WSNqpeMo
=RcH+
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
