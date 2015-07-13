From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 13 Jul 2015 22:34:21 +0200
Message-ID: <201507132234.22082@pali>
References: <201507111405.06048@pali> <201507131909.06521@pali> <20150713202835.GA9468@deathray>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1628391.VxBryyoJnE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150713202835.GA9468@deathray>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart1628391.VxBryyoJnE
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 13 July 2015 22:28:35 Michael Welling wrote:
> On Mon, Jul 13, 2015 at 07:09:06PM +0200, Pali Roh=C3=A1r wrote:
> > Hello, here is my objdump of 4.2-rc2 version:
> >=20
> > 00000064 <omap2_mcspi_set_cs>:
> >       64:       e3003182        movw    r3, #386        ; 0x182
> >       68:       e19030b3        ldrh    r3, [r0, r3]
> >       6c:       e3130004        tst     r3, #4
> >       70:       0a000001        beq     7c
> >       <omap2_mcspi_set_cs+0x18> 74:       e2711001        rsbs  =20
> >       r1, r1, #1
> >       78:       33a01000        movcc   r1, #0
> >       7c:       e5902188        ldr     r2, [r0, #392]  ; 0x188
> >       80:       e3520000        cmp     r2, #0
> >       84:       012fff1e        bxeq    lr
> >       88:       e5923018        ldr     r3, [r2, #24]
> >       8c:       e3510000        cmp     r1, #0
> >       90:       13c33601        bicne   r3, r3, #1048576        ;
> >       0x100000 94:       03833601        orreq   r3, r3, #1048576=20
> >             ; 0x100000 98:       e5823018        str     r3, [r2,
> >       #24]
> >       9c:       e5902188        ldr     r2, [r0, #392]  ; 0x188
> >       a0:       e5922000        ldr     r2, [r2]
> >       a4:       e582302c        str     r3, [r2, #44]   ; 0x2c
> >       a8:       e592302c        ldr     r3, [r2, #44]   ; 0x2c
> >       ac:       e12fff1e        bx      lr
>=20
> I have not been able to duplicate the failure on the hardware that I
> have. I dug out my old Beagleboard and added an SPI registration to
> the dts. This was the closest hardware that I had to the N900's
> processor.
>=20
> What is the version of the gcc compiler you are using and where did
> you get it from?
>=20

I'm using gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) from package=20
gcc-4.6-arm-linux-gnueabi which is available on Ubuntu 12.04 LTS
(version 4.6.3-1ubuntu5cross1.62).

> For instance, I am using a 4.9.1 compiler that I built using Yocto.
>=20
> Also are you using devicetree or the old board file board-rx51.c?

I'm using devicetree.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1628391.VxBryyoJnE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWkIM4ACgkQi/DJPQPkQ1L00wCfSiChIDKEGJQlAtVrUxmNyDlQ
0KsAn2qeQwoe9quzp5yEQ6qnpa8NlUbF
=gVz6
-----END PGP SIGNATURE-----

--nextPart1628391.VxBryyoJnE--
