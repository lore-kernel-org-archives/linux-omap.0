From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/7] ARM: OMAP2+: Remove unused ti81xx platform init code
Date: Tue, 13 Jan 2015 19:19:51 -0600
Message-ID: <20150114011951.GD18523@saruman>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
 <1421190837-4692-2-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44790 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbbANBU5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2015 20:20:57 -0500
Content-Disposition: inline
In-Reply-To: <1421190837-4692-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2015 at 03:13:51PM -0800, Tony Lindgren wrote:
> The support for 81xx was never working in mainline, and it
> will be only supported in device tree mode. Let's remove all
> the remaining 81xx related platform code.

you should probably also mention here that you're dropping unnecessary
non-DT AM33xx support since that has never booted on legacy mode.

Other than that

Reviewed-by: Felipe Balbi <balbi@ti.com>


> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/cclock3xxx_data.c   |  6 +-----
>  arch/arm/mach-omap2/omap_phy_internal.c | 35 ---------------------------=
------
>  arch/arm/mach-omap2/usb-musb.c          | 12 ++---------
>  arch/arm/mach-omap2/usb.h               |  2 --
>  4 files changed, 3 insertions(+), 52 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/=
cclock3xxx_data.c
> index 644ff32..e79c80b 100644
> --- a/arch/arm/mach-omap2/cclock3xxx_data.c
> +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
> @@ -3634,10 +3634,6 @@ int __init omap3xxx_clk_init(void)
>  		omap_clocks_register(omap36xx_am35xx_omap3430es2plus_clks,
>  				     ARRAY_SIZE(omap36xx_am35xx_omap3430es2plus_clks));
>  		omap_clocks_register(omap3xxx_clks, ARRAY_SIZE(omap3xxx_clks));
> -	} else if (soc_is_am33xx()) {
> -		cpu_mask =3D RATE_IN_AM33XX;
> -	} else if (cpu_is_ti814x()) {
> -		cpu_mask =3D RATE_IN_TI814X;
>  	} else if (cpu_is_omap34xx()) {
>  		if (omap_rev() =3D=3D OMAP3430_REV_ES1_0) {
>  			cpu_mask =3D RATE_IN_3430ES1;
> @@ -3681,7 +3677,7 @@ int __init omap3xxx_clk_init(void)
>  	 * Lock DPLL5 -- here only until other device init code can
>  	 * handle this
>  	 */
> -	if (!cpu_is_ti81xx() && (omap_rev() >=3D OMAP3430_REV_ES2_0))
> +	if (omap_rev() >=3D OMAP3430_REV_ES2_0)
>  		omap3_clk_lock_dpll5();
> =20
>  	/* Avoid sleeping during omap3_core_dpll_m2_set_rate() */
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap=
2/omap_phy_internal.c
> index 1a19fa0..8e90356 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -152,38 +152,3 @@ void am35x_set_mode(u8 musb_mode)
> =20
>  	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
>  }
> -
> -void ti81xx_musb_phy_power(u8 on)
> -{
> -	void __iomem *scm_base =3D NULL;
> -	u32 usbphycfg;
> -
> -	scm_base =3D ioremap(TI81XX_SCM_BASE, SZ_2K);
> -	if (!scm_base) {
> -		pr_err("system control module ioremap failed\n");
> -		return;
> -	}
> -
> -	usbphycfg =3D readl_relaxed(scm_base + USBCTRL0);
> -
> -	if (on) {
> -		if (cpu_is_ti816x()) {
> -			usbphycfg |=3D TI816X_USBPHY0_NORMAL_MODE;
> -			usbphycfg &=3D ~TI816X_USBPHY_REFCLK_OSC;
> -		} else if (cpu_is_ti814x()) {
> -			usbphycfg &=3D ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
> -				| USBPHY_DPINPUT | USBPHY_DMINPUT);
> -			usbphycfg |=3D (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
> -				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
> -		}
> -	} else {
> -		if (cpu_is_ti816x())
> -			usbphycfg &=3D ~TI816X_USBPHY0_NORMAL_MODE;
> -		else if (cpu_is_ti814x())
> -			usbphycfg |=3D USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
> -
> -	}
> -	writel_relaxed(usbphycfg, scm_base + USBCTRL0);
> -
> -	iounmap(scm_base);
> -}
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-mus=
b.c
> index bc89723..e4562b2 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -82,16 +82,8 @@ void __init usb_musb_init(struct omap_musb_board_data =
*musb_board_data)
>  	musb_plat.mode =3D board_data->mode;
>  	musb_plat.extvbus =3D board_data->extvbus;
> =20
> -	if (soc_is_am35xx()) {
> -		oh_name =3D "am35x_otg_hs";
> -		name =3D "musb-am35x";
> -	} else if (cpu_is_ti81xx()) {
> -		oh_name =3D "usb_otg_hs";
> -		name =3D "musb-ti81xx";
> -	} else {
> -		oh_name =3D "usb_otg_hs";
> -		name =3D "musb-omap2430";
> -	}
> +	oh_name =3D "usb_otg_hs";
> +	name =3D "musb-omap2430";
> =20
>          oh =3D omap_hwmod_lookup(oh_name);
>          if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
> diff --git a/arch/arm/mach-omap2/usb.h b/arch/arm/mach-omap2/usb.h
> index 4ba2ae7..3395365 100644
> --- a/arch/arm/mach-omap2/usb.h
> +++ b/arch/arm/mach-omap2/usb.h
> @@ -68,5 +68,3 @@ extern void am35x_musb_reset(void);
>  extern void am35x_musb_phy_power(u8 on);
>  extern void am35x_musb_clear_irq(void);
>  extern void am35x_set_mode(u8 musb_mode);
> -extern void ti81xx_musb_phy_power(u8 on);
> -
> --=20
> 2.1.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtcQ3AAoJEIaOsuA1yqREOsEP/1a8VM/LAcO4HDIlc9NB/IYr
UoqhBvL9oc+a+3DJJamCJgL+oO3FiOw9NNsRpckvQr347amkFuS3MEDf3U7J8B7u
sZrl+b02Lw5XgUiWlP0U/y+W0sYRzB17GpUuLQR6vCuyEwRhNMhgl7JaeuXR9E8T
lyjkQIJvqaOy1tzJInQpDX20L/7DnyW5traB/U2rKb/ENoPPGQz7+aycGtZlVvrb
TIK4rSEGqA2jSoq2L6BSlZLQl7v3j/QcEUBcA5yKiuMi+HLbLKDDG5Zr6N2W4BI1
67swoEox2JBHdtcEugem/xR4MPS+q7e8F+0zlTPIjQQxpcX48cL9cUSn71cuVf5v
IMGfkoDHiiFx2rLiAJlB+TkpvNXhzdw0gKfW37M0JmMLe70Ak0Z0122R6RhtJIhN
WDoosq9Vu7Y1TNsvPQEYK/Ab6hLl2NDfLP9wW76Su4/zhXpPQTE/KE+6I4zZNT7x
Qt5o9IiOPRtvhwuWgW6iuAQ6yVdfI9wR8KjqMXy1gYHi6I1Cvbif0/ijIj4GUKwC
BdwWpcriEcXyTM5zyELCebE8c/9da9C5VvlcWFGTieqwJCJnYvlZmFjQG86fktc/
LLxljsj2N+xxOHw7ap21DI97liDPaoUxNmLXRhoKW5jcrdejhd731WHNlUUxDRQ0
1AGJFPRQgfWQJXBJc4eJ
=6ARH
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
