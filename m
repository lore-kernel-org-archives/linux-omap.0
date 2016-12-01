From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/5] regulator: Add support for TI TWL6032
Date: Thu, 1 Dec 2016 10:10:00 -0600
Message-ID: <20161201161000.3g3eqi2xuch62lwy@rob-hp-laptop>
References: <20161126181326.14951-1-Nicolae_Rosia@mentor.com>
 <20161126181326.14951-5-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161126181326.14951-5-Nicolae_Rosia@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Graeme Gregory <gg@slimlogic.co.uk>, Baruch Siach <baruch@tkos.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 26, 2016 at 08:13:25PM +0200, Nicolae Rosia wrote:
> The TWL6032 PMIC is similar to TWL6030, has different
> output names, and regulator control logic.
> It is used on Barnes & Noble Nook HD and HD+.
> 
> Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
> ---
>  .../bindings/regulator/twl6032-regulator.txt       | 109 ++++
>  drivers/regulator/Kconfig                          |   7 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/twl6032-regulator.c              | 582 +++++++++++++++++++++
>  4 files changed, 699 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/twl6032-regulator.txt
>  create mode 100644 drivers/regulator/twl6032-regulator.c
> 
> diff --git a/Documentation/devicetree/bindings/regulator/twl6032-regulator.txt b/Documentation/devicetree/bindings/regulator/twl6032-regulator.txt
> new file mode 100644
> index 0000000..323f5a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/twl6032-regulator.txt
> @@ -0,0 +1,109 @@
> +TWL6032 PMIC Voltage Regulator Bindings
> +
> +The parent node must be MFD TWL Core, ti,twl6032.
> +
> +Required properties:
> +- compatible: "ti,twl6032"
> +
> +Optional properties:
> +- regulators node containing regulator childs.

s/childs/children/

regulators node is not a property.

> +
> +The child regulators  must be named after their hardware

extra space             ^

> +counterparts: LDO[1-6], LDOLN, LDOUSB and VANA.
> +
> +Each regulator is defined using the standard binding
> +for regulators as described in ./regulator.txt
> +
> +Example:
> +twl {
> +	compatible = "ti,twl6032";
> +
> +	[...]
> +
> +	pmic {
> +		compatible = "ti,twl6032-regulator";

Not documented.

> +
> +		regulators {

Do you really need pmic node and regulators node?

> +			ldo1: LDO1 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <2500000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo2: LDO2 {
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3000000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo3: LDO3 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3000000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo6: LDO6 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo7: LDO7 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldoln: LDOLN {
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +
> +			ldousb: LDOUSB {
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +
> +			vana: VANA {
> +				regulator-min-microvolt = <2100000>;
> +				regulator-max-microvolt = <2100000>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	[...]
> +};
