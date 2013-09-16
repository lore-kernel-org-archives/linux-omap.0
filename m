From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/7] omapdss: HDMI: Fix register definitions and reg dump
 functions
Date: Mon, 16 Sep 2013 09:11:01 +0300
Message-ID: <5236A0F5.1090804@ti.com>
References: <1379068178-17312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="uDVe3WUauX5CaO5gqMlMtnrrwka5STQPS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60030 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556Ab3IPGLH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Sep 2013 02:11:07 -0400
In-Reply-To: <1379068178-17312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--uDVe3WUauX5CaO5gqMlMtnrrwka5STQPS
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/09/13 13:29, Archit Taneja wrote:
> These patches complete the OMAP4 HDMI register definitions for HDMI sub=
modules
> and make sure all the corresponding regdump functions dump all the regi=
sters.
>=20
> Ricardo Neri (7):
>   OMAPDSS: HDMI: OMAP4: Complete register definitions for wrapper
>   OMAPDSS: HDMI: OMAP4: Complete dumping of wrapper registers
>   OMAPDSS: HDMI: OMAP4: Complete register definitions for DPLL
>   OMAPDSS: HDMI: OMAP4: Complete dumping of DPLL registers
>   OMAPDSS: HDMI: OMAP4: Rename the HDMI_CORE_CTRL1 register
>   OMAPDSS: HDMI: OMAP4: Complete register definitions for core
>   OMAPDSS: HDMI: OMAP4: Complete dumping of core registers
>=20
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c | 70 +++++++++++++++++++++++=
+++-----
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h | 65 +++++++++++++++++++++++=
+----
>  2 files changed, 118 insertions(+), 17 deletions(-)
>=20

These look fine to me, queuing for 3.13.

 Tomi



--uDVe3WUauX5CaO5gqMlMtnrrwka5STQPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSNqD3AAoJEPo9qoy8lh713pcQALHw8oPUa5VVY8Pkiep+PWAZ
w3+1D4bORfOxLOAEJKGDe9EYJbW78oN2omcznOQSeA0OTl4Ha3D73bLC+pIguXuC
ncwdXwlzYqy1FMXRj1SY3HOUT+YxV2uEoLj45w6GppSdxfa5L2gGWgmwTxWhOWmV
gD57baFIb6N9vnkhMvIKA4Tk7iJv/UNdTWZwiCjyiYNZIwxmoIO5Tgod9gt8S3OF
nJ6RjkyeVT9Ops8q24j1Jtz9h/GFFCaMUP4LVn7SAJMTzzE5MoDF1q3oRjQC7NR5
Q+zWzlEOlyI3wZao/Js8XonSoSzOAvDTcOzjQYwdqEVmZEhqAjq0FAoeySJt+V2P
Q3c84V63RYsszDLdtR9zHvBnY4EE2Vhio7i7JI+9Muims+XzGvNJimQt1d8i4YxU
GzaMFElOWKGnBlFsRB6hyc5fNiFeNaHsb8VZVpUwVl2MWlDxKLLh+ehPgMMrzYAI
hRimhHodCLjmCi5ieUJbc6F+PFslYMUUyLFQuvCGxn+uJu3e5+sLTy7iRXWy6564
LzsG5cufvdD00KwIHxoQpzB5oIJeYGnXPb+d61c+mjfoCz/zcsc4t10TBbP663Ls
s+CxWqXSKi3TwK/dKda45ywW4FprB+aveYj1c2MGP/dCzSn+9MJmE28d9qdSKzwF
j+j6KwYxytBqHagbuMjm
=5jWy
-----END PGP SIGNATURE-----

--uDVe3WUauX5CaO5gqMlMtnrrwka5STQPS--
