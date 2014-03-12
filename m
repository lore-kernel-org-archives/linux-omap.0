From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: cm-t3530: Add MMC2/SDIO/WLAN support
Date: Wed, 12 Mar 2014 10:44:24 -0700
Message-ID: <20140312174423.GC1996@atomide.com>
References: <1394621352-32438-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53351 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbaCLRob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 13:44:31 -0400
Content-Disposition: inline
In-Reply-To: <1394621352-32438-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dmitry Lifshitz <lifshitz@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>

* Stefan Roese <sr@denx.de> [140312 03:52]:
> Add support for the MMC2/SDIO WiFi Libertas (Marvell) module available
> on the CM-T3530 SOM.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> This patch is based on current mainline (v3.14-rc6) plus this compulab patch
> series from Dmitry:
> 
> [PATCH 00/11] ARM: dts: sbc-t3x: add support for more boards
> http://www.spinics.net/lists/arm-kernel/msg300078.html

Thanks applying into omap-for-v3.15/dt, no guarantees it gets merged though
as it's getting so close to the merge window.

Regards,

Tony

>  arch/arm/boot/dts/omap3-cm-t3530.dts | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-cm-t3530.dts b/arch/arm/boot/dts/omap3-cm-t3530.dts
> index 9faf1cd..d145849 100644
> --- a/arch/arm/boot/dts/omap3-cm-t3530.dts
> +++ b/arch/arm/boot/dts/omap3-cm-t3530.dts
> @@ -9,4 +9,40 @@
>  / {
>  	model = "CompuLab CM-T3530";
>  	compatible = "compulab,omap3-cm-t3530", "ti,omap34xx", "ti,omap3";
> +
> +	/* Regulator to trigger the reset signal of the Wifi module */
> +	mmc2_sdio_reset: regulator-mmc2-sdio-reset {
> +		compatible = "regulator-fixed";
> +		regulator-name = "regulator-mmc2-sdio-reset";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&twl_gpio 2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +&omap3_pmx_core {
> +	mmc2_pins: pinmux_mmc2_pins {
> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_clk.sdmmc2_clk */
> +			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_cmd.sdmmc2_cmd */
> +			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat0.sdmmc2_dat0 */
> +			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
> +			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat2.sdmmc2_dat2 */
> +			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat3.sdmmc2_dat3 */
> +			OMAP3_CORE1_IOPAD(0x2164, PIN_OUTPUT | MUX_MODE1)		/* sdmmc2_dat4.sdmmc2_dir_dat0 */
> +			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE1)		/* sdmmc2_dat5.sdmmc2_dir_dat1 */
> +			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE1)		/* sdmmc2_dat6.sdmmc2_dir_cmd */
> +			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE1)		/* sdmmc2_dat7.sdmmc2_clkin */
> +		>;
> +	};
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_pins>;
> +	vmmc-supply = <&mmc2_sdio_reset>;
> +	non-removable;
> +	bus-width = <4>;
> +	cap-power-off-card;
>  };
> -- 
> 1.8.5.5
> 
