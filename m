From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 7/7] dts: dra7-evm: add USB support
Date: Mon, 28 Apr 2014 11:07:05 -0500
Message-ID: <20140428160705.GK30292@saruman.home>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
 <1398693687-13967-8-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jtds+vpI57xq70EV"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398693687-13967-8-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--Jtds+vpI57xq70EV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 05:01:27PM +0300, Roger Quadros wrote:
> Add USB pinmux information and USB modes
> for the USB controllers.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  arch/arm/boot/dts/dra7-evm.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.=
dts
> index 5babba0..1d77815 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -93,6 +93,18 @@
>  			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd */
>  		>;
>  	};
> +
> +	usb1_pins: pinmux_usb1_pins {
> +                pinctrl-single,pins =3D <
> +			0x280	0xc0000	/* usb1_drvvbus, SLOW_SLEW | PULLUPEN | MODE0 */
> +                >;
> +        };
> +
> +	usb2_pins: pinmux_usb2_pins {
> +                pinctrl-single,pins =3D <
> +			0x284	0xc0000 /* usb2_drvvbus, SLOW_SLEW | PULLUPEN | MODE0 */
> +                >;
> +        };
>  };
> =20
>  &i2c1 {
> @@ -273,3 +285,15 @@
>  &cpu0 {
>  	cpu0-supply =3D <&smps123_reg>;
>  };
> +
> +&usb1 {
> +	dr_mode =3D "peripheral";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&usb1_pins>;
> +};
> +
> +&usb2 {
> +	dr_mode =3D "host";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&usb2_pins>;
> +};
> --=20
> 1.8.3.2
>=20

--=20
balbi

--Jtds+vpI57xq70EV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTXnypAAoJEIaOsuA1yqREjO0P/3exr+z5ORWJedwGGSGdjlAu
pg5RHN3tpumJoqNV0LCfaQuTRhCCGEymD5YwPpkIQWrvKihCIHyb/A5hfIMNjG9A
DTC/JZ4e32mn036V3tP2PKY8qugHj/U/POrSJe0Q+My5Dfq7hwBOOT3eaaIMnSTR
3mZjkkJbxbVOdbbMALrW/0+U4ZcCTpnTKGj3NKUHOnDYidUG4memEyT7I+tO983A
0jV8ufu9H7ZUkGYoISxyXbcmy0Zr8i9aW27WoOBXTSymu7Pv0wB3Onyoy01q8T1M
Lppw8rkt6SlVSpph5zYlsfsFaWxgV2pIlK72AwEPTmvYSglTd7XRky2+mKrCbVYl
SFDfC64pZ29hupG2YBgsFIV9WhgjakbCKDNuozj5krxgZb/K6EabYVo2RILFLYTl
8yLT9Fjz3z6GQ97bi3jkfaXVr9gM5kZNBsMsKn4jCBO/ZLI7O9x6rzo8fOabrB6g
JpIDsuqgWR0KcAI2rm9gvmmm55y11FRaCNF4CCtfzi/wQYvJaXY24LaGRipF0wgC
zmL8jXYeLPNDE3TrR0uB6Vcqq0T/o18n+iLlVQ4qLhSb1ENnfmUC0TFkwQzc5JJD
dIX6Cn0ytkgDzkTd2e+2TnfS0v+GTw0nlkUGM0buiOCbPeVkpLCrhBddBU5sxPf0
UjKkwtHlyhLWvA/zhPBO
=UGeP
-----END PGP SIGNATURE-----

--Jtds+vpI57xq70EV--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
