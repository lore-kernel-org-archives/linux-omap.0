From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: dts: sbc-t3x: add DVI display data
Date: Tue, 21 Oct 2014 12:32:37 +0300
Message-ID: <54462835.9010908@compulab.co.il>
References: <1413364186-23752-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:54110 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754394AbaJUJck (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Oct 2014 05:32:40 -0400
In-Reply-To: <1413364186-23752-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>, =?ISO-8859-1?Q?Beno=EEt_?= =?ISO-8859-1?Q?Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Dmitry,

On 10/15/14 12:09, Dmitry Lifshitz wrote:
> Add DSS related pinmux and display data nodes required to support
> DVI video out on SBC-T3530, SBC-T3730 and SBC-T3517.
> 
> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
> ---
>  arch/arm/boot/dts/omap3-cm-t3517.dts  |   22 +++++++++++++++
>  arch/arm/boot/dts/omap3-cm-t3530.dts  |   22 +++++++++++++++
>  arch/arm/boot/dts/omap3-cm-t3730.dts  |   24 ++++++++++++++++
>  arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   28 +++++++++++++++++++
>  arch/arm/boot/dts/omap3-sb-t35.dtsi   |   49 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-sbc-t3517.dts |   14 +++++++++
>  arch/arm/boot/dts/omap3-sbc-t3530.dts |   14 +++++++++
>  arch/arm/boot/dts/omap3-sbc-t3730.dts |   14 +++++++++
>  8 files changed, 187 insertions(+), 0 deletions(-)

[...]

> diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/omap3-cm-t3730.dts
> index b3f9a50..4b36d80 100644
> --- a/arch/arm/boot/dts/omap3-cm-t3730.dts
> +++ b/arch/arm/boot/dts/omap3-cm-t3730.dts
> @@ -31,6 +31,19 @@
>  	};
>  };
>  
> +&omap3_pmx_wkup {
> +	dss_dpi_pins_cm_t3730: pinmux_dss_dpi_pins_cm_t3730 {
> +		pinctrl-single,pins = <
> +			0x0a (PIN_OUTPUT | MUX_MODE3)   /* sys_boot0.dss_data18 */
> +			0x0c (PIN_OUTPUT | MUX_MODE3)   /* sys_boot1.dss_data19 */
> +			0x10 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot3.dss_data20 */
> +			0x12 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot4.dss_data21 */
> +			0x14 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot5.dss_data22 */
> +			0x16 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot6.dss_data23 */

Can't you use macros here as well?

> +		>;
> +	};
> +};
> +

[...]

> diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
> index c671a22..6b6c2f4 100644
> --- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
> +++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
> @@ -76,6 +76,34 @@
>  			OMAP3_CORE1_IOPAD(0x21e2, PIN_OUTPUT | MUX_MODE4)	/* sys_clkout2.gpio_186 */
>  		>;
>  	};
> +
> +	dss_dpi_pins_common: pinmux_dss_dpi_pins_common {
> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)	/* dss_pclk.dss_pclk */
> +			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)	/* dss_hsync.dss_hsync */
> +			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)	/* dss_vsync.dss_vsync */
> +			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)	/* dss_acbias.dss_acbias */
> +
> +			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)	/* dss_data6.dss_data6 */
> +			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)	/* dss_data7.dss_data7 */
> +			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)	/* dss_data8.dss_data8 */
> +			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)	/* dss_data9.dss_data9 */
> +			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)	/* dss_data10.dss_data10 */
> +			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)	/* dss_data11.dss_data11 */
> +			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)	/* dss_data12.dss_data12 */
> +			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)	/* dss_data13.dss_data13 */
> +			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)	/* dss_data14.dss_data14 */
> +			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)	/* dss_data15.dss_data15 */
> +			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE0)	/* dss_data16.dss_data16 */
> +			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE0)	/* dss_data17.dss_data17 */
> +			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE0)	/* dss_data18.dss_data18 */
> +			OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT | MUX_MODE0)	/* dss_data19.dss_data19 */
> +			OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MODE0)	/* dss_data20.dss_data20 */
> +			OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE0)	/* dss_data21.dss_data21 */
> +			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE0)	/* dss_data22.dss_data22 */
> +			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)	/* dss_data23.dss_data23 */
> +		>;
> +	};

I would also define the second set of pins used for cm-t3530 and cm-t3517 here.
So you will not have to duplicate them too.

[...]


-- 
Regards,
Igor.
