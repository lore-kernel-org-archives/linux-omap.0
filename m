From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: boot: dts: am437x-idk: enable i2c2
Date: Mon, 16 Mar 2015 14:07:51 -0700
Message-ID: <20150316210750.GH12397@atomide.com>
References: <1424375858-26664-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:37838 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932851AbbCPVMk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 17:12:40 -0400
Content-Disposition: inline
In-Reply-To: <1424375858-26664-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [150219 12:02]:
> i2c2 goes to an expansion connector which we
> want to use.

Applying into omap-for-v4.1/dt thanks.

Tony
 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/boot/dts/am437x-idk-evm.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
> index 2471f1ebd4ed..22c2031dea17 100644
> --- a/arch/arm/boot/dts/am437x-idk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-idk-evm.dts
> @@ -133,6 +133,20 @@
>  		>;
>  	};
>  
> +	i2c2_pins_default: i2c2_pins_default {
> +		pinctrl-single,pins = <
> +			0x1e8 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3) /* cam1_data1.i2c2_scl */
> +			0x1ec (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3) /* cam1_data0.i2c2_sda */
> +		>;
> +	};
> +
> +	i2c2_pins_sleep: i2c2_pins_sleep {
> +		pinctrl-single,pins = <
> +			0x1e8 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> +			0x1ec (PIN_INPUT_PULLDOWN | MUX_MODE7)
> +		>;
> +	};
> +
>  	mmc1_pins_default: pinmux_mmc1_pins_default {
>  		pinctrl-single,pins = <
>  			0x100 (PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
> @@ -263,6 +277,14 @@
>  	};
>  };
>  
> +&i2c2 {
> +	status = "okay";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c2_pins_default>;
> +	pinctrl-1 = <&i2c2_pins_sleep>;
> +	clock-frequency = <100000>;
> +};
> +
>  &epwmss0 {
>  	status = "okay";
>  };
> -- 
> 2.3.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
