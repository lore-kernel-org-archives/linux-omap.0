From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 3/4] ARM: dts: omap5-uevm: Add LED support for uEVM blue
 LED
Date: Thu, 6 Jun 2013 23:22:47 +0530
Message-ID: <51B0CC6F.2060506@ti.com>
References: <1370414770-1485-1-git-send-email-r.sricharan@ti.com> <1370414770-1485-4-git-send-email-r.sricharan@ti.com> <51AF6F8F.4000702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36163 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab3FFRxO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jun 2013 13:53:14 -0400
In-Reply-To: <51AF6F8F.4000702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com

Hi,
On Wednesday 05 June 2013 10:34 PM, Dan Murphy wrote:
> Sricharan
>
> Thanks for sending this up in the series.
>
> On 06/05/2013 01:46 AM, Sricharan R wrote:
>> From: Dan Murphy <dmurphy@ti.com>
>>
>> Add support for blue LED 1 off of GPIO 153.
>> Make the LED a heartbeat LED
>> Configure the MUX for GPIO output.
>>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> [Sricharan R <r.sricharan@ti.com>: Replaced constants with preprocessor macros]
>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>> ---
>>  arch/arm/boot/dts/omap5-uevm.dts |   17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index cf862df..a2aed5b 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -66,6 +66,16 @@
>>  		device = <&hsusb2_phy>;
>>  		clock-frequency = <19200000>; /* 19.2 MHz */
>>  	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		led@1 {
>> +			label = "omap5:blue:usr1";
>> +			gpios = <&gpio5 25 GPIO_ACTIVE_HIGH>; /* gpio5_153 D1 LED */
>> +			linux,default-trigger = "heartbeat";
>> +			default-state = "off";
>> +		};
>> +	};
>>  };
>>  
>>  &omap5_pmx_core {
>> @@ -77,6 +87,7 @@
>>  			&mcbsp1_pins
>>  			&mcbsp2_pins
>>  			&usbhost_pins
>> +			&led_gpio_pins
>>  	>;
>>  
>>  	twl6040_pins: pinmux_twl6040_pins {
>> @@ -175,6 +186,12 @@
>>  			0x6e (PIN_OUTPUT | MUX_MODE6) /* gpio3_79 OUTPUT | MODE 6 ETH_NRESET */
>>  		>;
>>  	};
>> +
>> +	led_gpio_pins: pinmux_led_gpio_pins {
>> +		pinctrl-single,pins = <
>> +			0x196 (PIN_OUTPUT | MUX_MODE6) /* uart3_cts_rctx.gpio5_153 OUTPUT | MODE6 */
> Same comment from Florian.  We can drop the OUTPUT | MODE6 in the comment.
   Ok thanks, Corrected in V2.

Regards,
 Sricharan
