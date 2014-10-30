From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 01/10] ARM: dts: Fix bootloader version dependencies by
 muxing n900 smc91x pins
Date: Thu, 30 Oct 2014 13:59:37 +0200
Message-ID: <54522829.6060406@ti.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com> <1414628948-30702-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52204 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932860AbaJ3MAF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2014 08:00:05 -0400
In-Reply-To: <1414628948-30702-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>

On 10/30/2014 02:28 AM, Tony Lindgren wrote:
> Apparently some versions of nolo don't mux the necessary GPMC
> pins for the smc91x probe to work properly. Let's fix this issue
> by adding mux support for GPMC to the kernel.
> 
> Note that it's unclear why the GPMC clk pin has input enabled, but
> let's not touch that as in general the mux settings in nolo are
> correct.
> 
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap3-n900.dts | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 739fcf2..e7210d1 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -142,6 +142,33 @@
>  		>;
>  	};
>  
> +	gpmc_pins: pinmux_gpmc_pins {
> +		pinctrl-single,pins = <
> +
> +			/* address lines */
> +                        OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
> +                        OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
> +                        OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
> +
> +			/* data lines, gpmc_d0..d7 not muxable according to TRM */
> +                        OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0)        /* gpmc_d8.gpmc_d8 */
> +                        OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0)        /* gpmc_d9.gpmc_d9 */
> +                        OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0)        /* gpmc_d10.gpmc_d10 */
> +                        OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0)        /* gpmc_d11.gpmc_d11 */
> +                        OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0)        /* gpmc_d12.gpmc_d12 */
> +                        OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0)        /* gpmc_d13.gpmc_d13 */
> +                        OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0)        /* gpmc_d14.gpmc_d14 */
> +                        OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0)        /* gpmc_d15.gpmc_d15 */
> +
> +			/*
> +			 * gpmc_ncs0, gpmc_nadv_ale, gpmc_noe, gpmc_nwe, gpmc_wait0 not muxable
> +			 * according to TRM. REVISIT: why does nolo set input for gpmc_clk?
> +			 */
> +                        OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
> +                        OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */

Right about the comment. GPMC_CLK should feed the CLK input of the OneNAND.
This needs to be an OUTPUT pin.

Does OneNAND work when this pin is configured as output?

cheers,
-roger

> +		>;
> +	};
> +
>  	i2c1_pins: pinmux_i2c1_pins {
>  		pinctrl-single,pins = <
>  			0x18a (PIN_INPUT | MUX_MODE0)		/* i2c1_scl */
> @@ -588,6 +615,8 @@
>  	ranges = <0 0 0x04000000 0x10000000>; /* 256MB */
>  	ranges = <0 0 0x01000000 0x01000000>,	/* 16 MB for OneNAND */
>  		 <1 0 0x02000000 0x01000000>;	/* 16 MB for smc91c96 */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gpmc_pins>;
>  
>  	/* gpio-irq for dma: 65 */
>  
> 

