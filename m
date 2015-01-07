From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
Date: Wed, 7 Jan 2015 15:44:42 -0800
Message-ID: <20150107234442.GI13010@atomide.com>
References: <1417800739-13146-1-git-send-email-nm@ti.com>
 <1417801732-24620-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417801732-24620-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [141205 09:51]:
> TPS gpio now controls a 5v 500mA TL5209 regulator which may be supply
> a fan (such as AFB02505HHB) over J1 connector for various purposes.
> Provide device tree node to enable the same.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applying into omap-for-v3.20/dt thanks.

Tony

> ---
> 
> V2: review comment updates
> 	review comments update
> 		- Sanitized outlook-ified name back to normal ;) 
> 		- removed unnecessary pinctrl-names property.
> V1: https://patchwork.kernel.org/patch/5444911/
> 
> 
> Depends on the following:
> https://patchwork.kernel.org/patch/5439201/
> https://patchwork.kernel.org/patch/5439191/
> 
> enable and disable can be controlled by (post the RPM, it finds
> closest match - even a 1 will do)
> 
> echo '13000' > /sys/class/hwmon/hwmon0/fan1_target
> and
> echo '0' > /sys/class/hwmon/hwmon0/fan1_target
> 
> Test log: http://slexy.org/view/s2T0ajh46z
> 
> requires CONFIG_GPIO_PALMAS and CONFIG_SENSORS_GPIO_FAN to be operational
> Applies on 
> https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.19/dt-v2
> 
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index 49edbda..4e55e94 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -80,6 +80,14 @@
>  			default-state = "off";
>  		};
>  	};
> +
> +	gpio_fan {
> +		/* Based on 5v 500mA AFB02505HHB */
> +		compatible = "gpio-fan";
> +		gpios =  <&tps659038_gpio 1 GPIO_ACTIVE_HIGH>;
> +		gpio-fan,speed-map = <0    0
> +				      13000 1>;
> +	};
>  };
>  
>  &dra7_pmx_core {
> @@ -314,6 +322,12 @@
>  			wakeup-source;
>  			ti,palmas-long-press-seconds = <12>;
>  		};
> +
> +		tps659038_gpio: tps659038_gpio {
> +			compatible = "ti,palmas-gpio";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
>  	};
>  
>  	tmp102: tmp102@48 {
> -- 
> 1.7.9.5
> 
