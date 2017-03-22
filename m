From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dts: omap4-droid4: Add CPCAP PMIC OTG PHY
 configuration
Date: Wed, 22 Mar 2017 03:20:52 +0100
Message-ID: <20170322022052.pnsagcg2saswoirl@earth>
References: <20170317041012.26800-1-tony@atomide.com>
 <20170317041012.26800-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qreag2a67egw7zcu"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170317041012.26800-4-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--qreag2a67egw7zcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 16, 2017 at 09:10:12PM -0700, Tony Lindgren wrote:
> Add CPCAP PMIC OTG PHY configuration.
>=20
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Tested-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

> ---
>  arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 23 ++++++++++++++++++++=
+++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/bo=
ot/dts/motorola-cpcap-mapphone.dtsi
> --- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> +++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> @@ -65,6 +65,29 @@
>  			interrupts =3D <23 IRQ_TYPE_NONE>;
>  		};
> =20
> +		cpcap_usb2_phy: phy {
> +			compatible =3D "motorola,mapphone-cpcap-usb-phy";
> +			pinctrl-0 =3D <&usb_gpio_mux_sel1 &usb_gpio_mux_sel2>;
> +			pinctrl-1 =3D <&usb_ulpi_pins>;
> +			pinctrl-2 =3D <&usb_utmi_pins>;
> +			pinctrl-3 =3D <&uart3_pins>;
> +			pinctrl-names =3D "default", "ulpi", "utmi", "uart";
> +			#phy-cells =3D <0>;
> +			interrupts-extended =3D <
> +				&cpcap 15 0 &cpcap 14 0 &cpcap 28 0 &cpcap 19 0
> +				&cpcap 18 0 &cpcap 17 0 &cpcap 16 0 &cpcap 49 0
> +				&cpcap 48 1
> +			>;
> +			interrupt-names =3D
> +				"id_ground", "id_float", "se0conn", "vbusvld",
> +				"sessvld", "sessend", "se1", "dm", "dp";
> +			mode-gpios =3D <&gpio2 28 GPIO_ACTIVE_HIGH
> +				      &gpio1 0 GPIO_ACTIVE_HIGH>;
> +			io-channels =3D <&cpcap_adc 2>, <&cpcap_adc 7>;
> +			io-channel-names =3D "vbus", "id";
> +			vusb-supply =3D <&vusb>;
> +		};
> +
>  		led_red: led-red {
>  			compatible =3D "motorola,cpcap-led-red";
>  			vdd-supply =3D <&sw5>;
> --=20
> 2.11.1

--qreag2a67egw7zcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljR34QACgkQ2O7X88g7
+ppbXg/9GU6uJap5EPPT7w509fbDX1AafEw8uYY7uEJRR64uwWNwd/P/6O492XC3
c7LzPkv07scZWM+PVHWgg1i6qiAJx/goX4bZNC0bR5+IAZSGSiZ4OpQ8FGJhvHoI
AzVYMSGy0pH0LRrGVXd8ce9F2azJnsa7SUJ0bsipXtLi1H+PWePa4U6tctw/W83J
8Ky5fE9Y8txYOuH7N58nGDgM1vo2Uktn7YGnlKEgham6rUEoVksZMk/VTk9TWG/v
3CVTxPHS42F/Ohvi/N1RkGuv4um4iJzoMgCc48C2kxOsTeQmhzuelTWonoBVIy7e
soEZOwJD7GSMSCz1cNrgsMb7ciNQIayhMsJFDBFP+p0qz4VY+4EqUasBS2V7FNOa
asL/2avLl3VykHV5Sls7knV9d4ZfD5VhGJCLmkRJ9A3ayim1buDwMjZtwbPNdDOn
xDgtPZQ01QtS3NIr6aB2RiGWYNDqt90fHkt1WrAUshVaF6682ZwHxx247WA/ELWb
9anGgUSA9nbNF+bO9ibTuB3p4OM4nZ7E/WWWyONOMdNsUmAQ0VJ9ij6XRR6GjH9i
odwpPOwY/Q7Y/7k2y5lw9XYx5Rj4FGCWpKRSO8x1PbUMwoMrqOMoC//8+MJjTNl+
YWMC/N3e+uhcbHQ0GcK3N0Z/eedvx4oj8eKONDmtkIEmS3ecVeY=
=fAVF
-----END PGP SIGNATURE-----

--qreag2a67egw7zcu--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
