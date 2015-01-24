From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Sat, 24 Jan 2015 23:14:58 +0100
Message-ID: <201501242314.58201@pali>
References: <1421171865-5209-1-git-send-email-tony@atomide.com> <201501241300.00723@pali> <2871852.qm0MoZvdlF@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2844144.FijMrupoIz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:54947 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbAXWPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2015 17:15:01 -0500
Received: by mail-we0-f172.google.com with SMTP id q59so3279483wes.3
        for <linux-omap@vger.kernel.org>; Sat, 24 Jan 2015 14:15:00 -0800 (PST)
In-Reply-To: <2871852.qm0MoZvdlF@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

--nextPart2844144.FijMrupoIz
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 24 January 2015 23:08:00 Arnd Bergmann wrote:
> On Saturday 24 January 2015 13:00:00 Pali Roh=C3=A1r wrote:
> > Another regression for DT setup (which does not occur for
> > board code):
> >=20
> > omap_hsmmc driver does not export slot_name sysfs entry
> > because it not supported by DT yet. Entry slot_name is used
> > by userspace application to determinate if mmc block device
> > is internal eMMC memory or external uSD card. So support
> > for this property also in DT is needed.
>=20
> > Here is simple patch which fix this problem:
> The sysfs file only exists for the two OMAP drivers, and the
> naming is used only by board-n8x0, board-rx51 and
> board-omap3logic.
>=20
> It may be better to add a board-specific hack for these to
> keep the existing user space working but not spread the use
> of this file anywhere else.
>=20
> 	Arnd

Why? omap_hsmmc.c has already support for slot_name sysfs entry,=20
just it is not filled from DT data (only from platform_data)...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2844144.FijMrupoIz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTEGWIACgkQi/DJPQPkQ1IZ9gCeOV4ipAuHslsQp5Up1vM0e7CJ
WrsAoJcByuveyCggxJjLKdsIeBFIm2ya
=lAob
-----END PGP SIGNATURE-----

--nextPart2844144.FijMrupoIz--
