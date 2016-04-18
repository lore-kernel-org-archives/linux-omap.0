From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapfb: panel-sharp-ls037v7dw01: fix check of
 gpio_to_desc() return value
Date: Mon, 18 Apr 2016 12:20:28 +0300
Message-ID: <5714A6DC.2@ti.com>
References: <1458687114-9390-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="v3CpLCC9JVM0ReP5SAnWdqaXA3gPiCqUF"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458687114-9390-1-git-send-email-vz@mleia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--v3CpLCC9JVM0ReP5SAnWdqaXA3gPiCqUF
Content-Type: multipart/mixed; boundary="6keT5uWhF5Ehs3xaLsqPA0l7SQjJaHbrH"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Vladimir Zapolskiy <vz@mleia.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <5714A6DC.2@ti.com>
Subject: Re: [PATCH] omapfb: panel-sharp-ls037v7dw01: fix check of
 gpio_to_desc() return value
References: <1458687114-9390-1-git-send-email-vz@mleia.com>
In-Reply-To: <1458687114-9390-1-git-send-email-vz@mleia.com>

--6keT5uWhF5Ehs3xaLsqPA0l7SQjJaHbrH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23/03/16 00:51, Vladimir Zapolskiy wrote:
> The change fixes a check of gpio_to_desc() return value, the function
> returns either a valid pointer to struct gpio_desc or NULL, this makes
> IS_ERR() check invalid and may lead to a NULL pointer dereference in
> runtime.
>=20
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  .../fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c    | 12 ++++=
--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls03=
7v7dw01.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7=
dw01.c
> index abfd1f6..1954ec9 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01=
=2Ec
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01=
=2Ec
> @@ -200,20 +200,16 @@ static struct omap_dss_driver sharp_ls_ops =3D {
>  static int sharp_ls_get_gpio(struct device *dev, int gpio, unsigned lo=
ng flags,
>  		  char *desc, struct gpio_desc **gpiod)
>  {
> -	struct gpio_desc *gd;
>  	int r;
> =20
> -	*gpiod =3D NULL;
> -
>  	r =3D devm_gpio_request_one(dev, gpio, flags, desc);
> -	if (r)
> +	if (r) {
> +		*gpiod =3D NULL;
>  		return r =3D=3D -ENOENT ? 0 : r;
> +	}
> =20
> -	gd =3D gpio_to_desc(gpio);
> -	if (IS_ERR(gd))
> -		return PTR_ERR(gd) =3D=3D -ENOENT ? 0 : PTR_ERR(gd);
> +	*gpiod =3D gpio_to_desc(gpio);
> =20
> -	*gpiod =3D gd;
>  	return 0;
>  }
> =20
>=20

Thanks, queued for 4.6 fixes.

 Tomi


--6keT5uWhF5Ehs3xaLsqPA0l7SQjJaHbrH--

--v3CpLCC9JVM0ReP5SAnWdqaXA3gPiCqUF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXFKbcAAoJEPo9qoy8lh715L4QAI8a9Z9kDzDvFnc+lBu2YlI4
PQcaLD2FArTT/+WgMiwCuQpFSIqojh+7HAp+scNt8Sp1CQOIXLv9071mQ9s9gol7
3FiOlrgysUjPbL8VAq7aza4QTtafENJynHO3xTaEJODqtfhbxUK7OIbHONxla39+
DCm3M6TP9beRc3wjsYYiytENODM4cnE59VcWPRXXtQQ28v6vkj3dEijM4n5nngEs
rSr4YCZkjYR4i2oi0wgVw25yAcL4drKYgg//QTGEnp/rPqGYKYx8h8wftFicMMgD
1TbVSZjJ01w8xIOi0u6MfuK9ZvyQvZCcgvFcuplcK6rwAhGfsQvpI+CHuCOtcBMz
UZfxWIzYU3Fx9uHjQcXOMmb4eRbd2l9hB5hPeh4uZRlf6kINF9MgkAOIQ7setjJF
ivy53LBOsCFjUHOmedvLPUSBJA1tp5zds2IxvTHV5DJ2/dOLyhENY25ACW9AQD79
jXhnDfAx5b6ONTDOq8bwJKNoDYnMc7F76h0mCHr+Cih044IShW55HChdrqa3KESj
0bA7C5ueOntL77QnM1S84MfLLBJXAiiMCujciKMqOWfa0PayxjSgYH0x1pDJBTPj
AkSf6j0cv1HBQejBZxDupdDGShfRNLsPvJXCXp1XkrBRQosv3bXFc8MRICBmKcfd
x3Jnti6yrEIQ9TrUtBq6
=p0jl
-----END PGP SIGNATURE-----

--v3CpLCC9JVM0ReP5SAnWdqaXA3gPiCqUF--
