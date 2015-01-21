From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 12/21] DT: omap4/5: add binding for the wake-up
 generator
Date: Wed, 21 Jan 2015 08:26:34 -0800
Message-ID: <20150121162633.GQ7718@atomide.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
 <1421660655-21394-13-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1421660655-21394-13-git-send-email-marc.zyngier@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, linux-samsung-soc@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, Stephen Warren <swarren@wwwdotorg.org>, Simon Horman <horms@verge.net.au>, Santosh Shilimkar <ssantosh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Marc Zyngier <marc.zyngier@arm.com> [150119 01:48]:
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  .../interrupt-controller/ti,omap4-wugen-mpu        | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu b/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
> new file mode 100644
> index 0000000..43effa0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
> @@ -0,0 +1,33 @@
> +TI OMAP4 Wake-up Generator
> +
> +All TI OMAP4/5 (and their derivatives) an interrupt controller that
> +routes interrupts to the GIC, and also serves as a wakeup source. It
> +is also referred to as "WUGEN-MPU", hence the name of the binding.
> +
> +Reguired properties:
> +
> +- compatible : should contain at least "ti,omap4-wugen-mpu" or
> +  "ti,omap5-wugen-mpu"
> +- reg : Specifies base physical address and size of the registers.
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
> +- Only SPIs can use the WUGEN as an interrupt parent. SGIs and PPIs
> +  are explicitly forbiden.
> +
> +Example:
> +
> +       wakeupgen: interrupt-controller@48281000 {
> +               compatible = "ti,omap5-wugen-mpu", "ti,omap4-wugen-mpu";
> +               interrupt-controller;
> +               #interrupt-cells = <3>;
> +               reg = <0x48281000 0x1000>;
> +               interrupt-parent = <&gic>;
> +       };
> -- 
> 2.1.4
> 
