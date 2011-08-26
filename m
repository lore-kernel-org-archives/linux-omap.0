From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6] usb: musb: Add support for ti81xx platform
Date: Sat, 27 Aug 2011 02:52:27 +0300
Message-ID: <20110826235226.GD4829@legolas.emea.dhcp.ti.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
 <1314357108-2279-7-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1314357108-2279-7-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 26, 2011 at 04:41:48PM +0530, Ajay Kumar Gupta wrote:
> @@ -57,6 +58,10 @@ config USB_MUSB_AM35X
>  	tristate "AM35x"
>  	depends on ARCH_OMAP
> =20
> +config USB_MUSB_TI81XX
> +	bool "TI81XX"
> +	depends on SOC_OMAPTI81XX

this *must* be tristate. I can't emphasize enough how important this is.

> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 20a2873..07f3faf 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1014,7 +1014,9 @@ static void musb_shutdown(struct platform_device *p=
dev)
>  	|| defined(CONFIG_USB_MUSB_OMAP2PLUS)		\
>  	|| defined(CONFIG_USB_MUSB_OMAP2PLUS_MODULE)	\
>  	|| defined(CONFIG_USB_MUSB_AM35X)		\
> -	|| defined(CONFIG_USB_MUSB_AM35X_MODULE)
> +	|| defined(CONFIG_USB_MUSB_AM35X_MODULE)	\
> +	|| defined(CONFIG_USB_MUSB_TI81XX)		\
> +	|| defined(CONFIG_USB_MUSB_TI81XX_MODULE)

we really need to find a better way to handle this :-(

> diff --git a/drivers/usb/musb/ti81xx.c b/drivers/usb/musb/ti81xx.c
> new file mode 100644
> index 0000000..f95774e
> --- /dev/null
> +++ b/drivers/usb/musb/ti81xx.c

I still think this should be part of am35x.c It really look like they
are very similar.

on monday I'll read the rest of the file.

--=20
balbi

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOWDG6AAoJEAv8Txj19kN141YH/3YkDSzEtnnB68h9k9TequF/
Hwsa0SDNCxXgJHAkaj7dEybXmr2AHuAfyT4BAYSVbsvtjVEkPvUAV+YEoiFBClz2
mIpwyPPCWRCLSqWftPV6cErecfai2/G7oe85V+uw1t9H00xdgHiyASssraujt79k
JXPGVaRfjIPiKbhyZpqtq+B7Hndzcvqk7wdj57i2ifjF5aXFMdV2/iBOx8nAKWoN
pgUPZKHqSmLdRpXTDpIVlPzOP3UrmbaPUZa+NsCi3f0s03Uba0NUidTvoZVu7q3s
uweduS9yioA5r0HSzI9n0rrC9YUnbjwdoEICXTY/SMBBRYuUAe4av2RoTzDxf3U=
=wgb8
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
