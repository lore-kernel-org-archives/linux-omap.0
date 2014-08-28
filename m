From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/5] usb: dwc3: Adding Kconfig dependency for Exynos7
Date: Thu, 28 Aug 2014 14:28:39 -0500
Message-ID: <20140828192824.GR16689@saruman.home>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
 <1409212920-28526-5-git-send-email-gautam.vivek@samsung.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AonAANj1daC6QcQu"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409212920-28526-5-git-send-email-gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--AonAANj1daC6QcQu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2014 at 01:31:59PM +0530, Vivek Gautam wrote:
> The Exynos-DWC3 USB 3.0 DRD controller is also present on
> Exynos7 platform, so adding the dependency on ARCH_EXYNOS7
> for this driver.
>=20
> Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/usb/dwc3/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 785510a..e235894 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -55,7 +55,7 @@ config USB_DWC3_OMAP
> =20
>  config USB_DWC3_EXYNOS
>  	tristate "Samsung Exynos Platform"
> -	depends on ARCH_EXYNOS || COMPILE_TEST
> +	depends on (ARCH_EXYNOS || ARCH_EXYNOS7) || COMPILE_TEST

wait when building for ARCH_EXYNOS7 you don't get ARCH_EXYNOS ?

--=20
balbi

--AonAANj1daC6QcQu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/4LYAAoJEIaOsuA1yqRE8D8P/0x6TC8uZM5+NMPlJeCa1R+t
yRV5KHQibRTl9idBNyoIFZjim70TLGTqGrSAlFr5zT5esgHjuqW5pcKzFWncW4vm
ABDbsTc+feZPYUUqQLvp6oxJiAkmhWUzjXqPsAXEC0NqhqJbvXhFjgiQHyRyeOd1
af0x8JR0gZoCupzu6kb6RiX2G5Gk/b8144YdBt2kKO2VvF70UJGTBx8y5eLtawg2
6esK6yOegPsoUILf9zODwFb1Dhp6L0rFmvPpT6SdPTzaMEhQdC8Z5MVjwwdGj7vf
oJthXNzF66B2P6MFRp1/kEcTbXjYjE3pDo4gqrOJ4dkPDbC02O8hAMnftSZfCmgE
wazv1fCvntDh/UponwC5aB8GRRcKiLRaD7YXtRpT1qEu/8nwhi9WggUt3v7NsBfl
qX75K95iKQlducc2PGnq8pCD1JqOjqliHGsit3kQsYOcILrUVHHzvGGVOTlnpgx4
66tZLXdLyFBevYpSiihAkYr7Vj3o6igTKhemVatl7u5FAoIKjvpPJxLvGVLJ8090
FBV/cfO6I5IhiPrmA1C+EVvpIpdFPCK/VbkpAfuXZ8dXgIEW/BtcHHf88HzxJ1Sq
7aSrnD7fBNZnp7gLHqjl31Z13JsDNB51IZUcba3iP0N1qvoRp/81+8U9+JfZHBu8
MZy6TVrQuNYo7Kh+FOmD
=QabP
-----END PGP SIGNATURE-----

--AonAANj1daC6QcQu--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
