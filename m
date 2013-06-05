From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 3/3] ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ
 line
Date: Wed, 05 Jun 2013 09:41:28 +0200
Message-ID: <51AEEBA8.1070301@epfl.ch>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org> <1370040357-25794-4-git-send-email-khilman@linaro.org> <51AC667D.6070409@epfl.ch> <87mwr6kfbm.fsf@linaro.org>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:50053 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752141Ab3FEHlg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jun 2013 03:41:36 -0400
In-Reply-To: <87mwr6kfbm.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 06/04/2013 12:19 AM, Kevin Hilman wrote:
> Florian Vaussard <florian.vaussard@epfl.ch> writes:
>
>> Hello Kevin,
>>
>> On 06/01/2013 12:45 AM, Kevin Hilman wrote:
>>> On most OMAP3 platforms, the twl4030 IRQ line is connected to the
>>> SYS_NIRQ line on OMAP.  Therefore, configure the defaults for the
>>> SYS_NIRQ pin in the twl4030 DTS file.
>>>
>>> Boards that hook up the twl4030 differently can easily override this
>>> in their board-specific DTS file.
>>>
>>> This allows RTC wake from off-mode to work again on OMAP3-based
>>> platforms with twl4030.  Tested on 3530/Beagle, 3730/Beagle-xM,
>>> 3530/Overo, 3730/Overo-STORM.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>>> ---
>>>    arch/arm/boot/dts/twl4030.dtsi | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
>>> index b3034da..c7fe9f6 100644
>>> --- a/arch/arm/boot/dts/twl4030.dtsi
>>> +++ b/arch/arm/boot/dts/twl4030.dtsi
>>> @@ -13,6 +13,8 @@
>>>    	compatible = "ti,twl4030";
>>>    	interrupt-controller;
>>>    	#interrupt-cells = <1>;
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&twl4030_pins>;
>>>
>>>    	rtc {
>>>    		compatible = "ti,twl4030-rtc";
>>> @@ -92,3 +94,18 @@
>>>    		#pwm-cells = <2>;
>>>    	};
>>>    };
>>> +
>>> +&omap3_pmx_core {
>>
>> Here you are making the TWL4030 to explicitly depend on OMAP3. Could
>> this chip be used by another target? If the case, I would put this
>> piece of code in the files including twl4030. Otherwise it's ok here.
>
> I talked this over with Tony before posting.  In theorry, it could be
> used on other platforms.  In practice, it's only used on OMAP.  We can
> easily move this to board files if needed later, but thought it would be
> simpler to put it here.  I'll let Benoit decide.
>

Ok, so I am fine with your approach. If need arises later, we can have
a .dtsi file in-between to make the glue layer and avoid duplication inside
board files.

Regards,

Florian
