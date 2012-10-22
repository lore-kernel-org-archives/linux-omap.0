From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/6] OMAPDSS: Convert to devm_ioremap
Date: Mon, 22 Oct 2012 10:22:41 +0300
Message-ID: <5084F441.4060502@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-3-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4C84C2D2EDA607F4E5885D3E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57992 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab2JVHWo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 03:22:44 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9M7Mi8e017383
	for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 02:22:44 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9M7MiSX021594
	for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 02:22:44 -0500
In-Reply-To: <1350350839-30408-3-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

--------------enig4C84C2D2EDA607F4E5885D3E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-16 04:27, Ricardo Neri wrote:
> Using devm_ioremap provides better memory handling and improves
> readability.
>=20
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/h=
dmi.c
> index 2cba177..6773e2c 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -1010,8 +1010,13 @@ static int __init omapdss_hdmihw_probe(struct pl=
atform_device *pdev)
>  		return -EINVAL;
>  	}
> =20
> +	if (!devm_request_mem_region(&pdev->dev, res->start,
> +				     resource_size(res), "HDMI"))
> +		return -EBUSY;
> +
>  	/* Base address taken from platform */
> -	hdmi.ip_data.base_wp =3D ioremap(res->start, resource_size(res));
> +	hdmi.ip_data.base_wp =3D devm_ioremap(&pdev->dev, res->start,
> +					     resource_size(res));

I think you can use devm_request_and_ioremap() here to simplify it even
more.

 Tomi



--------------enig4C84C2D2EDA607F4E5885D3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQhPRBAAoJEPo9qoy8lh716lcQAK3A111IiSv68Y8VXXF5vjOy
rNTs5SIEoLXGJZbU0HmPIAa9o2QEqV6NM6PP7egwVKDGfn7zzwzk8JGoK5WscU2B
ap2pPNXEcGRuydZwR780GvVmQsPllvNsQL9C4AY7Rilc69G38V2NeH06Et9tOGLT
snW3B+KNHcBgBw1ZCIewUh7aodl1J5zqIvgonvgQS8jLPoY9jX4NoRis6TuKjd3a
gRSFysPbOWguwoV1LoWc326a4TL5388mhhOmNda2OnVCquxtZkhPVTAqJ1WciLtc
QNy8gI1geYyVuIG6kZVtJyq6ZHn1HVUnwixT4+EgliKkNWt7a+stdyHPisN2P34b
cAvIJWlDImC7zQo6EX3n0i33IQ0mAjrn5fUpcrrfQfCoTEJUI5xrYF9OgjxEkUyf
LyDkldZy52wdeo8M/y3r0zCsTcKY2nCaCWQwGONZCosYcOSJpX+KxMHUdkUglHAc
1tWVyEzL7VgwR8gNnJNi3MAtdG3mtrcrwz62bNeoGsJVyas5yKQuug1yfT04N6Nv
hMw4TL7zRESauArisauyKk6DIWhBoQzz/0XRO9w4HnlFnCg449FRB3GFtsbeV9sW
bcQTJT/BsuHCuUqQEznhlPYIPwJiO6g+4rl7vYskk1cpfnZxOyZLDtCjDPie+pdJ
qIyjac/wImWHcRMTue1B
=5w55
-----END PGP SIGNATURE-----

--------------enig4C84C2D2EDA607F4E5885D3E--
