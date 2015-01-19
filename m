From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] ARM: omap2plus_defconfig: Enable OHCI & EHCI HCD
 support
Date: Mon, 19 Jan 2015 15:41:48 -0600
Message-ID: <20150119214148.GV20386@saruman>
References: <1421702916-19018-1-git-send-email-sjoerd.simons@collabora.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ln+iIw7POnzHEEo5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57957 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758AbbASVnS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jan 2015 16:43:18 -0500
Content-Disposition: inline
In-Reply-To: <1421702916-19018-1-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-omap@vger.kernel.org

--Ln+iIw7POnzHEEo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 10:28:36PM +0100, Sjoerd Simons wrote:
> Enable CONFIG_USB_EHCI_HCD and CONFIG_USB_OHCI_HCD to get USB supports
> with omap2plus_defconfig.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> Changes in v2: Enable as modules rather then builtin
>=20
>  arch/arm/configs/omap2plus_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap=
2plus_defconfig
> index c2c3a85..f4009a2 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -159,6 +159,8 @@ CONFIG_USB_NET_SMSC95XX=3Dy
>  CONFIG_USB_ALI_M5632=3Dy
>  CONFIG_USB_AN2720=3Dy
>  CONFIG_USB_EPSON2888=3Dy
> +CONFIG_USB_EHCI_HCD=3Dm
> +CONFIG_USB_OHCI_HCD=3Dm
>  CONFIG_USB_KC2190=3Dy
>  CONFIG_LIBERTAS=3Dm
>  CONFIG_LIBERTAS_USB=3Dm
> --=20
> 2.1.4
>=20

--=20
balbi

--Ln+iIw7POnzHEEo5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvXocAAoJEIaOsuA1yqREEAIP/1KnxuBd+5s6UajwBbgb9MGW
TyUh3YBq2fU+eMxNzLOYEfDs0nQTJjEnyZMNQvqTvmhsv7XW2ueubQI9TVv3z4Bt
qAv+Hjna863mqAxdawmxQcfNhJngBFreR4oKuZzcUib7ooqm6jmWDNRt3LtUrn55
j3isTRDQ1LnYuPr1FLcc/8kXvAgdkHJh5vt0A598WlK9Di81Bj9OO6Zxw2fKYhhF
9oy9LnAlfpONYtDLg2rPZvQ5k/anh+Oa9Q9HGCtvNuSYWb1HuwoHO4U/TpRw3ycN
8HEtyjqLP16e8dcA6M0qQZXHnhMLcDUANWnTiLYu8HP8fJu4Zcic5Z2x6OsXhhpG
5591SIJpiqgSBS1WKSe6Sy3N59CUsAdoDa7j80ooTzw6PCNLJyLs4H4l4tsPp1JL
BrMGIlR4gHn0aGIH8F7iwpfgUK8nMboEA3g2Lgp2b5zACRdGshuK1YgUmtrruYml
hshva1YicoeFlkjN0edkhp4r7+a+zFLbWpNp5fb3j3dp60J+vXPPuEOdyTsSLnkS
FW3XNzfSQEw0g6xd9nKvmrEW3trxzMbmmBamt8hyNjQtl+Wo2NZMk9VT6Ay74yNO
TYDi1A/79FmuNEK8OAgY/GhPUtEINIAxc2ZB48JUJEIC6InVHBKt5XMshbv6NH//
TJGtnpAKQeUAMjL+ae0K
=Dheh
-----END PGP SIGNATURE-----

--Ln+iIw7POnzHEEo5--
