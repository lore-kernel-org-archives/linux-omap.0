From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [RESEND PATCH 2/2] ARM: dts: OMAP2+: Add PMU nodes
Date: Mon, 17 Dec 2012 18:35:10 +0100
Message-ID: <50CF57CE.2080907@ti.com>
References: <1355520397-5759-1-git-send-email-jon-hunter@ti.com> <1355520397-5759-3-git-send-email-jon-hunter@ti.com> <20121217163858.GF16561@e106331-lin.cambridge.arm.com> <50CF4F38.3040500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37623 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107Ab2LQRfX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 12:35:23 -0500
In-Reply-To: <50CF4F38.3040500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 12/17/2012 05:58 PM, Jon Hunter wrote:
> 
> On 12/17/2012 10:38 AM, Mark Rutland wrote:
>> On Fri, Dec 14, 2012 at 09:26:37PM +0000, Jon Hunter wrote:
>>> Add PMU nodes for OMAP2, OMAP3 and OMAP4460 devices.
>>>
>>> Please note that the node for OMAP4460 has been placed in a separate
>>> header file for OMAP4460, because the node is not compatible with
>>> OMAP4430.
>>>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> ---
>>>  arch/arm/boot/dts/omap2.dtsi         |    5 +++++
>>>  arch/arm/boot/dts/omap3.dtsi         |    6 ++++++
>>>  arch/arm/boot/dts/omap4-panda-es.dts |    2 ++
>>>  arch/arm/boot/dts/omap4460.dtsi      |   18 ++++++++++++++++++
>>>  4 files changed, 31 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/omap4460.dtsi
>>>
>>> diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
>>> index 761c4b6..27f5ea1 100644
>>> --- a/arch/arm/boot/dts/omap2.dtsi
>>> +++ b/arch/arm/boot/dts/omap2.dtsi
>>> @@ -26,6 +26,11 @@
>>>  		};
>>>  	};
>>>  
>>> +	pmu {
>>> +		compatible = "arm,arm1136-pmu";
>>> +		interrupts = <3>;
>>> +	};
>>> +
>>>  	soc {
>>>  		compatible = "ti,omap-infra";
>>>  		mpu {
>>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>>> index 1acc261..6c63118 100644
>>> --- a/arch/arm/boot/dts/omap3.dtsi
>>> +++ b/arch/arm/boot/dts/omap3.dtsi
>>> @@ -26,6 +26,12 @@
>>>  		};
>>>  	};
>>>  
>>> +	pmu {
>>> +		compatible = "arm,cortex-a8-pmu";
>>> +		interrupts = <3>;
>>> +		ti,hwmods = "debugss";
>>> +	};
>>> +
>>>  	/*
>>>  	 * The soc node represents the soc top level view. It is uses for IPs
>>>  	 * that are not memory mapped in the MPU view or for the MPU itself.
>>> diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
>>> index 73bc1a6..2a6e344 100644
>>> --- a/arch/arm/boot/dts/omap4-panda-es.dts
>>> +++ b/arch/arm/boot/dts/omap4-panda-es.dts
>>> @@ -5,7 +5,9 @@
>>>   * it under the terms of the GNU General Public License version 2 as
>>>   * published by the Free Software Foundation.
>>>   */
>>> +
>>>  /include/ "omap4-panda.dts"
>>> +/include/ "omap4460.dtsi"
>>>  
>>>  /* Audio routing is differnet between PandaBoard4430 and PandaBoardES */
>>>  &sound {
>>> diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
>>> new file mode 100644
>>> index 0000000..1270890
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/omap4460.dtsi
>>> @@ -0,0 +1,18 @@
>>> +/*
>>> + * Device Tree Source for OMAP4460 SoC
>>> + *
>>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
>>> + *
>>> + * This file is licensed under the terms of the GNU General Public License
>>> + * version 2.  This program is licensed "as is" without any warranty of any
>>> + * kind, whether express or implied.
>>> + */
>>> +
>>> +/ {
>>> +	pmu {
>>> +		compatible = "arm,cortex-a9-pmu";
>>> +		interrupts = <0 54 0x4
>>> +			      0 55 0x4>;
>>
>> In other places I've seen interrupts properties written as:
>>
>> interrupts = < irq1... >,
>>              < irq2... >,
>> 	     < irqN... >;
>>
>> Where each individual interrupt is surrounded by angle brackets. This produces
>> the exact same dtb, but may appear easier to read.
>>
>> This might not be the right time and place to raise it, but it'd be nice if we
>> used one style consistently.
> 
> I see that we do define interrupts like that for other OMAP devices and
> so I can update this to be consistent.
> 
> Benoit, let me know if you want me to resend or if you want to update
> locally.

Yep, I agree with Mark, I don't like this style either.

If you don't mind, I'd prefer you resend the series...

Thanks,
Benoit


