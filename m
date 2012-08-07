From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP: Configuring CONTROL_DEVCONF0 register via DT with pinctrl
Date: Tue, 7 Aug 2012 04:10:42 -0700
Message-ID: <20120807111041.GY11011@atomide.com>
References: <501262B5.1080004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65129 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab2HGLKo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 07:10:44 -0400
Content-Disposition: inline
In-Reply-To: <501262B5.1080004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120727 02:47]:
> Hello,
> 
> I need to find a solution to control 2 bits in CONTROL_DEVCONF0 on OMAP2/3 for
> McBSP1 CLKR/FSR signal routing.
> In boards using McBSP1 we might need to change bit 3 and 4 based on the audio
> setup (how the board has been wired).
> 
> So far I have come up with the following idea to handle to but not really sure
> if it is the correct way (I have taken the idea from the arm/dts: Add AM33XX
> basic pinctrl support series).

You need to also consider that CONTROL_DEVCONF0 has the MMC/SDIO module input
clock selection. So pinctrl-single binding would have to be expanded to also
support one-bit-per-mux type registers in addition to one-register-per-mux
registers. And then this could also be used for the MMC/SDIO module input clock.

> In .dtsi file of the SoC:
> 
> control_devconf0: pinmux@48002274 {
> 	compatible = "pinctrl-single";
> 	reg = <0x48002274 4>;	/* Single register */
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	pinctrl-single,register-width = <32>;
> 	pinctrl-single,function-mask = <0x5F>;
> };

The pinctrl-single,function-mask is for all the registers in the range,
we also need something to specify the device specific mux bits.

> In the .dts file of the board which needs to change the CLKR/FSR configuration:
> 
> &control_devconf0 {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&mcbsp1_pins>;
> 
> 	mcbsp1_pins: pinmux_mcbsp1_pins {
> 		pinctrl-single,pins = <0x00 0x18>; /* CLKR/FSR from CLKX/FSX
> 						    * pin */
> 	};
> 
> };

I think adding support for one-bit-per-mux would require adding something
like this for the binding:

 	mcbsp1_pins: pinmux_mcbsp1_pins {
		/*                   offset bits mask */
 		pinctrl-single,bits = <0x00 0x18 0x18>;
	};

As otherwise you would not know which bits to clear for alternative
named modes. Or got any better ideas?

Regards,

Tony
