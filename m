From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Thu, 12 Sep 2019 23:12:18 +0200
Message-ID: <51bb8890-bfd7-c241-1ce5-151df3a90513@linaro.org>
References: <20190912183037.18449-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190912183037.18449-1-aford173@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>, linux-omap@vger.kernel.org
Cc: hns@goldelico.com, tony@atomide.com, neolynx@gmail.com, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, andreas@kemnade.info, nm@ti.com, adam.ford@logicpd.com
List-Id: linux-omap@vger.kernel.org

On 12/09/2019 20:30, Adam Ford wrote:
> The thermal sensor in the omap3 family isn't accurate, but it's
> better than nothing.  The various OPP's enabled for the omap3630
> support up to OPP1G, however the datasheet for the DM3730 states
> that OPP130 and OPP1G are not available above TJ of 90C.
> 
> This patch configures the thermal throttling to limit the
> operating points of the omap3630 to Only OPP50 and OPP100 if
> the thermal sensor reads a value above 90C.

Out of curiosity, what are the OPP50 and OPP100 mentioned above? and
what does mean "OPP130 and OPP1G are not available above TJ of 90C"?

I don't see the connection between these OPP names and the definition in
the DT.

> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> index 4bb4f534afe2..58b9d347019f 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -25,6 +25,7 @@
>  
>  			vbb-supply = <&abb_mpu_iva>;
>  			clock-latency = <300000>; /* From omap-cpufreq driver */
> +			#cooling-cells = <2>;
>  		};
>  	};
>  
> @@ -195,6 +196,31 @@
>  	};
>  };
>  
> +&cpu_thermal {
> +	cpu_trips: trips {
> +		/* OPP130 and OPP1G are not available above TJ of 90C. */
> +		cpu_alert0: cpu_alert {
> +			temperature = <90000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "passive";
> +		};
> +
> +		cpu_crit: cpu_crit {
> +			temperature = <125000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "critical";
> +		};
> +	};
> +
> +	cpu_cooling_maps: cooling-maps {
> +		map0 {
> +			trip = <&cpu_alert0>;
> +			/* Only allow OPP50 and OPP100 */
> +			cooling-device = <&cpu 0 1>;
> +		};
> +	};
> +};
> +
>  /* OMAP3630 needs dss_96m_fck for VENC */
>  &venc {
>  	clocks = <&dss_tv_fck>, <&dss_96m_fck>;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
