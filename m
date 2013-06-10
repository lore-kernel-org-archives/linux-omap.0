From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] ARM: dts: OMAP5: add palmas node and omap specific
 palmas regulator properties
Date: Mon, 10 Jun 2013 09:12:08 +0100
Message-ID: <20130610081208.GD24958@gmail.com>
References: <1370845335-14926-1-git-send-email-j-keerthy@ti.com>
 <1370845335-14926-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:63332 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab3FJIMQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 04:12:16 -0400
Received: by mail-ee0-f42.google.com with SMTP id c4so2790872eek.29
        for <linux-omap@vger.kernel.org>; Mon, 10 Jun 2013 01:12:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1370845335-14926-3-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ldewangan@nvidia.com, grant.likely@secretlab.ca, swarren@wwwdotorg.org, swarren@nvidia.com, sameo@linux.intel.com, gg@slimlogic.co.uk

> Add palmas node and omap specific palmas regulator properties.
>=20
> This patch is based on:
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt=
=2Egit
> 	for_3.11/dts

There's no need for this to be in the commit message.

> Boot tested on omap5-uevm board.
>=20
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/boot/dts/omap5-uevm.dts |  145 ++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 145 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/oma=
p5-uevm.dts
> index 927db1e..88172db 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -254,6 +254,151 @@
>  	pinctrl-0 =3D <&i2c1_pins>;
> =20
>  	clock-frequency =3D <400000>;
> +
> +	palmas: palmas@48 {
> +		reg =3D <0x48>;
> +		/* SPI =3D 0, IRQ# =3D 7, 4 =3D active high level-sensitive */

The interrupt property is fairly ubiqutous. There's not really any
need to document it in this manor.

> +		interrupts =3D <0 7 4>; /* IRQ_SYS_1N cascaded to gic */

Use the IRQ includes in dt-bindings.

> +		interrupt-parent =3D <&gic>;
> +	};
> +
> +};
> +
> +#include "palmas.dtsi"

I'm a bit confused by this. Is it now common practice to break out
nodes in this way? I assume to counter mass indentation, but it's a
bit alien to me.

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

Are these all board specific, or are they shared with any other
platform?

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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
