From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: tps65910: Add missing #include <linux/of.h>
Date: Mon, 16 Mar 2015 11:41:24 +0000
Message-ID: <20150316114124.GP28806@sirena.org.uk>
References: <1426424630-9781-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8lV4/+ewWCwXF+0e"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:46357 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbbCPLlg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2015 07:41:36 -0400
Content-Disposition: inline
In-Reply-To: <1426424630-9781-1-git-send-email-geert@linux-m68k.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org


--8lV4/+ewWCwXF+0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2015 at 02:03:50PM +0100, Geert Uytterhoeven wrote:
> drivers/regulator/tps65910-regulator.c: In function =E2=80=98tps65910_par=
se_dt_reg_data=E2=80=99:
> drivers/regulator/tps65910-regulator.c:1018: error: implicit declaration =
of function =E2=80=98of_get_child_by_name=E2=80=99

Applied, thanks.

--8lV4/+ewWCwXF+0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVBsFjAAoJECTWi3JdVIfQbi4H/AhtCRiTkuJkwibgpka0UmG0
PjlRarGbL7viQ+4h9GZQWzub7nrUpFMbPnhD0JcZNnVjA1+wylkZnMNB7cEWelQb
pMrVkoXvpQH+0jy05JttHFWO1CdipKvMV8KiP39sKe3M810V6wA0EzNIWI0lGhcs
5Fhgtag0purcA9TwwdS317ny2qyBxOmgv/N2nmSgE3HD+dymdWRWYHXLdSXqDyNw
Bc5iesv0ReZFkAc0TSUWz3f5ogoWnsr0AD1p5uTl7fixYTkv4pAfuPAo5aIQ1r1h
Ac2VNmBpRDOJymX58R2XmhcOYv+2N2UICJjLI51ts15xwlI++8a9qHP3DGazgxM=
=47Ai
-----END PGP SIGNATURE-----

--8lV4/+ewWCwXF+0e--
