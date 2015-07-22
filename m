From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Wed, 22 Jul 2015 16:27:13 +0200
Message-ID: <20150722142713.GE22138@pali>
References: <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150720204647.GA11931@deathstar>
 <20150721093441.GA23241@amd>
 <20150722001741.GA7950@deathstar>
 <20150722020306.GA8379@earth>
 <20150722051334.GA2165@deathstar>
 <20150722072732.GB22138@pali>
 <20150722133318.GA17442@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150722133318.GA17442@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Michael Welling <mwelling@ieee.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 22 July 2015 15:33:18 Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Jul 22, 2015 at 09:27:32AM +0200, Pali Roh=C3=A1r wrote:
> > > > diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-om=
ap2-mcspi.c
> > > > index 5867384..f7d9ffd 100644
> > > > --- a/drivers/spi/spi-omap2-mcspi.c
> > > > +++ b/drivers/spi/spi-omap2-mcspi.c
> > > > @@ -245,6 +245,7 @@ static void omap2_mcspi_set_enable(const st=
ruct spi_device *spi, int enable)
> > > > =20
> > > >  static void omap2_mcspi_set_cs(struct spi_device *spi, bool en=
able)
> > > >  {
> > > > +       struct omap2_mcspi *mcspi =3D spi_master_get_devdata(sp=
i->master);
> > > >         u32 l;
> > > > =20
> > > >         /* The controller handles the inverted chip selects
> > > > @@ -255,6 +256,8 @@ static void omap2_mcspi_set_cs(struct spi_d=
evice *spi, bool enable)
> > > >                 enable =3D !enable;
> > > > =20
> > > >         if (spi->controller_state) {
> > > > +               pm_runtime_get_sync(mcspi->dev);
> > > > +
> > >=20
> > > Should the return code should be checked here as with the other
> > > instances of pm_runtime_get_sync?
>=20
> Yes. If it fails, the line fetch error would be triggered again.
>=20
> Probably the set_cs callback should also be changed, so that it can
> return an error code. This is not something for 4.2-rc, though.
>=20
> > Anyway, what do you think about adding gcc macro for pm_runtime_get=
_sync
> > function which report compiler warning when return value is not che=
cked?
>=20
> Adding __must_check to pm_runtime_get_sync() should be discussed
> separately with the relevant people in Cc. A quick grep in drivers/
> reveals a huge amount of code not handling pm_runtime_get_sync's retu=
rn
> code.
>=20
> -- Sebastian

Two times, missing check for pm_runtime_get_sync() cased kernel crash o=
n
Nokia N900. See that crypto commits. I think all drivers which do not
check should be fixed. Otherwise we can see another mysterious problems=
=2E

Sebastian, can you CC relevant people? Or maybe start new thread?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
