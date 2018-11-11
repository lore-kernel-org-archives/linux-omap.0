From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 1/4] drm/omap: Populate DSS children in omapdss driver
Date: Sun, 11 Nov 2018 01:45:24 +0100
Message-ID: <20181111004524.4pygzunbn65owimv@earth.universe>
References: <20181110111654.4387-1-laurent.pinchart@ideasonboard.com>
 <20181110111654.4387-2-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1502546763=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181110111654.4387-2-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org


--===============1502546763==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2gmqexhtfj5zgy4b"
Content-Disposition: inline


--2gmqexhtfj5zgy4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 10, 2018 at 01:16:51PM +0200, Laurent Pinchart wrote:
> The DSS DT node contains children that describe the DSS components
> (DISPC and internal encoders). Each of those components is handled by a
> platform driver, and thus needs to be backed by a platform device.
>=20
> The corresponding platform devices are created in mach-omap2 code by a
> call to of_platform_populate(). While this approach has worked so far,
> it doesn't model the hardware architecture very well, as it creates
> child devices before the parent is ready to handle them. This would be
> akin to creating I2C slaves before the I2C master is available.
>=20
> The task can be easily performed in the omapdss driver code instead,
> simplifying mach-omap2 code. We however can't remove the mach-omap2 code
> completely as the omap2fb driver still depends on it, but we can move it
> to the omap2fb-specific section, where it can stay until the omap2fb
> driver gets removed.
>=20
> This has the added benefit of not allowing DSS components to probe
> before the DSS itself, which led to runtime PM issues when the DSS probe
> is deferred.
>=20
> Fixes: 27d624527d99 ("drm/omap: dss: Acquire next dssdev at probe time")
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  arch/arm/mach-omap2/display.c     | 111 ++++++++++++++----------------
>  drivers/gpu/drm/omapdrm/dss/dss.c |  11 ++-
>  2 files changed, 63 insertions(+), 59 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 9500b6e27380..f86b72d1d59e 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -209,11 +209,61 @@ static int __init omapdss_init_fbdev(void)
> =20
>  	return 0;
>  }
> -#else
> -static inline int omapdss_init_fbdev(void)
> +
> +static const char * const omapdss_compat_names[] __initconst =3D {
> +	"ti,omap2-dss",
> +	"ti,omap3-dss",
> +	"ti,omap4-dss",
> +	"ti,omap5-dss",
> +	"ti,dra7-dss",
> +};
> +
> +static struct device_node * __init omapdss_find_dss_of_node(void)
>  {
> -	return 0;
> +	struct device_node *node;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(omapdss_compat_names); ++i) {
> +		node =3D of_find_compatible_node(NULL, NULL,
> +			omapdss_compat_names[i]);
> +		if (node)
> +			return node;
> +	}
> +
> +	return NULL;
>  }
> +
> +static int __init omapdss_init_of(void)
> +{
> +	int r;
> +	struct device_node *node;
> +	struct platform_device *pdev;
> +
> +	/* only create dss helper devices if dss is enabled in the .dts */
> +
> +	node =3D omapdss_find_dss_of_node();
> +	if (!node)
> +		return 0;
> +
> +	if (!of_device_is_available(node))
> +		return 0;
> +
> +	pdev =3D of_find_device_by_node(node);
> +
> +	if (!pdev) {
> +		pr_err("Unable to find DSS platform device\n");
> +		return -ENODEV;
> +	}
> +
> +	r =3D of_platform_populate(node, NULL, NULL, &pdev->dev);
> +	if (r) {
> +		pr_err("Unable to populate DSS submodule devices\n");
> +		return r;
> +	}
> +
> +	return omapdss_init_fbdev();
> +}
> +omap_device_initcall(omapdss_init_of);
>  #endif /* CONFIG_FB_OMAP2 */
> =20
>  static void dispc_disable_outputs(void)
> @@ -361,58 +411,3 @@ int omap_dss_reset(struct omap_hwmod *oh)
> =20
>  	return r;
>  }
> -
> -static const char * const omapdss_compat_names[] __initconst =3D {
> -	"ti,omap2-dss",
> -	"ti,omap3-dss",
> -	"ti,omap4-dss",
> -	"ti,omap5-dss",
> -	"ti,dra7-dss",
> -};
> -
> -static struct device_node * __init omapdss_find_dss_of_node(void)
> -{
> -	struct device_node *node;
> -	int i;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(omapdss_compat_names); ++i) {
> -		node =3D of_find_compatible_node(NULL, NULL,
> -			omapdss_compat_names[i]);
> -		if (node)
> -			return node;
> -	}
> -
> -	return NULL;
> -}
> -
> -static int __init omapdss_init_of(void)
> -{
> -	int r;
> -	struct device_node *node;
> -	struct platform_device *pdev;
> -
> -	/* only create dss helper devices if dss is enabled in the .dts */
> -
> -	node =3D omapdss_find_dss_of_node();
> -	if (!node)
> -		return 0;
> -
> -	if (!of_device_is_available(node))
> -		return 0;
> -
> -	pdev =3D of_find_device_by_node(node);
> -
> -	if (!pdev) {
> -		pr_err("Unable to find DSS platform device\n");
> -		return -ENODEV;
> -	}
> -
> -	r =3D of_platform_populate(node, NULL, NULL, &pdev->dev);
> -	if (r) {
> -		pr_err("Unable to populate DSS submodule devices\n");
> -		return r;
> -	}
> -
> -	return omapdss_init_fbdev();
> -}
> -omap_device_initcall(omapdss_init_of);
> diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/=
dss/dss.c
> index 1aaf260aa9b8..7553c7fc1c45 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dss.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dss.c
> @@ -1484,16 +1484,23 @@ static int dss_probe(struct platform_device *pdev)
>  						   dss);
> =20
>  	/* Add all the child devices as components. */
> +	r =3D of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> +	if (r)
> +		goto err_uninit_debugfs;
> +
>  	omapdss_gather_components(&pdev->dev);
> =20
>  	device_for_each_child(&pdev->dev, &match, dss_add_child_component);
> =20
>  	r =3D component_master_add_with_match(&pdev->dev, &dss_component_ops, m=
atch);
>  	if (r)
> -		goto err_uninit_debugfs;
> +		goto err_of_depopulate;
> =20
>  	return 0;
> =20
> +err_of_depopulate:
> +	of_platform_depopulate(&pdev->dev);
> +
>  err_uninit_debugfs:
>  	dss_debugfs_remove_file(dss->debugfs.clk);
>  	dss_debugfs_remove_file(dss->debugfs.dss);
> @@ -1522,6 +1529,8 @@ static int dss_remove(struct platform_device *pdev)
>  {
>  	struct dss_device *dss =3D platform_get_drvdata(pdev);
> =20
> +	of_platform_depopulate(&pdev->dev);
> +
>  	component_master_del(&pdev->dev, &dss_component_ops);
> =20
>  	dss_debugfs_remove_file(dss->debugfs.clk);
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20

--2gmqexhtfj5zgy4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvne50ACgkQ2O7X88g7
+ppgcg/+I87eJ7FIJY5D6gsJXhcfMK7++0H4iYqQIi5fhK7ka9NGJwrRjepd81LO
4e9bFCWsMnFPYYY9AyvwP8Fx3AkDR665RkNCfzjERoEdx1dU56Ga+VLuqh15+PUz
EL7LaFPe5kP6sEvpnNcqug+Hz6ZmuwebkAvLJzCN7X5qGfsaDbkYmZyIq+HoPO0z
J7NC0j6oJGbcWddM+3k21i4nfy1wvYJKRLbFdq0sGUk0EvqxPv/9MpLUvgvLmSUY
Rk2JpWY/4cM/VvQhVj7O8QI7L+qqr3SelgS5tIyJAGzkCLwiAN73YUiuNTzRDYug
bz8AiCJVfh3Zt8fXhc7NLMCzRybv0fcKx2swD48T63pDrqWG7ce8r3Iysf+VHSz1
Yo8dgdAnP/gYXQljmXF4zTy2KGQmQNgP57iLatObeO3oZ62ZS0cz2xLU/vfUr/Mt
2bRdXl6/reLdatrTzKoMdDlXxzDS8tiBXYUixaWBWtvorVb+lGbCCxCXn8T/Ob53
VoE0dPAEJB7ZbgEDLc8Vw1xKHSMM8StRzji65d8KkGwziYFWoZeLLH0EzT7EXKWa
1QxvBgTQkWG2Wuhj8knN4A6uQbCwljrrrYW5BzN9VbQnuZHOYxNioJgwcg+nO0h8
9SxoItXB+oAFJ6PHMP5BODTfEIHHZWeEcveka46qAxFVgCglvj4=
=Ev89
-----END PGP SIGNATURE-----

--2gmqexhtfj5zgy4b--

--===============1502546763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1502546763==--
