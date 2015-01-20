From: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v4 16/21] DT: exynos: update PMU binding
Date: Tue, 20 Jan 2015 13:17:00 +0530
Message-ID: <54BE07F4.1000106@samsung.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
 <1421660655-21394-17-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1421660655-21394-17-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Marc,

On Monday 19 January 2015 03:14 PM, Marc Zyngier wrote:
> Document the fact that some Exynos PMUs are capable of acting as
> an interrupt controller.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   Documentation/devicetree/bindings/arm/samsung/pmu.txt | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> index 1e1979b..d698e74 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> @@ -28,10 +28,23 @@ Properties:
>    - clocks : list of phandles and specifiers to all input clocks listed in
>   		clock-names property.
>
> +Optional properties:
> +
> +Some PMUs are capable of behaving as an interrupt controller (mostly
> +to wake up a suspended PMU). In which case, they can have the
> +following properties:
> +
> +- interrupt-controller: indicate that said PMU is an interrupt controller
> +

Need to add #interrupt-cells property here.


> +- interrupt-parent: a phandle indicating which interrupt controller
> +  this PMU signals interrupts to.
> +
>   Example :
>   pmu_system_controller: system-controller@10040000 {
>   	compatible = "samsung,exynos5250-pmu", "syscon";
>   	reg = <0x10040000 0x5000>;
> +	interrupt-controller;
> +	interrupt-parent = <&gic>;
>   	#clock-cells = <1>;
>   	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
>   			"clkout4", "clkout8", "clkout9";
>

Thanks,
Pankaj Dubey
