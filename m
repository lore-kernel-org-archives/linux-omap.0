From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 14/20] ARM: dts: omap4: add clkctrl nodes
Date: Thu, 7 Dec 2017 13:14:35 -0800
Message-ID: <20171207211435.GC28152@atomide.com>
References: <1512636413-25243-1-git-send-email-t-kristo@ti.com>
 <1512636413-25243-15-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1512636413-25243-15-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [171207 08:50]:
> Add clkctrl nodes for OMAP4 SoC. These are going to be acting as
> replacement for part of the existing clock data and the existing
> clkctrl hooks under hwmod data.
...
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/pinctrl/omap.h>
> +#include <dt-bindings/clock/omap4.h>

We have the clkctrl defines above to keep things understandable for
humans, so let's use them. Otherwise we'll easily get errors deducting
the TRM register offset value from the 0x20 offset.

And I really like being able to easily verify the values against the
clockdomain offsets in include/dt-bindings/clock/omap4.h and see that
a correct clockdomain is being used. And without the preprocessor defines,
generating these clock nodes will be impossible for anybody except you
although looks like you've done it for all of the existing ones :)

>  / {
>  	compatible = "ti,omap4430", "ti,omap4";
> @@ -683,7 +684,7 @@
>  			reg-names = "sys", "gdd";
>  			ti,hwmods = "hsi";
>  
> -			clocks = <&hsi_fck>;
> +			clocks = <&l3_init_clkctrl 0x18 0>;
>  			clock-names = "hsi_fck";
>  
>  			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;

clocks = <&l3_init_clkctrl OMAP4_HSI_CLKCTRL 0>;

> @@ -982,7 +983,7 @@
>  			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>  			ti,hwmods = "timer1";
>  			ti,timer-alwon;
> -			clocks = <&dmt1_clk_mux>;
> +			clocks = <&l4_wkup_clkctrl 0x20 24>;
>  			clock-names = "fck";
>  		};

clocks = <&l4_wkup_clkctrl OMAP4_TIMER1_CLKCTRL 24>;

> @@ -1214,7 +1215,7 @@
>  			reg = <0x58000000 0x80>;
>  			status = "disabled";
>  			ti,hwmods = "dss_core";
> -			clocks = <&dss_dss_clk>;
> +			clocks = <&l3_dss_clkctrl 0 8>;
>  			clock-names = "fck";
>  			#address-cells = <1>;
>  			#size-cells = <1>;

clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>;

And so on.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
