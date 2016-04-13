From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: Correct path for ARM GIC documentation
Date: Wed, 13 Apr 2016 16:30:12 +0100
Message-ID: <570E6604.1070707@nvidia.com>
References: <1458226077-7179-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458226077-7179-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Rob,

Are you ok to pick this up? Or are you still waiting for ACK's from Tony
and Matthias?

Jon

On 17/03/16 14:47, Jon Hunter wrote:
> Commit eb3fcf007fff ("dt-bindings: consolidate interrupt controller
> bindings") moved the binding documentation for the ARM GIC from
> arm/gic.txt to interrupt-controller/arm,gic.txt. However, there are
> still some binding documents referring to the old path. Update these
> binding documents to use the correct location.
> 
> Fixes: eb3fcf007fff ("dt-bindings: consolidate interrupt controller bindings")
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/arm/omap/crossbar.txt                | 3 ++-
>  Documentation/devicetree/bindings/arm/ux500/boards.txt                 | 2 +-
>  .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt       | 3 +--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> index a9b28d74d902..bb5727ae004a 100644
> --- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> @@ -42,7 +42,8 @@ Examples:
>  Consumer:
>  ========
>  See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt and
> -Documentation/devicetree/bindings/arm/gic.txt for further details.
> +Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt for
> +further details.
>  
>  An interrupt consumer on an SoC using crossbar will use:
>  	interrupts = <GIC_SPI request_number interrupt_level>
> diff --git a/Documentation/devicetree/bindings/arm/ux500/boards.txt b/Documentation/devicetree/bindings/arm/ux500/boards.txt
> index b8737a8de718..7334c24625fc 100644
> --- a/Documentation/devicetree/bindings/arm/ux500/boards.txt
> +++ b/Documentation/devicetree/bindings/arm/ux500/boards.txt
> @@ -23,7 +23,7 @@ scu:
>  	see binding for arm/scu.txt
>  
>  interrupt-controller:
> -	see binding for arm/gic.txt
> +	see binding for interrupt-controller/arm,gic.txt
>  
>  timer:
>  	see binding for arm/twd.txt
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> index b8e1674c7837..8cf564d083d2 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> @@ -16,8 +16,7 @@ Required properties:
>  	"mediatek,mt6577-sysirq"
>  	"mediatek,mt2701-sysirq"
>  - interrupt-controller : Identifies the node as an interrupt controller
> -- #interrupt-cells : Use the same format as specified by GIC in
> -  Documentation/devicetree/bindings/arm/gic.txt
> +- #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
>  - interrupt-parent: phandle of irq parent for sysirq. The parent must
>    use the same interrupt-cells format as GIC.
>  - reg: Physical base address of the intpol registers and length of memory
> 

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
