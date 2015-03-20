From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: OMAP5+: separate the cpu thermal zone
 definition from omap4
Date: Fri, 20 Mar 2015 17:54:03 -0400
Message-ID: <20150320215402.GB7346@developer.amazonguestwifi.org>
References: <1426880861-9266-1-git-send-email-nm@ti.com>
 <1426880861-9266-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426880861-9266-2-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2015 at 02:47:39PM -0500, Nishanth Menon wrote:
> From: Tero Kristo <t-kristo@ti.com>
>=20
> OMAP4 has a finer counter granularity, which allows for a delay of 1000ms
> in the thermal zone polling intervals. OMAP5/DRA7 have different counter
> mechanism, which allows at maximum a 500ms timer. Adjust the cpu thermal
> zone accordingly for OMAP5/DRA7.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>


> ---
>  arch/arm/boot/dts/omap5-cpu-thermal.dtsi |   41 ++++++++++++++++++++++++=
++++++
>  arch/arm/boot/dts/omap5.dtsi             |    2 +-
>  2 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/omap5-cpu-thermal.dtsi
>=20
> diff --git a/arch/arm/boot/dts/omap5-cpu-thermal.dtsi b/arch/arm/boot/dts=
/omap5-cpu-thermal.dtsi
> new file mode 100644
> index 000000000000..4a6427c1e47e
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap5-cpu-thermal.dtsi
> @@ -0,0 +1,41 @@
> +/*
> + * Device Tree Source for OMAP4/5 SoC CPU thermal
> + *
> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
> + * Contact: Tero Kristo <t-kristo@ti.com>
> + *
> + * This file is licensed under the terms of the GNU General Public Licen=
se
> + * version 2.  This program is licensed "as is" without any warranty of =
any
> + * kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/thermal/thermal.h>
> +
> +cpu_thermal: cpu_thermal {
> +	polling-delay-passive =3D <250>; /* milliseconds */
> +	polling-delay =3D <500>; /* milliseconds */
> +
> +			/* sensor       ID */
> +	thermal-sensors =3D <&bandgap     0>;
> +
> +	cpu_trips: trips {
> +		cpu_alert0: cpu_alert {
> +			temperature =3D <100000>; /* millicelsius */
> +			hysteresis =3D <2000>; /* millicelsius */
> +			type =3D "passive";
> +		};
> +		cpu_crit: cpu_crit {
> +			temperature =3D <125000>; /* millicelsius */
> +			hysteresis =3D <2000>; /* millicelsius */
> +			type =3D "critical";
> +		};
> +	};
> +
> +	cpu_cooling_maps: cooling-maps {
> +		map0 {
> +			trip =3D <&cpu_alert0>;
> +			cooling-device =3D
> +				<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index ddff674bd05e..e650d4eb59dd 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -67,7 +67,7 @@
>  	};
> =20
>  	thermal-zones {
> -		#include "omap4-cpu-thermal.dtsi"
> +		#include "omap5-cpu-thermal.dtsi"

Can't we simple change the polling value for the omap5 case and reuse
the omap4 file?

>  		#include "omap5-gpu-thermal.dtsi"
>  		#include "omap5-core-thermal.dtsi"
>  	};
> --=20
> 1.7.9.5
>=20

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVDJbyAAoJEMLUO4d9pOJWNIIIAJRRUoZoHtlDdp5eVf7L6Apc
P0KkiW7ICKb1mol1gxxn4p9xIMZfAoj4X6NrW3eyZMJkUDEFWxJwVQ3cuzL3a9hp
RM7AwY728RK8WnbpOCdgK2ZYTRARLI47uzkkFJdg0EgQd/tzP4kBo09viwWzwwbi
xTqxs0F5Xiu5976kdTdRrrOsANPGz/7TFNGEeAm+N2sXiVXPxwK4t0y2rjts4Qyt
nuSnw/DxV2CMpZaRLCmJk5n8Tm82Xd2hhjKPV9T0TC5TB0rzslTlbeKPBO1WfBGP
91/DkdaZZ2YF/GD110DILO86aHTR+gfdfiaceYtjHgLeWIkCKsJ/OUefoGRvCuM=
=+FTw
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
