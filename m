From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V4 13/16] irqchip: crossbar: Introduce
 ti,max-crossbar-sources to identify valid crossbar mapping
Date: Fri, 27 Jun 2014 08:00:35 -0400
Message-ID: <20140627120035.GB23978@titan.lakedaemon.net>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
 <1403766634-18543-14-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403766634-18543-14-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 26, 2014 at 12:40:31PM +0530, Sricharan R wrote:
> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> 
> Currently we attempt to map any crossbar value to an IRQ, however,
> this is not correct from hardware perspective. There is a max crossbar
> event number upto which hardware supports. So describe the same in
> device tree using 'ti,max-crossbar-sources' property and use it to
> validate requests.
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/arm/omap/crossbar.txt      |    2 ++
>  drivers/irqchip/irq-crossbar.c                     |   21 ++++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> index 5f45c78..6923531 100644
> --- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> @@ -10,6 +10,7 @@ Required properties:
>  - compatible : Should be "ti,irq-crossbar"
>  - reg: Base address and the size of the crossbar registers.
>  - ti,max-irqs: Total number of irqs available at the interrupt controller.
> +- ti,max-crossbar-sources: Maximum number of crossbar sources that can be routed.
>  - ti,reg-size: Size of a individual register in bytes. Every individual
>  	    register is assumed to be of same size. Valid sizes are 1, 2, 4.
>  - ti,irqs-reserved: List of the reserved irq lines that are not muxed using
> @@ -30,6 +31,7 @@ Examples:
>  			compatible = "ti,irq-crossbar";
>  			reg = <0x4a002a48 0x130>;
>  			ti,max-irqs = <160>;
> +			ti,max-crossbar-sources = <MAX_SOURCES>;

As mentioned in my reply to #15, I can change this to 400 when I apply
it, or you can send a new version of #15 using the macro and explaining
it's definition.

Thinking about it more, it's probably best just to use numbers in the
docs.

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
