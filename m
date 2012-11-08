From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: TWL: mux sys_drm_msecure as output for PMIC
Date: Thu, 8 Nov 2012 21:28:34 +0200
Message-ID: <20121108192834.GA2962@arwen.pp.htv.fi>
References: <1352401730-4269-1-git-send-email-khilman@deeprootsystems.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40152 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466Ab2KHTeq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Nov 2012 14:34:46 -0500
Content-Disposition: inline
In-Reply-To: <1352401730-4269-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 08, 2012 at 11:08:50AM -0800, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
>=20
> On OMAP4 boards using the TWL6030 PMIC, the sys_drm_msecure is
> connected to the MSECURE input of the TWL6030 PMIC.  This signal
> controls the secure-mode operation of the PMIC.  If its not mux'd
> correctly, some functionality of the PMIC will not be accessible since
> the PMIC will be in secure mode.
>=20
> For example, if the TWL RTC is in secure mode, most of its registers
> are read-only, meaning (re)programming the RTC (e.g. for wakeup from
> suspend) will fail.
>=20
> To fix, ensure the signal is properly mux'd as output when TWL is
> intialized.
>=20
> This fix is required when using recent versions of u-boot (>=3D v2012.04.=
01)
> since u-boot is no longer setting the default mux for this pin.
>=20
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Based on v3.7-rc4.  Targetted as a fix for v3.7.
>=20
> A correponding DT fix for this is needed as well, but that will be part o=
f=20
> a bigger series to get PM working with DT boot and needs to include other
> pins like sys_nirq1.
>=20
>  arch/arm/mach-omap2/twl-common.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-c=
ommon.c
> index 635e109..96cae8b 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -73,6 +73,7 @@ void __init omap4_pmic_init(const char *pmic_type,
>  {
>  	/* PMIC part*/
>  	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_=
WAKEUPENABLE);
> +	omap_mux_init_signal("fref_clk0_out.sys_drm_msecure", OMAP_PIN_OUTPUT);
>  	omap_pmic_init(1, 400, pmic_type, 7 + OMAP44XX_IRQ_GIC_START, pmic_data=
);
> =20
>  	/* Register additional devices on i2c1 bus if needed */

not entirely related to $SUBJECT but this essentially means we're
dropping the security feature whenever Linux runs.

Shouldn't we try to change that pin at register write boundaries so we
keep the secure feature enabled until we know we're going to write to
the HW ?

Maybe it could even be done later through pinctrl, perhaps ?

--=20
balbi

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnAfiAAoJEIaOsuA1yqREE9UP/3a/qiYpdOd26wnlTQL7q9rw
nbpcWIgV5DZDfWRUrW7L3E+b9JjN4AT41ipwAn/Pz7DPjrxI3cNkL+8p7C1K4nln
2jHvmrWRr+b0hNCVRhknz6BIJMS2R6d29KOHCBSzmPmAiu+5ug6HujXS/qDxr+Rw
7ZX05ZPejLlUoIzd9PXz4TU4PI1pyIcaCpQUm+Inc8cyBk7nomjBnL0nSZ6mJaTH
t6h5NSWanAO3MzPmrTZl4Y6f51xDMjQZid6JQxz7hUfDVj0eIuKvDuV3cDvsbP5R
PVAvqKuJcS9JpBPsNDFy0XeocRIMoU3uo/rD1MhBzfzKH4177SPA8f6q43QaaMK8
grDh64ul1Q8xH/UlKYJwPeUPb9Nc9NvDN7dQpfitZzfPLQMR9jz+FT3ByITJ20BA
uNVOf9gFMmPOUOJKaQZFYPJLNXcYP6Hs2ArgDukgoUf5RJnbIITyBYsz+94sjR0z
YvFSrKdCc07Sgt+6v1bs1dxORSA/h6Ay+n0ObsWVZ0I3QqumDNIGORBQUKvcBhbz
56OBXiohegljmNA9KTOoork3jUb1WQwvaWTLXJdTESUC9qMmO9EP7CuYOoX8aa+T
9lQwJ/QfJFUL1YKz7uhwVqeAgH2dtS5dnCknIXGOs3vd8I9sYPNqEbo5YG9ahbFT
y91iZob9Ei9yMXvmYEPT
=FRVv
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
