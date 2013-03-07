From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP1: fix omap_udc registration
Date: Thu, 7 Mar 2013 15:41:17 +0200
Message-ID: <20130307134117.GA16577@arwen.pp.htv.fi>
References: <1362663013-28794-1-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53668 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753586Ab3CGNlm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 08:41:42 -0500
Content-Disposition: inline
In-Reply-To: <1362663013-28794-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 07, 2013 at 03:30:12PM +0200, Aaro Koskinen wrote:
> omap_udc platform device is not registered properly anymore:
> CONFIG_USB_GADGET_OMAP was deleted by 193ab2a6 (usb: gadget: allow
> multiple gadgets to be built) already in v3.1.
>=20
> Fix by using CONFIG_USB_OMAP instead. Tested on Nokia 770 by checking
> that omap_udc is probed & working properly when built as a module.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>=20
> 	Patch history:
>=20
> 	v2: use IS_ENABLED()
>=20
> 	v1: http://marc.info/?t=3D136260886600006&r=3D1&w=3D2
>=20
>  arch/arm/mach-omap1/include/mach/usb.h |    2 +-
>  arch/arm/mach-omap1/usb.c              |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1=
/include/mach/usb.h
> index 753cd5c..45e5ac7 100644
> --- a/arch/arm/mach-omap1/include/mach/usb.h
> +++ b/arch/arm/mach-omap1/include/mach/usb.h
> @@ -2,7 +2,7 @@
>   * FIXME correct answer depends on hmc_mode,
>   * as does (on omap1) any nonzero value for config->otg port number
>   */
> -#ifdef	CONFIG_USB_GADGET_OMAP
> +#if IS_ENABLED(CONFIG_USB_OMAP)
>  #define	is_usb0_device(config)	1
>  #else
>  #define	is_usb0_device(config)	0
> diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
> index 1a1db59..4118db5 100644
> --- a/arch/arm/mach-omap1/usb.c
> +++ b/arch/arm/mach-omap1/usb.c
> @@ -123,7 +123,7 @@ omap_otg_init(struct omap_usb_config *config)
>  	syscon =3D omap_readl(OTG_SYSCON_1);
>  	syscon |=3D HST_IDLE_EN|DEV_IDLE_EN|OTG_IDLE_EN;
> =20
> -#ifdef	CONFIG_USB_GADGET_OMAP
> +#if IS_ENABLED(CONFIG_USB_OMAP)
>  	if (config->otg || config->register_dev) {
>  		struct platform_device *udc_device =3D config->udc_device;
>  		int status;
> @@ -169,7 +169,7 @@ omap_otg_init(struct omap_usb_config *config)
>  void omap_otg_init(struct omap_usb_config *config) {}
>  #endif
> =20
> -#ifdef	CONFIG_USB_GADGET_OMAP
> +#if IS_ENABLED(CONFIG_USB_OMAP)
> =20
>  static struct resource udc_resources[] =3D {
>  	/* order is significant! */
> @@ -600,7 +600,7 @@ static void __init omap_1510_usb_init(struct omap_usb=
_config *config)
>  	while (!(omap_readw(ULPD_DPLL_CTRL) & DPLL_LOCK))
>  		cpu_relax();
> =20
> -#ifdef	CONFIG_USB_GADGET_OMAP
> +#if IS_ENABLED(CONFIG_USB_OMAP)
>  	if (config->register_dev) {
>  		int status;
> =20
> --=20
> 1.7.10.4
>=20

--=20
balbi

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROJj9AAoJEIaOsuA1yqRExQIP/1X9n0XmizNDsCGX8+/OgaX3
SFsEYzGjFwWGkjKk4gPpvFKOwf8cSItR6pR2dBha0NkatpSmCz0RQDihmJS70d+j
x9XtAQ2rudDyzIgtkMRufXf0BHe2WwikfDfodXCYFUROUEFT9PZ5iltDw+TFGUQo
s6DC6DQtT8rJ9mh0W1G4ZbvdmTm66P+DUu+fLk6Hrkom31xR186tLCjrqyLQsM5D
+u+NA7Fn6d5Yf2kmMW5YYd2eQ3bTZGrR7rs5Qhv7MYjDRqsXIshpPR7U8p+ZcTKf
TceEJMjs6s8w90JdL5U5Uvrmm9Deq+98cS034qkW+HuG/IM8dF4WFh4GbhtKHpZH
d12Egj9rDEVMhfUHtnsjWaOYKTVRCrVGJ47yTXT0PSgszwe0rK1l20ATDI1zycw0
Nmtfb/wBHa8ZqQkYBJnusA00/3W7C2PeRGlKakBsr6jvlkTz8Vg51FCHZhTpfhP1
3datmDVdXn4vRpmI/+o8Gq/rBqCygTYB5ta77zaORLFJv1CNgaWjM2e12miLiWrM
nJApC9/9lcEh+NMG1LFQKvTSO8hn/ll0JgOMsW0pK7NJ0rtCv1v3WSDOxufv/Zn2
8/Qiettk/UqkK5i2Rd+WS2JxUU4DVC/W1PyaD88R8p9fOfgVlBs+VtMagXtqrK+G
iIzoMdZERIh3KEGmkX+Z
=9yCO
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
