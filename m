From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] ARM: dts: omap4-droid4: Add GPIO poweroff
Date: Sun, 19 Mar 2017 02:19:17 +0100
Message-ID: <20170319011917.lx76z47hukk4cfol@earth>
References: <20170305054359.8293-1-tony@atomide.com>
 <20170305054359.8293-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="44dccuz6icalcitf"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170305054359.8293-4-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--44dccuz6icalcitf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 04, 2017 at 09:43:56PM -0800, Tony Lindgren wrote:
> Droid 4 has a GPIO line that we can use with CONFIG_POWER_RESET_GPIO.
> It is probably connected to the CPCAP PMIC, and seems to power down
> the whole device taking power consumption to zero based on what
> I measured.
>=20
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Tested-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -27,6 +27,14 @@
>  		reg =3D <0x80000000 0x3fd00000>;	/* 1021 MB */
>  	};
> =20
> +	/* Poweroff GPIO probably connected to CPCAP */
> +	gpio-poweroff {
> +		compatible =3D "gpio-poweroff";
> +		pinctrl-0 =3D <&poweroff_gpio>;
> +		pinctrl-names =3D "default";
> +		gpios =3D <&gpio2 18 GPIO_ACTIVE_LOW>;	/* gpio50 */
> +	};
> +
>  	/* This is probably coming straight from the battery.. */
>  	wl12xx_vmmc: regulator-wl12xx {
>  		compatible =3D "regulator-fixed";
> @@ -226,6 +234,14 @@
>  };
> =20
>  &omap4_pmx_core {
> +
> +	/* gpmc_ncs0.gpio_50 */
> +	poweroff_gpio: pinmux_poweroff_pins {
> +		pinctrl-single,pins =3D <
> +		OMAP4_IOPAD(0x074, PIN_OUTPUT_PULLUP | MUX_MODE3)
> +		>;
> +	};
> +
>  	usb_gpio_mux_sel1: pinmux_usb_gpio_mux_sel1_pins {
>  		/* gpio_60 */
>  		pinctrl-single,pins =3D <
> --=20
> 2.11.1

--44dccuz6icalcitf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljN3JQACgkQ2O7X88g7
+ppxvA//aMfW7pJrHlyqCX3iS0femPOvg7eGqxG2KsBa20BymX9r1tjPV1Cyvaz5
3LBgjr9ptitHlOrZnXoC2lIoWlaHFA0rwsllH/Zns3Kh8/MEAInO3DPGbexSi7NN
0ovpXEv8ylOF/DfuaZOkMP67Az34RUiuqx1yp+HiYgVxAAYt/9Uyc46QMWgFGeJz
j1QMODjhTGc7fYrlCU/Uuef4qctCh4UhIRGSTYPz4B9J5FM22f8xRz+p1UUYXNNj
Syx+VPXHGYhSkmNS2gDM0hqOmPqNk0UgZln+WkCQG37gA4uGEIqp7vc7pqcH7KV3
MR7O18eYZDv5W+LxV37WxL1w0fefT3UpKNRh8gbYJVlmrDY7PuuiG2v2XNnt6/7G
ZLbEyhMfc4BhuS3awWMHaEtuYMcY7Xh4o1K6F5NEyjM7x/YoCfFln8kIjmRwDu24
Cw5tfZHSjAumuL3gUIX+UvKAuQ01y9YchujY8WN0CyzzErYJr1mm4C0yPhd13MQ7
LS+PESpkz1vyGltgJVkY3BXT0C9nP1TqHBEieOX2RJz1q2kHa9X7ytEs14A3omyk
pUxQb2fTva48CbHInbslhjuQmWpbKpRvBcheEcFmVkxgyV3DKg9A1klKAJymIyLY
izV/owYb+Q+2A/8KJ6vGWukz2Mxkz75dM9u+gTWKNU621/1h8Oo=
=7qaP
-----END PGP SIGNATURE-----

--44dccuz6icalcitf--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
