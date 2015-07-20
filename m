From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 20 Jul 2015 22:58:47 +0200
Message-ID: <201507202258.47697@pali>
References: <201507111405.06048@pali> <20150714071412.GA12844@pali> <20150720204647.GA11931@deathstar>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2629834.pWIxFY6G85";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150720204647.GA11931@deathstar>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart2629834.pWIxFY6G85
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 20 July 2015 22:46:47 Michael Welling wrote:
> On Tue, Jul 14, 2015 at 09:14:12AM +0200, Pali Roh=C3=A1r wrote:
> > On Monday 13 July 2015 17:36:07 Michael Welling wrote:
> > > On Tue, Jul 14, 2015 at 12:02:44AM +0200, Pali Roh=C3=A1r wrote:
> > > > I think nothing special. I just call:
> > > >=20
> > > > export ARCH=3Darm
> > > > export CROSS_COMPILE=3Darm-linux-gnueabi-
> > > > make rx51_defconfig
> > > > rm -f arch/arm/boot/zImage
> > > > make -j12 zImage modules omap3-n900.dtb
> > > > CONFIG_DEBUG_SECTION_MISMATCH=3Dy cat arch/arm/boot/zImage
> > > > arch/arm/boot/dts/omap3-n900.dtb > arch/arm/boot/zImage.new mv
> > > > arch/arm/boot/zImage.new arch/arm/boot/zImage
> > >=20
> > > Where are you getting rx51_defconfig from?
> > >=20
> > > This does not appear to be in the kernel source any longer.
> > >=20
> > > Can you try the above with omap2plus_defconfig?
> >=20
> > It is in my linux-n900 repository:
> > https://github.com/pali/linux-n900 Repository contains more n900
> > specific patches but SPI code is unpatched
> >=20
> > https://github.com/pali/linux-n900/blob/HEAD/arch/arm/configs/rx51_
> > defconfig
> >=20
> > Later in week I can try to compile also with omap2plus_defconfig...
> > But in my opinion kernel should not crash with different
> > configuration.
>=20
> Has any progress been made on this?
>=20

Hi, sorry but I did not have time last weekend for testing...

> Seeing as I was dropped into the middle of this thread,
> I took a look at the discussion previous.
>=20
> It appears that you are building the drivers as modules.
> Perhaps I can again attempt to duplicate the issue using modules.
> Though this should not make a difference.

Yes, you can try to build drivers as modules. Also you can try to use my=20
rx51_defconfig. Maybe you find something more...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2629834.pWIxFY6G85
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWtYQcACgkQi/DJPQPkQ1I3ewCfTa01JMkVKu4MnPjjQ9eIHw4I
k/QAoM3cD07elAFBmshNKckcL6NhdXMF
=m/T9
-----END PGP SIGNATURE-----

--nextPart2629834.pWIxFY6G85--
