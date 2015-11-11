From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH 4/6] ARM: OMAP2+: dts: cm-t335: add support for MMC
Date: Wed, 11 Nov 2015 19:33:06 +0200
Message-ID: <56437BD2.7070404@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1445948100-16446-5-git-send-email-uri.mashiach@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445948100-16446-5-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, igor.grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Gentle ping

On 27/10/15 14:14, Uri Mashiach wrote:
> From: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>
> Add pinmux configuration for MMC0 pins.
> Add fixed regulator 'vmmc_fixed'.
> Enable MMC0 in 4-bit mode.
>
> Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Signed-off-by: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> ---
>   arch/arm/boot/dts/am335x-cm-t335.dts | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
> index 9d6117a..976c330 100644
> --- a/arch/arm/boot/dts/am335x-cm-t335.dts
> +++ b/arch/arm/boot/dts/am335x-cm-t335.dts
> @@ -31,6 +31,14 @@
>   			linux,default-trigger = "heartbeat";
>   		};
>   	};
> +
> +	/* regulator for mmc */
> +	vmmc_fixed: fixedregulator@0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmc_fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
>   };
>
>   &am33xx_pinmux {
> @@ -104,6 +112,23 @@
>   			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)
>   		>;
>   	};
> +
> +	mmc1_pins: pinmux_mmc1_pins {
> +		pinctrl-single,pins = <
> +			/* mmc0_dat3.mmc0_dat3 */
> +			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* mmc0_dat2.mmc0_dat2 */
> +			0xf4 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* mmc0_dat1.mmc0_dat1 */
> +			0xf8 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* mmc0_dat0.mmc0_dat0 */
> +			0xfc (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* mmc0_clk.mmc0_clk */
> +			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* mmc0_cmd.mmc0_cmd */
> +			0x104 (PIN_INPUT_PULLUP | MUX_MODE0)
> +		>;
> +	};
>   };
>
>   &uart0 {
> @@ -203,3 +228,11 @@
>   	status = "okay";
>   };
>
> +&mmc1 {
> +	status = "okay";
> +	vmmc-supply = <&vmmc_fixed>;
> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;
> +};
> +
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
