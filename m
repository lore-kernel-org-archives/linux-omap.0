From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] Documentation: mfd: LP873X: Add information for
 the mfd driver
Date: Fri, 5 Aug 2016 09:05:57 +0100
Message-ID: <20160805080557.GP5243@dell>
References: <1467215067-6486-1-git-send-email-j-keerthy@ti.com>
 <1467215067-6486-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467215067-6486-2-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Wed, 29 Jun 2016, Keerthy wrote:

> The lp873x series of PMICs have a bunch of regulators and a couple
> of GPO(General Purpose Outputs).
> Add information for the mfd and regulator drivers.

Nit: s/mfd/MFD/

> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v4:
> 
>   * Added the GPIO properties.
> 
> Changes in v3:
> 
>   * Changed the example node lable to pmic from lp8733.
> 
>  Documentation/devicetree/bindings/mfd/lp873x.txt | 59 ++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
> new file mode 100644
> index 0000000..1377c25
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
> @@ -0,0 +1,59 @@
> +TI LP873X MFD driver

"PMIC MFD" or "MFD PMIC"

> +Required properties:
> +  - compatible:		"ti,lp8732", "ti,lp8733"
> +  - reg:		I2C slave address.
> +  - gpio-controller :	Marks the device node as a GPIO Controller.
> +  - #gpio-cells	:	Should be two.  The first cell is the pin number and
> +			the second cell is used to specify flags.
> +			See ../gpio/gpio.txt for more information.
> +  - regulators: :	List of child nodes that specify the regulator
> +			initialization data.

Please standardise your formatting here.  Sometimes you do ":", other
times you do " :", and oddly ": :".

> +Example:
> +
> +pmic: lp8733@60 {
> +	compatible = "ti,lp8733";
> +	reg = <0x60>;
> +	gpio-controller;
> +	#gpio-cells = <2>;
> +
> +	regulators {
> +		lp8733_buck0: buck0 {
> +			regulator-name = "lp8733-buck0";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1400000>;
> +			regulator-min-microamp = <1500000>;
> +			regulator-max-microamp = <4000000>;
> +			regulator-ramp-delay = <10000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		lp8733_buck1: buck1 {
> +			regulator-name = "lp8733-buck1";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1400000>;
> +			regulator-min-microamp = <1500000>;
> +			regulator-max-microamp = <4000000>;
> +			regulator-ramp-delay = <10000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		lp8733_ldo0: ldo0 {
> +			regulator-name = "lp8733-ldo0";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		lp8733_ldo1: ldo1 {
> +			regulator-name = "lp8733-ldo1";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +	};
> +};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
