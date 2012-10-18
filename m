From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv9 8/8] ARM: OMAP4: USB: power down MUSB PHY if not used
Date: Thu, 18 Oct 2012 13:33:34 +0300
Message-ID: <20121018103334.GA1449@arwen.pp.htv.fi>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-9-git-send-email-t-kristo@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53343 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755073Ab2JRKjJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 06:39:09 -0400
Content-Disposition: inline
In-Reply-To: <1350552010-28760-9-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2012 at 12:20:10PM +0300, Tero Kristo wrote:
> Commit c9e4412ab8eb8ef82d645d8749c4ce96ad490007 removed all of the USB
> PHY functions for OMAP4, but this causes a problem with core retention
> as the MUSB module remains enabled if omap-usb2 phy driver is not used.
> This keeps the USB DPLL enabled and prevents l3_init pwrdm from idling.
>=20
> Fixed by adding a minimal function back that disables the USB PHY in
> case omap-usb2 driver is not used.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/omap_phy_internal.c |   27 +++++++++++++++++++++++++=
++
>  1 files changed, 27 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap=
2/omap_phy_internal.c
> index d992db8..6a4b9cf 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -33,6 +33,33 @@
>  #include "soc.h"
>  #include "control.h"
> =20
> +#define CONTROL_DEV_CONF		0x300
> +#define PHY_PD				0x1
> +
> +#ifndef CONFIG_OMAP_USB2

this is a tristate, meaning that can be a module.

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
> +#endif

I think you could do it even if the driver is enabled.

Just to make sure I understand the issue right: is the PHY enabled by
default or did bootloader left this enabled ?

--=20
balbi

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQf9r+AAoJEIaOsuA1yqRETPsP/j01FZRbv9oaA6W5qbRfxyAy
icspkHfBE91+2v6jsSAnRn/LKAfksHeFX2goA/HkmNIJEY+bK5GNwq6XmdhMp3vB
1piczD6upglU95k2y6rdBbsIOKh5q6K/tgw5aKw8QauRhbnDQ0tP8m1BZqSlCo4F
cDRIDPecBflhEhVoJQHyw/t1DbhSwGegSWpuX8rSMMjQYCzkInES1BAspQoJux+k
CjjUio+OxBpaNuUwa18u3nKtJevkyLLsS4zLH1IkRhHo11sWNDRKlxeTUG7AnJaQ
NrNC0ubabfeQ6dSvAnliMPJ2GevDc9i1FSFGMWv1hBhjDC9mnILi9ZUOoMJcu/Vk
BhzxVdaNlhdtltSr7CSZ7waXUQSGALYPUmHBLCyoju961t/PBojmWdDYgbGzszyq
h21YzHQxV0C76UJVNqc8hOnFZ2RhXNg46aeYNZxsyOjOrFSwmd0DUs+Em0STRF/m
yrVHmFYavWy8JphJ1LJ36Gc9XrPFPkF5OMKN2EOJb/SA9e0ySLCZzdMTFXJvvZ6T
9omdf0bSWYxZ1SJuhwHxJvsjcZZm42ZpAob1YYcc/vdQ5ubOc82XN1cCb6lbxEWb
9qRPqhXznLNOLst30ePxq5jjPqx0ATadwJmqkxKhjWqHM37CgLNEWSE2RsPm6Sob
WF5Qihx+24n5YAFtGks3
=jpdF
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
