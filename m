From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/4] Documentation: mfd: LP873X: Add information for
 the mfd driver
Date: Tue, 9 Aug 2016 13:50:37 +0100
Message-ID: <20160809125037.GE5243@dell>
References: <1470635218-15951-1-git-send-email-j-keerthy@ti.com>
 <1470635218-15951-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1470635218-15951-2-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 08 Aug 2016, Keerthy wrote:

> The lp873x series of PMICs have a bunch of regulators and a couple
> of GPO(General Purpose Outputs).
> Add information for the MFD and regulator drivers.
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

These should be in chronological order.  Rob could not have Acked the
patch before you sent it.

> ---
> Changes in v6:
> 
>   * Added more formating for properties.
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

Patch looks good though.

I'll fix the nit above.

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
> new file mode 100644
> index 0000000..1377c25
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
> @@ -0,0 +1,59 @@
> +TI LP873X PMIC MFD driver
> +
> +Required properties:
> +  - compatible:	"ti,lp8732", "ti,lp8733"
> +  - reg:		I2C slave address.
> +  - gpio-controller:	Marks the device node as a GPIO Controller.
> +  - #gpio-cells:	Should be two.  The first cell is the pin number and
> +			the second cell is used to specify flags.
> +			See ../gpio/gpio.txt for more information.
> +  - regulators:	List of child nodes that specify the regulator
> +			initialization data.
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
