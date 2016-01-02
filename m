From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: twl4030-power different data in DTS and board code
Date: Sat, 2 Jan 2016 22:39:27 +0100
Message-ID: <201601022239.27379@pali>
References: <201601021513.32814@pali> <20160102171430.GC12622@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1677503.TNtCCY8y40";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160102171430.GC12622@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machel <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Nishanth Menon <nm@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart1677503.TNtCCY8y40
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 02 January 2016 18:14:31 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160102 06:14]:
> > Hello,
> >=20
> > now I'm looking at differences between legacy board code and DTS
> > file for Nokia N900 and I see some inconsistency for twl4030-power
> > driver.
> >=20
> > In board code are defined more twl4030 power scripts which override
> > defaults defined in twl4030-power code. See:
> >=20
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tre
> > e/arch/arm/mach-omap2/board-rx51-peripherals.c#n790
> >=20
> > Next in DTS file is defined just "compatible" keyword, but no
> > custom scripts, see:
> >=20
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tre
> > e/arch/arm/boot/dts/omap3-n900.dts#n416
> >=20
> > And the last in DTS file is defined line:
> >=20
> > compatible =3D "ti,twl4030-power-n900"
> >=20
> > which is not in twl4030-power driver itself, see:
> >=20
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tre
> > e/drivers/mfd/twl4030-power.c#n851
> >=20
> > So all this stuff looks like some errors when board code was ported
> > to DTS. Tony, can you look at this at all?
>=20
> AFAIK it should work fine with the generic
> "ti,twl4030-power-idle-osc-off". This means reboot works and
> regulators are cut off during off mode.

Ok.

> The n900 specific code was based on something before the TI generic
> values were available I think. And the last time I looked at it I
> came to the conclusion the n900 specific code is no better.

Hm... if generic values are better, why old values are still there (in=20
board n900 code)?

> Or did I miss something? Are you seeing some issues with PM with dts
> based code?

I'm just asking why we have different code for DST and board...

> We can certainly add it to twl4030-power if it provides something
> that the "ti,twl4030-power-idle-osc-off" does not.

But do we need 'compatible =3D "ti,twl4030-power-n900"' specification in=20
omap3-n900.dts file at all?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1677503.TNtCCY8y40
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaIQ48ACgkQi/DJPQPkQ1JkOACgmDdYlquHK5dQIBCPYIBltQst
8LwAmgIuGwh2Au6z+MtDZ4P3xrV1+fhZ
=E85x
-----END PGP SIGNATURE-----

--nextPart1677503.TNtCCY8y40--
