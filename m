From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap4-droid4: add bluetooth
Date: Tue, 16 May 2017 09:34:59 -0700
Message-ID: <20170516163459.GK31418@atomide.com>
References: <20170415221832.16175-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170415221832.16175-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [170415 15:21]:
> Droid 4 has wl1835 connected to the OMAP's UART4 port, which is
> used for Bluetooth and most likely can also be used for controlling
> the FM radio and GPS receivers.
...

> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -395,6 +395,15 @@
>  		>;
>  	};
>  
> +	uart4_pins: pinmux_uart4_pins {
> +		pinctrl-single,pins = <
> +		OMAP4_IOPAD(0x15c, PIN_INPUT | MUX_MODE0)		/* uart4_rx */
> +		OMAP4_IOPAD(0x15e, PIN_OUTPUT | MUX_MODE0)		/* uart4_tx */
> +		OMAP4_IOPAD(0x110, PIN_INPUT_PULLUP | MUX_MODE5)	/* uart4_cts */
> +		OMAP4_IOPAD(0x112, PIN_OUTPUT_PULLUP | MUX_MODE5)	/* uart4_rts */
> +		>;
> +	};
> +
>  	mcbsp2_pins: pinmux_mcbsp2_pins {
>  		pinctrl-single,pins = <
>  			OMAP4_IOPAD(0x0f6, PIN_INPUT | MUX_MODE0)	/* abe_mcbsp2_clkx */

This needs updating against v4.12-rc1 BTW, looks like you have
some audio patches in works here that mainline does not have
for mcbsp2.

Regards,

Tony
