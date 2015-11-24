From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] video: omapdss: delete unneeded of_node_put
Date: Tue, 24 Nov 2015 13:37:58 +0200
Message-ID: <56544C16.2070209@ti.com>
References: <1444682596-3065-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444682596-3065-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i65rJa85XKJ06HIM1LqiHGoSgpovkkEQc"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444682596-3065-2-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-omap@vger.kernel.org

--i65rJa85XKJ06HIM1LqiHGoSgpovkkEQc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/10/15 23:43, Julia Lawall wrote:
> Device node iterators perform an of_node_put on each iteration, so putt=
ing
> an of_node_put before a continue results in a double put.
>=20
> A simplified version of the semantic match that finds this problem is a=
s
> follows (http://coccinelle.lip6.fr):
>=20
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> iterator i;
> @@
>=20
>  i(..., child, ...) {
>    ... when !=3D of_node_get(child)
> *  of_node_put(child);
>    ...
> *  continue;
> }
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/video/fbdev/omap2/dss/omapdss-boot-init.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Thanks, queued for 4.5.

 Tomi


--i65rJa85XKJ06HIM1LqiHGoSgpovkkEQc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWVEwWAAoJEPo9qoy8lh71Al4P/3UXuqJKtWgp6ZbgHMtelyM9
ABQ3xTdQ9mkANhrwktBJje3OToxEHUyA+2ZFb5HXOwEJCVWVFVmN8GhD0k1M5WTQ
lWil+In5gOQLoQp2qQH+jv8FjtWjh/S0dGisYVl2sdpCm/aKLam93wL4MVzU7Ube
hi2zKqbO4vlpVR+4jxe63aJW2CZwirYES8oRXVPwxRJvEEke96T3m5pHq5yl4y1G
179MY9Bq75zOCYJrDVRel0WO16G394fvmASqaIkoEpU+CVki6j0dk8JAoxRFHlCM
OW61Xw49DzU244JN2hOcAi4VlzIUbU8r7VXaZnYl9f7Be8j7bi7mPK0gJcoC5IDZ
016fgWt8lFM+gqXvj2Lk/XJaYy4SLh9XeV11CL6u8eF4zYQOVx0uiqMvKB0P0OlL
pSIAYjyg5hHSyDuguaTtBotlf9G1bJQpSUmY2xvzNCEB6gm81nRrvXz/DJoWYfpd
4EPOaxyfFVyTvQCixSdpEemRct/FIyoEkGznIF1LllQRbrTmArrplhdD0gxEvTwJ
JVPZDSJICCh5PbQ1YVJmrRkJ9qd/xJlBfAFTBOhguCSF0vXVwF8AQjFhtdzV40uu
nRJryp4jjM2ZBHg5DTVka8N4J350KkRCDPM25t4ci9OPm4eeNofqz0kODXl9wf8w
SZg/yTXh0kjgaTy/7cJL
=W9Et
-----END PGP SIGNATURE-----

--i65rJa85XKJ06HIM1LqiHGoSgpovkkEQc--
