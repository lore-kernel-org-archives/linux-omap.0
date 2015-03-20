From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: am57xx-beagle-x15: Add thermal map
Date: Fri, 20 Mar 2015 17:50:22 -0400
Message-ID: <20150320214959.GB7226@developer.amazonguestwifi.org>
References: <1426880861-9266-1-git-send-email-nm@ti.com>
 <1426880861-9266-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34421 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbbCTVu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 17:50:27 -0400
Content-Disposition: inline
In-Reply-To: <1426880861-9266-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2015 at 02:47:41PM -0500, Nishanth Menon wrote:
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
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |   49 +++++++++++++++++++++++++=
++++++
>  1 file changed, 49 insertions(+)
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
> --=20
> 1.7.9.5
>=20

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVDJYTAAoJEMLUO4d9pOJW/F8H/0EQ+gCgUQ3ZxKeBYoVE4ocb
jVwumSodb7A7QWq51wG7m87H9JsmJuqc+AA8hQZKFrCC1wqfhaPvUrA1FoG+/A//
t832Trx/LtFi0IPIqDdyNzNA+8ZqsVfOJzqJrVSwh/Hv6GfaFDCD96kFIWxgwFCj
i4b+lSySxp4BfIgKyz5vWCDLJKXdM2xafngZAAlwJNklfVUKWrKDaBJKMGnYdsmP
wKRxImRc1i9lezlZf0Fkifk8U2X6AEJl5iOA63+NukF3OYGFNiA+Y/6QpcF1TPbX
HYOK+PxzUYxyVTj+Q8C3WKU5OU02ygvbYiXeWYHNO7dwVCnGs7i7Zgpl2dWPDJs=
=YV2q
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
