From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3 1/3] rtc: omap: use module_platform_driver
Date: Fri, 24 Oct 2014 10:38:17 -0500
Message-ID: <20141024153817.GI26941@saruman>
References: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com>
 <1414126425-13198-2-git-send-email-lokeshvutla@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6187556472043849493=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1414126425-13198-2-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, tony@atomide.com, j-keerthy@ti.com, nsekhar@ti.com, johan@kernel.org, balbi@ti.com, t-kristo@ti.com, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux@roeck-us.net
List-Id: linux-omap@vger.kernel.org

--===============6187556472043849493==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kr14OxHsRwZHHqxS"
Content-Disposition: inline

--kr14OxHsRwZHHqxS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2014 at 10:23:43AM +0530, Lokesh Vutla wrote:
> module_platform_driver_probe() prevents driver from requesting probe defe=
rral.
> So using module_platform_drive() to support probe deferral.
> And also removing .owner field which is set by module_platform_driver.
>=20
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/rtc/rtc-omap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index e74750f..d9bb5e7 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -477,7 +477,7 @@ static const struct of_device_id omap_rtc_of_match[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
> =20
> -static int __init omap_rtc_probe(struct platform_device *pdev)
> +static int omap_rtc_probe(struct platform_device *pdev)
>  {
>  	struct omap_rtc	*rtc;
>  	struct resource	*res;
> @@ -708,18 +708,18 @@ static void omap_rtc_shutdown(struct platform_devic=
e *pdev)
>  }
> =20
>  static struct platform_driver omap_rtc_driver =3D {
> +	.probe		=3D omap_rtc_probe,
>  	.remove		=3D __exit_p(omap_rtc_remove),
>  	.shutdown	=3D omap_rtc_shutdown,
>  	.driver		=3D {
>  		.name	=3D "omap_rtc",
> -		.owner	=3D THIS_MODULE,
>  		.pm	=3D &omap_rtc_pm_ops,
>  		.of_match_table =3D omap_rtc_of_match,
>  	},
>  	.id_table	=3D omap_rtc_id_table,
>  };
> =20
> -module_platform_driver_probe(omap_rtc_driver, omap_rtc_probe);
> +module_platform_driver(omap_rtc_driver);
> =20
>  MODULE_ALIAS("platform:omap_rtc");
>  MODULE_AUTHOR("George G. Davis (and others)");
> --=20
> 1.9.1
>=20

--=20
balbi

--kr14OxHsRwZHHqxS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUSnJpAAoJEIaOsuA1yqRERzoP/RDpOuAnV8Han3KCbrCh14EA
Wi5Drjm0UzXFvjwUccR/pIBnW8CRYT2hTYxZyQRwoT7xsMv+xT1TjK+mC/H1Cp26
iuidWO0j84WDBfiqIe/rWPEwZHuOVfc4dZhyoFeODwAiKDbyqhd+lBrK0oMiJmzf
KvGLWPPRT7LewRa7vOCRKZBqGFhnGI/q7fUqkmd2CGQl1Vrq1M2l/JVMlC+j25/y
oiCeCzQM5LKLSL1xxUUHhLOgLNQDJ5umtSVYGZ28467SxHZ/g6QLCYkvVFgUJInH
DG72p6Ef+yZJO17GPjzEksKuUUC9b/bVtgv/5PWxose0BrrumcTchRH9LiGVv27x
aR161X15lf/LyfgASIYawGQbIzdC5uAjIBgprGBQymuyLL7+2IHvJ9XUMyMzWNUm
Y4qtNC971EWK77TGx4QLFxQrkWauxIx+jEBjZgP9XYBmH5S0KuQWi2AOA1XGw/wb
nR54BdLFhCCVsAOYfzK2QjOAG1owHjeks3pyPneKdH7BGfzYM2rfr2BL+30CNbEv
/3rBExJIa+DAZcy6crEGDB6x5U7HeTJn8aBL07Lam3kQDwnflGmBmbb3E/U5X4n4
hYJeRZDAexhmNeDoCCx4hCPPpvDG13t+kxLwm98eMnIFNPuPER8oTipm3rOkQRNJ
iKj5g6BS9cx3UhaL9Fnl
=8bTU
-----END PGP SIGNATURE-----

--kr14OxHsRwZHHqxS--


--===============6187556472043849493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6187556472043849493==--
