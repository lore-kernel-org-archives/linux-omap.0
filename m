From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 5/5] omap dt changes for v3.16 merge window
Date: Thu, 8 May 2014 18:32:12 -0700
Message-ID: <20140509013211.GM2198@atomide.com>
References: <pull-1399581053-360006>
 <pull-1399581053-360006-5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24181 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207AbaEIBcT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 21:32:19 -0400
Content-Disposition: inline
In-Reply-To: <pull-1399581053-360006-5>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [140508 16:45]:
> The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:
> 
>   Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/dt-signed
> 
> for you to fetch changes up to 3fdb77174a2c173e0e69f2499b836a0e412f6c4d:
> 
>   ARM: dts: omap3-n900: use MATRIX_KEY for keymap (2014-05-06 10:22:51 -0700)
> 
> ----------------------------------------------------------------
> Device tree related changes for omaps for v3.16 merge window.

FYI, this causes a trivial merge conflict with the PM pull request
in this. Just overlapping additions, my resolution below for
reference.

Regards,

Tony


--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@@ -141,12 -144,15 +155,21 @@@
  		>;
  	};
  
 +	debug_leds: pinmux_debug_led_pins {
 +		pinctrl-single,pins = <
 +			OMAP3_CORE1_IOPAD(0x2198, PIN_OUTPUT | MUX_MODE4)	/* mcbsp1_clkx.gpio_162 */
 +		>;
 +	};
 +
+ 	mcspi4_pins: pinmux_mcspi4_pins {
+ 		pinctrl-single,pins = <
+ 			0x15c (PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_clk */
+ 			0x162 (PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_somi */
+ 			0x160 (PIN_OUTPUT | MUX_MODE1) /* mcspi4_simo */
+ 			0x166 (PIN_OUTPUT | MUX_MODE1) /* mcspi4_cs0 */
+ 		>;
+ 	};
+ 
  	mmc1_pins: pinmux_mmc1_pins {
  		pinctrl-single,pins = <
  			0x114 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
