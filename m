From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: dts: am4372: setup rtc as system-power-controller
Date: Wed, 8 Aug 2018 02:06:07 -0700
Message-ID: <20180808090607.GR99251@atomide.com>
References: <1532498135-9031-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532498135-9031-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180725 05:59]:
> RTC alarm2 is connected to pmic_en line and hence can be used to control
> the pmic enabling/disabling. Hence add the system-power-controller for rtc
> node.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index f0cbd86..d4b7c59 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -469,6 +469,7 @@
>  			ti,hwmods = "rtc";
>  			clocks = <&clk_32768_ck>;
>  			clock-names = "int-clk";
> +			system-power-controller;
>  			status = "disabled";
>  		};
>  

Should this be queued as a fix for v4.19-rc series?

Regards,

Tony
