From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2: hwmod: Fix "register offset NULL check" bug
Date: Tue, 18 Dec 2012 14:31:43 +0200
Message-ID: <20121218123106.GB30971@arwen.pp.htv.fi>
References: <1355833929-25387-1-git-send-email-gururaja.hebbar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47615 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab2LRMjH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Dec 2012 07:39:07 -0500
Content-Disposition: inline
In-Reply-To: <1355833929-25387-1-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, sudhakar.raj@ti.com, linux@arm.linux.org.uk

--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 18, 2012 at 06:02:09PM +0530, Hebbar Gururaja wrote:
> From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
>=20
> omap4_cminst_wait_module_ready() checks if register offset is NULL.
>=20
> int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
> 				   u16 clkctrl_offs)
> {
> 	int i =3D 0;
>=20
> 	if (!clkctrl_offs)
> 		return 0;
>=20
> In case of AM33xx, not all clock domains have CLKSTCTRL at 0x00. An
> example of this would be the RTC clock domain. In such cases the
> module ready check is skipped which leads to a data abort during bootup
> when RTC registers is accessed.
>=20
> Since the actual base address is verified in
> omap4_cminst_read_inst_reg(), this check here is not required at all
> and hence can be removed.
>=20
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> ---
> :100644 100644 7f9a464... 40545ff... M	arch/arm/mach-omap2/cminst44xx.c
>  arch/arm/mach-omap2/cminst44xx.c |    3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cmins=
t44xx.c
> index 7f9a464..40545ff 100644
> --- a/arch/arm/mach-omap2/cminst44xx.c
> +++ b/arch/arm/mach-omap2/cminst44xx.c
> @@ -271,9 +271,6 @@ int omap4_cminst_wait_module_ready(u8 part, u16 inst,=
 s16 cdoffs,
>  {
>  	int i =3D 0;
> =20
> -	if (!clkctrl_offs)
> -		return 0;

looks like commit log has the wrong argument. I believe you meant to say
that AM33xx has CLKSTCTRL exactly at 0x00 and that's why this check has
to be removed. No ?

--=20
balbi

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ0GIvAAoJEIaOsuA1yqREl+QP/A3PpBXS7DxACj15Gi5vt2QJ
QTJq74Fgxy06mexCkk08jYFCXz/PGU3FrmufTr+rGzEqxBhVx7BKSSphIEWofIzp
55/T8hlnj2DAJl6kPjim7YSMzMLx6TNRgjr5AcCY4qEaG8GH4RYKQxCA8G5YT8/d
Y+yq0BnvBDndiSe07aENYV3YZ5A6m2GaT3bkern3NRgzm4R52aoPpdgCxtRQEn/t
E0/CsIOlM2MsGfXCtogA+dC8v3lTpcC/03Bx+DCKoMC9v261W8o2bzlZ+oX3jmpS
8i4w7ljV3OuH+BtQXrPxjC+bMYDmwEJucEBQlVp/5YWkfs2B5g1Uc44pO4OyPLAu
gxlSOBGW4FeooW+pF13BUZQX+Ek90rLprtDRxNN6vY2oFvrLsvgf4YP3uJlanIZZ
4EwOFoyBKFUi3deLu4MohSstQ312KFo1pIAPP7AGCVNAOxR0o7wjXbC+lD+ZTllg
Pwf2Su4Eoo7Bo5x8CWpaRz3B9DxicJEVsi1g0Bq70Pd9zFfHcczuO51rg1fyzq0W
aoQyAk7GiaZMunKOr/1rjmpRZTvqViz9lnTa29tZUEfSXmd4Gm8yx2MH9xzAGf7g
hJNywLR8iqTi3SYePYLages+3sLajZNDU7RiNH0ZyWRh5FVwMe5hWWGX1tkrKMa6
I7Fndekf6dbGTqgddtpr
=V3bW
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
