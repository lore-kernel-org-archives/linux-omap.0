From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 4/9] wl12xx: use frequency instead of enumerations for
 pdata clocks
Date: Tue, 2 Jul 2013 18:31:13 +0300
Message-ID: <20130702153113.GF7013@arwen.pp.htv.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-5-git-send-email-coelho@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372776948-24840-5-git-send-email-coelho-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 02, 2013 at 05:55:43PM +0300, Luciano Coelho wrote:
> diff --git a/drivers/net/wireless/ti/wl12xx/main.c b/drivers/net/wireless=
/ti/wl12xx/main.c
> index 1c627da..903dcb3 100644
> --- a/drivers/net/wireless/ti/wl12xx/main.c
> +++ b/drivers/net/wireless/ti/wl12xx/main.c
> @@ -1701,6 +1701,42 @@ static struct ieee80211_sta_ht_cap wl12xx_ht_cap =
=3D {
>  		},
>  };
> =20
> +static struct wl12xx_clock wl12xx_refclock_table[] =3D {

const

> +	{ 19200000,	false,	WL12XX_REFCLOCK_19	},
> +	{ 26000000,	false,	WL12XX_REFCLOCK_26	},
> +	{ 26000000,	true,	WL12XX_REFCLOCK_26_XTAL	},
> +	{ 38400000,	false,	WL12XX_REFCLOCK_38	},
> +	{ 38400000,	true,	WL12XX_REFCLOCK_38_XTAL	},
> +	{ 52000000,	false,	WL12XX_REFCLOCK_52	},
> +	{ 0,		false,	0 }
> +};
> +
> +static struct wl12xx_clock wl12xx_tcxoclock_table[] =3D {

const

--=20
balbi

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR0vJBAAoJEIaOsuA1yqREKRUQAJ73pu94CGu/7VONZrN80bat
GH4zZVV6q3bbm63/NzlUdZklonA5LwYUU8RUcRuF7xHBfkrt/iogHVfEtbtIrrgj
izP9hFLOWEM/iIkT8IIRMtIjsiIh10rH3JQ0s+WECz5/6G+B4hz1lRf9/bibNCxh
kyYCHD9ngHAtld0soEd2r7Yps0kzu4p1Eo+nmlTJg8pn9lB1eCPSOsMKfvATt32u
sawu3i+hwDlC6fG6x9GKidWEU9/6I31nNgyoKNXZgINp0P51h9cC2WoulboweWmy
SODIrBFfFfzp3YyCYpTxmD1bmN8vh8HCFTh+AdCiAG1rnN8/8m3qM0XfCSxWRO9b
zbYmrUlFQW4uIcrG62YTX3Cmv/z/4Wg2oNNR6FGJLdOK7xWDgdsWEedpUcOMJ7yw
MRed1iC7ve2Nk+iYv/T7jclfCIJYOpICs5VbwDca0eU1cu/vcKFC5/f13eR4qtdF
uMgkSTCoOTyQYeDSiVxy1Cwk5cDOTOWFpnxWbCaUlp3uVFM6QtDt8pZzQxupZJIv
bnd8LWXCvpktROTqJAeVZKOSaWRis1iJttgXF2j+cXaYIVe4cUVmYnPvbVYJsLbZ
w+ulUSiE3AIlEul5IGo4lA6Qrt8cmRDLJBz3hAUFADdKbb+WllUU6nw3O71uJoFo
Do6SpsKoCkxMoveFwq8p
=rKY4
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
