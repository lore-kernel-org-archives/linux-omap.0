From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Motorola Droid 4 progress, power consumption
Date: Fri, 4 May 2018 22:20:44 +0200
Message-ID: <20180504202044.GC22519@amd>
References: <20180501183148.GA26996@amd>
 <20180502144158.GJ98604@atomide.com>
 <20180503090611.GA14451@amd>
 <20180503142240.GQ98604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180503142240.GQ98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > user@devuan:/sys/class/power_supply/battery$ date; cat current_now
> > current_avg
> > Thu May  3 09:33:07 CEST 2018
> > -56000
> > -72308
> > user@devuan:/sys/class/power_supply/battery$ date; cat current_now
> > current_avg
> > Thu May  3 09:33:08 CEST 2018
> > -37000
> > -211362
>=20
> I recall it just being calculated based on the time between
> the reads. Hard to say what it does, -ENODOCS.. Maybe the mc13783
> PMIC docs have something similar.

Hmm. current_avg is world readable; if it does changes to the
hardware, that's somehow bad.

But I guess I can sample charge_counter every minute or so and get
what I need?

> > > Hmm oh and the POWER_SUPPLY_CHARGE_COUNTER value should be monitored
> > > by your libbattery and it's low value and high value should be saved
> > > to a file. Low should be saved when we get the battery low interrupt
> > > and battery state changes to POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL.
> > > High value should be saved on POWER_SUPPLY_CAPACITY_LEVEL_FULL.
> > >=20
> > > Then when you know the high value and low value, you can calculate
> > > the remaining capacity based on the current value and
> > > POWER_SUPPLY_POWER_AVG.
> >=20
> > I'll look into that... but probably will do experiments with python,
> > first.
>=20
> Sure. The reason why I think we should not do it in the kernel in
> addition to the earlier reasoning is that we don't have a place
> to store the min and max values across reboot. I think there's
> some flash on the battery over 1w bus, but it probably just
> contains battery serial number or something and is not intended
> for writing much to it. I guess the min and max values should be
> really keyd based on this battery id in case the battery gets
> changed.

I agree this should not be done in kernel as it requires persistent
storage.

Battery is not user-replacable (and this will recalibrate itself on
charge/discharge cycle) so.. I don't think keying is strictly
neccessary for D4.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrswJwACgkQMOfwapXb+vIH7QCgpxYlXpWTAwSJ80cbWykIGDz8
tBEAnR0kn4Hui9uXJbjI4Pfmqhiq4NHp
=epNT
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
