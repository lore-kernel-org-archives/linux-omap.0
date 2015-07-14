From: Michael Welling <mwelling@ieee.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 14 Jul 2015 15:17:22 -0500
Message-ID: <20150714201722.GA31356@deathray>
References: <201507111405.06048@pali>
 <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150714163342.GA8512@deathray>
 <20150714200125.GA26147@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150714200125.GA26147@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 14, 2015 at 10:01:26PM +0200, Pavel Machek wrote:
> On Tue 2015-07-14 11:33:42, Michael Welling wrote:
> > On Tue, Jul 14, 2015 at 09:14:12AM +0200, Pali Roh=E1r wrote:
> > > On Monday 13 July 2015 17:36:07 Michael Welling wrote:
> > > > On Tue, Jul 14, 2015 at 12:02:44AM +0200, Pali Roh=E1r wrote:
> > > > > I think nothing special. I just call:
> > > > >=20
> > > > > export ARCH=3Darm
> > > > > export CROSS_COMPILE=3Darm-linux-gnueabi-
> > > > > make rx51_defconfig
> > > > > rm -f arch/arm/boot/zImage
> > > > > make -j12 zImage modules omap3-n900.dtb CONFIG_DEBUG_SECTION_=
MISMATCH=3Dy
> > > > > cat arch/arm/boot/zImage arch/arm/boot/dts/omap3-n900.dtb > a=
rch/arm/boot/zImage.new
> > > > > mv arch/arm/boot/zImage.new arch/arm/boot/zImage
> > > > >
> > > >=20
> > > > Where are you getting rx51_defconfig from?
> > > >=20
> > > > This does not appear to be in the kernel source any longer.
> > > >=20
> > > > Can you try the above with omap2plus_defconfig?
> > > > =20
> > >=20
> > > It is in my linux-n900 repository: https://github.com/pali/linux-=
n900
> > > Repository contains more n900 specific patches but SPI code is un=
patched
> > >=20
> > > https://github.com/pali/linux-n900/blob/HEAD/arch/arm/configs/rx5=
1_defconfig
> > >=20
> > > Later in week I can try to compile also with omap2plus_defconfig.=
=2E.
> > > But in my opinion kernel should not crash with different configur=
ation.
> >=20
> > True.
> >=20
> > Could you try the following change to the set_cs function and see i=
f
> >it helps.
>=20
> Ok, so:
>=20
> 4.2-rc1 worked for me, IIRC.

This does not make sense.

Nothing has changed in drivers/spi between these versions.

Are you sure that 4.2-rc1 worked for you?

>=20
> 4.2-rc2 oopses a lot.
>=20
> 4.2-rc2+ this patch oopses, too. I don't have serial console, so it i=
s
> hard to tell if it is the same oops.
>=20
> 									Pavel
>=20
> > diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-=
mcspi.c
> > index 5867384..666038b 100644
> > --- a/drivers/spi/spi-omap2-mcspi.c
> > +++ b/drivers/spi/spi-omap2-mcspi.c
> > @@ -245,16 +245,18 @@ static void omap2_mcspi_set_enable(const stru=
ct spi_device *spi, int enable)
> > =20
> >  static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable=
)
> >  {
> > +	struct omap2_mcspi_cs *cs =3D spi->controller_state;
> >  	u32 l;
> > =20
> > -	/* The controller handles the inverted chip selects
> > -	 * using the OMAP2_MCSPI_CHCONF_EPOL bit so revert
> > -	 * the inversion from the core spi_set_cs function.
> > -	 */
> > -	if (spi->mode & SPI_CS_HIGH)
> > -		enable =3D !enable;
> > +	if (cs) {
> > +
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
