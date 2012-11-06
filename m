From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 1/6] ARM/dts: omap4-panda: Add pinmux configuration for
 HDMI
Date: Mon, 5 Nov 2012 23:24:41 -0600
Message-ID: <50989F19.70401@ti.com>
References: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com> <1352121259-5836-2-git-send-email-tomi.valkeinen@ti.com> <5097BC67.5050508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57910 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256Ab2KFE1I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 23:27:08 -0500
In-Reply-To: <5097BC67.5050508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, s-guiriec@ti.com

Hi Tomi,

On 11/05/2012 07:17 AM, Tomi Valkeinen wrote:
> Hi Ricardo,
>
> On 2012-11-05 15:14, Tomi Valkeinen wrote:
>> From: Ricardo Neri <ricardo.neri@ti.com>
>>
>> Add the pinmux configuration for HDMI and TPD12S015A. Configure the
>> gpios for the TPD12S015A and SDA, SCL and CEC for HDMI.
>>
>> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   arch/arm/boot/dts/omap4-panda-a4.dts |   17 +++++++++++++++++
>>   arch/arm/boot/dts/omap4-panda.dts    |   18 ++++++++++++++++++
>>   arch/arm/boot/dts/omap4-pandaES.dts  |    9 +++++++++
>>   3 files changed, 44 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/omap4-panda-a4.dts
>
> Ricardo, I modified this and the other dts patch to add new .dts files
> for the board revisions with external pull on the SCL/SDA lines. Can you
> verify that these are correct?

I verified the pinmux values to make sure that the OMAP internal pull is 
not enabled in Pandaboard A4/4430 ES2.3+. It looks correct to me.

I also tested it on 4430 ES2.1 and 4430 ES2.3 SDPs and works fine.

BR,

Ricardo

Tested-by: Ricardo Neri <ricardo.neri@ti.com>
Reviewed-by: Ricardo Neri <ricardo.neri@ti.com>

>
>   Tomi
>
>> diff --git a/arch/arm/boot/dts/omap4-panda-a4.dts b/arch/arm/boot/dts/omap4-panda-a4.dts
>> new file mode 100644
>> index 0000000..75466d2
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap4-panda-a4.dts
>> @@ -0,0 +1,17 @@
>> +/*
>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +/include/ "omap4-panda.dts"
>> +
>> +/* Pandaboard Rev A4+ have external pullups on SCL & SDA */
>> +&dss_hdmi_pins {
>> +	pinctrl-single,pins = <
>> +		0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
>> +		0x5c 0x100	/* hdmi_scl.hdmi_scl INPUT | MODE 0 */
>> +		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
>> +		>;
>> +};
>> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
>> index e8f927c..8060f5b 100644
>> --- a/arch/arm/boot/dts/omap4-panda.dts
>> +++ b/arch/arm/boot/dts/omap4-panda.dts
>> @@ -65,6 +65,8 @@
>>   			&twl6040_pins
>>   			&mcpdm_pins
>>   			&mcbsp1_pins
>> +			&dss_hdmi_pins
>> +			&tpd12s015_pins
>>   	>;
>>
>>   	twl6040_pins: pinmux_twl6040_pins {
>> @@ -92,6 +94,22 @@
>>   			0xc4 0x100	/* abe_mcbsp1_fsx.abe_mcbsp1_fsx INPUT | MODE0 */
>>   		>;
>>   	};
>> +
>> +	dss_hdmi_pins: pinmux_dss_hdmi_pins {
>> +		pinctrl-single,pins = <
>> +			0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
>> +			0x5c 0x118	/* hdmi_scl.hdmi_scl INPUT PULLUP | MODE 0 */
>> +			0x5e 0x118	/* hdmi_sda.hdmi_sda INPUT PULLUP | MODE 0 */
>> +		>;
>> +	};
>> +
>> +	tpd12s015_pins: pinmux_tpd12s015_pins {
>> +		pinctrl-single,pins = <
>> +			0x22 0x3	/* gpmc_a17.gpio_41 OUTPUT | MODE3 */
>> +			0x48 0x3	/* gpmc_nbe1.gpio_60 OUTPUT | MODE3 */
>> +			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
>> +		>;
>> +	};
>>   };
>>
>>   &i2c1 {
>> diff --git a/arch/arm/boot/dts/omap4-pandaES.dts b/arch/arm/boot/dts/omap4-pandaES.dts
>> index d4ba43a..73bc1a6 100644
>> --- a/arch/arm/boot/dts/omap4-pandaES.dts
>> +++ b/arch/arm/boot/dts/omap4-pandaES.dts
>> @@ -22,3 +22,12 @@
>>   		"AFML", "Line In",
>>   		"AFMR", "Line In";
>>   };
>> +
>> +/* PandaboardES has external pullups on SCL & SDA */
>> +&dss_hdmi_pins {
>> +	pinctrl-single,pins = <
>> +		0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
>> +		0x5c 0x100	/* hdmi_scl.hdmi_scl INPUT | MODE 0 */
>> +		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
>> +		>;
>> +};
>>
>
>
