From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] regulator: cpcap: Add basic regulator support
Date: Wed, 1 Feb 2017 11:14:35 -0600
Message-ID: <20170201171435.hl3atrmrrz7mjsmo@rob-hp-laptop>
References: <20170131001241.5926-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170131001241.5926-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 30, 2017 at 04:12:41PM -0800, Tony Lindgren wrote:
> Many Motorola phones like droid 4 are using a custom PMIC called CPCAP
> or 6556002. This PMIC is used with several SoCs, I've noticed at least
> omap3, omap4 and Tegra2 based Motorola phones and tablets using it.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> With the cpcap core MFD driver now in Linux next as commit
> 3d66c8abc13e ("mfd: cpcap: Add minimal support"), here's a related
> regulator driver. This is needed to support more devices on droid 4,
> such as the LCD and touchscreen.
> 
> ---
>  .../bindings/regulator/cpcap-regulator.txt         |  34 ++
>  drivers/regulator/Kconfig                          |   7 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/cpcap-regulator.c                | 517 +++++++++++++++++++++
>  4 files changed, 559 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
>  create mode 100644 drivers/regulator/cpcap-regulator.c
> 
> diff --git a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> @@ -0,0 +1,34 @@
> +Motorola CPCAP PMIC voltage regulators
> +------------------------------------
> +
> +Requires node properties:
> +- "compatible" value one of:
> +    "motorola,cpcap-regulator"
> +    "motorola,mapphone-cpcap-regulator"
> +
> +Required regulator properties:
> +- "regulator-name"
> +- "regulator-enable-ramp-delay"
> +- "regulator-min-microvolt"
> +- "regulator-max-microvolt"
> +
> +Optional regulator properties:
> +- "regulator-boot-on"
> +
> +See Documentation/devicetree/bindings/regulator/regulator.txt
> +for more details about the regulator properties.
> +
> +Example:
> +
> +cpcap_regulator: regulator@600 {

unit-address with no reg prop.

> +	compatible = "motorola,cpcap-regulator";
> +
> +	cpcap_regulators: regulators {
> +		sw5: SW5 {
> +			regulator-min-microvolt = <5050000>;
> +			regulator-max-microvolt = <5050000>;
> +			regulator-enable-ramp-delay = <50000>;
> +			regulator-boot-on;
> +		};
> +	};
> +};
