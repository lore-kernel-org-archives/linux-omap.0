From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 2/3] arm/dts: AM33XX: Configure pinmuxs for user
 leds control on Bone
Date: Fri, 7 Sep 2012 10:00:24 -0700
Message-ID: <20120907170023.GX1303@atomide.com>
References: <1346924304-27425-1-git-send-email-anilkumar@ti.com>
 <1346924304-27425-3-git-send-email-anilkumar@ti.com>
 <D8A9C7D8-76C8-4B30-A179-F007B336C97B@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:32998 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2IGRAj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 13:00:39 -0400
Content-Disposition: inline
In-Reply-To: <D8A9C7D8-76C8-4B30-A179-F007B336C97B@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: AnilKumar Ch <anilkumar@ti.com>, wg@grandegger.com, mkl@pengutronix.de, bryan.wu@canonical.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

* Koen Kooi <koen@dominion.thruhere.net> [120907 01:46]:
> 
> Op 6 sep. 2012, om 11:38 heeft AnilKumar Ch <anilkumar@ti.com> het volgende geschreven:
> 
> > Adds GPIO pinctrl nodes to am3358_pinmux master node to control
> > user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.
> > 
> > [koen@dominion.thruhere.net: led0, led1 suggested by koen]
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> Acked-by: Koen Kooi <koen@dominion.thruhere.net>

This one still has the discussion going on about if GPIO pins
should be muxed by the GPIO controller in the "GPIO only" case
for gpio leds driver. But other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> 
> > ---
> > arch/arm/boot/dts/am335x-bone.dts |   43 +++++++++++++++++++++++++++++++++++++
> > 1 file changed, 43 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> > index c634f87..b0a7409 100644
> > --- a/arch/arm/boot/dts/am335x-bone.dts
> > +++ b/arch/arm/boot/dts/am335x-bone.dts
> > @@ -18,11 +18,54 @@
> > 		reg = <0x80000000 0x10000000>; /* 256 MB */
> > 	};
> > 
> > +	am33xx_pinmux: pinmux@44e10800 {
> > +		userled_pins: pinmux_userled_pins {
> > +			pinctrl-single,pins = <
> > +				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
> > +				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
> > +				0x5c 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
> > +				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
> > +			>;
> > +		};
> > +	};
> > +
> > 	ocp {
> > 		uart1: serial@44e09000 {
> > 			status = "okay";
> > 		};
> > 
> > +		leds {
> > +			compatible = "gpio-leds";
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&userled_pins>;
> > +
> > +			heartbeat {
> > +				label = "beaglebone:green:usr0";
> > +				gpios = <&gpio2 21 0>;
> > +				linux,default-trigger = "heartbeat";
> > +				default-state = "off";
> > +			};
> > +
> > +			mmc {
> > +				label = "beaglebone:green:usr1";
> > +				gpios = <&gpio2 22 0>;
> > +				linux,default-trigger = "mmc0";
> > +				default-state = "off";
> > +			};
> > +
> > +			led2 {
> > +				label = "beaglebone:green:usr2";
> > +				gpios = <&gpio2 23 0>;
> > +				default-state = "off";
> > +			};
> > +
> > +			led3 {
> > +				label = "beaglebone:green:usr3";
> > +				gpios = <&gpio2 24 0>;
> > +				default-state = "off";
> > +			};
> > +		};
> > +
> > 		i2c1: i2c@44e0b000 {
> > 			status = "okay";
> > 			clock-frequency = <400000>;
> > -- 
> > 1.7.9.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
