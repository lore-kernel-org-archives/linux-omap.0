From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] fbdev: omap2: remove potential format string leak
Date: Fri, 12 Jun 2015 12:38:05 +0300
Message-ID: <557AA87D.2020504@ti.com>
References: <20150608223053.GA28939@www.outflux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ux3tWXD7UBfIEcwd84w9T5erSlgGcnciB"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150608223053.GA28939@www.outflux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Ux3tWXD7UBfIEcwd84w9T5erSlgGcnciB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 09/06/15 01:30, Kees Cook wrote:
> Since kobject_init_and_add takes a format string, make sure that the
> passed in name cannot be accidentally parsed.
>=20
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/video/fbdev/omap2/dss/display-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/display-sysfs.c b/drivers/vi=
deo/fbdev/omap2/dss/display-sysfs.c
> index 12186557a9d4..6ad0991f8259 100644
> --- a/drivers/video/fbdev/omap2/dss/display-sysfs.c
> +++ b/drivers/video/fbdev/omap2/dss/display-sysfs.c
> @@ -324,7 +324,7 @@ int display_init_sysfs(struct platform_device *pdev=
)
> =20
>  	for_each_dss_dev(dssdev) {
>  		r =3D kobject_init_and_add(&dssdev->kobj, &display_ktype,
> -			&pdev->dev.kobj, dssdev->alias);
> +			&pdev->dev.kobj, "%s", dssdev->alias);
>  		if (r) {
>  			DSSERR("failed to create sysfs files\n");
>  			omap_dss_put_device(dssdev);
>=20

Thanks, queued for 4.2.

 Tomi


--Ux3tWXD7UBfIEcwd84w9T5erSlgGcnciB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVeqh9AAoJEPo9qoy8lh71BaIQAJqwziSWkfL3n0BRRLCUxhTw
dAZ3mORTgEtLYKQFipYAtNAvdZ6EXslab0M4sOum9IZStKYrcRlmhA80WI4bRPqx
k9Xhm8lGj0JPyaPigYAukO4JPpv0tLS96bDGBLHXqtv3sz8gF1Wt0CNi7O0Rv2qN
M0/wrjXWqdQ5ttEjnPx7fmuGH4hznR8+cakpbXCBLY3jBiNwyDhea6mD/thNuK4A
VDjE9PXCYqPqhYFGdn2XGakYE/bjbgK7AQaqi3sd3sAVraPoSnC/M7sWJVoZ0sJT
ZPnTnyx88mff1MHj2arHyGnjgNqfRZIxi+GG62S3QRfT8yM+dmfkymXA5kIY6fGb
eReizWVbixsAvBRqO7yU0U2Lg0QySWq0Lmk975BQsCjB0o0S2ePL0TbBIDGx371N
o1yR5ONOuJ1osQmMSqdZ1uieaXI2RjUxOowd7KlLnFN/vgPoZzfaqpZX5mfnrsXr
JdoxmOxsN2TzuYh/4a5wKeWe4LRFLpbTV8RGzKs+FDU4URDezwG8LxxgrCAauXiF
pfcbt+WeoC1lZFysnRk834ufLN6Vfho6aw+alJwSCAYEo6+ZWFnS5wKwHjX28jJB
h71npPrttnF7fgH5meAFCzcTw5p7dbzlynd3mjW9fZ46RXii+YKlA1iOr96rLFk4
69/n3RGT7TcuoheryIFS
=DMX6
-----END PGP SIGNATURE-----

--Ux3tWXD7UBfIEcwd84w9T5erSlgGcnciB--
