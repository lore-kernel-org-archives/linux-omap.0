From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/1] drivers/video/fbdev/omap2/dss/dss.c: add __exit to
 dss_uninit_ports
Date: Fri, 9 May 2014 12:57:16 +0300
Message-ID: <536CA67C.2090109@ti.com>
References: <20140423180958.8b3cc405c00fbbf7c6c5a947@skynet.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="AeMGSGLlMmj0gi91eLW9XgjTdD1CrS5G5"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140423180958.8b3cc405c00fbbf7c6c5a947@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--AeMGSGLlMmj0gi91eLW9XgjTdD1CrS5G5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 23/04/14 19:09, Fabian Frederick wrote:
> dss_uninit_ports is only called by __exit omap_dsshw_remove
>=20
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  drivers/video/fbdev/omap2/dss/dss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/=
omap2/dss/dss.c
> index d55266c..a1c1cc2 100644
> --- a/drivers/video/fbdev/omap2/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/dss/dss.c
> @@ -813,7 +813,7 @@ static int __init dss_init_ports(struct platform_de=
vice *pdev)
>  	return 0;
>  }
> =20
> -static void dss_uninit_ports(void)
> +static void __exit dss_uninit_ports(void)
>  {
>  #ifdef CONFIG_OMAP2_DSS_DPI
>  	dpi_uninit_port();
>=20

Thanks, queued for 3.16.

 Tomi



--AeMGSGLlMmj0gi91eLW9XgjTdD1CrS5G5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbKZ8AAoJEPo9qoy8lh71TNgQAKFCeaXACuyvqFUnCn55hFBT
2G0TQREpyUdjgWIYvBKUzEfBL7hWYnXBBh9wK8ngB2QtU/5KLR5YZTmPy/rXEj3F
v5WkD7Kuk2fB1f58hiXfj0Y6+h4k2qj5BMvHktE4K2DQVFG1jDc6nuJ9P3Zbtzd2
NIi0npQqQbH2zdox84amsOELejwPagjGtJ9HR7WX+qqT6coBbo7UFxLp67+GLmDo
poJOWcsPY3Yf4NR70UFH4Q2A2YJPRKDwibsvZhrneyS1XWY2V5Yih+/APokWo0U1
clpz5wTsuO7Gr+MXAc3hO/BRVoniERkYcW21RXlzHmd9asanzDjNNjf932PSg/W/
sVtbXun1rrjBCczirbQDAHCInAP6V9VycuI94+bYsJdYLX9yZNdTXNQI6obyQPSr
FmesSpCSgOzUhXOGzoR+zwZHAyV948f78T+sFwn6Q6801L5fxtaoPKdbhJyKfmHI
D0F/IGqUFaS/fLgj7Gnz17aYjRNYIANWCyJcZikzmmpwoCBchBW6GfbTpIRj69Wo
9ulBW8GsB9f/U5UcvcB9UY/A4ILxsDaCTt40cpff5Sz0aupUKBy1x/pdoHwxwrJY
CgdVVEwh5sjZkypkUnOK8+VFcpBUTSk4wTOZ5VW6D7kxUSxaCm3gBZgnTLDl0hnT
etz/puv7g9QdFTx743Xp
=SNtz
-----END PGP SIGNATURE-----

--AeMGSGLlMmj0gi91eLW9XgjTdD1CrS5G5--
