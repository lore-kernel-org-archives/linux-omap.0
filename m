From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: Use pinctrl constants
Date: Fri, 23 Oct 2015 08:08:17 -0500
Message-ID: <562A3141.9000701@ti.com>
References: <1445530847-25217-1-git-send-email-afd@ti.com>
 <20151022212356.GU3078@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151022212356.GU3078@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/22/2015 04:23 PM, Tony Lindgren wrote:
> * Andrew F. Davis <afd@ti.com> [151022 09:21]:
>> Using constants for pinctrl allows better readability and removes
>> redundancy with comments.
>
> You should use the include/dt-bindings/pinctrl/omap.h macro
> AM33XX_IOPAD(pa, val) while at it. Otherwise we'll end up patching
> the same things again later on.
>

Hmm, I haven't really been following this change, it kind of seems to add
some unnecessary abstraction by using physical hardware addresses instead
of offsets, then just converting them back to offsets. The offset style DT
nodes are already auto-generated with existing tools anyway:
https://dev.ti.com/pinmux

I'm sure this has been discussed already so if this is a blocker I'll
re-spin this.

Andrew

> Regards,
>
> Tony
>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>   arch/arm/boot/dts/am335x-boneblack.dts | 44 +++++++++++++++++-----------------
>>   1 file changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
>> index eadbba3..a540a10 100644
>> --- a/arch/arm/boot/dts/am335x-boneblack.dts
>> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
>> @@ -36,32 +36,32 @@
>>   &am33xx_pinmux {
>>   	nxp_hdmi_bonelt_pins: nxp_hdmi_bonelt_pins {
>>   		pinctrl-single,pins = <
>> -			0x1b0 0x03      /* xdma_event_intr0, OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
>> -			0xa0 0x08       /* lcd_data0.lcd_data0, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xa4 0x08       /* lcd_data1.lcd_data1, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xa8 0x08       /* lcd_data2.lcd_data2, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xac 0x08       /* lcd_data3.lcd_data3, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xb0 0x08       /* lcd_data4.lcd_data4, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xb4 0x08       /* lcd_data5.lcd_data5, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xb8 0x08       /* lcd_data6.lcd_data6, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xbc 0x08       /* lcd_data7.lcd_data7, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xc0 0x08       /* lcd_data8.lcd_data8, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xc4 0x08       /* lcd_data9.lcd_data9, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xc8 0x08       /* lcd_data10.lcd_data10, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xcc 0x08       /* lcd_data11.lcd_data11, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xd0 0x08       /* lcd_data12.lcd_data12, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xd4 0x08       /* lcd_data13.lcd_data13, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xd8 0x08       /* lcd_data14.lcd_data14, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xdc 0x08       /* lcd_data15.lcd_data15, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
>> -			0xe0 0x00       /* lcd_vsync.lcd_vsync, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT */
>> -			0xe4 0x00       /* lcd_hsync.lcd_hsync, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT */
>> -			0xe8 0x00       /* lcd_pclk.lcd_pclk, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT */
>> -			0xec 0x00       /* lcd_ac_bias_en.lcd_ac_bias_en, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT */
>> +			0x1b0 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr0 */
>> +			0xa0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data0.lcd_data0 */
>> +			0xa4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data1.lcd_data1 */
>> +			0xa8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data2.lcd_data2 */
>> +			0xac (PIN_OUTPUT | MUX_MODE0)		/* lcd_data3.lcd_data3 */
>> +			0xb0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data4.lcd_data4 */
>> +			0xb4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data5.lcd_data5 */
>> +			0xb8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data6.lcd_data6 */
>> +			0xbc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data7.lcd_data7 */
>> +			0xc0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data8.lcd_data8 */
>> +			0xc4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data9.lcd_data9 */
>> +			0xc8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data10.lcd_data10 */
>> +			0xcc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data11.lcd_data11 */
>> +			0xd0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data12.lcd_data12 */
>> +			0xd4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data13.lcd_data13 */
>> +			0xd8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data14.lcd_data14 */
>> +			0xdc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data15.lcd_data15 */
>> +			0xe0 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
>> +			0xe4 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
>> +			0xe8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
>> +			0xec (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
>>   		>;
>>   	};
>>   	nxp_hdmi_bonelt_off_pins: nxp_hdmi_bonelt_off_pins {
>>   		pinctrl-single,pins = <
>> -			0x1b0 0x03      /* xdma_event_intr0, OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
>> +			0x1b0 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr0 */
>>   		>;
>>   	};
>>   };
>> --
>> 1.9.1
>>
