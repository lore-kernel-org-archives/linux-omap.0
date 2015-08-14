From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Fri, 14 Aug 2015 22:54:16 +0200
Message-ID: <201508142254.16292@pali>
References: <201507251228.27128@pali> <201508032017.45654@pali> <20150814204649.GA7628@Nokia-N900>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2085953.bUh1xxtlY5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150814204649.GA7628@Nokia-N900>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Lars-Peter Clausen <lars@metafoo.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

--nextPart2085953.bUh1xxtlY5
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 14 August 2015 22:46:49 Pavel Machek wrote:
> Hi!
>=20
> > Maybe some power management problem? Something is not always
> > initialized correctly?
> >=20
> > I remember that there is some problem (maybe in NoLo - Nokia
> > bootloader) that sometimes chainloaded U-Boot (booted via NoLo) is
> > not able to initialize mmc chip (all read operation fails). In
> > U-Boot I added some code to enable some parts in twl4030 regulator
> > and after that mmc is working always...
>=20
> Could I get some details? Thay code should be moved to kernel,
> I'd really like mmc to work, no matter how machine was booted.
>=20
> Best regards,
>=20
> 							Pavel

I think I was inspirited by kernel code when I added that functionality
into u-boot... But I do not remember which kernel version...

If you are interested and what to play with that, just look at few lines
of twl4030 code in uboot rx51.c (until "restore I2C access state"):

http://git.denx.de/?p=3Du-boot.git;a=3Dblob;f=3Dboard/nokia/rx51/rx51.c;h=
=3D3d019b01428b5392fb5d0b8c7428a6d1d2ba31af;hb=3DHEAD#l388

All are just i2c calls to twl4030 chipset.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2085953.bUh1xxtlY5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlXOVXgACgkQi/DJPQPkQ1JLDQCaA5QvKQUP+BvfKSx5k0CD7/FX
SnQAnREwckC7qUsJA2GxBF0drIxEonFg
=eWTs
-----END PGP SIGNATURE-----

--nextPart2085953.bUh1xxtlY5--
