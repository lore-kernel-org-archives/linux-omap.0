From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3] Documentation: dt-bindings: Add binding documentation
 for TI clkctrl clocks
Date: Mon, 13 Feb 2017 17:19:33 +0200
Message-ID: <dca1ef84-77d1-2b58-7913-91f3b69fde6d@ti.com>
References: <20170123221702.18420-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170123221702.18420-1-tony@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On 24/01/17 00:17, Tony Lindgren wrote:
> Texas Instruments omap variant SoCs starting with omap4 have a clkctrl
> clock controller instance for each interconnect target module. The clkctrl
> controls functional and interface clocks for the module.
>
> The clkctrl clocks are currently handled by arch/arm/mach-omap2 hwmod code.
> With this binding and a related clock device driver we can start moving the
> clkctrl clock handling to live in drivers/clk/ti.
>
> Note that this binding allows keeping the clockdomain related parts out of
> drivers/clock. The CLKCTCTRL and DYNAMICDEP registers can be handled by
> a separate driver in drivers/soc/ti and genpd. If the clockdomain driver
> needs to know it's clocks, we can just set the the clkctrl device
> instances to be children of the related clockdomain device.
>
> Each clkctrl clock can have multiple optional gate clocks, and multiple
> optional mux clocks. To represent this in device tree, it seems that
> it is best done using four clock cells #clock-cells = <2> property.
>
> The reasons for using #clock-cells = <2> are:
>
> 1. We need to specify the clkctrl offset from the instance base. Otherwise
>    we end up with a large number of device tree nodes that need to be
>    patched when new clocks are discovered in a clkctrl clock with minor
>    hardware revision changes for example
>
> 2. On omap5 CM_L3INIT_USB_HOST_HS_CLKCTRL has ten OPTFCLKEN bits. So we
>    need to use a separate cell for optional gate clocks to avoid address
>    space conflicts
>
> There is probably no need to list input clocks for each clkctrl clock
> instance in the binding. If we want to add them, the standard clocks
> binding can be used for that.
>
> For hardware reference, see omap4430 TRM "Table 3-1312. L4PER_CM2 Registers
> Mapping Summary" for example. It shows one instance of a clkctrl clock
> controller with multiple clkctrl registers.
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This binding works for me, so:

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
> Changes from v2 to v3:
>
> - Changed the #clock-cells from 4 to 2 based on comments from Tero
>   and dropped the related patch description parts. I've kept Rob's
>   ack from v2 as the changes are a subset of v2 and what was discussed
>   already with the v1 patch
>
> Changes from v1 to v2:
>
> - Use #clock-cells to avoid address space conflicts
>
> - Consider also optional mux clocks as pointed out by Tero
>
> ---
>  .../devicetree/bindings/clock/ti-clkctrl.txt       | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti-clkctrl.txt
>
> diff --git a/Documentation/devicetree/bindings/clock/ti-clkctrl.txt b/Documentation/devicetree/bindings/clock/ti-clkctrl.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti-clkctrl.txt
> @@ -0,0 +1,56 @@
> +Texas Instruments clkctrl clock binding
> +
> +Texas Instruments SoCs can have a clkctrl clock controller for each
> +interconnect target module. The clkctrl clock controller manages functional
> +and interface clocks for each module. Each clkctrl controller can also
> +gate one or more optional functional clocks for a module, and can have one
> +or more clock muxes. There is a clkctrl clock controller typically for each
> +interconnect target module on omap4 and later variants.
> +
> +The clock consumers can specify the index of the clkctrl clock using
> +the hardware offset from the clkctrl instance register space. The optional
> +clocks can be specified by clkctrl hardware offset and the index of the
> +optional clock.
> +
> +For more information, please see the Linux clock framework binding at
> +Documentation/devicetree/bindings/clock/clock-bindings.txt.
> +
> +Required properties :
> +- compatible : shall be "ti,clkctrl"
> +- #clock-cells : shall contain 2 with the first entry being the instance
> +		 offset from the clock domain base and the second being the
> +		 clock index
> +
> +Example: Clock controller node on omap 4430:
> +
> +&cm2 {
> +	l4per: cm@1400 {
> +		cm_l4per@0 {
> +			cm_l4per_clkctrl: clk@20 {
> +				compatible = "ti,clkctrl";
> +				reg = <0x20 0x1b0>;
> +				#clock-cells = <4>;
> +			};
> +		};
> +	};
> +};
> +
> +Example: Preprocessor helper macros in dt-bindings/clock/ti-clkctrl.h
> +
> +#define OMAP4_CLKCTRL_OFFSET		0x20
> +#define OMAP4_CLKCTRL_INDEX(offset)	((offset) - OMAP4_CLKCTRL_OFFSET)
> +#define MODULEMODE_HWCTRL		1
> +#define MODULEMODE_SWCTRL		2
> +
> +#define OMAP4_GPTIMER10_CLKTRL		OMAP4_CLKCTRL_INDEX(0x28)
> +#define OMAP4_GPTIMER11_CLKTRL		OMAP4_CLKCTRL_INDEX(0x30)
> +#define OMAP4_GPTIMER2_CLKTRL		OMAP4_CLKCTRL_INDEX(0x38)
> +...
> +#define OMAP4_GPIO2_CLKCTRL		OMAP_CLKCTRL_INDEX(0x60)
> +
> +Example: Clock consumer node for GPIO2:
> +
> +&gpio2 {
> +       clocks = <&cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 0
> +		 &cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 8>;
> +};
>

