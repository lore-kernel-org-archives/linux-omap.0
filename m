From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 6/7] OMAPDSS: DPI: Add support for multiple instances
Date: Thu, 26 Jun 2014 15:15:20 +0300
Message-ID: <53AC0ED8.7060303@ti.com>
References: <1401096492-1405-1-git-send-email-archit@ti.com> <1401864063-19196-1-git-send-email-archit@ti.com> <1401864063-19196-7-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="a56VLF9ivHeBUQp8GJvUxaa2vk4TfSsq4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59671 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932274AbaFZMPW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jun 2014 08:15:22 -0400
In-Reply-To: <1401864063-19196-7-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--a56VLF9ivHeBUQp8GJvUxaa2vk4TfSsq4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/06/14 09:41, Archit Taneja wrote:
> Register DPI outputs, and assign the port_num to them as specified by t=
he
> 'reg' property in the DPI ports in DT.
>=20
> To support multiple DPI instances, dpi_get_channel needs to take the DP=
I
> instance's reg-id to get the corresponding channel. Make it take this
> argument.We just pass 0 in the non-DT path, since we don't support mult=
iple
> instances in the non-DT case.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/fbdev/omap2/dss/dpi.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/=
omap2/dss/dpi.c
> index b579022..3e204a8 100644
> --- a/drivers/video/fbdev/omap2/dss/dpi.c
> +++ b/drivers/video/fbdev/omap2/dss/dpi.c
> @@ -616,7 +616,7 @@ static void dpi_init_pll(struct dpi_data *dpi)
>   * the channel in some more dynamic manner, or get the channel as a us=
er
>   * parameter.
>   */
> -static enum omap_channel dpi_get_channel(void)
> +static enum omap_channel dpi_get_channel(int reg)
>  {
>  	switch (omapdss_get_version()) {
>  	case OMAPDSS_VER_OMAP24xx:
> @@ -710,7 +710,7 @@ static void dpi_init_output(struct platform_device =
*pdev)
>  	out->id =3D OMAP_DSS_OUTPUT_DPI;
>  	out->output_type =3D OMAP_DISPLAY_TYPE_DPI;
>  	out->name =3D "dpi.0";
> -	out->dispc_channel =3D dpi_get_channel();
> +	out->dispc_channel =3D dpi_get_channel(0);
>  	out->ops.dpi =3D &dpi_ops;
>  	out->owner =3D THIS_MODULE;
> =20
> @@ -730,11 +730,31 @@ static void dpi_init_output_port(struct platform_=
device *pdev,
>  {
>  	struct dpi_data *dpi =3D port->data;
>  	struct omap_dss_device *out =3D &dpi->output;
> +	int r;
> +	u32 reg;
> +
> +	r =3D of_property_read_u32(port, "reg", &reg);
> +	if (r)
> +		reg =3D 0;
> +
> +	switch (reg) {
> +	case 2:
> +		out->name =3D "dpi.2";
> +		break;
> +	case 1:
> +		out->name =3D "dpi.1";
> +		break;
> +	case 0:
> +	default:
> +		out->name =3D "dpi.0";
> +		break;
> +	}

I don't think it makes sense to use "reg" word anywhere else than when
getting the property from the DT data. What we need here is port number.
That port number is just stored in "reg" property in the DT data. So
rather do:

of_property_read_u32(port, "reg", &port_num);

and use the port_num (or such) everywhere, including the subject of the
next patch.

 Tomi



--a56VLF9ivHeBUQp8GJvUxaa2vk4TfSsq4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrA7YAAoJEPo9qoy8lh71WKkP/3kZAYyH1b3Xj1ffI7eyOJgS
vWYDhvlAT4H3YhRZ+1ncdV8kqOY1uKWPnkxiAJ2O0bzhfDymqZOzHRdymPpI9o3T
4l7zdZ4oAx8UO5z+WStWD9N3H7IyQ7thHgudbb7o2t3k77qXmn2DJnBu8fzji9aV
q1TOe/5R1StYRQAmSgQnwDTcZjLlYgkqokhnf7GPi1GCfcUk3D+4MapW9nYAQLPO
cu351bR0dI4AvTiJkB85Byzcth5/pBCdl4iPWWTDnYA5gIp/wrDSikdaMICzOwta
Cp/coIrGYXuGD2nVsUqxwmGiM0OIAJVJO3dKRm2ii4mZeGop8YHO0bwVy9cjZQJ3
Ig//alNFFYDxRiyOttq3vANUEe64EmuPHzmhIDjosVRSNzVL+dAPvMzBM6eChSxO
GLyzFLHZdgOipPJiJou6F3OIq8h+xC6F4QJxJd05pSvzfmji6GJKIldedZmgwUQQ
nxtYajex0LYhV+n6tvOa++i7W1DU/uFCKNTl9/pViYqtNZwYZJwTqdRXsMiDWAHv
+B3wfCJ2k+qIgfIgv1wy9OWQVSV2CR0gZF6gCOD+0cdH//VZPihwF3VbMghJgEay
j2AevWNaLD2GiO2HNJ2UmPKKaWdk1lMVKTu1PjuGlYPEWgTZRTtdVe0cYzbG8nSa
K+E7dkSQ9KiUAf+XiETx
=2rcA
-----END PGP SIGNATURE-----

--a56VLF9ivHeBUQp8GJvUxaa2vk4TfSsq4--
