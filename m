From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC 14/23] USB: ehci-omap: raw read and write endian fix
Date: Mon, 18 Nov 2013 16:46:47 -0600
Message-ID: <20131118224647.GE12294@saruman.home>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
 <1384560086-11994-15-git-send-email-taras.kondratiuk@linaro.org>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384560086-11994-15-git-send-email-taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-networking-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2013 at 02:01:17AM +0200, Taras Kondratiuk wrote:
> From: Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
> Need to use endian neutral functions to read/write h/w registers.
> I.e instead of __raw_read[lw] and __raw_write[lw] functions code
> need to use read[lw]_relaxed and write[lw]_relaxed functions.
> If the first simply reads/writes register, the second will byteswap
> it if host operates in BE mode.
>=20
> Changes are trivial sed like replacement of __raw_xxx functions
> with xxx_relaxed variant.
>=20
> Signed-off-by: Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/usb/host/ehci-omap.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 6fa82d6..803e706 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -73,12 +73,12 @@ struct omap_hcd {
> =20
>  static inline void ehci_write(void __iomem *base, u32 reg, u32 val)
>  {
> -	__raw_writel(val, base + reg);
> +	writel_relaxed(val, base + reg);
>  }
> =20
>  static inline u32 ehci_read(void __iomem *base, u32 reg)
>  {
> -	return __raw_readl(base + reg);
> +	return readl_relaxed(base + reg);
>  }
> =20
>  /* configure so an HC device and id are always provided */
> --=20
> 1.7.9.5
>=20

--=20
balbi

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSipjXAAoJEIaOsuA1yqREA/MQAKab9xc4Y86C41FFYkoEGywX
tE5cVe1EvBDbba6QZ6C5w+snckoitr8fXF/gMMQzsyQNXonhxMu5Gvak9X1J1iGN
BZAiVrZTzo3WnbihqOpNsY9ZjBILXEW92ixYlck9pWx0kyWPwGrGwIJDcAV+Gh6s
RO2x904QHJ9BvWBXHaeOPQhFxQm6eS3F01yhSwt9Bi7PhhPd04KjcKzaXjo3Hh09
Qx0J3nk4b7LbUVIxkRk2+7vnV4x6bvGs0Oc9t2IaMtV8RNFa441ugzNPzKxKonEY
KCjIOziYYnWgl2aozD+SsP32x4XtMR6i5aKI6CHhacoXTAXg1WZoSCS3PZDxvjff
s2D7hwh/B3ePdFmXtzEXX0RsR75KPpUFTfMpCGVE0tSQC+3+/01lfvJ/YeA+zzza
M3WfoaHAE82DRrwvxzXepmIKUoG3UE8ed46i2GKywCJL8PPxwBpepC85L7smaPRV
weYVXTq2plD/E0Td4rs+0EZUFAL9La/q8wHCJ/EwfYXk7R7on//jV2ETehlINzTu
pX+sfbgLOr9FzbtjQEIo/ZYHFKWLk+C7/7lZZjXw+ked5NCGMH0Z6qOVvznV27+u
hfK7Y7V8GBYVgtDMtbkZaxjzfMAdAxt+FyWF/BRM2InxDiQoDUfWb+KB5Fdmb1r7
wmBaOWqdxvtbyw4E8PTA
=rzKl
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
