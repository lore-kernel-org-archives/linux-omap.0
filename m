From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/5] ARM: dts: AM33XX: Add ecap interrupt properties
Date: Fri, 28 Feb 2014 14:43:07 -0800
Message-ID: <20140228224307.GP13624@atomide.com>
References: <1391029199-3670-1-git-send-email-mporter@linaro.org>
 <1391029199-3670-6-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391029199-3670-6-git-send-email-mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linaro Patches <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [140129 13:02]:
> Add missing interrupt properties to the ecap0, ecap1, and ecap2
> nodes.
> 
> Signed-off-by: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Thanks taking this patch only into omap-for-v3.15/dt, the rest
should go via the driver mailing lists.

Regards,

Tony

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 6d95d3d..b4139ba 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -582,6 +582,8 @@
>  				compatible = "ti,am33xx-ecap";
>  				#pwm-cells = <3>;
>  				reg = <0x48300100 0x80>;
> +				interrupts = <31>;
> +				interrupt-names = "ecap0";
>  				ti,hwmods = "ecap0";
>  				status = "disabled";
>  			};
> @@ -610,6 +612,8 @@
>  				compatible = "ti,am33xx-ecap";
>  				#pwm-cells = <3>;
>  				reg = <0x48302100 0x80>;
> +				interrupts = <47>;
> +				interrupt-names = "ecap1";
>  				ti,hwmods = "ecap1";
>  				status = "disabled";
>  			};
> @@ -638,6 +642,8 @@
>  				compatible = "ti,am33xx-ecap";
>  				#pwm-cells = <3>;
>  				reg = <0x48304100 0x80>;
> +				interrupts = <61>;
> +				interrupt-names = "ecap2";
>  				ti,hwmods = "ecap2";
>  				status = "disabled";
>  			};
> -- 
> 1.8.4
> 
