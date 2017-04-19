From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 03/21] ARM: dts: omap: Add generic compatible string
 for I2C EEPROM
Date: Wed, 19 Apr 2017 18:56:46 -0500
Message-ID: <20170419235646.j6cc3vm7eru6buv6@rob-hp-laptop>
References: <20170414010445.21727-1-javier@osg.samsung.com>
 <20170414010445.21727-4-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170414010445.21727-4-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 13, 2017 at 10:04:27PM -0300, Javier Martinez Canillas wrote:
> The at24 driver allows to register I2C EEPROM chips using different vendor
> and devices, but the I2C subsystem does not take the vendor into account
> when matching using the I2C table since it only has device entries.
> 
> But when matching using an OF table, both the vendor and device has to be
> taken into account so the driver defines only a set of compatible strings
> using the "atmel" vendor as a generic fallback for compatible I2C devices.
> 
> So add this generic fallback to the device node compatible string to make
> the device to match the driver using the OF device ID table.
> 
> Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/boot/dts/am335x-baltos.dtsi            |  2 +-
>  arch/arm/boot/dts/am335x-base0033.dts           |  2 +-
>  arch/arm/boot/dts/am335x-bone-common.dtsi       | 10 +++++-----
>  arch/arm/boot/dts/am335x-nano.dts               |  2 +-
>  arch/arm/boot/dts/am335x-pepper.dts             |  2 +-
>  arch/arm/boot/dts/am335x-shc.dts                |  2 +-
>  arch/arm/boot/dts/am335x-sl50.dts               |  2 +-
>  arch/arm/boot/dts/am437x-idk-evm.dts            |  2 +-
>  arch/arm/boot/dts/am437x-sk-evm.dts             |  2 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts            |  2 +-
>  arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  2 +-
>  arch/arm/boot/dts/omap3-cm-t3x.dtsi             |  2 +-
>  arch/arm/boot/dts/omap3-gta04.dtsi              |  2 +-
>  arch/arm/boot/dts/omap3-sb-t35.dtsi             |  2 +-
>  arch/arm/boot/dts/omap4-var-som-om44.dtsi       |  2 +-
>  arch/arm/boot/dts/omap5-cm-t54.dts              |  2 +-
>  arch/arm/boot/dts/omap5-sbc-t54.dts             |  2 +-
>  17 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
> index d42b98f15e8b..6ca780d0623f 100644
> --- a/arch/arm/boot/dts/am335x-baltos.dtsi
> +++ b/arch/arm/boot/dts/am335x-baltos.dtsi
> @@ -255,7 +255,7 @@
>  	};
>  
>  	at24@50 {
> -		compatible = "at24,24c02";
> +		compatible = "at24,24c02", "atmel,24c02";

I think you can just drop the at24 compatibles. A new kernel doesn't 
need it. An old kernel ignores the manufacturer. I checked that u-boot 
only matches on "atmel,*", so okay there. Don't know about the *BSDs. I 
couldn't find anything.

Minimally, the deprecated compatible should come last.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
