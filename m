From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dts: omap4-droid4: Add LCD
Date: Sun, 19 Mar 2017 02:29:27 +0100
Message-ID: <20170319012927.kmyqngprpip7le4m@earth>
References: <20170305054359.8293-1-tony@atomide.com>
 <20170305054359.8293-7-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="obhbtter7op6etws"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170305054359.8293-7-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--obhbtter7op6etws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 04, 2017 at 09:43:59PM -0800, Tony Lindgren wrote:
> The LCD panel on droid 4 is a command mode LCD. The binding follows
> the standard omapdrm binding and the changes needed for omapdrm command
> mode panels are posted separately.
>=20
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Tested-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

With a non-modular kernel lcd is not working with omapdrm if HDMI
is enabled. After dropping HDMI in droid4's dts file everything
worked as expected. I assume both work properly with a modular
kernel?

-- Sebastian

> ---
>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 60 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 60 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -17,6 +17,11 @@
>  		stdout-path =3D &uart3;
>  	};
> =20
> +	aliases {
> +		display0 =3D &lcd0;
> +		display1 =3D &hdmi0;
> +	};
> +
>  	/*
>  	 * We seem to have only 1021 MB accessible, 1021 - 1022 is locked,
>  	 * then 1023 - 1024 seems to contain mbm. For SRAM, see the notes
> @@ -66,6 +71,17 @@
>  		regulator-always-on;
>  	};
> =20
> +	/* LCD regulator from sw5 source */
> +	lcd_regulator: regulator-lcd {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "lcd";
> +		regulator-min-microvolt =3D <5050000>;
> +		regulator-max-microvolt =3D <5050000>;
> +		gpio =3D <&gpio4 0 GPIO_ACTIVE_HIGH>;	/* gpio96 */
> +		enable-active-high;
> +		vin-supply =3D <&sw5>;
> +	};
> +
>  	/* This is probably coming straight from the battery.. */
>  	wl12xx_vmmc: regulator-wl12xx {
>  		compatible =3D "regulator-fixed";
> @@ -111,6 +127,50 @@
>  	};
>  };
> =20
> +&dsi1 {
> +	status =3D "okay";
> +	vdd-supply =3D <&vcsi>;
> +
> +	port {
> +		dsi1_out_ep: endpoint {
> +			remote-endpoint =3D <&lcd0_in>;
> +			lanes =3D <0 1 2 3 4 5>;
> +		};
> +	};
> +
> +	lcd0: display {
> +		compatible =3D "panel-dsi-cm";
> +		label =3D "lcd0";
> +		vddi-supply =3D <&lcd_regulator>;
> +		reset-gpios =3D <&gpio4 5 GPIO_ACTIVE_HIGH>;	/* gpio101 */
> +
> +		panel-timing {
> +			clock-frequency =3D <0>;		/* Calculated by dsi */
> +
> +			hback-porch =3D <2>;
> +			hactive =3D <540>;
> +			hfront-porch =3D <0>;
> +			hsync-len =3D <2>;
> +
> +			vback-porch =3D <1>;
> +			vactive =3D <960>;
> +			vfront-porch =3D <0>;
> +			vsync-len =3D <1>;
> +
> +			hsync-active =3D <0>;
> +			vsync-active =3D <0>;
> +			de-active =3D <1>;
> +			pixelclk-active =3D <1>;
> +		};
> +
> +		port {
> +			lcd0_in: endpoint {
> +				remote-endpoint =3D <&dsi1_out_ep>;
> +			};
> +		};
> +	};
> +};
> +
>  /* L3_2 interconnect is unused, SRAM, GPMC and L3_ICLK2 disabled */
>  &gpmc {
>  	status =3D "disabled";
> --=20
> 2.11.1

--obhbtter7op6etws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljN3vcACgkQ2O7X88g7
+pqE9hAAm+HCv1UnNHV3xrs4Z5NdaqE7aYrdSBqBgX1wKt/VGVtVXYuD9DR9+exY
ozy7qd5AC1GPAF0U3+4EpAxWFeYagrfzZJMCi4yFRfb/K5wXTgHJnFHehrNbyAc1
Y4sGEOtMjDB1GaZf0pda0bPzX1YGqX7GC3BXQ58uWXb2jFHDAdETK0nwNPbSXFoo
DGEaq3X47bkCsta1Wh7/lSMA0zgJO82xFmr8CSq6btwYfZKlcRmnbyaPhUv1mGxO
POaEmhX6ZRXR/+BJND0rhblIYNa5s/nzhoq4ioMKl+SZUMZ7QRcJzVsLbcaYcc0r
mJC4rxT9LCCTAKdcewCn+darZTE9GIb/P3h9tkCXOfiQ4pGKTjNM/5JJLMYk3n0w
8rjVaZEUgZabOJOndKw8ZlUDT2X+ZDg2egK46kqTRJZAcZWLem6zZnIjIR2D0ONe
oAGD2VzAF5bhULhIuM7L2vjspbAN3jJqnKHSJge8nNNG4GjISE3EwJmDV9STF3qV
/AogoImN6D6fTHWIpYkAOLQle2Bs+R7QXYsPAps80bFbm1s3sP/KMvXlHgx7OpaX
S8sELV/hJCXIobjZIb6+tArf+t+FhryBqop9rgwXeijCqnXO5LT7jKqw2z34BoZ+
vufwPWxUeRQ+MIurp1kpwg7nCIG2Zo7/S+VdmsXyT6c+RpgoPWs=
=ODJz
-----END PGP SIGNATURE-----

--obhbtter7op6etws--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
