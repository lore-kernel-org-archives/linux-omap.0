From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 1/3] ARM: DTS: OMAP3: beagle/overo: mux console UART,
 enable wakeup
Date: Mon, 03 Jun 2013 11:36:31 +0200
Message-ID: <51AC639F.3040504@epfl.ch>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org> <1370040357-25794-2-git-send-email-khilman@linaro.org>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:36913 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754363Ab3FCJgi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jun 2013 05:36:38 -0400
In-Reply-To: <1370040357-25794-2-git-send-email-khilman@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Kevin,

On 06/01/2013 12:45 AM, Kevin Hilman wrote:
> Ensure the console uart (UART3) on these boards is mux'd correctly, and
> IO ring wakeup is enabled.
>
> This is needed for serial console wakeups when using DT boot.
>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
>   arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++++++
>   arch/arm/boot/dts/omap3-beagle.dts    | 12 ++++++++++++
>   arch/arm/boot/dts/omap3-overo.dtsi    | 14 ++++++++++++++
>   3 files changed, 40 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index 3046d1f..ca067b0 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -126,3 +126,17 @@
>   	mode = <3>;
>   	power = <50>;
>   };
> +
> +&omap3_pmx_core {
> +	uart3_pins: pinmux_uart3_pins {
> +		pinctrl-single,pins = <
> +			0x16e 0x4100	/* uart3_rx_irrx.uart3_rx_irrx WAKEUP | INPUT | MODE0 */
> +			0x170 0x0	/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */

If you go through Benoit's tree, could you use the newly introduced 
constants [1]? They are defined
in include/dt-bindings/pinctrl/omap.h. The above will look:

			0x16e (PIN_INPUT | WAKEUP_EVENT | MUX_MODE0)	/* 
uart3_rx_irrx.uart3_rx_irrx */
			0x170 (PIN_OUTPUT | MUX_MODE0)			/* uart3_tx_irtx.uart3_tx_irtx */

> +		>;
> +	};
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart3_pins>;
> +};
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 6eec699..b004372 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -95,6 +95,13 @@
>   			0x1ae 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 INPUT | PULLDOWN */
>   		>;
>   	};
> +
> +	uart3_pins: pinmux_uart3_pins {
> +		pinctrl-single,pins = <
> +			0x16e 0x4100	/* uart3_rx_irrx.uart3_rx_irrx WAKEUP | INPUT | MODE0 */
> +			0x170 0x0	/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */

Same here

> +		>;
> +	};
>   };
>
>   &i2c1 {
> @@ -142,3 +149,8 @@
>   	 */
>   	ti,pulldowns = <0x03a1c4>;
>   };
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart3_pins>;
> +};
> diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
> index a626c50..d63ed39 100644
> --- a/arch/arm/boot/dts/omap3-overo.dtsi
> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
> @@ -77,3 +77,17 @@
>   	mode = <3>;
>   	power = <50>;
>   };
> +
> +&omap3_pmx_core {
> +	uart3_pins: pinmux_uart3_pins {
> +		pinctrl-single,pins = <
> +			0x16e 0x4100	/* uart3_rx_irrx.uart3_rx_irrx WAKEUP | INPUT | MODE0 */
> +			0x170 0x0	/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */

Same here

> +		>;
> +	};
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart3_pins>;
> +};
>

Regards,

Florian

[1] http://thread.gmane.org/gmane.linux.drivers.devicetree/36951
