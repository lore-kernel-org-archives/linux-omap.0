From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 7/9] ARM: OMAP1: move lcd pdata out of arch/arm/*
Date: Wed, 29 Aug 2012 18:06:05 +0300
Message-ID: <1346252765.12380.1.camel@deskari>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
	 <1346195937-6383-8-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-R8Afou6l8j5mgRoeXgB/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54391 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753846Ab2H2PGL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 11:06:11 -0400
Received: by bkwj10 with SMTP id j10so341102bkw.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 08:06:08 -0700 (PDT)
In-Reply-To: <1346195937-6383-8-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--=-R8Afou6l8j5mgRoeXgB/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-29 at 02:18 +0300, Igor Grinberg wrote:
> omap1 lcd platform data resides inside plat/board.h while it
> should be inside include/linux/...
> Move the omap1 lcd platform data to include/linux/omapfb.h.
>=20
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c   |    1 -
>  arch/arm/mach-omap1/board-fsample.c     |    1 -
>  arch/arm/mach-omap1/board-htcherald.c   |    1 -
>  arch/arm/mach-omap1/board-nokia770.c    |    1 -
>  arch/arm/mach-omap1/board-palmte.c      |    1 -
>  arch/arm/mach-omap1/board-palmtt.c      |    1 -
>  arch/arm/mach-omap1/board-palmz71.c     |    1 -
>  arch/arm/mach-omap1/board-perseus2.c    |    1 -
>  arch/arm/mach-omap1/board-sx1.c         |    1 -
>  arch/arm/plat-omap/fb.c                 |    2 --
>  arch/arm/plat-omap/include/plat/board.h |    7 -------
>  include/linux/omapfb.h                  |    7 ++++++-
>  12 files changed, 6 insertions(+), 19 deletions(-)
>=20

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--=-R8Afou6l8j5mgRoeXgB/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQPi/dAAoJEPo9qoy8lh716+kP/3+CfbCaz/PsStK/CIWTvaSw
U/o4XAgk1wP2uxCPd+1VYtVBCD/3HPl73T0w4ySguQFxBeG+w7ysVjvh/e5M8j6B
WAWkk6dnxtpP8S7xTObBHZY8EvDyCDy2aecpxloAhPkgtM+PK74I4yQGt9g66UU9
pjU3DEDqWHJ60NUYZitwD98gr9SnF78ZuarBay7WLJ7EcB/tvRpZpTdIFQBJb1GZ
n2ls/EXxp07MBS2lqUaNcLwcKz9/BvE6mDzKBJNx74d2crBaysgx+iD6kIDW6fY/
cwFzP658gpRwg2CqFWY6yqTWpP4ow3BbLNuFBllNDJrV7rnr+ZypGQ4Wmwgm9kLs
0Nl0R9Pe8IdoXq8RkoP0Xn//k0+uCl2ZFGW6U9VyNUiVRahtUmkew4PKonzjjf3I
3eOptsfjs++rDenTIOcc2vWBhs6HH1CF4KGTLUw3IjM/hV23mKkksDtlwHhWmGpo
LooDzdPaSzk74kcM+lrYsjil6pN2WHcY2DpsTMm/rMaQ9QqOWIuxgC7AfUI623G4
sk5Q4TFoOtTvclaEGRptRIIbmKymdiDyPwji8evRDCs1dl+2HptBlEirZvFUFwLo
pCCmqxj1G8/Q0Ge3UPM6/5wUxvhmbgBORDyHqKXZs+B0pNN/s5T+jvtFhP52goIB
1PgMfYVFOLJGwTMcAYrH
=uZZP
-----END PGP SIGNATURE-----

--=-R8Afou6l8j5mgRoeXgB/--

