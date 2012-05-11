From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb/dwc3: Fix the dwc3 dependency
Date: Fri, 11 May 2012 10:57:16 +0300
Message-ID: <20120511075713.GA14284@arwen.pp.htv.fi>
References: <1336715724-8441-1-git-send-email-josephdanielwalter@gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336715724-8441-1-git-send-email-josephdanielwalter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joseph daniel <josephdanielwalter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2012 at 11:25:24AM +0530, joseph daniel wrote:
> The warning shown up when ran with randconfig,
>=20
> warning: (USB_DWC3) selects USB_XHCI_PLATFORM which has unmet direct depe=
ndencies (USB_SUPPORT && USB_XHCI_HCD)
>=20
> Signed-off-by: joseph daniel <josephdanielwalter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/dwc3/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index d8f741f..68271fa 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -1,6 +1,6 @@
>  config USB_DWC3
>  	tristate "DesignWare USB3 DRD Core Support"
> -	depends on (USB && USB_GADGET)
> +	depends on (USB && USB_SUPPORT && USB_XCHI_HCD && USB_GADGET)
					      ^^^^
					      typo

I would prefer the select to change:

select XHCI_PLATFORM if (USB_SUPPORT && USB_XHCI_HCD)

or something similar.

>  	select USB_OTG_UTILS
>  	select USB_GADGET_DUALSPEED
>  	select USB_GADGET_SUPERSPEED

--=20
balbi

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPrMZZAAoJEIaOsuA1yqREblcP/jy7llmu5EKoTOAAKsqr2pq9
PZQxMTrGTxPKKHOIcdYM2PQcAAHD90eDBOc/n2pPgMioG3cgkRm/Fdaf5hY5GOUq
rilmGVCkFgpPPE79sF2Ziln4QxRb17NjAr7xbovG/SZidLds/GW6+uFP7dqNb6jR
yU4cy5/hvYM9siPE1bGgyPBAuroM6t/RXGOBLWFFuTfwK+LOQhWKMaX7xl7PRVSV
2fAwmML+lWmVIyMMVPv0IJVrW0S36JL8uFwOgwqrowrpA6zKzKFXtn6t+QgqwTew
LZBgQO5vVYybmB6H2v0x22h5f14iFyXmGWJZQ2nLqKhKP1EdOa+jg/Z4ASxQ8niA
5M+vc6D0kOwetccAp7stNa7zrSHPrh5W5wqA2xrC9KBPZmLvshPTBH1BvQ9z8BPA
rcgUdiCVfQwGw/8xLc8y4xQ2gwINWWVwbFex1wSimOEeRgZhXf8f012iF+i3QthV
Jb+0DUZlEme5vfAzHAYKCO3Mxky+Wg8sVO1Jyr4JdheULAMQTGTmne2/ixhjcXoX
W8fCTLjssyKJ3EPee7ZsB2nDkpv7FJJ7ZyxwzdqdU4SBsqLslx8OgKcBSzRNhLWN
wW1195NyI3GWSNIUBhYuu58oV9UCR1rjdnuFcWeuBQwXIrS1BfyNFDYhSQnmR7Ty
iS/7J8DHNsKWXj9K34Ut
=tt8g
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
