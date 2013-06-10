From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/2] ARM: dts: OMAP5: add palmas node and omap
 specific palmas regulator properties
Date: Mon, 10 Jun 2013 11:05:40 +0100
Message-ID: <20130610100540.GI20297@gmail.com>
References: <1370855059-5342-1-git-send-email-j-keerthy@ti.com>
 <1370855059-5342-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370855059-5342-3-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ldewangan@nvidia.com, grant.likely@secretlab.ca, swarren@wwwdotorg.org, swarren@nvidia.com, sameo@linux.intel.com, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On Mon, 10 Jun 2013, J Keerthy wrote:

> Add palmas node and omap specific palmas regulator properties.
>=20
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/boot/dts/omap5-uevm.dts |  147 ++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 147 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/oma=
p5-uevm.dts
> index 927db1e..ffbcc3f 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -8,6 +8,8 @@
>  /dts-v1/;
> =20
>  #include "omap5.dtsi"
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> =20
>  / {
>  	model =3D "TI OMAP5 uEVM board";
> @@ -254,6 +256,151 @@
>  	pinctrl-0 =3D <&i2c1_pins>;
> =20
>  	clock-frequency =3D <400000>;
> +
> +	palmas: palmas@48 {
> +		reg =3D <0x48>;
> +		/* SPI =3D 0, IRQ# =3D 7, active high level-sensitive */

I still think this is superfluous, especially now you're using the
defines which basically say the same thing.

> +		interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N */
> +		interrupt-parent =3D <&gic>;
> +	};
> +
> +};
> +
> +#include "palmas.dtsi"
> +
> +&palmas {
> +	palmas_pmic {
> +		ti,ldo6-vibrator;
> +
> +		regulators {
> +			smps123_reg: smps123 {
> +				regulator-min-microvolt =3D < 600000>;
> +				regulator-max-microvolt =3D <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			smps45_reg: smps45 {
> +				regulator-min-microvolt =3D < 600000>;
> +				regulator-max-microvolt =3D <1310000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			smps6_reg: smps6 {
> +				regulator-min-microvolt =3D <1200000>;
> +				regulator-max-microvolt =3D <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			smps7_reg: smps7 {
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			smps8_reg: smps8 {
> +				regulator-min-microvolt =3D < 600000>;
> +				regulator-max-microvolt =3D <1310000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			smps9_reg: smps9 {
> +				regulator-min-microvolt =3D <2100000>;
> +				regulator-max-microvolt =3D <2100000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				ti,smps-range =3D <0x80>;
> +			};
> +
> +			smps10_reg: smps10 {
> +				regulator-min-microvolt =3D <5000000>;
> +				regulator-max-microvolt =3D <5000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo1_reg: ldo1 {
> +				regulator-min-microvolt =3D <2800000>;
> +				regulator-max-microvolt =3D <2800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo2_reg: ldo2 {
> +				regulator-min-microvolt =3D <2900000>;
> +				regulator-max-microvolt =3D <2900000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo3_reg: ldo3 {
> +				regulator-min-microvolt =3D <3000000>;
> +				regulator-max-microvolt =3D <3000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo4_reg: ldo4 {
> +				regulator-min-microvolt =3D <2200000>;
> +				regulator-max-microvolt =3D <2200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo5_reg: ldo5 {
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo6_reg: ldo6 {
> +				regulator-min-microvolt =3D <1500000>;
> +				regulator-max-microvolt =3D <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo7_reg: ldo7 {
> +				regulator-min-microvolt =3D <1500000>;
> +				regulator-max-microvolt =3D <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo8_reg: ldo8 {
> +				regulator-min-microvolt =3D <1500000>;
> +				regulator-max-microvolt =3D <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo9_reg: ldo9 {
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldoln_reg: ldoln {
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldousb_reg: ldousb {
> +				regulator-min-microvolt =3D <3250000>;
> +				regulator-max-microvolt =3D <3250000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +		};
> +	};
>  };
> =20
>  &i2c5 {

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
