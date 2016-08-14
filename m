From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 7/7] ARM: dts: OMAP3-N950: Add bluetooth
Date: Sun, 14 Aug 2016 10:53:47 +0200
Message-ID: <20160814085347.GE21321@amd>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-8-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471058078-5579-8-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

You'll need to sign off the patch.

Acked-by: Pavel Machek <pavel@ucw.cz>

							Pavel

On Sat 2016-08-13 05:14:38, Sebastian Reichel wrote:
> ---
>  arch/arm/boot/dts/omap3-n950-n9.dtsi | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> index 927b17fc4ed8..7c0c53e2f679 100644
> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> @@ -58,6 +58,13 @@
>  			pinctrl-0 = <&debug_leds>;
>  		};
>  	};
> +
> +	/* controlled (enabled/disabled) directly by wl1271 */
> +	vctcxo: vctcxo {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <38400000>;
> +	};
>  };
>  
>  &omap3_pmx_core {
> @@ -125,6 +132,16 @@
>  			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE4)            /* gpio_93 (cmt_apeslpx) */
>  		>;
>  	};
> +
> +	uart2_pins: pinmux_uart2_pins {
> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT | MUX_MODE0)		/* uart2_cts */
> +			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts */
> +			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
> +			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx */
> +		>;
> +	};
> +
>  };
>  
>  &omap3_pmx_core2 {
> @@ -435,3 +452,20 @@
>  &ssi_port2 {
>  	status = "disabled";
>  };
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins>;
> +
> +	bluetooth {
> +		compatible = "nokia,ti,wl1271-bluetooth";
> +
> +		reset-gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>; /* 26 */
> +		host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* 101 */
> +		bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* 37 */
> +
> +		clocks = <&vctcxo>;
> +		clock-names = "sysclk";
> +	};
> +
> +};

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
