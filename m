From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 6/6] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Thu, 17 Mar 2016 10:11:47 -0500
Message-ID: <20160317151147.GA29802@rob-hp-laptop>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-7-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457400224-24797-7-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 07, 2016 at 07:23:44PM -0600, Franklin S Cooper Jr wrote:
> From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> 
> Add PWMSS device tree nodes for DRA7 SoC family and add documentation
> for dt bindings.
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> [fcooper-l0cyMroinI0@public.gmane.org: Add eCAP and use updated bindings for PWMSS and ePWM]
> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> ---
> Version 5 changes:
> Add DT node for eCAP and update eCAP binding documentation
> 
> Version 4 changes:
> Updated link to the latest documentation
> 
>  .../devicetree/bindings/pwm/pwm-tiecap.txt         |  9 +++
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  9 +++
>  .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 15 +++-
>  arch/arm/boot/dts/dra7.dtsi                        | 84 ++++++++++++++++++++++
>  4 files changed, 116 insertions(+), 1 deletion(-)


> +			ehrpwm1: pwm@48440200 {
> +				compatible = "ti,dra7xx-ehrpwm",
> +					     "ti,am33xx-ehrpwm";
> +				#pwm-cells = <3>;
> +				reg = <0x48440200 0x80>;
> +				clocks = <&ehrpwm1_tbclk>;
> +				clock-names = "tbclk";
> +				status = "disabled";
> +			};
> +
> +			ecap1: ecap@48440100 {

This also is a PWM? Then it should also be pwm@...

> +				compatible = "ti,dra7xx-ecap",
> +					     "ti,am33xx-ecap";
> +				#pwm-cells = <3>;
> +				reg = <0x48440100 0x80>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		epwmss2: epwmss@48442000 {
> +			compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
> +			reg = <0x48442000 0x30>;
> +			ti,hwmods = "epwmss2";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			status = "disabled";
> +			ranges;
> +
> +			ehrpwm2: pwm@48442200 {
> +				compatible = "ti,dra7xx-ehrpwm",
> +					     "ti,am33xx-ehrpwm";
> +				#pwm-cells = <3>;
> +				reg = <0x48442200 0x80>;
> +				clocks = <&ehrpwm2_tbclk>;
> +				clock-names = "tbclk";
> +				status = "disabled";
> +			};
> +
> +			ecap2: ecap@48442100 {

And here.

> +				compatible = "ti,dra7xx-ecap",
> +					     "ti,am33xx-ecap";
> +				#pwm-cells = <3>;
> +				reg = <0x48442100 0x80>;
> +				status = "disabled";
> +			};
> +		};
>  	};
>  
>  	thermal_zones: thermal-zones {
> -- 
> 2.7.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
