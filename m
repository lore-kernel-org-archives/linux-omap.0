From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/2] ARM: ATAGS: move save_atags() to include/asm arch/arm/include/asm/setup.h
Date: Thu, 24 Dec 2015 18:48:17 +0100
Message-ID: <201512241848.17946@pali>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk> <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com> <1450975076-7411-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6460702.6MNbeOqhbT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450975076-7411-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, nicolas.pitre@linaro.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart6460702.6MNbeOqhbT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 24 December 2015 17:37:55 Ivaylo Dimitrov wrote:
> So it can be used by code outside arch/arm/kernel/. Fix save_atags()
> declaration to match its definition while at it.
>=20
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6460702.6MNbeOqhbT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlZ8L+EACgkQi/DJPQPkQ1IAEwCfQiMKoQ+oB/+ZU+48ITSbAKto
DHAAnR1HVRibKttcMfdG+uFL7P5e7y90
=m19v
-----END PGP SIGNATURE-----

--nextPart6460702.6MNbeOqhbT--
