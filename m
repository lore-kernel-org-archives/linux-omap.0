From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 05/21] DT: tegra: add binding for the legacy interrupt
 controller
Date: Thu, 8 Jan 2015 09:12:08 -0600
Message-ID: <20150108151208.GC24654@kahuna>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-6-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420652576-22309-6-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 17:42-20150107, Marc Zyngier wrote:
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  .../interrupt-controller/nvidia,tegra-ictlr.txt    | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt
> new file mode 100644
> index 0000000..44fd873
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt
> @@ -0,0 +1,39 @@
> +NVIDIA Legacy Interrupt Controller
> +
> +All Tegra SoCs contain a legacy interrupt controller that routes
> +interrupts to the GIC, and also serves as a wakeup source. It is also
> +refered to as "ictlr", hence the name of the binding.
> +
> +The HW block exposes a number of frames, each implementing a set of 32
> +interrupts.
> +
> +Reguired properties:
> +
> +- compatible : should contain at least "nvidia,tegra-ictlr".

perhaps list the specific versions here..?

+WARNING: DT compatible string "nvidia,tegra114-ictlr" appears un-documented -- check ./Documentation/devicetree/bindings/
+#39: FILE: arch/arm/boot/dts/tegra114.dtsi:141:
++		compatible = "nvidia,tegra114-ictlr", "nvidia,tegra-ictlr";
+WARNING: DT compatible string "nvidia,tegra-ictlr" appears un-documented -- check ./Documentation/devicetree/bindings/
+#39: FILE: arch/arm/boot/dts/tegra114.dtsi:141:
++		compatible = "nvidia,tegra114-ictlr", "nvidia,tegra-ictlr";
+WARNING: DT compatible string "nvidia,tegra124-ictlr" appears un-documented -- check ./Documentation/devicetree/bindings/
+#84: FILE: arch/arm/boot/dts/tegra124.dtsi:195:
++		compatible = "nvidia,tegra124-ictlr", "nvidia,tegra-ictlr";
+WARNING: DT compatible string "nvidia,tegra-ictlr" appears un-documented -- check ./Documentation/devicetree/bindings/
+#84: FILE: arch/arm/boot/dts/tegra124.dtsi:195:
++		compatible = "nvidia,tegra124-ictlr", "nvidia,tegra-ictlr";
+WARNING: DT compatible string "nvidia,tegra20-ictlr" appears un-documented -- check ./Documentation/devicetree/bindings/
+#139: FILE: arch/arm/boot/dts/tegra20.dtsi:171:
++		compatible = "nvidia,tegra20-ictlr", "nvidia,tegra-ictlr";
+WARNING: DT compatible string "nvidia,tegra-ictlr" appears un-documented -- check ./Documentation/devicetree/bindings/
+#139: FILE: arch/arm/boot/dts/tegra20.dtsi:171:
++		compatible = "nvidia,tegra20-ictlr", "nvidia,tegra-ictlr";
+WARNING: DT compatible string "nvidia,tegra30-ictlr" appears un-documented -- check ./Documentation/devicetree/bindings/
+#186: FILE: arch/arm/boot/dts/tegra30.dtsi:256:
++		compatible = "nvidia,tegra30-ictlr", "nvidia,tegra-ictlr";
+WARNING: DT compatible string "nvidia,tegra-ictlr" appears un-documented -- check ./Documentation/devicetree/bindings/
+#186: FILE: arch/arm/boot/dts/tegra30.dtsi:256:
++		compatible = "nvidia,tegra30-ictlr", "nvidia,tegra-ictlr";
> +- reg : Specifies base physical address and size of the registers.
> +  Each frame must be described separately.
> +- interrupt-controller : Identifies the node as an interrupt controller.
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value must be 3.
> +- interrupt-parent : a phandle to the GIC these interrupts are routed
> +  to.
> +
> +Notes:
> +
> +- Because this HW ultimately routes interrupts to the GIC, the
> +  interrupt specifier must be that of the GIC.
> +- Only SPIs can use the ictlr as an interrupt parent. SGIs and PPIs
> +  are explicitely forbiden.
> +
> +Example:
> +
> +	ictlr: interrupt-controller@60004000 {
> +		compatible = "nvidia,tegra20-ictlr", "nvidia,tegra-ictlr";

> +		reg = <0x60004000 64>,
> +		      <0x60004100 64>,
> +		      <0x60004200 64>,
> +		      <0x60004300 64>;
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&intc>;
> +	};
> -- 
> 2.1.4

Might be good to have this patch before patch #3, since the binding
defined here is implemented in #3 and used in #4. also:

+WARNING: 'refered' may be misspelled - perhaps 'referred'?
+#23: FILE: Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt:5:
++refered to as "ictlr", hence the name of the binding.
+WARNING: 'explicitely' may be misspelled - perhaps 'explicitly'?
+#44: FILE: Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt:26:
++  are explicitely forbiden.
-- 
Regards,
Nishanth Menon
