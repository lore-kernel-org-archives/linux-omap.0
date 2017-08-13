From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] nokia n900: update dts with camera support
Date: Sun, 13 Aug 2017 17:37:57 +0200
Message-ID: <20170813153757.GH1095@pali>
References: <20170810204923.GA18442@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170810204923.GA18442@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, sakari.ailus@iki.fi
List-Id: linux-omap@vger.kernel.org

On Thursday 10 August 2017 22:49:23 Pavel Machek wrote:
> 
> Add camera support to N900 dts. Also add a note about MMC & debugging.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Looks good,

Acked-by: Pali Rohár <pali.rohar@gmail.com>

> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 49f3708..b1be53d 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -144,6 +144,15 @@
>  		io-channel-names = "temp", "bsi", "vbat";
>  	};
>  
> +	rear_camera: camera@0 {
> +		compatible = "linux,camera";
> +
> +		module {
> +			model = "TCM8341MD";
> +			sensor = <&cam1>;
> +		};
> +	};
> +
>  	pwm9: dmtimer-pwm {
>  		compatible = "ti,omap-dmtimer-pwm";
>  		#pwm-cells = <3>;
> @@ -164,6 +173,31 @@
>  	};
>  };
>  
> +&isp {
> +	vdds_csib-supply = <&vaux2>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&camera_pins>;
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +
> +			csi_isp: endpoint {
> +				remote-endpoint = <&csi_cam1>;
> +				bus-type = <3>; /* CCP2 */
> +				clock-lanes = <1>;
> +				data-lanes = <0>;
> +				lane-polarity = <0 0>;
> +				clock-inv = <0>;
> +				/* Select strobe = <1> for back camera, <0> for front camera */
> +				strobe = <1>;
> +				crc = <0>;
> +			};
> +		};
> +	};
> +};
> +
>  &omap3_pmx_core {
>  	pinctrl-names = "default";
>  
> @@ -328,6 +362,22 @@
>  			OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MODE4)		/* gpio 157 => cmt_bsi */
>  		>;
>  	};
> +
> +	camera_pins: pinmux_camera {
> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x210c, PIN_OUTPUT | MUX_MODE7)       /* cam_hs */
> +			OMAP3_CORE1_IOPAD(0x210e, PIN_OUTPUT | MUX_MODE7)       /* cam_vs */
> +			OMAP3_CORE1_IOPAD(0x2110, PIN_OUTPUT | MUX_MODE0)       /* cam_xclka */
> +			OMAP3_CORE1_IOPAD(0x211e, PIN_OUTPUT | MUX_MODE7)       /* cam_d4 */
> +			OMAP3_CORE1_IOPAD(0x2122, PIN_INPUT | MUX_MODE0)        /* cam_d6 */
> +			OMAP3_CORE1_IOPAD(0x2124, PIN_INPUT | MUX_MODE0)        /* cam_d7 */
> +			OMAP3_CORE1_IOPAD(0x2126, PIN_INPUT | MUX_MODE0)        /* cam_d8 */
> +			OMAP3_CORE1_IOPAD(0x2128, PIN_INPUT | MUX_MODE0)        /* cam_d9 */
> +			OMAP3_CORE1_IOPAD(0x212a, PIN_OUTPUT | MUX_MODE7)       /* cam_d10 */
> +			OMAP3_CORE1_IOPAD(0x212e, PIN_OUTPUT | MUX_MODE7)       /* cam_xclkb */
> +			OMAP3_CORE1_IOPAD(0x2132, PIN_OUTPUT | MUX_MODE0)       /* cam_strobe */
> +		>;
> +	};
>  };
>  
>  &i2c1 {
> @@ -726,6 +776,40 @@
>  		st,max-limit-y = <32>;
>  		st,max-limit-z = <32>;
>  	};
> +
> +	cam1: camera@3e {
> +		compatible = "toshiba,et8ek8";
> +		reg = <0x3e>;
> +
> +		vana-supply = <&vaux4>;
> +
> +		clocks = <&isp 0>;
> +		clock-names = "extclk";
> +		clock-frequency = <9600000>;
> +
> +		reset-gpio = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 */
> +
> +		port {
> +			csi_cam1: endpoint {
> +				bus-type = <3>; /* CCP2 */
> +				strobe = <1>;
> +				clock-inv = <0>;
> +				crc = <1>;
> +
> +				remote-endpoint = <&csi_isp>;
> +			};
> +		};
> +	};
> +
> +	/* D/A converter for auto-focus */
> +	ad5820: dac@0c {
> +		compatible = "adi,ad5820";
> +		reg = <0x0c>;
> +
> +		VANA-supply = <&vaux4>;
> +
> +		#io-channel-cells = <0>;
> +	};
>  };
>  
>  &mmc1 {
> @@ -733,6 +817,9 @@
>  	pinctrl-0 = <&mmc1_pins>;
>  	vmmc-supply = <&vmmc1>;
>  	bus-width = <4>;
> +	/* For debugging, it is often good idea to remove this GPIO.
> +	   It means you can remove back cover (to reboot by removing
> +	   battery) and still use the MMC card. */
>  	cd-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>; /* 160 */
>  };
>  
> 

-- 
Pali Rohár
pali.rohar@gmail.com
