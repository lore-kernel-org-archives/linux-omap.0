From: Sebastian Reichel <sre@kernel.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Wed, 22 Jul 2015 15:33:18 +0200
Message-ID: <20150722133318.GA17442@earth>
References: <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150720204647.GA11931@deathstar>
 <20150721093441.GA23241@amd>
 <20150722001741.GA7950@deathstar>
 <20150722020306.GA8379@earth>
 <20150722051334.GA2165@deathstar>
 <20150722072732.GB22138@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150722072732.GB22138@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Michael Welling <mwelling@ieee.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 22, 2015 at 09:27:32AM +0200, Pali Roh=E1r wrote:
> > > diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mc=
spi.c
> > > index 5867384..f7d9ffd 100644
> > > --- a/drivers/spi/spi-omap2-mcspi.c
> > > +++ b/drivers/spi/spi-omap2-mcspi.c
> > > @@ -245,6 +245,7 @@ static void omap2_mcspi_set_enable(const struct s=
pi_device *spi, int enable)
> > > =20
> > >  static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
> > >  {
> > > +       struct omap2_mcspi *mcspi =3D spi_master_get_devdata(spi->mas=
ter);
> > >         u32 l;
> > > =20
> > >         /* The controller handles the inverted chip selects
> > > @@ -255,6 +256,8 @@ static void omap2_mcspi_set_cs(struct spi_device =
*spi, bool enable)
> > >                 enable =3D !enable;
> > > =20
> > >         if (spi->controller_state) {
> > > +               pm_runtime_get_sync(mcspi->dev);
> > > +
> >=20
> > Should the return code should be checked here as with the other
> > instances of pm_runtime_get_sync?

Yes. If it fails, the line fetch error would be triggered again.

Probably the set_cs callback should also be changed, so that it can
return an error code. This is not something for 4.2-rc, though.

> Anyway, what do you think about adding gcc macro for pm_runtime_get_sync
> function which report compiler warning when return value is not checked?

Adding __must_check to pm_runtime_get_sync() should be discussed
separately with the relevant people in Cc. A quick grep in drivers/
reveals a huge amount of code not handling pm_runtime_get_sync's return
code.

-- Sebastian

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVr5uYAAoJENju1/PIO/qaf/oP/1tQOTVzrvv51ZnR9TuFB6yn
t/pid8g8gm407Hi6QVpFZJV7apSDvj0D/cXNKECIjypwNPvrXYt8LvTx7tTkuON2
XqXYIHmsHMSXQISmhefL0nV7pMkfERlawLMpQHUk9HVyC/rOd1I3jWX8kOeM6b/o
MpAEP1B7edu7MSL2jzt2Oe6zpFwJGM2CjjS+BWkOOl3g1AobzuE0KvRc8Qx+ddHM
WbJDYynHF9qI4h2psXqCRQmL3dClhDMyFmqeX2fNR84CgEF7iYhDC7c8o9iz+f6k
CBu4ezbZiGBggJOcNb+oq7R9SWoWSWho8z2THTmNsYCs+K5ZdprS8TtOMmIrZjeu
zuz2OwR/OgGztPvwxsIfkb8SK8onQkJ07JXcUdvz9NtREBQfaCoz7VBia4aD16Db
MMPQsJKVrVjTib3EFs1l3rc798w8oIR3fABmuKTREfvXbwwhQAtx/jtCcYt+otTm
xSVHr6zV17DwoFEhdOWzXolQMVcy8FgvcjdQZeNMBAA00RMyl4osDCu0NJELbqF9
oGwdij7Y4v0vkwv+g3yvTgRJ41/GsvDaLppKwi+ANaTIjvhtwiilcAN3/GN05+g4
iJs5ViLkrao4qDhIW+4n9df/5yTg0TEqpog789iN0pJpT5Gg2rcCXHf3LWhxEnLZ
sD2ThumvEE2JExZ9/VUo
=LED5
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
