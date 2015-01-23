From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: N900 v3.19-rc5 arm atags_to_fdt.c is broken
Date: Fri, 23 Jan 2015 22:39:55 +0100
Message-ID: <201501232239.55801@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2096829.N2XBTCAeEO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:47438 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbbAWVj7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2015 16:39:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Laura Abbott <lauraa@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

--nextPart2096829.N2XBTCAeEO
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

when I boot zImage with appended DT n900 in qemu fdt_open_into()=20
function called from file arch/arm/boot/compressed/atags_to_fdt.c=20
(in function atags_to_fdt) always returns -FDT_ERR_NOSPACE.

It means that all ATAGS (including cmdline arguments) passed by=20
bootloader are ignored.

On real n900 device I see that booted DT version also ignore=20
cmdline arguments from bootloader. I cannot debug decompress code=20
on real device, but I think it is same problem as in qemu.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2096829.N2XBTCAeEO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTCv6sACgkQi/DJPQPkQ1KqUQCaA3mni2KrsUm2/vjdSO5XKPMM
4u8AoIf2n0MRmW0Gz3+isd5wzBHn1AOm
=qhMO
-----END PGP SIGNATURE-----

--nextPart2096829.N2XBTCAeEO--
