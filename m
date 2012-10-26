From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapdss: dss: Fix clocks on OMAP363x
Date: Fri, 26 Oct 2012 09:17:25 +0300
Message-ID: <508A2AF5.3080706@ti.com>
References: <1351190530-16863-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5D352CABC3079049724F1858"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55580 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab2JZGRe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 02:17:34 -0400
In-Reply-To: <1351190530-16863-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

--------------enig5D352CABC3079049724F1858
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-25 21:42, Laurent Pinchart wrote:
> Commit 185bae1095188aa199c9be64d6030d8dbfc65e0a ("OMAPDSS: DSS: Cleanup=

> cpu_is_xxxx checks") broke the DSS clocks configuration by erroneously
> using the clock parameters applicable to all other OMAP34xx SoCs for th=
e
> OMAP363x. This went unnoticed probably because the cpu_is_omap34xx()
> class check wasn't seen as matching the OMAP363x subclass.
>=20
> Fix it by checking for the OMAP363x subclass before checking for the
> OMAP34xx class.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/video/omap2/dss/dss.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> Hi Tomi,
>=20
> The patch has been tested on the Beagleboard-xM and restores the DVI ou=
tput
> operation. This is a regression fix that should be pushed to v3.7.
>=20
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/ds=
s.c
> index 2ab1c3e..0bb7406 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -805,10 +805,10 @@ static int __init dss_init_features(struct device=
 *dev)
> =20
>  	if (cpu_is_omap24xx())
>  		src =3D &omap24xx_dss_feats;
> -	else if (cpu_is_omap34xx())
> -		src =3D &omap34xx_dss_feats;
>  	else if (cpu_is_omap3630())
>  		src =3D &omap3630_dss_feats;
> +	else if (cpu_is_omap34xx())
> +		src =3D &omap34xx_dss_feats;
>  	else if (cpu_is_omap44xx())
>  		src =3D &omap44xx_dss_feats;
>  	else if (soc_is_omap54xx())
>=20

Good catch, thanks. I don't have a 36xx board, so this went unnoticed.
I'll push it for 3.7-rc.

 Tomi



--------------enig5D352CABC3079049724F1858
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQiir5AAoJEPo9qoy8lh71H58P/19E3mQKM7wsq4WyrDn25BEX
fO3UqGistWBhQuKcMX7MBWLF9I1v/VbNhxzwfLbhdJOlDQsuGZo0Ve9/keQkEsda
bmrT5QJo7GFxqhmrizYqWaNHnNIIGJ/J+se0PTGbs/QWClfFCAgMq/DDcVLuzKBs
49LQjtxTxu0rz2KAVYQWk3BAdw2FnqcWxi0tjtkbHMaHRLOzlmYKlcEcJVSOlzRJ
aU90VnrTG6LbYKogm++xjCgAge2Ch8eF+WsMhowu0+V3lw3Wl7OVrtLXZVIxHa24
PavTgEl1h5epSKhnbgHgxf+eqb4KSm7KLsythx8KP4Bj8HcsuJlGHawj3+vJi6iz
DhV1TdRLxxSYGSyV/H3986EADDgX+W7sroiSwOIxw4wXAKH7dlDg5N6bUd1u7T2d
QKEaNLpdYbfgtUcawSuDv1++FDfL03dIBXVwYx7mP6x9U6ejsoQIQoV1nsuudYBb
B+pqpAxRx+DLnEqug9TlUQ+y/nNq4pbmLuU6JcHnb/lfvJP2GKWgLHg6x3gdnlwe
PQF+uNaPF9kxd7KvR4526/DPAWbUh9Q1r84muyMuB3rgZvZkK54FJdVDhv3m6bx1
9s+rF7NOpFd07MsvHAXbfhl2xuawI3A2l8lLOFGrVVMf9XEXWI4BNvuSifsxDw4F
HWT2QSJqmQHm3Bk+E3Bf
=tS34
-----END PGP SIGNATURE-----

--------------enig5D352CABC3079049724F1858--
