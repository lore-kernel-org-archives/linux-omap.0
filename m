From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] ARM: dts: omap4-droid4: Add tmp105 sensor for droid 4
Date: Sun, 19 Mar 2017 02:26:22 +0100
Message-ID: <20170319012622.lg7qhqgdbkeqr7vf@earth>
References: <20170305054359.8293-1-tony@atomide.com>
 <20170305054359.8293-5-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="43bi5vfhdzirlsxh"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170305054359.8293-5-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--43bi5vfhdzirlsxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 04, 2017 at 09:43:57PM -0800, Tony Lindgren wrote:
> Add tmp105 sensor for droid 4. This can be used with modprobe
> lm75.ko and running sensors from lm-sensors package. Note that
> the lm75.c driver does not yet support alert interrupt but
> droid 4 seems to be wired for it.

lazy testing: cat /sys/class/hwmon/hwmon0/temp1_input
31437

> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Tested-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

> ---
>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -81,6 +81,20 @@
>  	status =3D "disabled";
>  };
> =20
> +&i2c1 {
> +	tmp105@48 {
> +		compatible =3D "ti,tmp105";
> +		reg =3D <0x48>;
> +		pinctrl-0 =3D <&tmp105_irq>;
> +		pinctrl-names =3D "default";
> +		/* kpd_row0.gpio_178 */
> +		interrupts-extended =3D <&gpio6 18 IRQ_TYPE_EDGE_FALLING
> +				       &omap4_pmx_core 0x14e>;
> +		interrupt-names =3D "irq", "wakeup";
> +		wakeup-source;
> +	};
> +};
> +
>  &keypad {
>  	keypad,num-rows =3D <8>;
>  	keypad,num-columns =3D <8>;
> @@ -242,6 +256,13 @@
>  		>;
>  	};
> =20
> +	/* kpd_row0.gpio_178 */
> +	tmp105_irq: pinmux_tmp105_irq {
> +		pinctrl-single,pins =3D <
> +		OMAP4_IOPAD(0x18e, PIN_INPUT_PULLUP | MUX_MODE3)
> +		>;
> +	};
> +
>  	usb_gpio_mux_sel1: pinmux_usb_gpio_mux_sel1_pins {
>  		/* gpio_60 */
>  		pinctrl-single,pins =3D <
> --=20
> 2.11.1

--43bi5vfhdzirlsxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljN3j0ACgkQ2O7X88g7
+prp5xAAnRLXmOQ1NTxTV+rgQrcFSf9MFdV1dNzUAjvhKYVBbCgQLAQwIsSucWWy
WRbq4q6SPGFdUWz22sWu08skdhwZBGpPcKKmHM0D48lmhu/w5qNygN/BSKaTbBHn
Mj3AotXPXSN1NajGngQFljDwtpqZmKYvw1BDuGOTb7ToCARUQ3lojmwNKLVrFagX
wKKwS8+UCcaoKCqJ3u7Ajt8dTlMrArZbxfmyXLDeV5ueyI4Z4mr1wyA00ZFWLgK8
d1yQmOImxmmGI5PV2uJBev6iPuWfy5SB+CmGOh5c8UXDb/WwZ0nyKcwo5aZGwXMN
CNy7Trks1H0X2alIwGxRjRJcXvjPQ/lSYsszR2qCzWU4aIxnUWxTDzr6q/4/QNhH
mF4nkAdQGHt7WfxA4wm8POrwrg6Uu0MuP9zZJ3DSIAw7KpkpMXAlcGt3ZjLlhA3t
X9bTzq0g8ep67XvORspHiua/HSCvx1JP9kJUprH30z0537et66H2DlXU7nq8qfp+
x79keZcgKoqZMF1KNG9uD4OxBlJd6u/wIULcbz/wd3LvzNoQvr2RX40R2d9375Os
t0bqi+DF7RW95dwSvQNmLpSDemIk0SRbfKvX48dN1fEdZcKH1n2K1mFPf00jLDWq
CZLOI/Zw22cs2stVkPgLuDry6vkJ91/ozYNpY5YYBuKf7zZajvw=
=5JBI
-----END PGP SIGNATURE-----

--43bi5vfhdzirlsxh--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
