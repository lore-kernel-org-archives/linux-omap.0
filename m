From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] reset: ti-rstctrl: use the reset-simple driver
Date: Tue, 16 Jan 2018 10:30:54 +0100
Message-ID: <1516095054.9022.1.camel@pengutronix.de>
References: <20180116011159.1386-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180116011159.1386-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Parsons <lost.distance-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishant Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Mon, 2018-01-15 at 17:11 -0800, Tony Lindgren wrote:
> We can support the RSTCTRL reset registers on many TI SoCs with
> reset-simple.
> 
> Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Nishant Menon <nm-l0cyMroinI0@public.gmane.org>
> Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
> 
> That's all there is to it :) Naturally this can wait for v4.17
> if necessary.
> 
> ---
>  .../devicetree/bindings/reset/ti-rstctrl.txt       | 29 ++++++++++++++++++++++
>  drivers/reset/Kconfig                              |  2 +-
>  drivers/reset/reset-simple.c                       |  1 +
>  3 files changed, 31 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/ti-rstctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/ti-rstctrl.txt b/Documentation/devicetree/bindings/reset/ti-rstctrl.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/ti-rstctrl.txt
> @@ -0,0 +1,29 @@
> +TI RSTCTRL Reset Controller
> +
> +Required properties:
> +- compatible : "ti,rstctrl"
> +- reg : Should contain 1 register ranges(address and length)
> +- #reset-cells: 1
> +
> +Example:
> +
> +	prcm: prcm@200000 {
> +		compatible = "ti,am3-prcm", "simple-bus";
> +		reg = <0x200000 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x200000 0x4000>;
> +
> +		prm_gfx: prm@1100 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x1100 0x100>;
> +
> +			gfx_rstctrl: rstctrl@4 {
   			,->
> +			|	reg = <0x4 0x4>;
> +			|	#reset-cells = <1>;
> +			`--	compatible = "ti,rstctrl";

Looks good to me. Can I move the compatible property when applying?

> +			};
> +		};
> +	};
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -83,7 +83,7 @@ config RESET_PISTACHIO
>  
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST
> -	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX
> +	default ARCH_OMAP2PLUS || ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX
>  	help
>  	  This enables a simple reset controller driver for reset lines that
>  	  that can be asserted and deasserted by toggling bits in a contiguous,
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -123,6 +123,7 @@ static const struct of_device_id reset_simple_dt_ids[] = {
>  	{ .compatible = "st,stm32-rcc", },
>  	{ .compatible = "allwinner,sun6i-a31-clock-reset",
>  		.data = &reset_simple_active_low },
> +	{ .compatible = "ti,rstctrl", },
>  	{ .compatible = "zte,zx296718-reset",
>  		.data = &reset_simple_active_low },
>  	{ /* sentinel */ },

regards
Philipp
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
