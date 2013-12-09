From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2 09/10] arm: dts: dra7: Add qspi device.
Date: Mon, 9 Dec 2013 09:42:04 -0800
Message-ID: <20131209174203.GB12527@atomide.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
 <1386339891-32717-10-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386339891-32717-10-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org> [131206 06:29]:
> These add device tree entry for qspi controller driver on dra7.

FYI these .dts changes need to be queued separately by Benoit and
should be posted as a seprate series in general to avoid confusion.

Regards,

Tony
 
> Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> ---
> v1->v2:
> use "MUX_MODE1" instead of numeric value
>  arch/arm/boot/dts/dra7-evm.dts |   32 ++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi    |   13 +++++++++++++
>  2 files changed, 45 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 5babba0..4a57fdf 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -93,6 +93,21 @@
>  			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd */
>  		>;
>  	};
> +
> +	qspi1_pins: pinmux_qspi1_pins {
> +		pinctrl-single,pins = <
> +			0x4c (PIN_INPUT | MUX_MODE1)  /* gpmc_a3.qspi1_cs2 */
> +			0x50 (PIN_INPUT | MUX_MODE1)  /* gpmc_a4.qspi1_cs3 */
> +			0x74 (PIN_INPUT | MUX_MODE1)  /* gpmc_a13.qspi1_rtclk */
> +			0x78 (PIN_INPUT | MUX_MODE1)  /* gpmc_a14.qspi1_d3 */
> +			0x7c (PIN_INPUT | MUX_MODE1)  /* gpmc_a15.qspi1_d2 */
> +			0x80 (PIN_INPUT | MUX_MODE1) /* gpmc_a16.qspi1_d1 */
> +			0x84 (PIN_INPUT | MUX_MODE1)  /* gpmc_a17.qspi1_d0 */
> +			0x88 (PIN_INPUT | MUX_MODE1)  /* qpmc_a18.qspi1_sclk */
> +			0xb8 (PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs2.qspi1_cs0 */
> +			0xbc (PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs3.qspi1_cs1 */
> +		>;
> +	};
>  };
>  
>  &i2c1 {
> @@ -273,3 +288,20 @@
>  &cpu0 {
>  	cpu0-supply = <&smps123_reg>;
>  };
> +
> +&qspi {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qspi1_pins>;
> +
> +	spi-max-frequency = <48000000>;
> +	m25p80@0 {
> +		compatible = "s25fl256s1";
> +		spi-max-frequency = <48000000>;
> +		reg = <0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-cpol;
> +		spi-cpha;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 67275c8..b06d899 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -582,6 +582,19 @@
>  			dma-names = "tx0", "rx0";
>  			status = "disabled";
>  		};
> +
> +		qspi: qspi@4b300000 {
> +			compatible = "ti,dra7xxx-qspi";
> +			reg = <0x4b300000 0x100>, <0x4a002558 0x4>,
> +					<0x5c000000 0x3ffffff>;
> +			reg-names = "qspi_base", "qspi_ctrlmod", "qspi_mmap";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "qspi";
> +			num-cs = <4>;
> +			interrupts = <0 124 0x4>;
> +			status = "disabled";
> +		};
>  	};
>  
>  	clocks {
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
