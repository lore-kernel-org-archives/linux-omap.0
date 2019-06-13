From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: lp87565: Add lp87561
 configuration
Date: Thu, 13 Jun 2019 15:28:38 -0600
Message-ID: <20190613212838.GA21714@bogus>
References: <20190516043218.8222-1-j-keerthy@ti.com>
 <20190516043218.8222-2-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190516043218.8222-2-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, May 16, 2019 at 10:02:16AM +0530, Keerthy wrote:
> lp87561 is a single output 4-phase regulator configuration.
> Add support for the same.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../devicetree/bindings/mfd/lp87565.txt       | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
> index a48df7c08ab0..41671e0dc26b 100644
> --- a/Documentation/devicetree/bindings/mfd/lp87565.txt
> +++ b/Documentation/devicetree/bindings/mfd/lp87565.txt
> @@ -41,3 +41,39 @@ lp87565_pmic: pmic@60 {
>  		};
>  	};
>  };
> +
> +TI LP87561 PMIC:
> +
> +This is a single output 4-phase regulator configuration
> +
> +Required properties:
> +  - compatible:	"ti,lp87561-q1"
> +  - reg:		I2C slave address.
> +  - gpio-controller:	Marks the device node as a GPIO Controller.
> +  - #gpio-cells:	Should be two.  The first cell is the pin number and
> +			the second cell is used to specify flags.
> +			See ../gpio/gpio.txt for more information.
> +  - xxx-in-supply:	Phandle to parent supply node of each regulator
> +			populated under regulators node. xxx should match
> +			the supply_name populated in driver.

This is not something we can validate. You need to enumerate values of 
'xxx'.

> +Example:
> +
> +lp87561_pmic: pmic@62 {
> +	compatible = "ti,lp87561-q1";
> +	reg = <0x62>;
> +	gpio-controller;
> +	#gpio-cells = <2>;
> +
> +	buck3210-in-supply = <&vsys_3v3>;
> +
> +	regulators: regulators {
> +		buck3210_reg: buck3210 {
> +			/* VDD_CORE */
> +			regulator-name = "buck3210";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +	};
> +};
> -- 
> 2.17.1
> 
