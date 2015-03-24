From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 2/2] ARM: dts: am57xx-beagle-x15: Add thermal map to
 include fan and tmp102
Date: Tue, 24 Mar 2015 11:17:37 -0400
Message-ID: <20150324151736.GE29155@developer.hsd1.ca.comcast.net>
References: <1427139579-4215-1-git-send-email-nm@ti.com>
 <1427139579-4215-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427139579-4215-3-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: tony@atomide.com, bcousson@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2015 at 02:39:39PM -0500, Nishanth Menon wrote:
> BeagleBoard-X15 has capability for a fan and has an onboard TMP102
> temperature sensor as well. This allows us to create a new thermal
> zone (called, un-imaginatively "board"), and allows us to use some
> active cooling as temperatures start edge upward in the system by
> creating a new alert temperature (emperically 50C) for cpu.
>=20
> NOTE: Fan is NOT mounted by default on the platform, in such a case,
> all we end up doing is switch on a regulator and leak very minimal
> current.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
> Changes since V1:
> 	- slight change in omap4-cpu-thermal for usage in am57xx-dtsi
> 	- Not carrying forward ack due to change
>=20
> V1: http://marc.info/?t=3D142688102700004&r=3D1&w=3D2
>=20
>  arch/arm/boot/dts/am57xx-beagle-x15.dts  |   49 ++++++++++++++++++++++++=
++++++
>  arch/arm/boot/dts/omap4-cpu-thermal.dtsi |    4 +--
>  2 files changed, 51 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/=
am57xx-beagle-x15.dts
> index 41642fe770a1..6a3621c23017 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -86,6 +86,7 @@
>  		gpios =3D  <&tps659038_gpio 1 GPIO_ACTIVE_HIGH>;
>  		gpio-fan,speed-map =3D <0     0>,
>  				     <13000 1>;
> +		#cooling-cells =3D <2>;
>  	};
> =20
>  	extcon_usb1: extcon_usb1 {
> @@ -441,6 +442,7 @@
>  		pinctrl-0 =3D <&tmp102_pins_default>;
>  		interrupt-parent =3D <&gpio7>;
>  		interrupts =3D <16 IRQ_TYPE_LEVEL_LOW>;
> +		#thermal-sensor-cells =3D <1>;
>  	};
>  };
> =20
> @@ -559,3 +561,50 @@
>  &usb2 {
>  	dr_mode =3D "peripheral";
>  };
> +
> +&cpu_trips {
> +	cpu_alert1: cpu_alert1 {
> +		temperature =3D <50000>; /* millicelsius */
> +		hysteresis =3D <2000>; /* millicelsius */
> +		type =3D "active";
> +	};
> +};
> +
> +&cpu_cooling_maps {
> +	map1 {
> +		trip =3D <&cpu_alert1>;
> +		cooling-device =3D <&gpio_fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +	};
> +};
> +
> +&thermal_zones {
> +	board_thermal: board_thermal {
> +		polling-delay-passive =3D <1250>; /* milliseconds */
> +		polling-delay =3D <1500>; /* milliseconds */
> +
> +				/* sensor       ID */
> +		thermal-sensors =3D <&tmp102     0>;
> +
> +		board_trips: trips {
> +			board_alert0: board_alert {
> +				temperature =3D <40000>; /* millicelsius */
> +				hysteresis =3D <2000>; /* millicelsius */
> +				type =3D "active";
> +			};
> +
> +			board_crit: board_crit {
> +				temperature =3D <105000>; /* millicelsius */
> +				hysteresis =3D <0>; /* millicelsius */
> +				type =3D "critical";
> +			};
> +		};
> +
> +		board_cooling_maps: cooling-maps {
> +			map0 {
> +				trip =3D <&board_alert0>;
> +				cooling-device =3D
> +				  <&gpio_fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
> +		};
> +       };
> +};
> diff --git a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi b/arch/arm/boot/dts=
/omap4-cpu-thermal.dtsi
> index cb9458feb2e3..ab7f87ae96f0 100644
> --- a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
> +++ b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
> @@ -18,7 +18,7 @@ cpu_thermal: cpu_thermal {
>  			/* sensor       ID */
>          thermal-sensors =3D <&bandgap     0>;
> =20
> -        trips {
> +	cpu_trips: trips {
>                  cpu_alert0: cpu_alert {
>                          temperature =3D <100000>; /* millicelsius */
>                          hysteresis =3D <2000>; /* millicelsius */
> @@ -31,7 +31,7 @@ cpu_thermal: cpu_thermal {
>                  };
>          };
> =20
> -	cooling-maps {
> +	cpu_cooling_maps: cooling-maps {
>  		map0 {
>  			trip =3D <&cpu_alert0>;
>  			cooling-device =3D
> --=20
> 1.7.9.5
>=20

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVEYAQAAoJEMLUO4d9pOJWVA8IAIZ1K884BS2zrrY0Q5XG69Dl
wWJDaCoUcymYOw0nLA9olMBDHuYzd91JnXDgKuGSebewY9FY1qPE55rLc74j8+Fe
BhEiShTigYAwW6V6X+N8v8aTDb9aBUYSa5dn3/gQv6KVMbHo0LKaxIw+l6k7XXzy
yO0whnwZl6eGxJrWkmGILksTDHADhlTTy0Duvjldcr6kV3XGxU1l0qml/o1RXjxq
nCsxGw+ZZBVZDxA4pax7LgGKxLhLTix5s6M7t8h9+BufSUEvOm2m/VKTyBI3ZVwC
es7FaMB7GqbqsrzqFrp3UPYwJ0LJ7n7Ynggs6ZvrLPhhBjzdYcdQx0zXBsZlNJA=
=lBbN
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
