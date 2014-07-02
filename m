From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] ARM: dts: am335x-evmsk: enable display and lcd panel
 support
Date: Wed, 2 Jul 2014 00:45:08 -0700
Message-ID: <20140702074508.GT28884@atomide.com>
References: <1404248420-10086-1-git-send-email-detheridge@ti.com>
 <20140701210812.GN13396@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25009 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750796AbaGBHpL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2014 03:45:11 -0400
Content-Disposition: inline
In-Reply-To: <20140701210812.GN13396@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Darren Etheridge <detheridge@ti.com>, bcousson@baylibre.com, wsa@sang-engineering.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tomi.valkeinen@ti.com

* Felipe Balbi <balbi@ti.com> [140701 14:10]:
> Hi,
> 
> On Tue, Jul 01, 2014 at 04:00:20PM -0500, Darren Etheridge wrote:
> > Add the necessary nodes to enable the LCD controller and the
> > LCD panel that is attached to the Texas Instruments AM335x
> > EVMSK platform.  Also setup the necessary pin mux within the
> > DT file to drive the LCD connector and add the correct
> > pinmux settings for the lcd pins to be configured to when
> > the SoC goes into sleep state for the minimum power
> > consumption.
> > 
> > For the sleep mode LCD pin settings, MUX_MODE7 is chosen as
> > this corresponds to switching the pins into input GPIO's with
> > an internal pulldown.  Which has been determined to offer the
> > lowest power solution vs leaving the pins configured in LCD
> > mode.
> > 
> > Signed-off-by: Darren Etheridge <detheridge@ti.com>
> > Acked-by: Wolfram Sang <wsa@sang-engineering.com>
> 
> Tested-by: Felipe Balbi <balbi@ti.com>
> 
> serial console capture: http://slexy.org/view/s200thiMb3
> 
> note that v2 has been pending since May 9th:
> http://marc.info/?l=linux-omap&m=139966159102339&w=2
> 
> > ---
> > Tony, Benoit,
> > 
> > I didn't see this patch get applied anywhere, so I updated it and I am
> > resending it.  Please let me know if you need any more info before you will
> > apply it.

Tomi, do you want to ack this one or want to queue the panel .dts
changes into a separate branch?

Regards,

Tony


> > Thanks, Darren
> > 
> > v3:
> > Updated subject to match classification style of subsystem
> > Rebased against 3.16-rc3
> > 
> > v2:
> > Fixed up the incorrect label ordering in the pinmux comments for LCD pins
> > 16 through 23 as reported by Wolfram Sang <wsa@sang-engineering.com>
> > 
> >  arch/arm/boot/dts/am335x-evmsk.dts | 105 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> > index ab9a34c..59766e2 100644
> > --- a/arch/arm/boot/dts/am335x-evmsk.dts
> > +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> > @@ -149,12 +149,113 @@
> >  			"Headphone Jack",       "HPLOUT",
> >  			"Headphone Jack",       "HPROUT";
> >  	};
> > +
> > +	panel {
> > +		compatible = "ti,tilcdc,panel";
> > +		pinctrl-names = "default", "sleep";
> > +		pinctrl-0 = <&lcd_pins_default>;
> > +		pinctrl-1 = <&lcd_pins_sleep>;
> > +		status = "okay";
> > +		panel-info {
> > +			ac-bias           = <255>;
> > +			ac-bias-intrpt    = <0>;
> > +			dma-burst-sz      = <16>;
> > +			bpp               = <32>;
> > +			fdd               = <0x80>;
> > +			sync-edge         = <0>;
> > +			sync-ctrl         = <1>;
> > +			raster-order      = <0>;
> > +			fifo-th           = <0>;
> > +		};
> > +		display-timings {
> > +			480x272 {
> > +				hactive         = <480>;
> > +				vactive         = <272>;
> > +				hback-porch     = <43>;
> > +				hfront-porch    = <8>;
> > +				hsync-len       = <4>;
> > +				vback-porch     = <12>;
> > +				vfront-porch    = <4>;
> > +				vsync-len       = <10>;
> > +				clock-frequency = <9000000>;
> > +				hsync-active    = <0>;
> > +				vsync-active    = <0>;
> > +			};
> > +		};
> > +	};
> >  };
> >  
> >  &am33xx_pinmux {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&gpio_keys_s0 &clkout2_pin>;
> >  
> > +	lcd_pins_default: lcd_pins_default {
> > +		pinctrl-single,pins = <
> > +			0x20 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad8.lcd_data23 */
> > +			0x24 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad9.lcd_data22 */
> > +			0x28 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad10.lcd_data21 */
> > +			0x2c (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad11.lcd_data20 */
> > +			0x30 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad12.lcd_data19 */
> > +			0x34 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad13.lcd_data18 */
> > +			0x38 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad14.lcd_data17 */
> > +			0x3c (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad15.lcd_data16 */
> > +			0xa0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
> > +			0xa4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
> > +			0xa8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
> > +			0xac (PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
> > +			0xb0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
> > +			0xb4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
> > +			0xb8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
> > +			0xbc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
> > +			0xc0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
> > +			0xc4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
> > +			0xc8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
> > +			0xcc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
> > +			0xd0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
> > +			0xd4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
> > +			0xd8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
> > +			0xdc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
> > +			0xe0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
> > +			0xe4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
> > +			0xe8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
> > +			0xec (PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
> > +		>;
> > +	};
> > +
> > +	lcd_pins_sleep: lcd_pins_sleep {
> > +		pinctrl-single,pins = <
> > +			0x20 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad8.lcd_data23 */
> > +			0x24 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad9.lcd_data22 */
> > +			0x28 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad10.lcd_data21 */
> > +			0x2c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad11.lcd_data20 */
> > +			0x30 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad12.lcd_data19 */
> > +			0x34 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad13.lcd_data18 */
> > +			0x38 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad14.lcd_data17 */
> > +			0x3c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad15.lcd_data16 */
> > +			0xa0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data0.lcd_data0 */
> > +			0xa4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data1.lcd_data1 */
> > +			0xa8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data2.lcd_data2 */
> > +			0xac (PULL_DISABLE | MUX_MODE7)	/* lcd_data3.lcd_data3 */
> > +			0xb0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data4.lcd_data4 */
> > +			0xb4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data5.lcd_data5 */
> > +			0xb8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data6.lcd_data6 */
> > +			0xbc (PULL_DISABLE | MUX_MODE7)	/* lcd_data7.lcd_data7 */
> > +			0xc0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data8.lcd_data8 */
> > +			0xc4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data9.lcd_data9 */
> > +			0xc8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data10.lcd_data10 */
> > +			0xcc (PULL_DISABLE | MUX_MODE7)	/* lcd_data11.lcd_data11 */
> > +			0xd0 (PULL_DISABLE | MUX_MODE7)	/* lcd_data12.lcd_data12 */
> > +			0xd4 (PULL_DISABLE | MUX_MODE7)	/* lcd_data13.lcd_data13 */
> > +			0xd8 (PULL_DISABLE | MUX_MODE7)	/* lcd_data14.lcd_data14 */
> > +			0xdc (PULL_DISABLE | MUX_MODE7)	/* lcd_data15.lcd_data15 */
> > +			0xe0 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.lcd_vsync */
> > +			0xe4 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.lcd_hsync */
> > +			0xe8 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.lcd_pclk */
> > +			0xec (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.lcd_ac_bias_en */
> > +		>;
> > +	};
> > +
> > +
> >  	user_leds_s0: user_leds_s0 {
> >  		pinctrl-single,pins = <
> >  			0x10 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad4.gpio1_4 */
> > @@ -573,3 +674,7 @@
> >  		ti,wire-config = <0x00 0x11 0x22 0x33>;
> >  	};
> >  };
> > +
> > +&lcdc {
> > +      status = "okay";
> > +};
> > -- 
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> balbi


