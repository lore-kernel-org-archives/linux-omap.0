From: Sourav <sourav.poddar@ti.com>
Subject: Re: [PATCH] arm: dts: omap4-sdp: pinmux configuration for keypad
Date: Tue, 23 Oct 2012 11:54:08 +0530
Message-ID: <50863808.3010305@ti.com>
References: <1350890955-29553-1-git-send-email-sourav.poddar@ti.com> <20121022161909.GY4730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121022161909.GY4730@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,
On Monday 22 October 2012 09:49 PM, Tony Lindgren wrote:
> * Sourav Poddar <sourav.poddar@ti.com> [121022 00:30]:
>> --- a/arch/arm/boot/dts/omap4-sdp.dts
>> +++ b/arch/arm/boot/dts/omap4-sdp.dts
>> @@ -194,6 +194,27 @@
>>   			0xbc 0x100	/* abe_mcbsp2_fsx.abe_mcbsp2_fsx INPUT | MODE0 */
>>   		>;
>>   	};
>> +
>> +	keypad_pins: pinmux_keypad_pins {
>> +		pinctrl-single,pins = <
>> +			0x24 0x4119   /* gpmc_a18.kpd_row6 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
>> +			0x26 0x4119   /* gpmc_a19.kpd_row6 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
>> +			0x2c 0x4001   /* gpmc_a22.kpd_col6 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
>> +			0x2e 0x4001   /* gpmc_a23.kpd_col7 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
>> +			0x13c 0x4001  /* kpd_col0.kpd_col0 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
>> +			0x13e 0x4001  /* kpd_col1.kpd_col1 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
>> +			0x140 0x4001  /* kpd_col2.kpd_col2 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
>> +			0x142 0x10F   /* kpd_col3.kpd_col3 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
>> +			0x144 0x4001  /* kpd_col4.kpd_col4 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
>> +			0x146 0x4001  /* kpd_col5.kpd_col5 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
>> +			0x148 0xc119  /* kpd_row0.kpd_row0 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
>> +			0x14a 0x4119  /* kpd_row1.kpd_row1 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
>> +			0x14c 0x4119  /* kpd_row2.kpd_row2 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
>> +			0x14e 0x4119  /* kpd_row3.kpd_row3 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
>> +			0x150 0x4119  /* kpd_row4.kpd_row4 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
>> +			0x152 0x4119  /* kpd_row5.kpd_row5 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
>> +		>;
>> +	};
>>   };
> Please shorten these to leave out OMAP_:
Ok. Will update and send a new version.
> 		pinctrl-single,pins = <
> 			0x24 0x4119   /* gpmc_a18.kpd_row6 PULL_ENA | PULL_UP | WAKEUP_EN | MUX_MODE1 | INPUT_EN */
> 			0x26 0x4119   /* gpmc_a19.kpd_row6 PULL_ENA | PULL_UP | WAKEUP_EN | MUX_MODE1 | INPUT_EN */
> 			...
>
> When we convert them over to use the preprocessor, we can still
> easily replace them.
>
> Regards,
>
> Tony
