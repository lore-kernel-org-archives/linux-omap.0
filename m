From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 7/7] ARM: omap2: gpmc-onenand: Replace printk KERN_ERR
 with dev_warn()
Date: Sat, 9 Feb 2013 18:55:32 +0200
Message-ID: <20130209165532.GB13338@arwen.pp.htv.fi>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360427896-12004-8-git-send-email-ezequiel.garcia@free-electrons.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60653 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760756Ab3BIQzj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 9 Feb 2013 11:55:39 -0500
Content-Disposition: inline
In-Reply-To: <1360427896-12004-8-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>

--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 09, 2013 at 01:38:16PM -0300, Ezequiel Garcia wrote:
> Since the condition is not an error but a warning, replace
> printk KERN_ERR with dev_warn.
>=20
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-omap2/gpmc-onenand.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpm=
c-onenand.c
> index 4771945..fd6e35b 100644
> --- a/arch/arm/mach-omap2/gpmc-onenand.c
> +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> @@ -367,7 +367,7 @@ void gpmc_onenand_init(struct omap_onenand_platform_d=
ata *_onenand_data)
> =20
>  	if (cpu_is_omap24xx() &&
>  			(gpmc_onenand_data->flags & ONENAND_SYNC_READWRITE)) {
> -		printk(KERN_ERR "Onenand using only SYNC_READ on 24xx\n");
> +		dev_warn(dev, "OneNAND using only SYNC_READ on 24xx\n");

it would seem more natural to use dev_err() instead.

--=20
balbi

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFn+EAAoJEIaOsuA1yqRES70QAKjkku/I6SLTpH8cXtqTuvly
BmPYyTRUH3wIf7mXClpPEFaJTKsVoMoYVPh6Fidi/FBUbKFuUgP17EPCcVD93bgM
RSF4sFoMlfdSknVxrq3UaDmFwBBJn+ky/BVLSr1QFhy2DuqMzPSB9ZA9oUorvaUE
5zFYN7cI4G8O3/21cG5iMnEXOn0zdzPJrOV1n5tnWI/Ztp4jDLTfkJFo94WKfMtn
GxEe/1ytexHkVCdBlWFNhCcVX1irYamZgTt1arF+qVRdKI0HQXFoLLpH9GgGzeQx
3L+gnERgvfI1ryIIASUhQ6b7BOJuEKaCzL0Ba5Zl2ynEtS7FC6U42oVHorIyLrLU
0ap9OKp1BXDf69/NAIIsp4eSKT+82G2hrgWysrng1k2b06n9moGLLEULIWWUSrp4
Z4GTi3mtIPBmc+7Rkz3oh7WEmRCm1+zT8YJI6R4RYtRnG5h+YISPr0dCyJVEPoax
HafQFAvlWAyPl+ruuyLSxq0VmuWJLYEsyU9/GTpsi279c6KP/GQdHY/iQVSwRJN3
yfQDeCFnI+tS7ptCsLpjmQYNqa4MV0U6OPbJ50dLUXmUR5MQOtiTvheWnKRp+wp/
uEfrSBSo1Hd+l9RfM3aEKXZKMkr9iSBsMkF7+Pf5qXSnk65uM3BrPNkAX3rqdW6R
rQ5mKbVphuUzXCAW3Kwa
=B2sL
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
