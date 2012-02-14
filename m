From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 2/4] ARM: OMAP2/3: intc: Add DT support for TI
 interrupt controller
Date: Tue, 14 Feb 2012 13:52:08 -0700
Message-ID: <20120214205208.GA2656@ponder.secretlab.ca>
References: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
 <1329242172-4214-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43463 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279Ab2BNUwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 15:52:12 -0500
Received: by iacb35 with SMTP id b35so407726iac.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 12:52:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329242172-4214-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Tue, Feb 14, 2012 at 06:56:10PM +0100, Benoit Cousson wrote:
> Add a function to initialize the OMAP2/3 interrupt controller (INTC)
> using a device tree node.
> 
> This version take advantage of the new irq_domain_add_legacy API.
> 
> Replace some printk() with the proper pr_ macro.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++
>  arch/arm/mach-omap2/common.h                       |   10 +++
>  arch/arm/mach-omap2/irq.c                          |   59 ++++++++++++++++---
>  3 files changed, 86 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/intc.txt b/Documentation/devicetree/bindings/arm/omap/intc.txt
> new file mode 100644
> index 0000000..f2583e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/intc.txt
> @@ -0,0 +1,27 @@
> +* OMAP Interrupt Controller
> +
> +OMAP2/3 are using a TI interrupt controller that can support several
> +configurable number of interrupts.
> +
> +Main node required properties:
> +
> +- compatible : should be:
> +	"ti,omap2-intc"
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The type shall be a <u32> and the value shall be 1.
> +
> +  The cell contains the interrupt number in the range [0-128].
> +- ti,intc-size: Number of interrupts handled by the interrupt controller.
> +- reg: physical base address and size of the intc registers map.
> +
> +Example:
> +
> +	intc: interrupt-controller@1 {
> +		compatible = "ti,omap2-intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		ti,intc-size = <96>;
> +		reg = <0x48200000 0x1000>;
> +	};
> +
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index febffde..a87ce52 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -174,6 +174,16 @@ void omap3_intc_handle_irq(struct pt_regs *regs);
>  extern void __iomem *omap4_get_l2cache_base(void);
>  #endif
>  
> +struct device_node;
> +#ifdef CONFIG_OF
> +int __init intc_of_init(struct device_node *node, struct device_node *parent);

This name is pretty generic for a global symbol.  How about omap2_intc_of_init?

Otherwise this series looks good.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

This series need to be committed on top of the irqdomain tree.  I can either
pick it up myself (with Tony's ack) or I can stabilize the irqdomain/next tree
so that you can use it as a stable base to commit against (which I should
probably do anyway since there are others who will depend on it).

g.
