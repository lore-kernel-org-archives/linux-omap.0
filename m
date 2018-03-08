From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv2] reset: ti-rstctrl: use the reset-simple driver
Date: Wed, 7 Mar 2018 20:48:06 -0600
Message-ID: <20180308024806.vombsjullqw5gpmz@rob-hp-laptop>
References: <20180307182143.58383-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180307182143.58383-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishant Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 07, 2018 at 10:21:43AM -0800, Tony Lindgren wrote:
> We can support the RSTCTRL reset registers on many TI SoCs with
> reset-simple.
> 
> Note that some devices will also need to check the RSTST bits
> for reset reason. Support for these could be possibly added to
> the reset controller framework later on.
> 
> Cc: Dave Gerlach <d-gerlach@ti.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Nishant Menon <nm@ti.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Suman Anna <s-anna@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> - Update patch description to mention the unhandled RSTST bits
> - Rebase against Linux next
> 
> ---
>  .../devicetree/bindings/reset/ti-rstctrl.txt         | 20 ++++++++++++++++++++
>  drivers/reset/Kconfig                                |  3 ++-
>  drivers/reset/reset-simple.c                         |  1 +
>  3 files changed, 23 insertions(+), 1 deletion(-)
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

What's a PRM?

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x1100 0x100>;

And what else is in this range?

> +
> +		gfx_rstctrl: rstctrl@4 {
> +			compatible = "ti,rstctrl";
> +			reg = <0x4 0x4>;

Anytime I see a single register in DT I worry about scaling. How many of 
these in an SoC?

> +			#reset-cells = <1>;
> +		};
> +	};
