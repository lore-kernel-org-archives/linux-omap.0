From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Wed, 25 Apr 2012 17:48:49 +0300
Message-ID: <1335365341.6356.5.camel@koala>
References: <1334652536-4442-1-git-send-email-ivan.djelic@parrot.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-zmnzT0y8UlxgqZGyn8W4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54848 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab2DYOtD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 10:49:03 -0400
Received: by lbbgf7 with SMTP id gf7so151855lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 07:49:02 -0700 (PDT)
In-Reply-To: <1334652536-4442-1-git-send-email-ivan.djelic@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Ivan Djelic <ivan.djelic@parrot.com>


--=-zmnzT0y8UlxgqZGyn8W4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-04-17 at 10:48 +0200, Ivan Djelic wrote:
> This patch adds a simple BCH ecc computation api, similar to the
> existing Hamming ecc api. It is intended to be used by the MTD layer.
> It implements the following features:
>=20
> - support 4-bit and 8-bit ecc computation
> - do not protect user bytes in spare area, only data area is protected
> - ecc for an erased NAND page (0xFFs) is also a sequence of 0xFFs
>=20
> This last feature is obtained by adding a constant polynomial to
> the hardware computed ecc. It allows to correct bitflips in blank pages
> and is extremely useful to support filesystems such as UBIFS, which expec=
t
> erased pages to contain only 0xFFs.
>=20
> This api has been tested on an OMAP3630 board.
>=20
> Signed-off-by: Ivan Djelic <ivan.djelic@parrot.com>

Hi Tony,

what do you think about merging this patch? This is the enabler for
making UBIFS actually usable on OMAP platforms which use BCH ECC. There
are 2 other MTD patches which depend on this - so I wonder if it is
easier to merge this one via the MTD tree, providing it has your/others'
ack(s).

Thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-zmnzT0y8UlxgqZGyn8W4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPmA7RAAoJEJtuLFy+q7fe9L8H/RGKeKKn3XASoUUHWAVIBa5R
jnqq8iexEkNzVhvRMcjCj6gA/5eRDifUrIHDFvYtB5iQResZz6VIM2qQ1qD6tiXo
IGjNLVNhJIGOBEkcA1MagLnQMT7KEB5WMDEpw8XGMSGoN+c/GodueDH/XsTM1mit
IipQ/OhIDcXhsBmUA/rdCJNqJGZqoZSZi0Xt/1Usqva2kiTOHmQQwI5jOaFbV0dR
Dg6lHK1IfOzPPww5bqr4RM9NNRLdOrzmDcLCqHgWemUpPusrrxk+XlbcZEUGc/Py
VJaHYKNqAyh7kkoxaJSuBFD17w36UfbcFsCGUC7YaTXlPlQXYLYQN63Z9va74DM=
=WqAR
-----END PGP SIGNATURE-----

--=-zmnzT0y8UlxgqZGyn8W4--

