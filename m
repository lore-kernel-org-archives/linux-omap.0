From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 10/36] ARM: dts: OMAP2+: Fix NAND device nodes
Date: Fri, 13 Jun 2014 00:21:30 -0700
Message-ID: <20140613072129.GL17845@atomide.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com>
 <1402477001-31132-11-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402477001-31132-11-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pekon-l0cyMroinI0@public.gmane.org, ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140611 01:58]:
> Add compatible id, GPMC register resource and interrupt
> resource to NAND controller nodes.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-evm.dts         |  8 ++++++--
>  arch/arm/boot/dts/am335x-igep0033.dtsi   |  8 ++++++--
>  arch/arm/boot/dts/am43x-epos-evm.dts     |  8 ++++++--
>  arch/arm/boot/dts/omap3-devkit8000.dts   |  9 +++++++--
>  arch/arm/boot/dts/omap3-evm-37xx.dts     | 10 +++++++---
>  arch/arm/boot/dts/omap3-igep0020.dts     | 10 +++++++---
>  arch/arm/boot/dts/omap3-igep0030.dts     |  8 ++++++--
>  arch/arm/boot/dts/omap3-ldp.dts          | 10 +++++++---
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi  | 10 +++++++---
>  arch/arm/boot/dts/omap3-lilly-dbb056.dts |  7 ++++---
>  arch/arm/boot/dts/omap3430-sdp.dts       |  8 ++++++--
>  11 files changed, 69 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 6028217..fa25f2b 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -437,9 +437,13 @@
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&nandflash_pins_s0>;
> -	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
> +	ranges = <0 0 0x08000000 0x10000000	/* CS0 space, 16MB */
> +		  255 0 0x50000000 0x36c>;	/* GPMC reg */

And here too let's not let the NAND driver tinker with the GPMC
registers.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
