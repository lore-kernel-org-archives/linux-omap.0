From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/6] ARM: dts: omap4-droid4: Add LCD backlight
Date: Sun, 19 Mar 2017 02:18:30 +0100
Message-ID: <20170319011830.4fapdy2jvlfvpljr@earth>
References: <20170305054359.8293-1-tony@atomide.com>
 <20170305054359.8293-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5a2fveuyy5ewvvsc"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170305054359.8293-3-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--5a2fveuyy5ewvvsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 04, 2017 at 09:43:55PM -0800, Tony Lindgren wrote:
> The TI LMU driver has not yet been merged, but the device
> tree binding for TI LMU drivers has been acked already
> earlier by Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>. So it should
> be safe to apply to cut down the number of pending patches.
>=20
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Tested-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

I had to add https://patchwork.kernel.org/patch/7704601/ in addition
to the patches recently queued into MFD. It would be nice to get that
into 4.12 - @Milo Kim: What's your plan on that patch?

-- Sebastian

> ---
>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -180,6 +180,25 @@
>  	};
>  };
> =20
> +&i2c1 {
> +	lm3532@38 {
> +		compatible =3D "ti,lm3532";
> +		reg =3D <0x38>;
> +
> +		enable-gpios =3D <&gpio6 12 GPIO_ACTIVE_HIGH>;
> +
> +		backlight {
> +			compatible =3D "ti,lm3532-backlight";
> +
> +			lcd {
> +				led-sources =3D <0 1 2>;
> +				ramp-up-msec =3D <1>;
> +				ramp-down-msec =3D <0>;
> +			};
> +		};
> +	};
> +};
> +
>  /*
>   * REVISIT: Add gpio173 reset pin handling to the driver, see gpio-hog a=
bove.
>   * If the GPIO reset is used, we probably need to have /lib/firmware/max=
touch.fw
> --=20
> 2.11.1

--5a2fveuyy5ewvvsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljN3GMACgkQ2O7X88g7
+pprcg//es8CMoBFseetRj6dRaEkmCatqK6tDergwDbUgY67jMcz0irkQSVgFwCY
xSjuwZhnvVtb1uedOOvL87BEPMh3VOhRYLCbsZCOPvMdkou0QHOWcX74lrVUeqlp
Yfm2RKN+f9sHhv7HnyByeNXulAQ0Z8EFhbNxvWGTlOYvhDmdG8s99+iAhcLpFaSP
kfAncHgMSo6WWco/5WFDq5zeFTZFZMZqkTZFmMUTWnUR0b2FSpzFUNdr7vBKlSiZ
Ih7zEkDTtBbeG3dYl9TpQuTzNIT2weWGKkfnmt1Dmh1b/we+65msiNe7USkV5M5s
iIL1EgtXfBcPQNSYAz3vYBBGRv2bKSZuqM47k6mCAL+SW2ppLBSUvbd5UqXCBM7R
bt2ySohOy22Pz+IJq3XOOzsmdCR6lb6OZnYB+PEJDQkbRptgbcezcuZYMeTb8y2n
GaDa9R8tGapZkRUKlLpQpKSCdq0HAfAmuAchljDnztnvhwiiedliMKvs3IgV0tDD
XETL2Df7mMFttXqPjs8/ZLeGSD9xZSNjoIhDr30/zIDEzcnnZsNp2J4AP6U0ulTi
vXEFZWYE2CII443w2m3TV6xNmkW80Ek7HvQN+bPiz4nfECTr5IMJ0jtgwr6jxAVE
/H8BjAUY2AMt7JZQbLUN5orrtZqBn8FJV2wE+Etj2pLNDNRBni4=
=CjQ9
-----END PGP SIGNATURE-----

--5a2fveuyy5ewvvsc--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
