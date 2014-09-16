From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/4] ARM: dts: cm-t54: add HDMI/DVI display data
Date: Tue, 16 Sep 2014 11:46:15 -0500
Message-ID: <54186957.50803@ti.com>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il> <1410885322-5928-2-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44877 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150AbaIPQqr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 12:46:47 -0400
In-Reply-To: <1410885322-5928-2-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>, =?windows-1252?Q?Beno=EEt_?= =?windows-1252?Q?Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/16/2014 11:35 AM, Dmitry Lifshitz wrote:
> Add DSS related pinmux and display data nodes required to support HDMI
> and DVI video out on CM-T54.
> 
> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
> ---
>  arch/arm/boot/dts/omap5-cm-t54.dts |  158 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 158 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
> index 429471a..9cb40d6 100644
> --- a/arch/arm/boot/dts/omap5-cm-t54.dts
> +++ b/arch/arm/boot/dts/omap5-cm-t54.dts
> @@ -66,6 +66,69 @@
>  			default-state = "off";
>  		};
>  	};
> +
> +	aliases {
> +		display0 = &hdmi0;
> +		display1 = &dvi0;
> +	};

Should probably maintain all the aliases in one place at the top of
the dts?

> +
> +	hdmi0: connector@0 {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +
> +		type = "a";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hdmi_conn_pins>;
> +
> +		hpd-gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>; /* GPIO 193, HPD */
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_out>;
> +			};
> +		};
> +	};
> +
> +	tfp410: encoder@0 {
> +		compatible = "ti,tfp410";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				tfp410_in: endpoint@0 {
> +					remote-endpoint = <&dpi_dvi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				tfp410_out: endpoint@0 {
> +					remote-endpoint = <&dvi_connector_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	dvi0: connector@1 {
> +		compatible = "dvi-connector";
> +		label = "dvi";
> +
> +		digital;
> +
> +		ddc-i2c-bus = <&i2c2>;
> +
> +		port {
> +			dvi_connector_in: endpoint {
> +				remote-endpoint = <&tfp410_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &omap5_pmx_core {
> @@ -88,6 +151,13 @@
>  		>;
>  	};
>  
> +	i2c2_pins: pinmux_i2c2_pins {
> +		pinctrl-single,pins = <
> +			OMAP5_IOPAD(0x01b8, PIN_INPUT | MUX_MODE0) /* i2c2_scl */
> +			OMAP5_IOPAD(0x01ba, PIN_INPUT | MUX_MODE0) /* i2c2_sda */
> +		>;
> +	};
> +
>  	mmc1_pins: pinmux_mmc1_pins {
>  		pinctrl-single,pins = <
>  			OMAP5_IOPAD(0x01e2, PIN_INPUT_PULLUP | MUX_MODE0) /* sdcard_clk */
> @@ -144,6 +214,53 @@
>  			OMAP5_IOPAD(0x00b6, PIN_OUTPUT | MUX_MODE6) /* hsi2_acdata.gpio3_83 */
>  		>;
>  	};
> +
> +	dss_hdmi_pins: pinmux_dss_hdmi_pins {
> +		pinctrl-single,pins = <
> +			OMAP5_IOPAD(0x013c, PIN_INPUT_PULLUP | MUX_MODE0) /* hdmi_cec.hdmi_cec */
> +			OMAP5_IOPAD(0x0140, PIN_INPUT | MUX_MODE0) /* hdmi_ddc_scl.hdmi_ddc_scl */
> +			OMAP5_IOPAD(0x0142, PIN_INPUT | MUX_MODE0) /* hdmi_ddc_sda.hdmi_ddc_sda */
> +		>;
> +	};
> +
> +	hdmi_conn_pins: pinmux_hdmi_conn_pins {
> +		pinctrl-single,pins = <
> +			OMAP5_IOPAD(0x013e, PIN_INPUT | MUX_MODE6) /* hdmi_hpd.gpio7_193 */
> +		>;
> +	};
> +
> +	dss_dpi_pins: pinmux_dss_dpi_pins {
> +		pinctrl-single,pins = <
> +			OMAP5_IOPAD(0x0104, PIN_OUTPUT | MUX_MODE3) /* dispc_data15 */
> +			OMAP5_IOPAD(0x0106, PIN_OUTPUT | MUX_MODE3) /* dispc_data14 */
> +			OMAP5_IOPAD(0x0108, PIN_OUTPUT | MUX_MODE3) /* dispc_data13 */
> +			OMAP5_IOPAD(0x010a, PIN_OUTPUT | MUX_MODE3) /* dispc_data12 */
> +			OMAP5_IOPAD(0x010c, PIN_OUTPUT | MUX_MODE3) /* dispc_data11 */
> +			OMAP5_IOPAD(0x010e, PIN_OUTPUT | MUX_MODE3) /* dispc_data10 */
> +			OMAP5_IOPAD(0x0110, PIN_OUTPUT | MUX_MODE3) /* dispc_data9 */
> +			OMAP5_IOPAD(0x0112, PIN_OUTPUT | MUX_MODE3) /* dispc_data8 */
> +			OMAP5_IOPAD(0x0114, PIN_OUTPUT | MUX_MODE3) /* dispc_data7 */
> +			OMAP5_IOPAD(0x0116, PIN_OUTPUT | MUX_MODE3) /* dispc_data6 */
> +			OMAP5_IOPAD(0x0118, PIN_OUTPUT | MUX_MODE3) /* dispc_data5 */
> +			OMAP5_IOPAD(0x011a, PIN_OUTPUT | MUX_MODE3) /* dispc_data4 */
> +			OMAP5_IOPAD(0x011c, PIN_OUTPUT | MUX_MODE3) /* dispc_data3 */
> +			OMAP5_IOPAD(0x011e, PIN_OUTPUT | MUX_MODE3) /* dispc_data2 */
> +			OMAP5_IOPAD(0x0120, PIN_OUTPUT | MUX_MODE3) /* dispc_data1 */
> +			OMAP5_IOPAD(0x0122, PIN_OUTPUT | MUX_MODE3) /* dispc_data0 */
> +			OMAP5_IOPAD(0x0124, PIN_OUTPUT | MUX_MODE3) /* dispc_vsync */
> +			OMAP5_IOPAD(0x0126, PIN_OUTPUT | MUX_MODE3) /* dispc_hsync */
> +			OMAP5_IOPAD(0x0128, PIN_OUTPUT | MUX_MODE3) /* dispc_de */
> +			OMAP5_IOPAD(0x012a, PIN_OUTPUT | MUX_MODE3) /* dispc_pclk */
> +			OMAP5_IOPAD(0x012c, PIN_OUTPUT | MUX_MODE3) /* dispc_data17 */
> +			OMAP5_IOPAD(0x012e, PIN_OUTPUT | MUX_MODE3) /* dispc_data16 */
> +			OMAP5_IOPAD(0x0130, PIN_OUTPUT | MUX_MODE3) /* dispc_data18 */
> +			OMAP5_IOPAD(0x0132, PIN_OUTPUT | MUX_MODE3) /* dispc_data19 */
> +			OMAP5_IOPAD(0x0134, PIN_OUTPUT | MUX_MODE3) /* dispc_data20 */
> +			OMAP5_IOPAD(0x0136, PIN_OUTPUT | MUX_MODE3) /* dispc_data21 */
> +			OMAP5_IOPAD(0x0138, PIN_OUTPUT | MUX_MODE3) /* dispc_data22 */
> +			OMAP5_IOPAD(0x013a, PIN_OUTPUT | MUX_MODE3) /* dispc_data23 */
> +		>;
> +	};
>  };
>  
>  &mmc1 {
> @@ -398,6 +515,13 @@
>  	};
>  };
>  
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +
> +	clock-frequency = <100000>;
> +};
> +
>  &usbhshost {
>  	port2-mode = "ehci-hsic";
>  	port3-mode = "ehci-hsic";
> @@ -410,3 +534,37 @@
>  &cpu0 {
>  	cpu0-supply = <&smps123_reg>;
>  };
> +
> +&dss {
> +	status = "ok";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dss_dpi_pins>;
> +
> +	port {
> +		dpi_dvi_out: endpoint@0 {
> +			remote-endpoint = <&tfp410_in>;
> +			data-lines = <24>;
> +		};
> +	};
> +};
> +
> +&dsi2 {
> + 	status = "ok";
> + 	vdd-supply = <&ldo4_reg>;
> +};
> +
> +&hdmi {
> +	status = "ok";
> +	vdda-supply = <&ldo4_reg>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dss_hdmi_pins>;
> +
> +	port {
> +		hdmi_out: endpoint {
> +			remote-endpoint = <&hdmi_connector_in>;
> +			lanes = <1 0 3 2 5 4 7 6>;
> +		};
> +	};
> +};
> 


-- 
Regards,
Nishanth Menon
