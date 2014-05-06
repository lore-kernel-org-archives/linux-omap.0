From: sourav <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [Resend/PATCH] arm: dts: am43x-epos: Add qspi device.
Date: Tue, 6 May 2014 13:52:55 +0530
Message-ID: <53689BDF.5030208@ti.com>
References: <1398692550-31758-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398692550-31758-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Monday 28 April 2014 07:12 PM, Sourav Poddar wrote:
> This patch adds qspi nodes for am43xx SOC devices.
>
> Signed-off-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>

This patch has been posted many times before.
If this patch looks OK, can it be picked?
> ---
> Note,
> checpatch gives 1 warning on flash compatible string
> "mx66l51235l". This flash is supported in m25p80 driver and
> the driver is used for other flash devices also. Hence, each
> flash compatible is not described in[1], but a genric example
> is shown using spansion flash device.
> [1]:
> Documentation/devicetree/bindings/mtd/m25p80.txt
>
>   arch/arm/boot/dts/am4372.dtsi        |   11 ++++++
>   arch/arm/boot/dts/am43x-epos-evm.dts |   63 ++++++++++++++++++++++++++++++++++
>   2 files changed, 74 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 36d523a..49633ff 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -735,6 +735,17 @@
>   			#size-cells =<1>;
>   			status = "disabled";
>   		};
> +
> +		qspi: qspi@47900000 {
> +			compatible = "ti,am4372-qspi";
> +			reg =<0x47900000 0x100>;
> +			#address-cells =<1>;
> +			#size-cells =<0>;
> +			ti,hwmods = "qspi";
> +			interrupts =<0 138 0x4>;
> +			num-cs =<4>;
> +			status = "disabled";
> +		};
>   	};
>   };
>
> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
> index 167dbc8..25cd07c 100644
> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> @@ -138,6 +138,17 @@
>   				0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
>   			>;
>   		};
> +
> +		qspi1_default: qspi1_default {
> +			pinctrl-single,pins =<
> +				0x7c (PIN_INPUT_PULLUP | MUX_MODE3)
> +				0x88 (PIN_INPUT_PULLUP | MUX_MODE2)
> +				0x90 (PIN_INPUT_PULLUP | MUX_MODE3)
> +				0x94 (PIN_INPUT_PULLUP | MUX_MODE3)
> +				0x98 (PIN_INPUT_PULLUP | MUX_MODE3)
> +				0x9c (PIN_INPUT_PULLUP | MUX_MODE3)
> +			>;
> +		};
>   	};
>
>   	matrix_keypad: matrix_keypad@0 {
> @@ -367,3 +378,55 @@
>   	pinctrl-0 =<&spi1_pins>;
>   	status = "okay";
>   };
> +
> +&qspi {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 =<&qspi1_default>;
> +
> +	spi-max-frequency =<48000000>;
> +	m25p80@0 {
> +		compatible = "mx66l51235l";
> +		spi-max-frequency =<48000000>;
> +		reg =<0>;
> +		spi-cpol;
> +		spi-cpha;
> +		spi-tx-bus-width =<1>;
> +		spi-rx-bus-width =<4>;
> +		#address-cells =<1>;
> +		#size-cells =<1>;
> +
> +		/* MTD partition table.
> +		 * The ROM checks the first 512KiB
> +		 * for a valid file to boot(XIP).
> +		 */
> +		partition@0 {
> +			label = "QSPI.U_BOOT";
> +			reg =<0x00000000 0x000080000>;
> +		};
> +		partition@1 {
> +			label = "QSPI.U_BOOT.backup";
> +			reg =<0x00080000 0x00080000>;
> +		};
> +		partition@2 {
> +			label = "QSPI.U-BOOT-SPL_OS";
> +			reg =<0x00100000 0x00010000>;
> +		};
> +		partition@3 {
> +			label = "QSPI.U_BOOT_ENV";
> +			reg =<0x00110000 0x00010000>;
> +		};
> +		partition@4 {
> +			label = "QSPI.U-BOOT-ENV.backup";
> +			reg =<0x00120000 0x00010000>;
> +		};
> +		partition@5 {
> +			label = "QSPI.KERNEL";
> +			reg =<0x00130000 0x0800000>;
> +		};
> +		partition@6 {
> +			label = "QSPI.FILESYSTEM";
> +			reg =<0x00930000 0x36D0000>;
> +		};
> +	};
> +};

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
