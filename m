From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC 3/6] Documentation: dt: add bindings for ti bb2d
Date: Thu, 17 Nov 2016 20:54:15 -0600
Message-ID: <3e993bed-c818-bfdd-52d3-774fdca85cda@ti.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-3-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161118024436.13447-3-robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Gowtham Tammana <g-tammana-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/17/2016 08:44 PM, Robert Nelson wrote:
> From: Gowtham Tammana <g-tammana-l0cyMroinI0@public.gmane.org>
>
> Add documentation for device tree bindings description for
> 2D GPU blitter module present in Texas Instruments family of SoCs.
>
> Signed-off-by: Gowtham Tammana <g-tammana-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> ---

Might want to point at the source of the patch -> just for the record, 
this came from TI vendor kernel..
>  Documentation/devicetree/bindings/gpu/ti-bb2d.txt | 27 +++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/ti-bb2d.txt
>
> diff --git a/Documentation/devicetree/bindings/gpu/ti-bb2d.txt b/Documentation/devicetree/bindings/gpu/ti-bb2d.txt
> new file mode 100644
> index 0000000..af47488
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/ti-bb2d.txt
> @@ -0,0 +1,27 @@
> +* Texas Instruments BB2D blitter module
> +
> +This binding describes the 2D BitBlit (BB2D) graphics accelerator
> +subsystem based on the GC320 core from Vivante Corporation available
> +in Texas Instruments SoCs.
> +
> +Required properties:
> +  - compatible: value should take the following format:
> +        "ti,<soc>-bb2d", "vivante,<gpuversion>"
> +    accepted values:
> +     (a) "ti,dra7-bb2d", "vivante,gc320" for TI DRA7xx / AM57x
> +
> +  - reg : base address and length of BB2D IP registers
> +  - interrupts : BB2D interrupt line number
> +  - ti,hwmods : name of the hwmod associated with BB2D module
> +  - clocks : handle to BB2D functional clock
> +  - clock-names : fclk
> +
> +Example for DRA7x SoC:
> +        bb2d: bb2d@59000000 {
> +            compatible = "ti,dra7-bb2d", "vivante,gc320";
> +            reg = <0x59000000 0x0700>;
> +            interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +            ti,hwmods = "bb2d";
> +            clocks = <&dpll_core_h24x2_ck>;
> +            clock-names = "fclk";
> +        };
>


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
