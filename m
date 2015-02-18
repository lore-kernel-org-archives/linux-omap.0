From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Wed, 18 Feb 2015 20:04:03 +0100
Message-ID: <201502182004.03195@pali>
References: <20150105230228.GO4081@atomide.com> <201502181619.46278@pali> <20150218163352.GB32521@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1764173.VKk8alIJKu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150218163352.GB32521@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--nextPart1764173.VKk8alIJKu
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 February 2015 17:33:53 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150218 07:23]:
> > On Tuesday 06 January 2015 00:02:29 Tony Lindgren wrote:
> > > Revert "ARM: dts: Disable smc91x on n900 until bootloader
> > > dependency is removed". We've now fixed the issues that
> > > caused problems with uninitialized hardware depending on
> > > the bootloader version. Mostly things got fixed with
> > > the following commits:
> > >=20
> > > 9a894953a97b ("ARM: dts: Fix bootloader version
> > > dependencies by muxing n900 smc91x pins") 7d2911c43815
> > > ("net: smc91x: Fix gpios for device tree based booting")
> > >=20
> > > Note that this only affects the early development boards
> > > with Ethernet that we still have in a few automated boot
> > > test systems.
> > >=20
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >=20
> > > --- a/arch/arm/boot/dts/omap3-n900.dts
> > > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > > @@ -702,9 +702,6 @@
> > >=20
> > >  	ethernet@gpmc {
> > >  =09
> > >  		compatible =3D "smsc,lan91c94";
> > >=20
> > > -
> > > -		status =3D "disabled";
> > > -
> > >=20
> > >  		interrupt-parent =3D <&gpio2>;
> > >  		interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54=20
*/
> > >  		reg =3D <1 0x300 0xf>;		/* 16 byte IO range at=20
offset
> > >  		0x300
> > >=20
> > > */
> >=20
> > Hello Tony,
> >=20
> > to make smc ethernet working in n900 qemu I needed to apply
> > this patch:
> >=20
> > diff --git a/arch/arm/boot/dts/omap3-n900.dts
> > b/arch/arm/boot/dts/omap3-n900.dts index ff36fbe..d96eeb8
> > 100644
> > --- a/arch/arm/boot/dts/omap3-n900.dts
> > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > @@ -770,7 +770,8 @@
> >=20
> >  		compatible =3D "smsc,lan91c94";
> >  		interrupt-parent =3D <&gpio2>;
> >  		interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
> >=20
> > -		reg =3D <1 0x300 0xf>;		/* 16 byte IO range at offset=20
0x300
> > */ +//		reg =3D <1 0x300 0xf>;		/* 16 byte IO range at=20
offset
> > 0x300 */ +		reg =3D <1 0x0 0xf>;		/* 16 byte IO range=20
at
> > offset 0x300 */
> >=20
> >  		bank-width =3D <2>;
> >  		pinctrl-names =3D "default";
> >  		pinctrl-0 =3D <&ethernet_pins>;
>=20
> Oh cool, the 0x300 offset is there mostly to suppress warnings
> about non-standard location.
>=20
> > With this patch I see in dmesg:
> >=20
> > [   20.577911] smc91x 2000000.ethernet (unnamed net_device)
> > (uninitialized): smc91x: smc_probe [   20.580535] smc91x
> > 2000000.ethernet (unnamed net_device) (uninitialized):
> > smc91x: bank signature probe returned 0x3300
> > [   20.585327] smc91x 2000000.ethernet (unnamed net_device)
> > (uninitialized): smc91x: revision =3D 0x3391 [   20.590087]
> > smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre
> > <nico@fluxnic.net> [   20.593627] smc91x 2000000.ethernet
> > (unnamed net_device) (uninitialized): smc_reset [ =20
> > 20.596832] smc91x 2000000.ethernet (unnamed net_device)
> > (uninitialized): smc_phy_detect [   20.611938] smc91x
> > 2000000.ethernet (unnamed net_device) (uninitialized):
> > smc91x: smc_shutdown [   20.615875] smc91x 2000000.ethernet
> > eth0: SMC91C11xFD (rev 1) at d08be000 IRQ 166 [ =20
> > 20.618682]
> > [   20.621124] smc91x 2000000.ethernet eth0: Ethernet addr:
> > 52:54:00:12:34:56 [   20.624938] smc91x 2000000.ethernet
> > eth0: No PHY found
> >=20
> > (and eth0 exists in ifconfig)
> >=20
> > If I do not apply my patch I got this error message:
> >=20
> > [   22.134704] smc91x 2000300.ethernet (unnamed net_device)
> > (uninitialized): smc91x: bank signature probe returned
> > 0x0000
> > [   22.140014] smc91x: not found (-19).
> >=20
> > and no ethernet device was registered.
> >=20
> > With 2.6.28 kernel with N900 patches (but smc91x is
> > unmodified!) ethernet device is working fine.
>=20
> OK that's good news. Care to do a patch to set the offset 0x0
> with added comment that qemu needs it? I'll test to make sure
> it works on the real hardware as well.
>=20
> Regards,
>=20
> Tony

Yes, I can send proper git format-patch, but first let me know if=20
that change does not break your HW...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1764173.VKk8alIJKu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTk4iMACgkQi/DJPQPkQ1Ln+QCbBBy+sRSliG2C8dOR12b1OYMD
E7wAnA//690UyhGEsR/IXIOii0SIG2HM
=uZk5
-----END PGP SIGNATURE-----

--nextPart1764173.VKk8alIJKu--
