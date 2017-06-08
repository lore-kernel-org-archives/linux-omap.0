From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: Remove unused legacy code for device
 init
Date: Thu, 8 Jun 2017 12:55:53 +0200
Message-ID: <20170608105553.dq7rhfwhvz3wwa3e@earth>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-5-tony@atomide.com>
 <20170607222711.6kdhuvkymiseootn@earth>
 <20170608082825.GG3730@atomide.com>
 <20170608094712.GI3730@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1657127548119193568=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170608094712.GI3730@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============1657127548119193568==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vxuqz6ypofgy4i2p"
Content-Disposition: inline


--vxuqz6ypofgy4i2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 08, 2017 at 02:47:12AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [170608 01:32]:
> > * Sebastian Reichel <sre@kernel.org> [170607 15:30]:
> > > I guess you can drop omap2_init_devices() completly?
> >=20
> > We still have omap_init_sti() left there, but it's
> > just static inline void omap_init_sti(void) {} :)
> >=20
> > So yeah will remove that too.
>=20
> Here's this one updated.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Defines for L3_MODULES_MAX_LEN + L3_MODULES and most of the includes
could be dropped now.

-- Sebastian

> 8< -----------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 31 May 2017 15:51:32 -0700
> Subject: [PATCH] ARM: OMAP2+: Remove unused legacy code for device init
>=20
> We are now booting all mach-omap2 in device tree only mode.
> Any code that is only called in legacy boot mode where
> of_have_populated_dt() is not set is safe to remove now.
>=20
> Note that omap_init_sti() won't do anything so we can
> remove omap2_init_devices() as pointed out by Sebastian
> Reichel <sebastian.reichel@collabora.co.uk>.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/devices.c | 175 ------------------------------------=
------
>  1 file changed, 175 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -36,130 +36,6 @@
>  #define L3_MODULES_MAX_LEN 12
>  #define L3_MODULES 3
> =20
> -static int __init omap3_l3_init(void)
> -{
> -	struct omap_hwmod *oh;
> -	struct platform_device *pdev;
> -	char oh_name[L3_MODULES_MAX_LEN];
> -
> -	/*
> -	 * To avoid code running on other OMAPs in
> -	 * multi-omap builds
> -	 */
> -	if (!(cpu_is_omap34xx()) || of_have_populated_dt())
> -		return -ENODEV;
> -
> -	snprintf(oh_name, L3_MODULES_MAX_LEN, "l3_main");
> -
> -	oh =3D omap_hwmod_lookup(oh_name);
> -
> -	if (!oh)
> -		pr_err("could not look up %s\n", oh_name);
> -
> -	pdev =3D omap_device_build("omap_l3_smx", 0, oh, NULL, 0);
> -
> -	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
> -
> -	return PTR_ERR_OR_ZERO(pdev);
> -}
> -omap_postcore_initcall(omap3_l3_init);
> -
> -static inline void omap_init_sti(void) {}
> -
> -#if IS_ENABLED(CONFIG_SPI_OMAP24XX)
> -
> -#include <linux/platform_data/spi-omap2-mcspi.h>
> -
> -static int __init omap_mcspi_init(struct omap_hwmod *oh, void *unused)
> -{
> -	struct platform_device *pdev;
> -	char *name =3D "omap2_mcspi";
> -	struct omap2_mcspi_platform_config *pdata;
> -	static int spi_num;
> -	struct omap2_mcspi_dev_attr *mcspi_attrib =3D oh->dev_attr;
> -
> -	pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata) {
> -		pr_err("Memory allocation for McSPI device failed\n");
> -		return -ENOMEM;
> -	}
> -
> -	pdata->num_cs =3D mcspi_attrib->num_chipselect;
> -	switch (oh->class->rev) {
> -	case OMAP2_MCSPI_REV:
> -	case OMAP3_MCSPI_REV:
> -			pdata->regs_offset =3D 0;
> -			break;
> -	case OMAP4_MCSPI_REV:
> -			pdata->regs_offset =3D OMAP4_MCSPI_REG_OFFSET;
> -			break;
> -	default:
> -			pr_err("Invalid McSPI Revision value\n");
> -			kfree(pdata);
> -			return -EINVAL;
> -	}
> -
> -	spi_num++;
> -	pdev =3D omap_device_build(name, spi_num, oh, pdata, sizeof(*pdata));
> -	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s\n",
> -				name, oh->name);
> -	kfree(pdata);
> -	return 0;
> -}
> -
> -static void omap_init_mcspi(void)
> -{
> -	omap_hwmod_for_each_by_class("mcspi", omap_mcspi_init, NULL);
> -}
> -
> -#else
> -static inline void omap_init_mcspi(void) {}
> -#endif
> -
> -/**
> - * omap_init_rng - bind the RNG hwmod to the RNG omap_device
> - *
> - * Bind the RNG hwmod to the RNG omap_device.  No return value.
> - */
> -static void __init omap_init_rng(void)
> -{
> -	struct omap_hwmod *oh;
> -	struct platform_device *pdev;
> -
> -	oh =3D omap_hwmod_lookup("rng");
> -	if (!oh)
> -		return;
> -
> -	pdev =3D omap_device_build("omap_rng", -1, oh, NULL, 0);
> -	WARN(IS_ERR(pdev), "Can't build omap_device for omap_rng\n");
> -}
> -
> -static void __init omap_init_sham(void)
> -{
> -	struct omap_hwmod *oh;
> -	struct platform_device *pdev;
> -
> -	oh =3D omap_hwmod_lookup("sham");
> -	if (!oh)
> -		return;
> -
> -	pdev =3D omap_device_build("omap-sham", -1, oh, NULL, 0);
> -	WARN(IS_ERR(pdev), "Can't build omap_device for omap-sham\n");
> -}
> -
> -static void __init omap_init_aes(void)
> -{
> -	struct omap_hwmod *oh;
> -	struct platform_device *pdev;
> -
> -	oh =3D omap_hwmod_lookup("aes");
> -	if (!oh)
> -		return;
> -
> -	pdev =3D omap_device_build("omap-aes", -1, oh, NULL, 0);
> -	WARN(IS_ERR(pdev), "Can't build omap_device for omap-aes\n");
> -}
> -
>  /*----------------------------------------------------------------------=
---*/
> =20
>  #if IS_ENABLED(CONFIG_VIDEO_OMAP2_VOUT)
> @@ -185,54 +61,3 @@ int __init omap_init_vout(void)
>  #else
>  int __init omap_init_vout(void) { return 0; }
>  #endif
> -
> -/*----------------------------------------------------------------------=
---*/
> -
> -static int __init omap2_init_devices(void)
> -{
> -	/* Enable dummy states for those platforms without pinctrl support */
> -	if (!of_have_populated_dt())
> -		pinctrl_provide_dummies();
> -
> -	/* If dtb is there, the devices will be created dynamically */
> -	if (!of_have_populated_dt()) {
> -		/*
> -		 * please keep these calls, and their implementations above,
> -		 * in alphabetical order so they're easier to sort through.
> -		 */
> -		omap_init_mcspi();
> -		omap_init_sham();
> -		omap_init_aes();
> -		omap_init_rng();
> -	}
> -	omap_init_sti();
> -
> -	return 0;
> -}
> -omap_arch_initcall(omap2_init_devices);
> -
> -static int __init omap_gpmc_init(void)
> -{
> -	struct omap_hwmod *oh;
> -	struct platform_device *pdev;
> -	char *oh_name =3D "gpmc";
> -
> -	/*
> -	 * if the board boots up with a populated DT, do not
> -	 * manually add the device from this initcall
> -	 */
> -	if (of_have_populated_dt())
> -		return -ENODEV;
> -
> -	oh =3D omap_hwmod_lookup(oh_name);
> -	if (!oh) {
> -		pr_err("Could not look up %s\n", oh_name);
> -		return -ENODEV;
> -	}
> -
> -	pdev =3D omap_device_build("omap-gpmc", -1, oh, NULL, 0);
> -	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
> -
> -	return PTR_ERR_OR_ZERO(pdev);
> -}
> -omap_postcore_initcall(omap_gpmc_init);
> --=20
> 2.13.0

--vxuqz6ypofgy4i2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5LTIACgkQ2O7X88g7
+przcg//UfE/nE0GSjy4G0lEqIFklF+x4GjPSzzorsWSkJxX4JDCcq7nxiXO13XO
zn4OJdplCA07tHXcIveWLule4Z7mARmiq/muevQdBrx7q/9q5qQwarzWsZxkQQDK
WtNT0bFDWGVa6F09vYLRZ0SkgmXIUe1ulal/kYxCSHnyBdh6si9T9oJHm7Gw5B4w
ZrY2Pb7lfDox927L3/DgDl7A76RXNSygki7jWm80b0v3piLG6SffPGxoN0xDIXph
4CbPxs6aRdeUwHQtOQoybHCDMMgZxuKSIwYPLDHihoLF/qRr8bHrevJzW9E6FoVt
61L+AuzcnZZlZfAnE8N7l5tiU/ntGtJAIYeKfxXc58S8p25j8lH0vaEVwwRVLc82
pPhGxe3+aBHLLCurxjgdGGFe63Mk8XFkt4KY4ayt1QLbSJlXNLxqIP/qachfNJyC
Wl69ZuO2XmPlg8BrL6WUhU6Gd6qZ1ipBSZ8w/icDyimnPjRoUZyxodlN/p9cuTXr
ydI8ldXGs2b+hP5xPc0/JsSK5rFyVVmvUoLNXNcP7pPM1QACD5U9WKgXfMb0E/oO
l3FcMjLbq9TSbi23GeTbLOBbd4GgQ6lU5ReqVhzFWfDASzyYLppf1WsR+imP8ZFV
xFFpAa84UCXZsXabQOmydjuib3dxHrqMaxGgZtqO06aTdkO+THE=
=visD
-----END PGP SIGNATURE-----

--vxuqz6ypofgy4i2p--


--===============1657127548119193568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1657127548119193568==--
