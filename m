From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Remove __exit macro from hdmi_uninit_display
Date: Wed, 7 Nov 2012 09:21:02 +0200
Message-ID: <509A0BDE.60201@ti.com>
References: <1352259434-21196-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig80475CF6D195BFC1D5AF6D0C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60444 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577Ab2KGHVE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 02:21:04 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA77L44H004917
	for <linux-omap@vger.kernel.org>; Wed, 7 Nov 2012 01:21:04 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA77L4JY031391
	for <linux-omap@vger.kernel.org>; Wed, 7 Nov 2012 01:21:04 -0600
In-Reply-To: <1352259434-21196-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: linux-omap@vger.kernel.org

--------------enig80475CF6D195BFC1D5AF6D0C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-07 05:37, Ricardo Neri wrote:
> This function is now used in the driver init path to handle
> probe errors properly. Thus, it may be possible to use this function
> outside the exit path.
>=20
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Reported-by: Yuanhan Liu <yuanhan.liu@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/h=
dmi.c
> index 0c2f35b..6cf2fe2 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -365,7 +365,7 @@ static int __init hdmi_init_display(struct omap_dss=
_device *dssdev)
>  	return 0;
>  }
> =20
> -static void __exit hdmi_uninit_display(struct omap_dss_device *dssdev)=

> +static void hdmi_uninit_display(struct omap_dss_device *dssdev)
>  {
>  	DSSDBG("uninit_display\n");

Thanks, I'll apply.

 Tomi




--------------enig80475CF6D195BFC1D5AF6D0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQmgveAAoJEPo9qoy8lh71pL0QAJFsWk5E7HwcM1ZEQQzmlzwi
H2UtBgXTjjrDuY7DS6+hR1HMv0LFCE3srN0aKzuhukRavezGXV2E7wDp6RlZupxd
e41Y9oTaeYDe5+XlD4a9G7HFJX59A72g10gnwhzWtOC/WUZI7D22zDVPqeAoAUaY
SSuUo4+uphTuAavJ9vCEzhZzrqSuUzfZY6n1EMW8GhABu6xPz/+Rdv8ROjhLB25K
wR2K8e0HghG0RTH7ttywEYnm+2REyuFrojsijAAmjA2yOUoHrxv6cx2fqob7FJ3+
k6R7GcCqxeQu6IH9x88xmCyR4A0Lypz7GpcXjkGfX5EaynN25C1B3zE+GxKcq6T7
kzwRfi9DabF7L5YKiwz+1bhdusSrp3yf7GAE38OEHPLJzvZCA+rikjLL4MPhiupU
64vQkWdCxhOrH0DyAkOB3Zi9ns5OsafNYARhxt6tYMKMzXEmqHzfQx9qVG2GKYVB
4wVquFJqb5x64pMx1ZjlBVhd4zFGBEOUPBNgnWJDSVUxTRhMphyWL1kKNEeZcgnI
2t6Y5EGQOaXAo8ddoGAIyvbTi4slZR3rvY8Opel/U7WWlUzd77y+BjPcDKGq7gQG
OD1VfKA+BD50JqyHqdlXXfrnb89Og7f03UTFwYK93MKXm0jiTQmQYqoiwylc9bDv
qNn8rMHgifrx9QODe+pn
=/pcq
-----END PGP SIGNATURE-----

--------------enig80475CF6D195BFC1D5AF6D0C--
