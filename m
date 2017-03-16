From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/6] ARM: dts: omap4-droid4: Add HDMI support
Date: Thu, 16 Mar 2017 23:43:56 +0100
Message-ID: <20170316224355.dvrxccmywesvyi47@earth>
References: <20170305054359.8293-1-tony@atomide.com>
 <20170305054359.8293-6-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pfgz6o3nia4oehf2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170305054359.8293-6-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--pfgz6o3nia4oehf2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 04, 2017 at 09:43:58PM -0800, Tony Lindgren wrote:
> We can get HDMI working as long as the 5V regulator is on. There is
> probably an encoder chip there too, but so far no idea what it might be.
> Let's keep the 5V HDMI regulator always enabled for now as otherwise we
> cannot detect the monitor properly.

Tested-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 65 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 65 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -35,6 +35,37 @@
>  		gpios =3D <&gpio2 18 GPIO_ACTIVE_LOW>;	/* gpio50 */
>  	};
> =20
> +	hdmi0: connector {
> +		compatible =3D "hdmi-connector";
> +		pinctrl-0 =3D <&hdmi_hpd_gpio>;
> +		pinctrl-names =3D "default";
> +		label =3D "hdmi";
> +		type =3D "d";
> +
> +		hpd-gpios =3D <&gpio2 31 GPIO_ACTIVE_HIGH>;	/* gpio63 */
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint =3D <&hdmi_out>;
> +			};
> +		};
> +	};
> +
> +	/*
> +	 * HDMI 5V regulator probably sourced from battery. Let's keep
> +	 * keep this as always enabled for HDMI to work until we've
> +	 * figured what the encoder chip is.
> +	 */
> +	hdmi_regulator: regulator-hdmi {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "hdmi";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		gpio =3D <&gpio2 27 GPIO_ACTIVE_HIGH>;	/* gpio59 */
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
>  	/* This is probably coming straight from the battery.. */
>  	wl12xx_vmmc: regulator-wl12xx {
>  		compatible =3D "regulator-fixed";
> @@ -67,6 +98,10 @@
>  	};
>  };
> =20
> +&dss {
> +	status =3D "okay";
> +};
> +
>  &gpio6 {
>  	touchscreen_reset {
>  		gpio-hog;
> @@ -81,6 +116,20 @@
>  	status =3D "disabled";
>  };
> =20
> +&hdmi {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&dss_hdmi_pins>;
> +	pinctrl-names =3D "default";
> +	vdda-supply =3D <&vdac>;
> +
> +	port {
> +		hdmi_out: endpoint {
> +			remote-endpoint =3D <&hdmi_connector_in>;
> +			lanes =3D <1 0 3 2 5 4 7 6>;
> +		};
> +	};
> +};
> +
>  &i2c1 {
>  	tmp105@48 {
>  		compatible =3D "ti,tmp105";
> @@ -249,6 +298,22 @@
> =20
>  &omap4_pmx_core {
> =20
> +	/* hdmi_hpd.gpio_63 */
> +	hdmi_hpd_gpio: pinmux_hdmi_hpd_pins {
> +		pinctrl-single,pins =3D <
> +                OMAP4_IOPAD(0x098, PIN_INPUT | MUX_MODE3)
> +		>;
> +	};
> +
> +	/* hdmi_cec.hdmi_cec, hdmi_scl.hdmi_scl, hdmi_sda.hdmi_sda */
> +	dss_hdmi_pins: pinmux_dss_hdmi_pins {
> +		pinctrl-single,pins =3D <
> +		OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)
> +		OMAP4_IOPAD(0x09c, PIN_INPUT | MUX_MODE0)
> +		OMAP4_IOPAD(0x09e, PIN_INPUT | MUX_MODE0)
> +		>;
> +	};
> +
>  	/* gpmc_ncs0.gpio_50 */
>  	poweroff_gpio: pinmux_poweroff_pins {
>  		pinctrl-single,pins =3D <
> --=20
> 2.11.1

--pfgz6o3nia4oehf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljLFSkACgkQ2O7X88g7
+ppsxhAAh+Ixw6oC/d7+wbgvmiaFxHHiunC7494qRz+V8SNNrxQFsRqWZkAMd1pq
ANrjqpjclZoQjOT8XJXgxb4UnYhGyn7W239rY2ma4gcgpp++wD4XFXuK4Xf1SQfI
jMm5oG/LU6HETZ4YdsBtlY1sYgQOkA/K8MW+jTv7Yw16joqm3+z3Y1CvCnHZPihU
DHmI6YD7qMsBEP+uw7klQXC6WsKORgkC5kDdDp7WMcAg6gTC1UPzl2oef4L293SI
1twrzJZfO2oyHIyRjSArJhWxbQFvCh632QKFCaC5f976IXhTBrY2l/a0QnwFBrJJ
d5fbgdRu68zWXA++GvZ1dIImBpz4PttZrCSqR0Ur6Hk8AKwDmIg3UCEpXdkBWFpe
P9B8QX7PEY1yhxwJJgbiM5i7OVvlySUYyZNGyXhBorYEcgqiy2KcLDm5YLAbkbNW
Ps7GqJZcUetGKMc/syHTkfPvD3wRgTSWtz26HbIqvD+roBhqvuntzGQHA+YZuj/j
aS/vlICeROplcnGbdNEjDRkrmGrq8Uer72AhX9LnA1MRIoFmHByEYqXUckxz5Lri
2+JFkXp4Y9Qda+5YaMJckCl4CeSAPrCQIO6InO7ngucMH7Q1SVjiVDlbOaRGCrBq
OZLyCPYNNsuL69qvOUFk1uMb7zPsdtdzDOru96c7G2WYyRlMwaw=
=JCu1
-----END PGP SIGNATURE-----

--pfgz6o3nia4oehf2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
