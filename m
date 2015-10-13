From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 27/27] ARM: dts: omap3: Fix gpmc and NAND nodes
Date: Mon, 12 Oct 2015 17:43:35 -0700
Message-ID: <20151013004335.GU23801@atomide.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <1442588029-13769-28-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442588029-13769-28-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150918 08:00]:
> Add compatible id, GPMC register resource and interrupt
> resource to NAND controller nodes.
> 
> The GPMC driver now implements gpiochip and irqchip so
> enable gpio-controller and interrupt-controller properties.
> 
> With this the interrupt parent of NAND node changes so fix it
> accordingly.
...
> --- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> +++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> @@ -35,11 +35,14 @@
>  };
>  
>  &gpmc {
> -	ranges = <0 0 0x00000000 0x1000000>;	/* CS0: 16MB for NAND */
> +	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
>  
>  	nand@0,0 {
> -		linux,mtd-name = "micron,mt29f4g16abbda3w";
> +		compatible = "ti,omap2-nand";
>  		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
> +		interrupt-parent = <&intc>;
> +		interrupts = <20>;
> +		linux,mtd-name = "micron,mt29f4g16abbda3w";
>  		nand-bus-width = <16>;
>  		ti,nand-ecc-opt = "bch8";
>  		gpmc,sync-clk-ps = <0>;

At least torpedo breaks for NFSroot as NAND now overlaps with
Ethernet.. What's the policy you have for moving the addresses
around?

There may be other similar cases to check too.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
