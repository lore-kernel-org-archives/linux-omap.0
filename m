From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2] ARM: OMAP4: USB: power down MUSB PHY during boot
Date: Fri, 9 Nov 2012 16:30:34 +0200
Message-ID: <20121109143033.GB10718@arwen.pp.htv.fi>
References: <1352471435-9560-1-git-send-email-t-kristo@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60168 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441Ab2KIOgu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Nov 2012 09:36:50 -0500
Content-Disposition: inline
In-Reply-To: <1352471435-9560-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Fri, Nov 09, 2012 at 04:30:35PM +0200, Tero Kristo wrote:
> Commit c9e4412ab8eb8ef82d645d8749c4ce96ad490007 removed all of the USB
> PHY functions for OMAP4, but this causes a problem with core retention
> as the MUSB module remains enabled if omap-usb2 phy driver is not used.
> This keeps the USB DPLL enabled and prevents l3_init pwrdm from idling.
>=20
> Fixed by adding a minimal function back that disables the USB PHY during
> boot.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>

looks good to me. I would still suggest adding a REVISIT or FIXME note
stating that this should be moved to SCM driver eventually ;-)

Other than that:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/omap_phy_internal.c |   32 +++++++++++++++++++++++++=
++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap=
2/omap_phy_internal.c
> index d992db8..9b56e5e 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -33,6 +33,38 @@
>  #include "soc.h"
>  #include "control.h"
> =20
> +#define CONTROL_DEV_CONF		0x300
> +#define PHY_PD				0x1
> +
> +/**
> + * omap4430_phy_power_down: disable MUSB PHY during early init
> + *
> + * OMAP4 MUSB PHY module is enabled by default on reset, but this will
> + * prevent core retention if not disabled by SW. USB driver will
> + * later on enable this, once and if the driver needs it.
> + */
> +static int __init omap4430_phy_power_down(void)
> +{
> +	void __iomem *ctrl_base;
> +
> +	if (!cpu_is_omap44xx())
> +		return 0;
> +
> +	ctrl_base =3D ioremap(OMAP443X_SCM_BASE, SZ_1K);
> +	if (!ctrl_base) {
> +		pr_err("control module ioremap failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Power down the phy */
> +	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
> +
> +	iounmap(ctrl_base);
> +
> +	return 0;
> +}
> +early_initcall(omap4430_phy_power_down);
> +
>  void am35x_musb_reset(void)
>  {
>  	u32	regval;
> --=20
> 1.7.4.1
>=20

--=20
balbi

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnROJAAoJEIaOsuA1yqREFy4P/jq1KtxgG38cIFN8ufZM1/Yc
OVqMnD7LqncVldngrPmzCSeKYSrI0SIUs++JuTyTipwlcv7tUti1aW4a358kNPv9
fGYggLLFK9lqd0o9LCnq+YbPgmDeavg1uue32K3L+z2W7NbC+7Jk78NJSPGLDEN5
PDiXANm9x4kdfCrxPx8tlrf1F+nqyduvrMhiwx1y1Gx5SQvT/MX3fSx3n0VGCRhv
1/xvphWSQKqy+dR12wf3g3vZZslGe0c3yNlKrw9hgnIUun6x8YZdjw/W4RjWCz0m
44RV9EmDWeQnj1CobjMwrtJHvMVRLs5kHk20auNUiO5YSNP34gPV26LswfjksXIs
6L4eKcwLXtg9fJ7lgDQSpZpfITx18ImltZ1ZPZ0qXHg2BEogYJLvD6fTcWxYSpx2
wXpKLS6/cIhkMZXllKUNKt0HH31vBGdrqSyHO9UDIJ6n82/1CM7ijHQZuiBc64e0
+i08IUO/cKdthTeADJrKY/KTpcBTBln2PPEkiQ2X6Gy57h6uRnSv0NFTGiCQWyMl
v44IMB2wqXfyIKtM5Go1wVTM4TNsKXgdSQRyMOWhuPSW0KB/hmDeUhycwCTVc5RD
G3PVbUAInMxaey9YZ2VkU2R44AlPNycrVP3iVZcrcjT/I44QSba4RSSb9UMvtjGJ
SFz3W19i9ywx9OG8+qz5
=2tiA
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
