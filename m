From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] reset: ti-rstctrl: use the reset-simple driver
Date: Tue, 16 Jan 2018 15:22:54 -0600
Message-ID: <d32d9836-5edd-d43d-547b-f22384950f2c@ti.com>
References: <20180116011159.1386-1-tony@atomide.com>
 <1516095054.9022.1.camel@pengutronix.de> <20180116150314.GC4042@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180116150314.GC4042-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Parsons <lost.distance-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishant Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 01/16/2018 09:03 AM, Tony Lindgren wrote:
> Hi,
> 
> * Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> [180116 09:52]:
>> On Mon, 2018-01-15 at 17:11 -0800, Tony Lindgren wrote:
>>> +Example:
>>> +
>>> +	prcm: prcm@200000 {
>>> +		compatible = "ti,am3-prcm", "simple-bus";
>>> +		reg = <0x200000 0x4000>;
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		ranges = <0 0x200000 0x4000>;
>>> +
>>> +		prm_gfx: prm@1100 {
>>> +			compatible = "simple-bus";
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			ranges = <0 0x1100 0x100>;
>>> +
>>> +			gfx_rstctrl: rstctrl@4 {
>>    			,->
>>> +			|	reg = <0x4 0x4>;
>>> +			|	#reset-cells = <1>;
>>> +			`--	compatible = "ti,rstctrl";
>>
>> Looks good to me. Can I move the compatible property when applying?
> 
> Oops, here's a better version. I also left out the "prcm" part as
> at some point that should have just ranges instead of both reg and
> ranges that it currently has.

While this adaptation is very simple for replacing the RSTCTRL registers
from the hwmod data into an existing reset driver, I am afraid that it
doesn't fit well when you want to use the reset API from client drivers.
The RSTST is not accounted for (which is what we rely on for saying that
a deassert is successful), and this is currently only replacing part of
the omap4_prminst_{assert/deassert}_hardreset functionality, which in
itself is only a small portion of what the current drivers use
(omap_hwmod_{assert/deassert}_hardreset() functions.

regards
Suman

> 
> Regards,
> 
> Tony
> 
> 8< -----------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Mon, 15 Jan 2018 15:25:54 -0800
> Subject: [PATCHv2] reset: ti-rstctrl: use the reset-simple driver
> 
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
>  .../devicetree/bindings/reset/ti-rstctrl.txt         | 20 ++++++++++++++++++++
>  drivers/reset/Kconfig                                |  2 +-
>  drivers/reset/reset-simple.c                         |  1 +
>  3 files changed, 22 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/ti-rstctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/ti-rstctrl.txt b/Documentation/devicetree/bindings/reset/ti-rstctrl.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/ti-rstctrl.txt
> @@ -0,0 +1,20 @@
> +TI RSTCTRL Reset Controller
> +
> +Required properties:
> +- compatible : "ti,rstctrl"
> +- reg : Should contain 1 register ranges(address and length)
> +- #reset-cells: 1
> +
> +Example:
> +	prm_gfx: prm@1100 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x1100 0x100>;
> +
> +		gfx_rstctrl: rstctrl@4 {
> +			compatible = "ti,rstctrl";
> +			reg = <0x4 0x4>;
> +			#reset-cells = <1>;
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
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
