From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/8] usb: musb: Change to use new IO access
Date: Mon, 24 Nov 2014 13:12:02 -0600
Message-ID: <20141124191202.GH25712@saruman>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
 <1416855906-13931-5-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38263 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754074AbaKXTLv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2014 14:11:51 -0500
Content-Disposition: inline
In-Reply-To: <1416855906-13931-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Fabio Baltieri <fabio.baltieri@linaro.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

--9sSKoi6Rw660DLir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2014 at 11:05:02AM -0800, Tony Lindgren wrote:
> @@ -312,10 +345,40 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 l=
en, u8 *dst)
>  		ioread8_rep(fifo, dst, len);
>  	}
>  }
> -#endif
> =20
> -#endif	/* normal PIO */
> +/*
> + * Old style IO functions
> + */
> +u8 (*musb_readb)(const void __iomem *addr, unsigned offset);
> +EXPORT_SYMBOL(musb_readb);
> +
> +void (*musb_writeb)(void __iomem *addr, unsigned offset, u8 data);
> +EXPORT_SYMBOL(musb_writeb);
> =20
> +u16 (*musb_readw)(const void __iomem *addr, unsigned offset);
> +EXPORT_SYMBOL(musb_readw);
> +
> +void (*musb_writew)(void __iomem *addr, unsigned offset, u16 data);
> +EXPORT_SYMBOL(musb_writew);
> +
> +u32 (*musb_readl)(const void __iomem *addr, unsigned offset);
> +EXPORT_SYMBOL(musb_readl);
> +
> +void (*musb_writel)(void __iomem *addr, unsigned offset, u32 data);
> +EXPORT_SYMBOL(musb_writel);

let's make all these _GPL()

--=20
balbi

--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUc4MCAAoJEIaOsuA1yqRENdsP/idDXNAtqEY+6/xffJ6yug5W
VScl28UEcdm5lsmrgt4YKvHqCSNP63xXgJ8j0k4QVu2KlIOXmTeVMyTXrNkgTNSm
sNajzzFYtvLza0imsFrkEZ2LjNDp7TKgp12jKEafdCy5I5iFINDH5Lt4ayY/qJ0p
YT9UfF9/h+9XE2EM67qqgGgFfE3GCrzvvLHdnRhH2OEkdhX3O5g7x4tRMjz74BOV
16Z0WK6VjJc/dtPXezfT6DMOLPIj+1DIXJ+X4wH8EODhlrhQ3qNwa6h/tGYfaCo1
gKrEuyJ6Tb2yB/TiRd8BiByaghpKmDNrWXJDsFhuXsUxrBj0519H71lYQ5wLUSSJ
PQJztrKUXxk8u5CUtSRoOHqJP0znjnG/fVG5EZat1abUE3ZmDznXARkEv1WhcGiJ
IMbGEGTbtQIslPyF0X4jYdIkKEJ6kM8YnahoUc1GatGaEkBEg9HLuoK29k/j5fF3
dC82qyLh9qG4X0M1KzOZzMrjI6K8ZZgnu3xJFUV9LikSBxhAcIlT/Z3/j4zxVcKx
Ud8YrggrxOoj1P9n7pi6voKIGxivuvBLHehM9GU3JZ8aBW2kz325vO3+Dwq+Bn/n
2/XVNPiXvJS4iVR1dhVMKqWMqAqrxIsOMZDUg+MAxS1uGjhIleOtklKvgA9WjOqz
clKDgvQn9I+bybVlWYhw
=rXBB
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--
