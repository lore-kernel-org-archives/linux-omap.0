From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Thu, 19 Feb 2015 17:47:24 +0100
Message-ID: <201502191747.24296@pali>
References: <20150105230228.GO4081@atomide.com> <201502182004.03195@pali> <20150218224206.GC32521@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1508164.cckMOJTdfR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150218224206.GC32521@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--nextPart1508164.cckMOJTdfR
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 February 2015 23:42:06 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150218 11:07]:
> > On Wednesday 18 February 2015 17:33:53 Tony Lindgren wrote:
> > > > */ +//		reg =3D <1 0x300 0xf>;		/* 16 byte IO range at
> >=20
> > offset
> >=20
> > > > 0x300 */ +		reg =3D <1 0x0 0xf>;		/* 16 byte IO range
> >=20
> > at
> >=20
> > > > offset 0x300 */
> > > >=20
> > > >  		bank-width =3D <2>;
> > > >  		pinctrl-names =3D "default";
> > > >  		pinctrl-0 =3D <&ethernet_pins>;
> > >=20
> > > Oh cool, the 0x300 offset is there mostly to suppress
> > > warnings about non-standard location.
>=20
> ...
>=20
> > > OK that's good news. Care to do a patch to set the offset
> > > 0x0 with added comment that qemu needs it? I'll test to
> > > make sure it works on the real hardware as well.
> >=20
> > Yes, I can send proper git format-patch, but first let me
> > know if that change does not break your HW...
>=20
> Yes using reg =3D <1 0 0xf> works, it just adds this extra
> warning:
>=20
> smc91x 2000000.ethernet (unnamed net_device) (uninitialized):
> smc91x: IOADDR d09d6000 doesn't match configuration (300).
>=20
> And I'm pretty sure that can be fixed by setting the EEPROM
> offset to 0 instead of the default 0x300. People with smc91x
> most likely want to write at least the MAC address to the
> EEPROM, so might as well set the offset to zero then too.
>=20
> Of course it's always possible to do do a omap3-n900-qemu.dts
> if larger changes are needed :)
>=20
> Regards,
>=20
> Tony

Anyway, here are original Nokia board data (2.6.28) for smc91x ethernet:

https://gitorious.org/linux-n900/linux-n900/source/629fc5ab00cafb31272c478e=
fa2c2b35fabd4c70:arch/arm/mach-omap2/board-rx51-peripherals.c#L42

https://gitorious.org/linux-n900/linux-n900/source/629fc5ab00cafb31272c478e=
fa2c2b35fabd4c70:arch/arm/mach-omap2/board-rx51-peripherals.c#L274

Can you check if it match with our data in DT file?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1508164.cckMOJTdfR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTmE5wACgkQi/DJPQPkQ1IQgwCgjHtHogJxSfhetrp0UiaT/9Xe
VgAAoMJp8lMHQfpRFfdggT0MF53ILbnR
=xhNJ
-----END PGP SIGNATURE-----

--nextPart1508164.cckMOJTdfR--
