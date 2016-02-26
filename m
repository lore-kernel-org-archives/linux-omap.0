From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: DRA7: change address-cells and size-cells
Date: Fri, 26 Feb 2016 11:11:27 -0800
Message-ID: <20160226191127.GE13417@atomide.com>
References: <1456308664-28308-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456308664-28308-1-git-send-email-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> [160224 02:14]:
> DRA7 SoC has the capability to support DDR memory upto 4GB. In order to
> represent this in memory dt node, the address-cells and size cells
> should be 2. So, changing the address-cells and size-cells to 2 and
> updating the memory nodes accordingly.
> @@ -57,10 +57,10 @@
>  		compatible = "arm,cortex-a15-gic";
>  		interrupt-controller;
>  		#interrupt-cells = <3>;
> -		reg = <0x48211000 0x1000>,
> -		      <0x48212000 0x1000>,
> -		      <0x48214000 0x2000>,
> -		      <0x48216000 0x2000>;
> +		reg = <0x0 0x48211000 0x0 0x1000>,
> +		      <0x0 0x48212000 0x0 0x1000>,
> +		      <0x0 0x48214000 0x0 0x2000>,
> +		      <0x0 0x48216000 0x0 0x2000>;
>  		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
>  		interrupt-parent = <&gic>;
>  	};
> @@ -69,7 +69,7 @@
>  		compatible = "ti,omap5-wugen-mpu", "ti,omap4-wugen-mpu";
>  		interrupt-controller;
>  		#interrupt-cells = <3>;
> -		reg = <0x48281000 0x1000>;
> +		reg = <0x0 0x48281000 0x0 0x1000>;
>  		interrupt-parent = <&gic>;
>  	};
>  
> @@ -96,10 +96,10 @@
>  		compatible = "ti,dra7-l3-noc", "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		ranges;
> +		ranges = <0x0 0x0 0x0 0xc0000000>;
>  		ti,hwmods = "l3_main_1", "l3_main_2";
> -		reg = <0x44000000 0x1000000>,
> -		      <0x45000000 0x1000>;
> +		reg = <0x0 0x44000000 0x0 0x1000000>,
> +		      <0x0 0x45000000 0x0 0x1000>;
>  		interrupts-extended = <&crossbar_mpu GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>  				      <&wakeupgen GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>  

Is size-cells 2 needed for all these devices too? Can't
you just set it for the memory nodes?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
