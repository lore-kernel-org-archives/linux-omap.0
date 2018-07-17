From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 1/4] ARM: dts: am33xx: Add all fck timer clocks
Date: Mon, 16 Jul 2018 22:55:47 -0700
Message-ID: <20180717055547.GV99251@atomide.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
 <1531773542-15736-2-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531773542-15736-2-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: daniel.lezcano@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, aford173@gmail.com, drivshin@awxrd.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Neil Armstrong <narmstrong@baylibre.com> [180716 20:42]:
> Add the missing fck clock to all timer nodes of the AM33XX dtsi.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 9cd62bc2..e8e665d 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -541,6 +541,8 @@
>  			reg = <0x48042000 0x400>;
>  			interrupts = <69>;
>  			ti,hwmods = "timer3";
> +			clocks = <&timer3_fck>;
> +			clock-names = "fck";
>  		};

These should all use the clkctrl clock nodes, see:

$ git grep CLKCTRL include/dt-bindings/clock/ | grep TIMER

The module clock is bit 0, and on some SoCs bit 24 is the
timer fck. But I don't think these SoS use separate bit 24
clock.

Regards,

Tony
