From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 4/5] arm/dts: OMAP3: Add interrupt-controller bindings
 for INTC
Date: Fri, 13 Jan 2012 14:01:24 +0100
Message-ID: <4F102B24.7090302@ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com> <1324388398-2683-5-git-send-email-b-cousson@ti.com> <79CD15C6BA57404B839C016229A409A8317A43FC@DBDE01.ent.ti.com> <4F100F6B.2050303@ti.com> <79CD15C6BA57404B839C016229A409A8317A4E77@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52975 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187Ab2AMNBi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 08:01:38 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317A4E77@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On 1/13/2012 1:31 PM, Hiremath, Vaibhav wrote:
> On Fri, Jan 13, 2012 at 16:33:07, Cousson, Benoit wrote:
>> Hi Vaibhav,
>>
>> On 1/13/2012 7:14 AM, Hiremath, Vaibhav wrote:
>>> On Tue, Dec 20, 2011 at 19:09:57, Cousson, Benoit wrote:
>>
>> [...]
>>
>>>> +++ b/arch/arm/boot/dts/omap3.dtsi
>>>> @@ -54,10 +54,12 @@
>>>>    		ranges;
>>>>    		ti,hwmods = "l3_main";
>>>>
>>>> -		intc: interrupt-controller@1 {
>>>> -			compatible = "ti,omap3-intc";
>>>> +		intc: interrupt-controller@48200000 {
>>>> +			compatible = "ti,omap2-intc";
>>>>    			interrupt-controller;
>>>>    			#interrupt-cells =<1>;
>>>> +			ti,intc-size =<96>;
>>> Can we configure/change this field in platform specific .dts file?
>>> OR
>>> Is there condition based configuration possible in DT?
>>
>> I'm not sure to fully understand how your two options differ.
>> Otherwise, yes the DT it can be configured, that why I exposed this
>> attribute.
>> The intc code was already supporting the ti81xx with 128 lines as well,
>> hence the need to make it configurable.
>
> I wanted to use DT configuration completely here, using existing
> omap_init_irq.
> And I personally think, lets not use different implementation only because
> number of interrupts are different.

Sure, that was the goal of that binding. Anyway, my point was that the 
driver was already generic enough to handle OMAP2, OMAP3 and TI81xx.

>> The other option was two handle that in the driver with 2 different
>> compatible strings.
>>
>>> To be specific,
>>>
>>> I am adding support for AM335x EVM (using all your DT support patches),
>>> The device is considered as OMAP3 variant and when it comes to INTC support,
>>> I need to configure it to value "128", rest everything is same
>>> (including base add).
>>>
>>> Can I do something like
>>>
>>> File - am335x-evm.dts
>>>
>>> /include/ "omap3.dtsi"
>>>
>>> ....
>>> Again change the specific fields of " intc: interrupt-controller"?
>>
>> Yes.
>>
>>> ....
>>>
>>> How can this be handled?
>>
>> After the include, you can redefine the node and the hierarchy:
>>
>> +	ocp {
>> +		intc: interrupt-controller@48200000 {
>> +			ti,intc-size =<128>;
>> +		};
>> ...
>>
>> or use the label directly:
>>
>> +&intc: {
>> +	ti,intc-size =<128>;
>> +}
>>
>> You can have a look at the way i2c or twl are using the include so far.
>>
> Thanks, I will trying this now...
> And if it works, then I can submit the patches...

Well, it should in theory :-)

Regards,
Benoit
