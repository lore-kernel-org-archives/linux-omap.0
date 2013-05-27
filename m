From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v2 5/5] ARM: dts: OMAP2+: use pinctrl constants
Date: Mon, 27 May 2013 13:11:11 +0200
Message-ID: <51A33F4F.5010501@epfl.ch>
References: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch> <1369323421-4180-6-git-send-email-florian.vaussard@epfl.ch> <20130523184636.GE13507@atomide.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:58028 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757683Ab3E0LLQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 May 2013 07:11:16 -0400
In-Reply-To: <20130523184636.GE13507@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello Tony,

Thanks for your review.

On 05/23/2013 08:46 PM, Tony Lindgren wrote:
> * Florian Vaussard <florian.vaussard@epfl.ch> [130523 08:42]:
>> index f39b237..b3cc896 100644
>> --- a/arch/arm/boot/dts/omap2.dtsi
>> +++ b/arch/arm/boot/dts/omap2.dtsi
>> @@ -9,6 +9,7 @@
>>    */
>>
>>   #include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/pinctrl/omap.h>
>>
>>   #include "skeleton.dtsi"
>>
>> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
>> index 434288f..2518e6a 100644
>> --- a/arch/arm/boot/dts/omap3-beagle.dts
>> +++ b/arch/arm/boot/dts/omap3-beagle.dts
>> @@ -81,18 +81,18 @@
>>
>>   	hsusbb2_pins: pinmux_hsusbb2_pins {
>>   		pinctrl-single,pins = <
>> -			0x5c0 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk OUTPUT */
>> -			0x5c2 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp OUTPUT */
>> -			0x5c4 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir INPUT | PULLDOWN */
>> -			0x5c6 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt INPUT | PULLDOWN */
>> -			0x5c8 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 INPUT | PULLDOWN */
>> -			0x5cA 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 INPUT | PULLDOWN */
>> -			0x1a4 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 INPUT | PULLDOWN */
>> -			0x1a6 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 INPUT | PULLDOWN */
>> -			0x1a8 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 INPUT | PULLDOWN */
>> -			0x1aa 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat5 INPUT | PULLDOWN */
>> -			0x1ac 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat6 INPUT | PULLDOWN */
>> -			0x1ae 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 INPUT | PULLDOWN */
>> +			0x5c0 (OMAP_PIN_OUTPUT | OMAP_MUX_MODE3)		/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk */
>> +			0x5c2 (OMAP_PIN_OUTPUT | OMAP_MUX_MODE3)		/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp */
>> +			0x5c4 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir */
>> +			0x5c6 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt */
>> +			0x5c8 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 */
>> +			0x5cA (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 */
>> +			0x1a4 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 */
>> +			0x1a6 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 */
>> +			0x1a8 (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 */
>> +			0x1aa (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat5 */
>> +			0x1ac (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat6 */
>> +			0x1ae (OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE3)	/* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 */
>>   		>;
>>   	};
>>   };
>
> Nice!
>
> While at it, can you lowercase the USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk
> naming to usbb2_ulpittl_clk.usbb1_ulpiphy_clk? You can also leave out _MUXMODE
> from these for consistency.
>

Sure. I will send out a v3 ASAP.

> I wonder if we can leave out the OMAP_ prefix from the mux mode defines
> here and just assume PIN_OUTPUT etc would not conflict with other SoC's
> naming?
>

We can avoid conflicts as long as we do not include two headers from two 
different arch,
which should not happen if designed with care. I will do the change.

Regards,

Florian
