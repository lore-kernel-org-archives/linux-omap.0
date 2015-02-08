From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: DTS: omap3-n900.dts: fix i2c bus numbering
Date: Sun, 8 Feb 2015 19:37:13 +0100
Message-ID: <201502081937.13632@pali>
References: <1423410536-16579-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2086823.SrgNrtFezx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:43083 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233AbbBHShR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2015 13:37:17 -0500
In-Reply-To: <1423410536-16579-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: tony@atomide.com, pavel@ucw.cz, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

--nextPart2086823.SrgNrtFezx
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 08 February 2015 16:48:56 Ivaylo Dimitrov wrote:
> With legacy boot i2c buses on Nokia N900 are numbered i2c1,
> i2c2 and i2c3. Commit 20b80942ef4e ("ARM: dts: OMAP3+: Add
> i2c aliases") fixed the numbering with DT boot, but
> introduced a regression on N900 - aliases become i2c0, i2c1
> and i2c2. Fix that by providing the correct aliases in the
> board dts.
>=20
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-n900.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20

Works fine,

Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2086823.SrgNrtFezx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTXrNkACgkQi/DJPQPkQ1JSMACfRBrcKSxJLHfD72IqbklgB7HO
PzcAoMaSCvmCgq+39EfqTkuhrhuexIKe
=htY9
-----END PGP SIGNATURE-----

--nextPart2086823.SrgNrtFezx--
