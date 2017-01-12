From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/6] power: bq24190_charger: Call enable_irq() only at
 the end of probe()
Date: Thu, 12 Jan 2017 22:40:52 +0100
Message-ID: <20170112214051.kx6oaghah5sxtwr3@earth>
References: <20170112004154.31568-1-tony@atomide.com>
 <20170112004154.31568-2-tony@atomide.com>
 <20170112174435.fotlw2mrif4oubdt@earth>
 <CAKvHMgRq3r-6dFTXdJcrUD94BvMzq6w8RRQFgodwoBX3uAZUKw@mail.gmail.com>
 <20170112205811.GJ2630@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vjsn2ym5v4zwsed4"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170112205811.GJ2630@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Breck <liam@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org


--vjsn2ym5v4zwsed4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 12, 2017 at 12:58:11PM -0800, Tony Lindgren wrote:
> * Liam Breck <liam@networkimprov.net> [170112 12:25]:
> > On Thu, Jan 12, 2017 at 9:44 AM, Sebastian Reichel <sre@kernel.org> wro=
te:
> > > On Wed, Jan 11, 2017 at 04:41:49PM -0800, Tony Lindgren wrote:
> > >> From: Liam Breck <kernel@networkimprov.net>
> > >>
> > >> The device specific data is not fully initialized after
> > >> request_threaded_irq().
> > >>
> > >> This causes problems when the IRQ handler tries to reference them.
> > >> Fix the issue by enabling IRQ only at the end of the probe.
> > >>
> > >> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190
> > >> Battery Charger")
> > >> Cc: Mark A. Greer <mgreer@animalcreek.com>
> > >> Cc: Matt Ranostay <matt@ranostay.consulting>
> > >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> > >> [tony@atomide.com: cleaned up patch description a bit]
> > >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >> ---
> > >>  drivers/power/supply/bq24190_charger.c | 3 +++
> > >>  1 file changed, 3 insertions(+)
> > >>
> > >> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/=
supply/bq24190_charger.c
> > >> --- a/drivers/power/supply/bq24190_charger.c
> > >> +++ b/drivers/power/supply/bq24190_charger.c
> > >> @@ -1392,6 +1392,7 @@ static int bq24190_probe(struct i2c_client *cl=
ient,
> > >>               return -EINVAL;
> > >>       }
> > >>
> > >> +     irq_set_status_flags(bdi->irq, IRQ_NOAUTOEN);
> > >>       ret =3D devm_request_threaded_irq(dev, bdi->irq, NULL,
> > >>                       bq24190_irq_handler_thread,
> > >>                       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > >> @@ -1436,6 +1437,8 @@ static int bq24190_probe(struct i2c_client *cl=
ient,
> > >>               goto out4;
> > >>       }
> > >>
> > >> +     enable_irq(bdi->irq);
> > >> +
> > >>       return 0;
> > >>
> > >>  out4:
> > >
> > > Can't you just move the irq request towards the end of the probe?
> > > That way it will also be released before the power-supply structure
> > > is released.
> >=20
> > I did that in a first draft I showed Tony. He suggested this way.
> > Tony, rationale?
>=20
> Both will work for me just fine as long as done in a single patch
> with no other changes.
>=20
> The first option is less changes if needed as a fix, up to Sebastian
> depending on what he prefers.

Then please send the variant, which moves the block in the v2
patchset, since it behaves correctly during driver removal and
results in less lines of code.

> > diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_ch=
arger.c

Also make sure, that you base your patches on power-supply's
for-next branch. Your base is way too *old*, since the driver
lives in drivers/power/supply/bq24190_charger.c nowadays.

-- Sebastian

--vjsn2ym5v4zwsed4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh39+EACgkQ2O7X88g7
+pr0bw/8C/oI11P5kTKWdSthd44WaVZGRVSMheC+vuL+2g3p8MdupRtKu6SmAWuv
qxyGJ3JWiSlJ/u1q57GzG/Dq2vi0Zf08JTTaZWgc8HfUT2h1SLk8+T1jxZyYKvZb
3ioxryOx7uQbAtiE++9HxhuIzsDDt+Zh3IwwVs+W2FrC9pbK3Z8kWhDWHr85g09X
gLDl2z/nPCCXLO+OAuPCa3T7tnJijg7KdBQWMuiL+fpDi/kEEwek18/+5vGTkiLH
FaHOSeHEdvS+cpZzVXYENg8NJ+3lj7F7Hrzni4wSE8zqDz48S7zn4vNtij7j29eH
DKF3rVVeNpW7nnYBLthW8wwR7fYTEH3h0Uw4W/FL3APSGh5/tP43KaDkuH7Ymmf0
ce4HIXlFdoIFFYoX/xxUgQl/J+uMBy3Urjp11DHZUx2Q7YtXfesC9Io4hd1VOOpq
d8ZK2Wp0RLmIhRHHypSZJMu9oSyD7BgDUy3lAmFU7Hvl3G4H7yEkQXLrpkwAzII0
zzRiD0nAYy3p6dDpbZUjYORVwf45H67sHmT+GBofawoJLzMS7P+lRCmfj7igequv
hK2PJSq9PMF54NK/YrTP2EsEd1Q9pq291z7wR10A5dDo2meS3ao1a9UCcAs0HpoZ
13v5oEW4QxlbkwR0E659ESDtx0OirCiFEsyrI+dApfWv/7AUGVw=
=4pme
-----END PGP SIGNATURE-----

--vjsn2ym5v4zwsed4--
