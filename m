From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb otg: TWL4030_USB depends on USB_MUSB_OMAP2PLUS in
 Kconfig
Date: Fri, 24 Aug 2012 10:27:31 +0300
Message-ID: <20120824072729.GE3334@arwen.pp.htv.fi>
References: <20120820113624.GP17455@arwen.pp.htv.fi>
 <1345754324-12068-1-git-send-email-pmeerw@pmeerw.net>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1345754324-12068-1-git-send-email-pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2012 at 10:38:44PM +0200, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>

I need a commit log explaining why we need to add this extra depend ;-)

> ---
>  drivers/usb/otg/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
> index 13fd1ddf..fefca18 100644
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -58,7 +58,7 @@ config USB_ULPI_VIEWPORT
> =20
>  config TWL4030_USB
>  	tristate "TWL4030 USB Transceiver Driver"
> -	depends on TWL4030_CORE && REGULATOR_TWL4030
> +	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
>  	select USB_OTG_UTILS
>  	help
>  	  Enable this to support the USB OTG transceiver on TWL4030
> --=20
> 1.7.9.5
>=20

--=20
balbi

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNyzhAAoJEIaOsuA1yqREQjYP/AxZN3w+Xdnun1VlsPmwej/F
C72wRglghss+8u3gOJHbayh+L8YsH1GGu94xj8LzgMfGHcfuL66VbBb080Le1BTs
eBPdwafqeNZ5HGF2WnjLwqxfP/TiGSAvVILnx3NuIMc3GDzDmWWBx3DXHs1RVlhK
Wk3gcnjBP56dBX4ov+fdTY0uLYJE79NVg3kkoP6dTCdKxrZ7aIilVEFljRjmTC3v
fkOod0cjZo22bNbJgkFRLtpQ/YbebSFL7N6MIllNQe2C9J9NXute/K6qap5DAoeH
2+qt5YcgdduMbn4AcDKxh4OfKTJZpyZHzFLmFg7KE2dd2dBLyE+Zzf17EpbaQXSI
DodsvFZ0QqcqU369s3bWGUhv8PN563Uexye5h6YYYH7jauKIkWg471P1zK9DwuxM
0uXsQyAkpDqoNqSyoKui8Zl86gawtGNj3Kyd3s28Ps1kiWq9e3lkoWP8efCzAWm5
lxSeMluJ2ALn0QJIKaOkZ0/ukveoA1vb3hwMm7DUIG3j3a/J9E9O7Uv8EKHpwiVc
xdrn53d9o/tTsTjBv/26I6oBMtgVnft++hY/x8/zkF6EqVHN6nOxw84VfxOMxpiJ
BGCH78NoOiHXiT8+c4htdh55YZaxZenJV1Rg8xy6h5dNCgzw3/gwl+7YyLY920qO
0BdQRXTmMl/SBEDWqPpu
=joa7
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
