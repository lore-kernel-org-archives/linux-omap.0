From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: igep0020: Add SD card write-protect pin.
Date: Fri, 13 May 2016 14:37:18 +0200
Message-ID: <20160513123718.GA2841@localhost.localdomain>
References: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com>
 <1462568554-7868-2-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462568554-7868-2-git-send-email-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Enric!

On Fri, May 06, 2016 at 11:02:34PM +0200, Enric Balletbo i Serra wrote:
> A host device that supports write protection should refuse to write to
> an SD card that is designated read-only when write-protect is set. This
> is an optional feature of the SD specification.

Does it ever work on any IGEPv2? I have similar patch in my repo and there
is no difference when enabling write protection on SD card. Also schemantics
shows GPIO29 constantly pulled up with a resistor. Is there any board
revision with working WP? I'm just curious as patch is of course correct.

Best regards,
	ladis

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap3-igep0020-common.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
> index d6f839c..b697106 100644
> --- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
> @@ -194,6 +194,12 @@
>  			OMAP3630_CORE2_IOPAD(0x25f8, PIN_OUTPUT | MUX_MODE4) /* etk_d14.gpio_28 */
>  		>;
>  	};
> +
> +	mmc1_wp_pins: pinmux_mmc1_cd_pins {
> +		pinctrl-single,pins = <
> +			OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT | MUX_MODE4)   /* etk_d15.gpio_29 */
> +		>;
> +	};
>  };
>  
>  &i2c3 {
> @@ -250,3 +256,8 @@
>  		};
>  	};
>  };
> +
> +&mmc1 {
> +	pinctrl-0 = <&mmc1_pins &mmc1_wp_pins>;
> +	wp-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;	/* gpio_29 */
> +};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
