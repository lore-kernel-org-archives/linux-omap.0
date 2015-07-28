From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 28 Jul 2015 10:39:32 +0200
Message-ID: <20150728083932.GD13765@pali>
References: <201507111405.06048@pali>
 <20150722001741.GA7950@deathstar>
 <20150722020306.GA8379@earth>
 <201507251055.51375@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201507251055.51375@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Michael Welling <mwelling@ieee.org>
Cc: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Saturday 25 July 2015 10:55:50 Pali Roh=C3=A1r wrote:
> On Wednesday 22 July 2015 04:03:07 Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Tue, Jul 21, 2015 at 07:17:41PM -0500, Michael Welling wrote:
> > > On Tue, Jul 21, 2015 at 11:34:41AM +0200, Pavel Machek wrote:
> > >=20
> > > This code has my head spinning.
> > >=20
> > > I found that the errors do not occur when the driver is built int=
o
> > > the kernel.
> > >=20
> > > I also found that with the patch below the errors go away.
> > >=20
> > > Not sure if it is acceptible but see if it fixes things on your
> > > side.
> > >=20
> > >=20
> > > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > > index cf8b91b..3164d13 100644
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -1801,11 +1801,11 @@ int spi_setup(struct spi_device *spi)
> > >=20
> > >  	if (!spi->max_speed_hz)
> > >  =09
> > >  		spi->max_speed_hz =3D spi->master->max_speed_hz;
> > >=20
> > > -	spi_set_cs(spi, false);
> > > -
> > >=20
> > >  	if (spi->master->setup)
> > >  =09
> > >  		status =3D spi->master->setup(spi);
> > >=20
> > > +	spi_set_cs(spi, false);
> > > +
> > >=20
> > >  	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max
> > >  	--> %d\n",
> > >  =09
> > >  			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
> > >  			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
> >=20
> > mh. maybe a runtime PM issue?
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
> >=20
> > -- Sebastian
> >=20
> > diff --git a/drivers/spi/spi-omap2-mcspi.c
> > b/drivers/spi/spi-omap2-mcspi.c index 5867384..f7d9ffd 100644
> > --- a/drivers/spi/spi-omap2-mcspi.c
> > +++ b/drivers/spi/spi-omap2-mcspi.c
> > @@ -245,6 +245,7 @@ static void omap2_mcspi_set_enable(const struct
> > spi_device *spi, int enable)
> >=20
> >  static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable=
)
> >  {
> > +       struct omap2_mcspi *mcspi =3D
> > spi_master_get_devdata(spi->master); u32 l;
> >=20
> >         /* The controller handles the inverted chip selects
> > @@ -255,6 +256,8 @@ static void omap2_mcspi_set_cs(struct spi_devic=
e
> > *spi, bool enable) enable =3D !enable;
> >=20
> >         if (spi->controller_state) {
> > +               pm_runtime_get_sync(mcspi->dev);
> > +
> >                 l =3D mcspi_cached_chconf0(spi);
> >=20
> >                 if (enable)
> > @@ -263,6 +266,9 @@ static void omap2_mcspi_set_cs(struct spi_devic=
e
> > *spi, bool enable) l |=3D OMAP2_MCSPI_CHCONF_FORCE;
> >=20
> >                 mcspi_write_chconf0(spi, l);
> > +
> > +               pm_runtime_mark_last_busy(mcspi->dev);
> > +               pm_runtime_put_autosuspend(mcspi->dev);
> >         }
> >  }
>=20
> This patch fix spi bus for me.
>=20
> Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20

Sebastian or Michael: Can you add check for pm_runtime_get_sync()
function and send patch for including in mainline kernel?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
