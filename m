From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap: usb: host: remove deprecated flag
 'es2_compatibility'
Date: Wed, 25 Jul 2012 10:54:13 +0300
Message-ID: <20120725075413.GS3630@arwen.pp.htv.fi>
References: <1343153320-4628-1-git-send-email-ruslan.bilovol@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OiITrshLgfui8fEl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:42494 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755385Ab2GYH5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jul 2012 03:57:25 -0400
Received: by lahc1 with SMTP id c1so308364lah.4
        for <linux-omap@vger.kernel.org>; Wed, 25 Jul 2012 00:57:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343153320-4628-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: balbi@ti.com, tony@atomide.com, ajay.gupta@ti.com, gadiyar@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>


--OiITrshLgfui8fEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 24, 2012 at 09:08:40PM +0300, Ruslan Bilovol wrote:
> Currently this flag is not used anywhere and may be safely removed.
>=20
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>

looks good to me. Keshava ?

> ---
>  arch/arm/mach-omap2/usb-host.c        |    1 -
>  arch/arm/plat-omap/include/plat/usb.h |    4 ----
>  2 files changed, 0 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-hos=
t.c
> index dde8a11..5e1cb53 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -500,7 +500,6 @@ void __init usbhs_init(const struct usbhs_omap_board_=
data *pdata)
>  		ehci_data.regulator[i] =3D pdata->regulator[i];
>  	}
>  	ehci_data.phy_reset =3D pdata->phy_reset;
> -	ohci_data.es2_compatibility =3D pdata->es2_compatibility;
>  	usbhs_data.ehci_data =3D &ehci_data;
>  	usbhs_data.ohci_data =3D &ohci_data;
> =20
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/i=
nclude/plat/usb.h
> index 762eeb0..f8c1eb8 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -32,9 +32,6 @@ struct usbhs_omap_board_data {
>  	/* have to be valid if phy_reset is true and portx is in phy mode */
>  	int	reset_gpio_port[OMAP3_HS_USB_PORTS];
> =20
> -	/* Set this to true for ES2.x silicon */
> -	unsigned			es2_compatibility:1;
> -
>  	unsigned			phy_reset:1;
> =20
>  	/*
> @@ -53,7 +50,6 @@ struct ehci_hcd_omap_platform_data {
> =20
>  struct ohci_hcd_omap_platform_data {
>  	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
> -	unsigned			es2_compatibility:1;
>  };
> =20
>  struct usbhs_omap_platform_data {
> --=20
> 1.7.1
>=20

--=20
balbi

--OiITrshLgfui8fEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD6YlAAoJEIaOsuA1yqRE8moP/37kZVMxSlGfCQWjPDFquVNC
2VARsdPVT0g6MdB4MSDz7gcK5zlEP+7zcfiopsnc1S8iZImGDDoxTo38fl7UQhBq
tCcqhUjyLMHY5KiXARLxtKlyDgjLjE/JCqfk2wtCnKu/taRJ7WZBrE1buZvWi5fm
gvM/FCdzP0TQePBXba3VsiTkoSM89ce+DUqRsg9Zl+07KOqIYB6Y5OSQyknTl76T
B1XEVrlSlTyazXHChZmNTzKc1SRenAR3D0ss79jjfoC6FcjCH13TutMn5QdD3ZIQ
RmgOh5JKZfOXJoFxdck24WYBBrLImpemGz0uBj/9RJiQOI6YWTlIAhmMG1kWNVPM
e8vhS9S5kITUpH26HwtrheNYv7mmF99Yxt/EjA0qjkK5eQcUgZ6P28g2RGAnknNq
qbyEZFglCTbBgCuuYmWjUDMAJF/9hz5W3XmipM5U0o4iIOc+lPxeG5UqKrItHirr
xXeSy7htqNkBlyCnbDfwAuFCUxCAnfSMNf52iTUtcVipp7QJGxeIPX+Db8Y29olJ
aRc+1Y2/DN9Ym9RKMj2VRLVFUZIaiuA4fUj58N9ir6YjzTWdU7nAPK/xNjDRZw7z
ZCvs8h8vajz/HowlAOu66PChtBFAhpdbcSONLu5d+DPah+iaeCDouScqp/BNbTfN
Gq1+2dsy9GsWoZigBRwQ
=YNAP
-----END PGP SIGNATURE-----

--OiITrshLgfui8fEl--
