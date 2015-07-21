From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 21 Jul 2015 11:34:41 +0200
Message-ID: <20150721093441.GA23241@amd>
References: <201507111405.06048@pali>
 <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150720204647.GA11931@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150720204647.GA11931@deathstar>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon 2015-07-20 15:46:47, Michael Welling wrote:
> On Tue, Jul 14, 2015 at 09:14:12AM +0200, Pali Roh=E1r wrote:
> > On Monday 13 July 2015 17:36:07 Michael Welling wrote:
> > > On Tue, Jul 14, 2015 at 12:02:44AM +0200, Pali Roh=E1r wrote:
> > > > I think nothing special. I just call:
> > > >=20
> > > > export ARCH=3Darm
> > > > export CROSS_COMPILE=3Darm-linux-gnueabi-
> > > > make rx51_defconfig
> > > > rm -f arch/arm/boot/zImage
> > > > make -j12 zImage modules omap3-n900.dtb CONFIG_DEBUG_SECTION_MI=
SMATCH=3Dy
> > > > cat arch/arm/boot/zImage arch/arm/boot/dts/omap3-n900.dtb > arc=
h/arm/boot/zImage.new
> > > > mv arch/arm/boot/zImage.new arch/arm/boot/zImage
> > > >
> > >=20
> > > Where are you getting rx51_defconfig from?
> > >=20
> > > This does not appear to be in the kernel source any longer.
> > >=20
> > > Can you try the above with omap2plus_defconfig?
> > > =20
> >=20
> > It is in my linux-n900 repository: https://github.com/pali/linux-n9=
00
> > Repository contains more n900 specific patches but SPI code is unpa=
tched
> >=20
> > https://github.com/pali/linux-n900/blob/HEAD/arch/arm/configs/rx51_=
defconfig
> >=20
> > Later in week I can try to compile also with omap2plus_defconfig...
> > But in my opinion kernel should not crash with different configurat=
ion.
>=20
> Has any progress been made on this?
>=20
> Seeing as I was dropped into the middle of this thread,
> I took a look at the discussion previous.
>=20
> It appears that you are building the drivers as modules.
> Perhaps I can again attempt to duplicate the issue using modules.
> Though this should not make a difference.

Actually.. for the record I'm _not_ using modules. So either I hit
something different, or problem happens regardless of modules.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
