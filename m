From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: add dtsi for palmas
Date: Fri, 7 Jun 2013 14:27:21 +0200
Message-ID: <51B1D1A9.40702@ti.com>
References: <1370604504-32310-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370604504-32310-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Keerthy,

On 06/07/2013 01:28 PM, J Keerthy wrote:
> Adds palmas mfd and palmas regulator nodes. This is
> based on the patch series:
> 
> http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg89957.html
> 
> The device tree nodes are based on:
> https://lkml.org/lkml/2013/6/6/25

It looks like the board node to use palmas is missing? I cannot find it
in the previous series as well?

> 
> Signed-off-by: J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
> ---
>  arch/arm/boot/dts/palmas.dtsi |  171 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 171 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/palmas.dtsi
> 
> diff --git a/arch/arm/boot/dts/palmas.dtsi b/arch/arm/boot/dts/palmas.dtsi
> new file mode 100644
> index 0000000..be631b5
> --- /dev/null
> +++ b/arch/arm/boot/dts/palmas.dtsi
> @@ -0,0 +1,171 @@
> +/*
> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +&palmas {
> +	compatible = "ti,palmas";
> +	interrupt-controller;
> +	#interrupt-cells = <2>;

The I2C address should be there as well. We used to put it in the board
file, but this is really an I2C device specific information and not
board specific in that case.

Regards,
Benoit


> +
> +	palmas_pmic {
> +		compatible = "ti,palmas-pmic";
> +		interrupt-parent = <&palmas>;
> +		interrupts = <14 IRQ_TYPE_NONE>;
> +		interrupt-name = "short-irq";
> +
> +		ti,ldo6-vibrator;
> +
> +		regulators {
> +			smps123_reg: smps123 {
> +				regulator-name = "smps123";
> +				regulator-min-microvolt = < 600000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			smps45_reg: smps45 {
> +				regulator-name = "smps45";
> +				regulator-min-microvolt = < 600000>;
> +				regulator-max-microvolt = <1310000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			smps6_reg: smps6 {
> +				regulator-name = "smps6";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			smps7_reg: smps7 {
> +				regulator-name = "smps7";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			smps8_reg: smps8 {
> +				regulator-name = "smps8";
> +				regulator-min-microvolt = < 600000>;
> +				regulator-max-microvolt = <1310000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			smps9_reg: smps9 {
> +				regulator-name = "smps9";
> +				regulator-min-microvolt = <2100000>;
> +				regulator-max-microvolt = <2100000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				ti,smps-range = <0x80>;
> +			};
> +
> +			smps10_reg: smps10 {
> +				regulator-name = "smps10";
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo1_reg: ldo1 {
> +				regulator-name = "ldo1";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo2_reg: ldo2 {
> +				regulator-name = "ldo2";
> +				regulator-min-microvolt = <2900000>;
> +				regulator-max-microvolt = <2900000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo3_reg: ldo3 {
> +				regulator-name = "ldo3";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo4_reg: ldo4 {
> +				regulator-name = "ldo4";
> +				regulator-min-microvolt = <2200000>;
> +				regulator-max-microvolt = <2200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo5_reg: ldo5 {
> +				regulator-name = "ldo5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo6_reg: ldo6 {
> +				regulator-name = "ldo6";
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo7_reg: ldo7 {
> +				regulator-name = "ldo7";
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo8_reg: ldo8 {
> +				regulator-name = "ldo8";
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo9_reg: ldo9 {
> +				regulator-name = "ldo9";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldoln_reg: ldoln {
> +				regulator-name = "ldoln";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldousb_reg: ldousb {
> +				regulator-name = "ldousb";
> +				regulator-min-microvolt = <3250000>;
> +				regulator-max-microvolt = <3250000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +		};
> +	};
> +};
> 
