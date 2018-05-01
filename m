From: "Reizer, Eyal" <eyalr@ti.com>
Subject: RE: [EXTERNAL] [tiL4.14-CON PATCH v2] ARM: dts: am437x-sk-evm: add
   wilink8 support
Date: Tue, 1 May 2018 07:18:41 +0000
Message-ID: <72f9d7d4f85b4ebdb1d15a0a642c7a20@ti.com>
References: <1525158789-32255-1-git-send-email-eyalr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525158789-32255-1-git-send-email-eyalr@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eyal Reizer <eyalreizer@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "tony@atomide.com" <tony@atomide.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Please discard. Wrong patch header.
Will resend. Sorry about that.

>=20
> enable mmc3 used for wlan and uart1 used for bluetooth
> configure the gpios used for wlan and bluetooth controls
> add fixed voltage regulator used for wlan power control
>=20
> Signed-off-by: Eyal Reizer <eyalr@ti.com>
> ---
>  arch/arm/boot/dts/am437x-sk-evm.dts | 115
> ++++++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts
> b/arch/arm/boot/dts/am437x-sk-evm.dts
> index 16d9db0..afffdb1 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/pwm/pwm.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>=20
>  / {
>  	model =3D "TI AM437x SK EVM";
> @@ -158,6 +159,22 @@
>  			};
>  		};
>  	};
> +
> +	vmmcwl_fixed: fixedregulator-mmcwl {
> +		/*
> +		 * WL_EN is not SDIO standard compliant. It is an out of band
> +		 * signal and hard to be dealt with in a standard way by the
> +		 * SDIO core driver.
> +		 * So modelling the WL_EN line as a regulator was a natural
> +		 * choice as the MMC core already deals with MMC supplies.
> +		 */
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vmmcwl_fixed";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		gpio =3D <&gpio4 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
>  };
>=20
>  &am43xx_pinmux {
> @@ -424,6 +441,62 @@
>  			AM4372_IOPAD(0xac4, PIN_OUTPUT |
> MUX_MODE0) /* usb0_drvvbus.usb0_drvvbus */
>  		>;
>  	};
> +
> +	mmc3_pins_default: pinmux_mmc3_pins_default {
> +		pinctrl-single,pins =3D <
> +			AM4372_IOPAD(0x9f0, PIN_INPUT_PULLUP |
> MUX_MODE3) /* (AD21) cam1_data2.mmc2_clk */
> +			AM4372_IOPAD(0x9f4, PIN_INPUT_PULLUP |
> MUX_MODE3) /* (AE22) cam1_data3.mmc2_cmd */
> +			AM4372_IOPAD(0x9f8, PIN_INPUT_PULLUP |
> MUX_MODE3) /* (AD22) cam1_data4.mmc2_dat0 */
> +			AM4372_IOPAD(0x9fc, PIN_INPUT_PULLUP |
> MUX_MODE3) /* (AE23) cam1_data5.mmc2_dat1 */
> +			AM4372_IOPAD(0xa00, PIN_INPUT_PULLUP |
> MUX_MODE3) /* (AD23) cam1_data6.mmc2_dat2 */
> +			AM4372_IOPAD(0xa04, PIN_INPUT_PULLUP |
> MUX_MODE3) /* (AE24) cam1_data7.mmc2_dat3 */
> +		>;
> +	};
> +
> +	mmc3_pins_sleep: pinmux_mmc3_pins_sleep {
> +		pinctrl-single,pins =3D <
> +			AM4372_IOPAD(0x9f0, PIN_INPUT_PULLDOWN |
> MUX_MODE7) /* (AD21) cam1_data2.mmc2_clk */
> +			AM4372_IOPAD(0x9f4, PIN_INPUT_PULLDOWN |
> MUX_MODE7) /* (AE22) cam1_data3.mmc2_cmd */
> +			AM4372_IOPAD(0x9f8, PIN_INPUT_PULLDOWN |
> MUX_MODE7) /* (AD22) cam1_data4.mmc2_dat0 */
> +			AM4372_IOPAD(0x9fc, PIN_INPUT_PULLDOWN |
> MUX_MODE7) /* (AE23) cam1_data5.mmc2_dat1 */
> +			AM4372_IOPAD(0xa00, PIN_INPUT_PULLDOWN |
> MUX_MODE7) /* (AD23) cam1_data6.mmc2_dat2 */
> +			AM4372_IOPAD(0xa04, PIN_INPUT_PULLDOWN |
> MUX_MODE7) /* (AE24) cam1_data7.mmc2_dat3 */
> +		>;
> +	};
> +
> +	wlan_pins_default: pinmux_wlan_pins_default {
> +		pinctrl-single,pins =3D <
> +			AM4372_IOPAD(0x9d0, PIN_OUTPUT_PULLDOWN |
> MUX_MODE7)		/* cam1_data8.gpio4_8 WL_EN */
> +			AM4372_IOPAD(0x9e4, PIN_INPUT |
> WAKEUP_ENABLE | MUX_MODE7)	/* cam1_wen.gpio4_13 WL_IRQ */
> +		>;
> +	};
> +
> +	wlan_pins_sleep: pinmux_wlan_pins_sleep {
> +		pinctrl-single,pins =3D <
> +			AM4372_IOPAD(0x9d0, PIN_OUTPUT_PULLDOWN |
> MUX_MODE7) 		/* cam1_data8.gpio4_8 WL_EN */
> +			AM4372_IOPAD(0x9e4, PIN_INPUT |
> WAKEUP_ENABLE | MUX_MODE7)	/* cam1_wen.gpio4_13 WL_IRQ */
> +		>;
> +	};
> +
> +	uart1_bt_pins_default: pinmux_uart1_bt_pins_default {
> +		pinctrl-single,pins =3D <
> +			AM4372_IOPAD(0x980, PIN_INPUT | MUX_MODE0)
> 		/* uart1_rxd.uart1_rxd */
> +			AM4372_IOPAD(0x984, PIN_OUTPUT_PULLDOWN |
> MUX_MODE0) 	/* uart1_txd.uart1_txd */
> +			AM4372_IOPAD(0x978, PIN_INPUT_PULLUP |
> MUX_MODE0)	/* uart1_ctsn.uart1_ctsn */
> +			AM4372_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN |
> MUX_MODE0) 	/* uart1_rtsn.uart1_rtsn */
> +			AM4372_IOPAD(0x9cc, PIN_OUTPUT_PULLDOWN |
> MUX_MODE7)	/* cam1_data9.gpio4_7 BT_EN */
> +		>;
> +	};
> +
> +	uart1_bt_pins_sleep: pinmux_uart1_bt_pins_sleep {
> +		pinctrl-single,pins =3D <
> +			AM4372_IOPAD(0x980, PIN_OUTPUT_PULLDOWN |
> MUX_MODE7)	/* uart1_rxd.uart1_rxd */
> +			AM4372_IOPAD(0x984, PIN_OUTPUT_PULLDOWN |
> MUX_MODE7) 	/* uart1_txd.uart1_txd */
> +			AM4372_IOPAD(0x978, PIN_OUTPUT_PULLDOWN |
> MUX_MODE7)	/* uart1_ctsn.uart1_ctsn */
> +			AM4372_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN |
> MUX_MODE7) 	/* uart1_rtsn.uart1_rtsn */
> +			AM4372_IOPAD(0x9cc, PIN_OUTPUT_PULLUP |
> MUX_MODE7)	/* cam1_data9.gpio4_7 BT_EN */
> +		>;
> +	};
>  };
>=20
>  &i2c0 {
> @@ -606,6 +679,10 @@
>  	status =3D "okay";
>  };
>=20
> +&gpio4 {
> +	status =3D "okay";
> +};
> +
>  &gpio5 {
>  	status =3D "okay";
>  };
> @@ -620,6 +697,44 @@
>  	cd-gpios =3D <&gpio0 6 GPIO_ACTIVE_LOW>;
>  };
>=20
> +&uart1 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default", "sleep";
> +	pinctrl-0 =3D <&uart1_bt_pins_default>;
> +	pinctrl-1 =3D <&uart1_bt_pins_sleep>;
> +};
> +
> +&mmc3 {
> +	status =3D "okay";
> +	/*
> +	 * these are on the crossbar and are outlined in the
> +	 * xbar-event-map element
> +	 */
> +	dmas =3D <&edma_xbar 30 0 1>,
> +		<&edma_xbar 31 0 2>;
> +	dma-names =3D "tx", "rx";
> +	vmmc-supply =3D <&vmmcwl_fixed>;
> +	bus-width =3D <4>;
> +	pinctrl-names =3D "default", "sleep";
> +	pinctrl-0 =3D <&mmc3_pins_default>;
> +	pinctrl-1 =3D <&mmc3_pins_sleep>;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
> +	ti,non-removable;
> +
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	wlcore: wlcore@0 {
> +		compatible =3D "ti,wl1835";
> +		pinctrl-names =3D "default", "sleep";
> +		pinctrl-0 =3D <&wlan_pins_default>;
> +		pinctrl-1 =3D <&wlan_pins_sleep>;
> +		reg =3D <2>;
> +		interrupt-parent =3D <&gpio4>;
> +		interrupts =3D <13 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +};
> +
>  &usb2_phy1 {
>  	status =3D "okay";
>  };
> --
> 2.7.4
