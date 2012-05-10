From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Thu, 10 May 2012 16:07:37 +0300
Message-ID: <1336655257.2625.8.camel@sauron.fi.intel.com>
References: <1335442669-13474-1-git-send-email-ivan.djelic@parrot.com>
	 <20120509002927.GF5088@atomide.com> <20120509081047.GC17333@parrot.com>
	 <20120509153141.GI5088@atomide.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-yrD52XDRsdRVQC5fRukn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37435 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758360Ab2EJNF2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 09:05:28 -0400
In-Reply-To: <20120509153141.GI5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ivan Djelic <ivan.djelic@parrot.com>
Cc: afzal@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>


--=-yrD52XDRsdRVQC5fRukn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 08:31 -0700, Tony Lindgren wrote:
> > Note that I could prepare a new MTD patch with BCH ecc code included,
> > allowing to drop the GPMC BCH ecc api.
>=20
> OK, let's do that then. I'll drop this patch and you can coordinate
> your patch with Afzal.

Ivan, so are you going to send new patches early enough to make them hit
3.5? Can you please then re-send all the dependent patches again and
again describe what depends on what, because I am getting lost :-)

--=20
Best Regards,
Artem Bityutskiy

--=-yrD52XDRsdRVQC5fRukn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPq72ZAAoJECmIfjd9wqK013cQAK4GUh+MUpRv1B6H0miTcAL8
+aaUBkV1Mu5NzqCmf42wzU5YeZTxRkrMU6rX0/lcsKtU+Ve6cYCXhP6LnSGUVaX4
A5+JQvuT86kewLsZHdG/RZBgRULWHFWE6kQal1nz1KCdwIInEJwOBU7W2wmhKkDK
4RE1e2/LaHMklONO95dlXqMYxijuvTM7ScCGRWoe6y3FBOLcebrMqYUAsptw/yko
qXa+h8C6LT7ernOGvJvWhAGLEzO3dmisFFmjatmHFUIHwzj96fX4uHQuy9ch23up
2qo29CPtLpFxjLj4F946hOS3kqjMJ1c+vOz0PIWNmsm7NBTcReOO69MuMkJ1o7TD
M10exeTC9QDR1qIr86kYyzG1ay4KjQtj93qsSvp6Kw5fXIVdGP+FOqNVynTgKEn9
VdkR2eBL74+XFhf1lER/r9RM6W9IV39V+qYb2lDWTRu2II8FzJyH2/nmmzcxZKic
5NhcPiyOVlwMBq3JwFjpfkP+5Wm4pgHDgqNqSuj2Tv08YX9AykS1X6rIJ4WfocBI
iWtOOi6N/UhEtQHjQ7vL62JWulnq0V6xYMgE2BOc/vJlV/TQEblgEOddBkluT4/7
E5T3zFXB8WPtGui/qSXZBNR3WquUgMeqbHEN8N6rWO/4I+Pnqos0I40SyoGV4Zdd
uqRVJhRkF8KogP0BhRXM
=Df5E
-----END PGP SIGNATURE-----

--=-yrD52XDRsdRVQC5fRukn--

