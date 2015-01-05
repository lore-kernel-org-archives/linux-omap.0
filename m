From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 6 Jan 2015 00:09:15 +0100
Message-ID: <201501060009.15806@pali>
References: <20150105230228.GO4081@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5607020.OIplBnob2i";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:42338 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbbAEXJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2015 18:09:19 -0500
Received: by mail-wi0-f171.google.com with SMTP id bs8so4295794wib.10
        for <linux-omap@vger.kernel.org>; Mon, 05 Jan 2015 15:09:18 -0800 (PST)
In-Reply-To: <20150105230228.GO4081@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>

--nextPart5607020.OIplBnob2i
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Just to note that smc91x ethernet support is also in qemu n900=20
emulation. Later I will try if it work with upstream kernel...

On Tuesday 06 January 2015 00:02:29 Tony Lindgren wrote:
> Revert "ARM: dts: Disable smc91x on n900 until bootloader
> dependency is removed". We've now fixed the issues that
> caused problems with uninitialized hardware depending on
> the bootloader version. Mostly things got fixed with
> the following commits:
>=20
> 9a894953a97b ("ARM: dts: Fix bootloader version dependencies
> by muxing n900 smc91x pins") 7d2911c43815 ("net: smc91x: Fix
> gpios for device tree based booting")
>=20
> Note that this only affects the early development boards
> with Ethernet that we still have in a few automated boot
> test systems.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -702,9 +702,6 @@
>=20
>  	ethernet@gpmc {
>  		compatible =3D "smsc,lan91c94";
> -
> -		status =3D "disabled";
> -
>  		interrupt-parent =3D <&gpio2>;
>  		interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
>  		reg =3D <1 0x300 0xf>;		/* 16 byte IO range at offset=20
0x300
> */

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5607020.OIplBnob2i
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlSrGZsACgkQi/DJPQPkQ1JMdgCgq/zSf/FQ6+kJin/pjVmvMrdD
b+wAn0CwIvmpIpP2p+iamNspLiwMymkK
=eL0K
-----END PGP SIGNATURE-----

--nextPart5607020.OIplBnob2i--
