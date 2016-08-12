From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: am335x-icev2: Add nodes for gpio-decoder
Date: Fri, 12 Aug 2016 14:00:31 -0500
Message-ID: <20160812190031.GA16954@rob-hp-laptop>
References: <20160812045229.29241-1-vigneshr@ti.com>
 <20160812045229.29241-3-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160812045229.29241-3-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>, Daniel Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 12, 2016 at 10:22:29AM +0530, Vignesh R wrote:
> AM335x ICE board has a rotary-switch connected to PCA9536 I2C GPIO
> expander. The position of the rotary-switch is reflected by status of
> GPIO lines. Add gpio-decoder node to read these GPIO line status via
> gpio-decoder driver and report it as an input event to the system.
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-icev2.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
> index 7d8b8fefdf08..f2de594343f2 100644
> --- a/arch/arm/boot/dts/am335x-icev2.dts
> +++ b/arch/arm/boot/dts/am335x-icev2.dts
> @@ -139,6 +139,15 @@
>  			default-state = "off";
>  		};
>  	};
> +	gpio-decoder0 {

Drop the 0 here.

> +		compatible = "gpio-decoder";
> +		gpios = <&pca9536 3 GPIO_ACTIVE_HIGH>,
> +			<&pca9536 2 GPIO_ACTIVE_HIGH>,
> +			<&pca9536 1 GPIO_ACTIVE_HIGH>,
> +			<&pca9536 0 GPIO_ACTIVE_HIGH>;
> +		linux,axis = <0>; /* ABS_X */
> +		gpio-decoder,max-value = <9>;
> +	};
>  };
>  
>  &am33xx_pinmux {
> -- 
> 2.9.2
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
