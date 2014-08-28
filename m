From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] arm: omap3: Add Technexion TAO3530 SOM
 omap3-tao3530.dtsi
Date: Thu, 28 Aug 2014 11:07:58 -0700
Message-ID: <20140828180757.GJ16006@atomide.com>
References: <1409245829-3938-1-git-send-email-sr@denx.de>
 <1409245829-3938-2-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18512 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbaH1SIH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2014 14:08:07 -0400
Content-Disposition: inline
In-Reply-To: <1409245829-3938-2-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>, Tapani Utriainen <tapani@technexion.com>

* Stefan Roese <sr@denx.de> [140828 10:10]:
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
...

> +&omap3_pmx_core {
> +	hsusbb2_pins: pinmux_hsusbb2_pins {
> +		pinctrl-single,pins = <
> +			0x5c0 (PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
> +			0x5c2 (PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
> +			0x5c4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
> +			0x5c6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
> +			0x5c8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
> +			0x5cA (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
> +			0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
> +			0x1a6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
> +			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
> +			0x1aa (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_somi.hsusb2_data5 */
> +			0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs0.hsusb2_data6 */
> +			0x1ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 */
> +		>;
> +	};
> +
> +	mmc1_pins: pinmux_mmc1_pins {
> +		pinctrl-single,pins = <
> +			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
> +			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
> +			0x118 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0.sdmmc1_dat0 */
> +			0x11a (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat1.sdmmc1_dat1 */
> +			0x11c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat2.sdmmc1_dat2 */
> +			0x11e (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat3.sdmmc1_dat3 */
> +			0x120 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat4.sdmmc1_dat4 */
> +			0x122 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat5.sdmmc1_dat5 */
> +			0x124 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat6.sdmmc1_dat6 */
> +			0x126 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat7.sdmmc1_dat7 */
> +		>;
> +	};
> +
> +	mmc2_pins: pinmux_mmc2_pins {
> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_clk.sdmmc2_clk */
> +			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_cmd.sdmmc2_cmd */
> +			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat0.sdmmc2_dat0 */
> +			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
> +			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat2.sdmmc2_dat2 */
> +			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat3.sdmmc2_dat3 */
> +		>;
> +	};

Can you please use the macros above as well for the other mux
entries like you do here?

> +&gpmc {

Aren't you missing the ranges entry here for the GPMC
CS mapping? AFAIK it should be just the minimal 16 MB
range.

> +	nand@0,0 {
> +		reg = <0 0 0>; /* CS0, offset 0 */
> +		nand-bus-width = <16>;
...

Regards,

Tony
