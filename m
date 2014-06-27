From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V4 15/16] documentation: dt: omap: crossbar: Add
 description for interrupt consumer
Date: Fri, 27 Jun 2014 07:57:42 -0400
Message-ID: <20140627115742.GA23978@titan.lakedaemon.net>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
 <1403766634-18543-16-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403766634-18543-16-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 26, 2014 at 12:40:33PM +0530, Sricharan R wrote:
> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> 
> The current crossbar description does not include the description
> required for the consumer of the crossbar, a.k.a devices whoes events
> pass through the crossbar into the GIC interrupt controller.
> 
> So, provide documentation for the same.
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/arm/omap/crossbar.txt      |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> index 6923531..35356b6 100644
> --- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> @@ -36,3 +36,20 @@ Examples:
>  			ti,irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
>  			ti,irqs-skip = <10 133 139 140>;
>  		};
> +
> +Consumer:
> +========
> +See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt and
> +Documentation/devicetree/bindings/arm/gic.txt for further details.
> +
> +An interrupt consumer on an SoC using crossbar will use:
> +	interrupts = <GIC_SPI request_number interrupt_level>
> +request number shall be between 0 to that described by
> +"ti,max-crossbar-sources"
> +
> +Example:
> +	device_x@0x4a023000 {
> +		/* Crossbar 8 used */
> +		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;

If you are going to reference MAX_SOURCES in the previous patch to the
docs, then you should use the macro here as well and explain both.  Or,
just use numbers in the docs, and macros in the dtsi files.

If you prefer the latter, just let me know and I'll fixup the other
patch when applying these.  Otherwise, you can just send a v5 of the two
patches affected.

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
