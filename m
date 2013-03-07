From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP1: fix omap_udc registration
Date: Thu, 7 Mar 2013 09:34:34 +0200
Message-ID: <20130307073434.GB9171@arwen.pp.htv.fi>
References: <1362608605-26611-1-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59082 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab3CGHes (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 02:34:48 -0500
Content-Disposition: inline
In-Reply-To: <1362608605-26611-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2013 at 12:23:25AM +0200, Aaro Koskinen wrote:
> omap_udc platform device is not registered properly anymore:
> CONFIG_USB_GADGET_OMAP was deleted by 193ab2a6 (usb: gadget: allow
> multiple gadgets to be built) already in v3.1.
>=20
> Fix by using CONFIG_USB_OMAP instead. Tested on Nokia 770 by checking
> that omap_udc is probed & working properly when built as a module.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/mach-omap1/include/mach/usb.h |    2 +-
>  arch/arm/mach-omap1/usb.c              |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1=
/include/mach/usb.h
> index 753cd5c..8b2150e 100644
> --- a/arch/arm/mach-omap1/include/mach/usb.h
> +++ b/arch/arm/mach-omap1/include/mach/usb.h
> @@ -2,7 +2,7 @@
>   * FIXME correct answer depends on hmc_mode,
>   * as does (on omap1) any nonzero value for config->otg port number
>   */
> -#ifdef	CONFIG_USB_GADGET_OMAP
> +#if defined(CONFIG_USB_OMAP) || defined(CONFIG_USB_OMAP_MODULE)

could use IS_ENABLED()

--=20
balbi

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROEMKAAoJEIaOsuA1yqREvDIP/ju4hk5Wuh9BqeL4sf1axtL4
WKAGrnTTzmzvD4/H0L+bY7o7+G1Ghal8hMFCHtWKj9CfsZ+zdx0fEWx0U1sJfpZi
RXi5eUmuB7sI9evNdNQxJC4ZM2egek8QkmTwRhjISbn3uaHfONL0TcxJuRGF3qrX
3Ft0ypSGXy6/Hch0VQdssTlmwjkVlZyH9VAlbhZa4DONzRUS/YO55wbH4bU2bWQq
9FxwTJWvbf1RtI3l0Rah7OEQ2CK2wKdzV2ZqN3vIW/KimAYIUPwsCRmANRop5E6l
YXAKA8n/7+RdFrh41bOwaBuNnsUO0P2/9Pd7dwCUMoVvQ+ciApPou2VgPXMfDiQ3
VKO8X/Vg8c5J4654oON3A3vzWfNQKcHq9YFXOr1dNIRsZ59i3/7dUBF/BmY2pJ4u
k/n6SKP9V8d31SY8MGLJuyFNZ5dXy2WiQttCFmCjAQyKRFMv/Meq/qNtQRxbw8dv
JHHEAMFgtb5Sn21zmhRKrA4/hn2xdvnla0Jk8vOGxg5G4Lyputt0GxyakSzOMyZQ
ptgs0Mm/ZGqXk1v2ALFD9E7K3VmqcSTvLixM3v13zIzGClaBX7IkIik/fGrTqVYN
tTJXIvVUoHTRBzpC6h3W27+qUKjTKSkm7skj711yiTjyMmHt15SV4qn5F7CWb7yP
r8cpgeP11WBfh19KPj7N
=ZJD1
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
