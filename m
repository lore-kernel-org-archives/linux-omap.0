From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Wed, 22 Jul 2015 09:27:32 +0200
Message-ID: <20150722072732.GB22138@pali>
References: <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150720204647.GA11931@deathstar>
 <20150721093441.GA23241@amd>
 <20150722001741.GA7950@deathstar>
 <20150722020306.GA8379@earth>
 <20150722051334.GA2165@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150722051334.GA2165@deathstar>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 22 July 2015 00:13:34 Michael Welling wrote:
> On Wed, Jul 22, 2015 at 04:03:07AM +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Tue, Jul 21, 2015 at 07:17:41PM -0500, Michael Welling wrote:
> > > On Tue, Jul 21, 2015 at 11:34:41AM +0200, Pavel Machek wrote:
> > >=20
> > > This code has my head spinning.
> > >=20
> > > I found that the errors do not occur when the driver is built int=
o the kernel.
> > >=20
> > > I also found that with the patch below the errors go away.
> > >=20
> > > Not sure if it is acceptible but see if it fixes things on your s=
ide.
> > >=20
> > >=20
> > > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > > index cf8b91b..3164d13 100644
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -1801,11 +1801,11 @@ int spi_setup(struct spi_device *spi)
> > >  	if (!spi->max_speed_hz)
> > >  		spi->max_speed_hz =3D spi->master->max_speed_hz;
> > > =20
> > > -	spi_set_cs(spi, false);
> > > -
> > >  	if (spi->master->setup)
> > >  		status =3D spi->master->setup(spi);
> > > =20
> > > +	spi_set_cs(spi, false);
> > > +
> > >  	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max=
 --> %d\n",
> > >  			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
> > >  			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
> >=20
> > mh. maybe a runtime PM issue?
>=20
> mh?
>=20
> >=20
> >  * external abort on non-linefetch: address cannot be accessed,
> >    since the module's clocks are disabled
> >  * built-in works, module not: built-in is probably a little bit
> >    faster (module must not be loaded from filesystem), so that
> >    the device has not yet been suspended
> >  * Before 4.2, omap2_mcspi_set_cs() was called in the setup
> >    routine, which acquired runtime PM
> >  * In 4.2, omap2_mcspi_set_cs() seems to be called without a
> >    prior pm_runtime_get_sync()
> >  * With your workaround, the device has not yet returned to
> >    suspend after the runtime PM acquisition in setup()
> >=20
> > So I suggest trying the following (compile tested only) patch:
> >
>=20
> It seems you are right.
>=20
> With this patch the SPI drivers no longer cause data aborts.
>=20
> I will wait for feedback from Pavel and Pali but it looks like
> we have a winner.
>=20

I'm busy right now for testing something on my N900...

> > -- Sebastian
> >=20
> > diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-=
mcspi.c
> > index 5867384..f7d9ffd 100644
> > --- a/drivers/spi/spi-omap2-mcspi.c
> > +++ b/drivers/spi/spi-omap2-mcspi.c
> > @@ -245,6 +245,7 @@ static void omap2_mcspi_set_enable(const struct=
 spi_device *spi, int enable)
> > =20
> >  static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable=
)
> >  {
> > +       struct omap2_mcspi *mcspi =3D spi_master_get_devdata(spi->m=
aster);
> >         u32 l;
> > =20
> >         /* The controller handles the inverted chip selects
> > @@ -255,6 +256,8 @@ static void omap2_mcspi_set_cs(struct spi_devic=
e *spi, bool enable)
> >                 enable =3D !enable;
> > =20
> >         if (spi->controller_state) {
> > +               pm_runtime_get_sync(mcspi->dev);
> > +
>=20
> Should the return code should be checked here as with the other
> instances of pm_runtime_get_sync?
>=20

Yes, you *must* check return value of pm_runtime_get_sync! Otherwise we
can get another oops/kernel panic. See similar commits:

f7b2b5dd6a62a47e871627c71ed01aa3482154d9
604c31039dae4653f33003d08c91ef58b70b5e63

Anyway, what do you think about adding gcc macro for pm_runtime_get_syn=
c
function which report compiler warning when return value is not checked=
?

> >                 l =3D mcspi_cached_chconf0(spi);
> > =20
> >                 if (enable)
> > @@ -263,6 +266,9 @@ static void omap2_mcspi_set_cs(struct spi_devic=
e *spi, bool enable)
> >                         l |=3D OMAP2_MCSPI_CHCONF_FORCE;
> > =20
> >                 mcspi_write_chconf0(spi, l);
> > +
> > +               pm_runtime_mark_last_busy(mcspi->dev);
> > +               pm_runtime_put_autosuspend(mcspi->dev);
> >         }
> >  }
> > =20
>=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
