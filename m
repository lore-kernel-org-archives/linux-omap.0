From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv4 4/4] DTS: ARM: OMAP3-N900: Add tsc2005 support
Date: Wed, 21 May 2014 15:19:55 -0700
Message-ID: <20140521221955.GC14520@atomide.com>
References: <1400693774-21306-1-git-send-email-sre@kernel.org>
 <1400693774-21306-5-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400693774-21306-5-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [140521 10:38]:
> This adds support for the tsc2005 touchscreen
> to the Nokia N900 DTS file.
> 
> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Dmitry, if no other comments, feel free to pick this one too.
This does not seem to conflict with anything I have queued:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> ---
>  arch/arm/boot/dts/omap3-n900.dts | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 1a57b61..cb8ed2d5 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -580,9 +580,24 @@
>  	 * Also... order in the device tree actually matters here.
>  	 */
>  	tsc2005@0 {
> -		compatible = "tsc2005";
> +		compatible = "ti,tsc2005";
>  		spi-max-frequency = <6000000>;
>  		reg = <0>;
> +
> +		vio-supply = <&vio>;
> +
> +		reset-gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>; /* 104 */
> +		interrupts-extended = <&gpio4 4 IRQ_TYPE_EDGE_RISING>; /* 100 */
> +
> +		touchscreen-fuzz-x = <4>;
> +		touchscreen-fuzz-y = <7>;
> +		touchscreen-fuzz-pressure = <2>;
> +		touchscreen-max-x = <4096>;
> +		touchscreen-max-y = <4096>;
> +		touchscreen-max-pressure = <2048>;
> +
> +		ti,x-plate-ohms = <280>;
> +		ti,esd-recovery-timeout-ms = <8000>;
>  	};
>  
>  	acx565akm@2 {
> -- 
> 2.0.0.rc2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
