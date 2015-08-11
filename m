From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 2/6] rtc: omap: Add external clock enabling support
Date: Tue, 11 Aug 2015 16:00:54 +0200
Message-ID: <20150811140054.GM3411@piout.net>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
 <1439198906-31189-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439198906-31189-3-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This seems better but:

On 10/08/2015 at 14:58:22 +0530, Keerthy wrote :
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index d99b2ee..756819f 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -336,6 +336,8 @@
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
>  				      GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
>  			ti,hwmods = "rtc";
> +			clocks = <&clk_32768_ck>, <&clk_32k_rtc>;
> +			clock-names = "int-clk", "ext-clk";
>  			status = "disabled";
>  		};
>  

This change has to be part of another patch.

> @@ -698,6 +706,7 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
>  static int omap_rtc_suspend(struct device *dev)
>  {
>  	struct omap_rtc *rtc = dev_get_drvdata(dev);
> +	u8 reg;
>  
>  	rtc->interrupts_reg = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>  
> @@ -711,6 +720,18 @@ static int omap_rtc_suspend(struct device *dev)
>  		enable_irq_wake(rtc->irq_alarm);
>  	else
>  		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
> +
> +	/*
> +	 * If we have the luxury of external clock then
> +	 * Switch to external clock so we can keep ticking
> +	 * acorss suspend
> +	 */
> +	if (rtc->has_ext_clk) {
> +		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
> +		rtc_write(rtc, OMAP_RTC_OSC_REG, reg |
> +			  OMAP_RTC_OSC_SEL_32KCLK_SRC);
> +	}
> +

You should probably prepare/enable the clock before switching to it. I
know it doesn't matter right now but that may not be the case on other
boards.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
