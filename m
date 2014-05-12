From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: am335x-bone-common: Add i2c2 definition
Date: Mon, 12 May 2014 12:50:50 -0700
Message-ID: <20140512195050.GB5668@atomide.com>
References: <1399686184-1594-1-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34389 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751692AbaELTu6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 15:50:58 -0400
Content-Disposition: inline
In-Reply-To: <1399686184-1594-1-git-send-email-mranostay@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pantelis.antoniou@gmail.com, matt.porter@linaro.org

* Matt Ranostay <mranostay@gmail.com> [140509 18:43]:
> Add missing i2c2 bus define to access various cape and
> prototype/breakout board devices.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index 2e7d932..5fdae2e 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -84,6 +84,13 @@
>  		>;
>  	};
>  
> +	i2c2_pins: pinmux_i2c2_pins {
> +		pinctrl-single,pins = <
> +			0x178 (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
> +			0x17c (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_rtsn.i2c2_scl */
> +		>;
> +	};
> +
>  	uart0_pins: pinmux_uart0_pins {
>  		pinctrl-single,pins = <
>  			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
>
> @@ -222,6 +229,15 @@
>  
>  };
>  
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +
> +	status = "okay";
> +	clock-frequency = <100000>;
> +};
> +

If these pins are not used for i2c2 on some capes, this device
should be set to status = "disabled" state by default. Then
u-boot could re-enable it on the boards that have i2c2 in use.

Regards,

Tony
