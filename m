From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5] mfd: tps65218: make INT[12] and STATUS registers
 volatile
Date: Tue, 6 Jan 2015 11:37:34 -0600
Message-ID: <20150106173734.GL6502@saruman>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-2-git-send-email-balbi@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2OzUYMsT4j3Kc+NU"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419622104-25812-2-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--2OzUYMsT4j3Kc+NU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2014 at 01:28:20PM -0600, Felipe Balbi wrote:
> STATUS register can be modified by the HW, so we
> should bypass cache because of that.
>=20
> In the case of INT[12] registers, they are the ones
> that actually clear the IRQ source at the time they
> are read. If we rely on the cache for them, we will
> never be able to clear the interrupt, which will cause
> our IRQ line to be disabled due to IRQ throttling.
>=20
> Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.15+
> Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

ping

> ---
>  drivers/mfd/tps65218.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 0d256cb..2243f75 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -125,10 +125,21 @@ int tps65218_clear_bits(struct tps65218 *tps, unsig=
ned int reg,
>  }
>  EXPORT_SYMBOL_GPL(tps65218_clear_bits);
> =20
> +static const struct regmap_range tps65218_yes_ranges[] =3D {
> +	regmap_reg_range(TPS65218_REG_INT1, TPS65218_REG_INT2),
> +	regmap_reg_range(TPS65218_REG_STATUS, TPS65218_REG_STATUS),
> +};
> +
> +static const struct regmap_access_table tps65218_volatile_table =3D {
> +	.yes_ranges =3D tps65218_yes_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(tps65218_yes_ranges),
> +};
> +
>  static struct regmap_config tps65218_regmap_config =3D {
>  	.reg_bits =3D 8,
>  	.val_bits =3D 8,
>  	.cache_type =3D REGCACHE_RBTREE,
> +	.volatile_table =3D &tps65218_volatile_table,
>  };
> =20
>  static const struct regmap_irq tps65218_irqs[] =3D {
> --=20
> 2.2.0
>=20

--=20
balbi

--2OzUYMsT4j3Kc+NU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrB1eAAoJEIaOsuA1yqRE/coP/1OU0pdJRftXk9YsTY9fe6j9
dzmu7aHymCSEhiSz9uU3sl3jobRecmHkwwtUIW7OvW5eEf0vgwcyzOGXQKMsv/w5
BquzTK1GkNptjZounbcy4dPs1hGyOWxesVh5ZIy/76LlFtEUuZs97VMtqYscyBSh
s19HhJbkxWEbw/WePiB6nvLW+dCOKyvscDk5h4oobo5vlSNFKjt8Vk98//9YvYBO
LyzRP1NhJ0jPIh5FCkr1WVUljXN1HsFx9QmFYx5otpAaF89fQzNWBpDdVULgaKsP
3nViawDfO3TWgC9Kiz9wZVD34y48rXw+t6VB8lFFWpaINa2XYcnorU3fFWuAsG7v
UxfgxAP23CGJJChm1K3QDtWe48xUiNwchRWZ7A6tR3SOTE6RRcnVAjtbBDifjvHT
xX22a2HILlicD+e+pJNB9XK5UIhVe9BV5qBMOzYiVB+emyd9h3XzrtHjNxLQIwD/
SsiFDNaBYINXAET8HFfOeiybxR9fpd0zgtqrlUqKujUvegzIcjtT5QLrsgKRksUk
8dwHah8bWZlR5CtAJzIutN3q47gxrNHw1vkCnNOfR9HV6zKjSaPdLq1CVRYardc1
tPSnE9OHGGCXvth7T2FchheSV3rMqmsVPdkduN+63GfSZWhg7zg3ofO4D4LYYoQ3
bI76g/xC/Gb4+Dsx4g5Q
=A3xo
-----END PGP SIGNATURE-----

--2OzUYMsT4j3Kc+NU--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
