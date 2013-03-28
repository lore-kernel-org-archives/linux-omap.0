From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Thu, 28 Mar 2013 18:24:32 +0100
Message-ID: <201303281824.32672@pali>
References: <201302281905.48546@pali> <20130327210918.GP10155@atomide.com> <20130328095228.GT30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4077183.Al80tHH4Np";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:57490 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558Ab3C1RYm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 13:24:42 -0400
In-Reply-To: <20130328095228.GT30923@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Juha Yrjola <juha.yrjola@solidboot.com>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart4077183.Al80tHH4Np
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 28 March 2013 10:52:28 Russell King - ARM Linux=20
wrote:
> On Wed, Mar 27, 2013 at 02:09:18PM -0700, Tony Lindgren wrote:
> > > +	setup_timer(&idle_timer, omap3_rom_idle_rng, 0);
> > > +	rng_clk =3D clk_get_sys("omap_rng", "ick");
>=20
> Why is this using clk_get_sys when it should be using
> clk_get() with the platform device?

=46uncion clk_get() needs struct device* instead clk device name.=20
And I do not know how to get that pointer to device. With=20
clk_get_sys driver working.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4077183.Al80tHH4Np
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlFUfNAACgkQi/DJPQPkQ1J5+QCguVdXdTIZse9lpLizZPn8hYwi
RkwAoJV47khhl0bUXx7t7ctWOxouxdqk
=XmK6
-----END PGP SIGNATURE-----

--nextPart4077183.Al80tHH4Np--
