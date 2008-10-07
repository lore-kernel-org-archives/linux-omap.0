From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH] kill warnings in gpmc
Date: Tue, 7 Oct 2008 16:23:08 +0300
Message-ID: <20081007132308.GB6212@intune.research.nokia.com>
References: <20081007130411.GX7437@gandalf.research.nokia.com> <EAF47CD23C76F840A9E7FCE10091EFAB028C62FBEF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jPC/Tkukgh9ZDT79"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59594 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbYJGNVW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 09:21:22 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB028C62FBEF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--jPC/Tkukgh9ZDT79
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2008 at 06:43:41PM +0530, ext Pakaravoor, Jagadeesh wrote:
> > I had sent that fix for the same, though not merged in yet. :)
> >=20
>=20
> Oops.. I forgot about V2 patch. :(
>=20
> =3D=3DCut here=3D=3D
> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
>=20
> Return type of gpmc_init() function is void. Also, the error values
> returned by the function is not used by the caller. Hence it should
> not be returning any value.
>=20
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

Signed-off-by: Daniel Stone <daniel.stone@nokia.com>

--jPC/Tkukgh9ZDT79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjrYrwACgkQ68xJuWtYYdUPLgCgvdjmadEnc/t/JU7CrP0q0DG+
QncAoJATLg5v+p3MglFETCgZRRyoWWZs
=e6HS
-----END PGP SIGNATURE-----

--jPC/Tkukgh9ZDT79--
