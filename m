From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: DRA7: Add bandgap and related thermal nodes
Date: Fri, 20 Mar 2015 17:51:24 -0400
Message-ID: <20150320215123.GA7346@developer.amazonguestwifi.org>
References: <1426880861-9266-1-git-send-email-nm@ti.com>
 <1426880861-9266-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426880861-9266-3-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2015 at 02:47:40PM -0500, Nishanth Menon wrote:
> From: Keerthy <j-keerthy@ti.com>
>=20
> Add bandgap and related thermal nodes. The patch adds 5 thermal
> sensors. Only one cooling device for mpu as of now. The sensors are
> the exact same on both dra72 and dra7.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  arch/arm/boot/dts/dra7.dtsi   |   12 ++++++++++++
>  arch/arm/boot/dts/dra72x.dtsi |    9 +++++++++
>  arch/arm/boot/dts/dra74x.dtsi |    9 +++++++++
>  3 files changed, 30 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index eea4a54d6cb3..4b975cc377fd 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -177,6 +177,18 @@
>  			};
>  		};
> =20
> +		bandgap: bandgap@4a0021e0 {
> +			reg =3D <0x4a0021e0 0xc
> +				0x4a00232c 0xc
> +				0x4a002380 0x2c
> +				0x4a0023C0 0x3c
> +				0x4a002564 0x8
> +				0x4a002574 0x50>;
> +				compatible =3D "ti,dra752-bandgap";
> +				interrupts =3D <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> +				#thermal-sensor-cells =3D <1>;
> +		};
> +
>  		cm_core_aon: cm_core_aon@4a005000 {
>  			compatible =3D "ti,dra7-cm-core-aon";
>  			reg =3D <0x4a005000 0x2000>;
> diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
> index e5a3d23a3df1..43bd0709bde9 100644
> --- a/arch/arm/boot/dts/dra72x.dtsi
> +++ b/arch/arm/boot/dts/dra72x.dtsi
> @@ -20,6 +20,11 @@
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a15";
>  			reg =3D <0>;
> +
> +			/* cooling options */
> +			cooling-min-level =3D <0>;
> +			cooling-max-level =3D <2>;
> +			#cooling-cells =3D <2>; /* min followed by max */
>  		};
>  	};
> =20
> @@ -27,4 +32,8 @@
>  		compatible =3D "arm,cortex-a15-pmu";
>  		interrupts =3D <GIC_SPI DIRECT_IRQ(131) IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		#include "omap5-cpu-thermal.dtsi"
> +	};
>  };
> diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
> index 10173fab1a15..4f2c870836fe 100644
> --- a/arch/arm/boot/dts/dra74x.dtsi
> +++ b/arch/arm/boot/dts/dra74x.dtsi
> @@ -31,6 +31,11 @@
>  			clock-names =3D "cpu";
> =20
>  			clock-latency =3D <300000>; /* From omap-cpufreq driver */
> +
> +			/* cooling options */
> +			cooling-min-level =3D <0>;
> +			cooling-max-level =3D <2>;
> +			#cooling-cells =3D <2>; /* min followed by max */
>  		};
>  		cpu@1 {
>  			device_type =3D "cpu";
> @@ -45,6 +50,10 @@
>  			     <GIC_SPI DIRECT_IRQ(132) IRQ_TYPE_LEVEL_HIGH>;
>  	};
> =20
> +	thermal_zones: thermal-zones {
> +		#include "omap5-cpu-thermal.dtsi"
> +	};
> +
>  	ocp {
>  		omap_dwc3_4: omap_dwc3_4@48940000 {
>  			compatible =3D "ti,dwc3";
> --=20
> 1.7.9.5
>=20

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVDJZTAAoJEMLUO4d9pOJWjlgH/iB9uRElvrAfDYgAjpc+0PZI
W+ql8t8iC8B9fYYOy4+vxliYDL6S0JLLDxaoQDOC/oT7yUR6XbEoGczdEM0DHb9K
ZZAHUQBrTVMvLEYH8wOZcObnz7kfO35Y49wnrfDbkhdpQZQNZeltjRDnmlMK6lgy
V3v/AGjWigap0D9yOMJdoj29pNa4wUqWcmCAzi/qaALUpFi0mmWljLHts6G7knFf
hjYt62FMAqux0RM6w23/NnGOEXj9Pa9JqG8TY7cPTKygnja3gCjujGXf66hbC+sB
+i/QYTYYbCBCbknnyIARBTblw4PBleLhQgUDzMrFfpcoPH9vo0a1g1lEK2Fqwzk=
=cRyY
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
