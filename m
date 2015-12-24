From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/2] OMAP: RX51: save ATAGS data in the early boot stage
Date: Thu, 24 Dec 2015 18:49:11 +0100
Message-ID: <201512241849.11704@pali>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk> <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com> <1450975076-7411-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5307451.xvTaR8n5fa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450975076-7411-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, nicolas.pitre@linaro.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart5307451.xvTaR8n5fa
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 24 December 2015 17:37:56 Ivaylo Dimitrov wrote:
> Nokia N900 (RX51) legacy userspace needs various ATAGS passed by the
> bootloader (boot reason, device serial, boot mode, various GPIO
> swithes, etc). Save that data early enough in the boot process, so
> it can be exported later in /proc/atags
>=20
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Working fine in qemu.

Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5307451.xvTaR8n5fa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlZ8MBcACgkQi/DJPQPkQ1JqnwCeKo5XxL5FNK7dnyD/jSPo07du
TvwAnRRvnQL+dSjAUrEY3yKETRuV361V
=qQUH
-----END PGP SIGNATURE-----

--nextPart5307451.xvTaR8n5fa--
