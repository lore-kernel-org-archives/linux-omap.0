From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for
 devconf1 register
Date: Mon, 10 Nov 2014 15:36:31 -0800
Message-ID: <20141110233630.GD31454@atomide.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-5-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415051968-4878-5-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, linux@arm.linux.org.uk, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

* Marek Belisko <marek@goldelico.com> [141103 14:01]:
> gta04 board need for tvout enabled 2 bits in devconf1 register (tvbypass and acbias).
> Add single pinmux entry and enable it.
> 
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index e4d05f0..a456d37 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -118,6 +118,17 @@
>  			};
>  		};
>  	};
> +
> +	/* pinmux for devconf1 */
> +	control_devconf1: pinmux@480022d8 {
> +		compatible = "pinctrl-single";
> +		reg = <0x480022d8 4>;	/* single register */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-single,bit-per-mux;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xfc0bd5>;
> +	};
>  };
>  

The pinctrl-single entry should be in omap3.dtsi as the mux register is there
for all the omap3 devices, can you please update the patch for that?

Regards,

Tony

>  &omap3_pmx_core {
> @@ -497,3 +508,14 @@
>  		};
>  	};
>  };
> +
> +&control_devconf1 {
> +	pinctrl-name = "default";
> +	pinctrl-0 = < &tv_acbias_pins>;
> +
> +	tv_acbias_pins: pinmux_tv_acbias_pins {
> +		pinctrl-single,bits = <
> +			0 0x40800 0x40800
> +		>;
> +	};
> +};
> -- 
> 1.9.1
> 
