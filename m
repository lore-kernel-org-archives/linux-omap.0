From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch 4/6] dt-bindings: media: ti-vpe: Document VPE driver
Date: Tue, 17 Oct 2017 16:00:51 -0500
Message-ID: <20171017210051.6ap3yg7b7viav6cy@rob-hp-laptop>
References: <20171012192719.15193-1-bparrot@ti.com>
 <20171012192719.15193-5-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171012192719.15193-5-bparrot-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 12, 2017 at 02:27:17PM -0500, Benoit Parrot wrote:
> Device Tree bindings for the Video Processing Engine (VPE) driver.
> 
> Signed-off-by: Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/media/ti-vpe.txt | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/ti-vpe.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/ti-vpe.txt b/Documentation/devicetree/bindings/media/ti-vpe.txt
> new file mode 100644
> index 000000000000..c2ef93d08417
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/ti-vpe.txt
> @@ -0,0 +1,41 @@
> +Texas Instruments DRA7x VIDEO PROCESSING ENGINE (VPE)
> +------------------------------------------------------
> +
> +The Video Processing Engine (VPE) is a key component for image post
> +processing applications. VPE consist of a single memory to memory
> +path which can perform chroma up/down sampling, deinterlacing,
> +scaling and color space conversion.
> +
> +Required properties:
> +- compatible: must be "ti,vpe"

Needs SoC specific compatibles.

> +- reg:	physical base address and length of the registers set for the 8
> +	memory regions required;
> +- reg-names: name associated with the memory regions described is <reg>;
> +- interrupts: should contain IRQ line for VPE;
> +
> +Example:
> +	vpe {
> +		compatible = "ti,vpe";
> +		ti,hwmods = "vpe";
> +		clocks = <&dpll_core_h23x2_ck>;
> +		clock-names = "fck";
> +		reg =	<0x489d0000 0x120>,
> +			<0x489d0300 0x20>,
> +			<0x489d0400 0x20>,
> +			<0x489d0500 0x20>,
> +			<0x489d0600 0x3c>,
> +			<0x489d0700 0x80>,

Is there other stuff between these regions?

> +			<0x489d5700 0x18>,
> +			<0x489dd000 0x400>;
> +		reg-names =	"vpe_top",
> +				"vpe_chr_us0",
> +				"vpe_chr_us1",
> +				"vpe_chr_us2",
> +				"vpe_dei",
> +				"sc",
> +				"csc",
> +				"vpdma";
> +		interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;

> +		#address-cells = <1>;
> +		#size-cells = <0>;

These aren't needed.

> +	};
> -- 
> 2.9.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
