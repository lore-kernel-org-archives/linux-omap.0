From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: DTS: am57xx-beagle-x15: Select SYS_CLK2 for audio
 clocks
Date: Wed, 10 Feb 2016 16:25:58 -0800
Message-ID: <20160211002558.GP19432@atomide.com>
References: <1455018417-2608-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455018417-2608-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160209 03:48]:
> The tlv320aic3104 codec's master clock is coming from the SoC's CLKOUT2.
> Select the SYS_CLK2 (via divider) as parent clock for CLKOUT2 and select
> the same clock (SYS_CLK2) for McASP3 AHCLKX clock as well.
> SYS_CLK2 is sourced from an external oscillator running 22.5792MHz and it
> is coming in to the SoC via the X1_OSC1.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

Applying into omap-for-v4.5/fixes thanks.

Tony

> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index c37a5193f199..592e65c3a4e0 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -173,6 +173,8 @@
>  
>  		sound0_master: simple-audio-card,codec {
>  			sound-dai = <&tlv320aic3104>;
> +			assigned-clocks = <&clkoutmux2_clk_mux>;
> +			assigned-clock-parents = <&sys_clk2_dclk_div>;
>  			clocks = <&clkout2_clk>;
>  		};
>  	};
> @@ -795,6 +797,8 @@
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&mcasp3_pins_default>;
>  	pinctrl-1 = <&mcasp3_pins_sleep>;
> +	assigned-clocks = <&mcasp3_ahclkx_mux>;
> +	assigned-clock-parents = <&sys_clkin2>;
>  	status = "okay";
>  
>  	op-mode = <0>;	/* MCASP_IIS_MODE */
> -- 
> 2.7.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
