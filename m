From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Thu, 15 Mar 2012 17:30:49 +0100
Message-ID: <4F621939.9040906@ti.com>
References: <4F22DEF2.5000807@ti.com> <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com> <201203150922.06379.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33851 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030656Ab2COQbS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 12:31:18 -0400
In-Reply-To: <201203150922.06379.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Thierry Reding <thierry.reding@avionic-design.de>

On 3/15/2012 10:22 AM, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Nicolas Ferre wrote:
>> Add some basic helpers to retrieve a DMA controller device_node and the
>> DMA request specifications. By making DMA controllers register a generic
>> translation function, we allow the management of any type of DMA requests
>> specification.
>> The void * output of an of_dma_xlate() function that will be implemented
>> by the DMA controller can carry any type of "dma-request" argument.
>>
>> The DMA client will search its associated DMA controller in the list and
>> call the registered of_dam_xlate() function to retrieve the request values.
>>
>> One simple xlate function is provided for the "single number" type of
>> request binding.
>>
>> This implementation is independent from dmaengine so it can also be used
>> by legacy drivers.
>>
>> For legacy reason another API will export the DMA request number into a
>> Linux resource of type IORESOURCE_DMA.
>
> This looks very good. I missed the first version of this patch, but was
> thinking of very similar bindings.
>
>> +Client drivers should specify the DMA request property using a phandle to
>> +the controller. If needed, the DMA request identity on that controller is then
>> +added followed by optional request specifications.
>> +
>> +Required property:
>> +    - dma-request: List of phandle + dma-request + request specifications,
>> +      one group per request "line".
>> +Optional property:
>> +    - dma-request-names: list of strings in the same order as the dma-request
>> +      in the dma-request property.
>> +
>> +
>> +Example:
>> +
>> +	i2c1: i2c@1 {
>> +		...
>> +		dma-request =<&sdma 2&sdma 3>;
>> +		dma-request-names = "tx", "rx";
>> +		...
>> +	};
>
> This is slightly different from how the proposed pwm binding works that
> Thierry is working on, which uses an arbitrary property name instead of
> requiring the use of a specific property but then allowing to give names
> in another property.
>
> I don't care much which way it's done, but please try to agree on one
> approach that is used for both.
>
> The one you have here is already used by reg and irq, while the other
> one is used in gpio.

This was done like IRQ on purpose, because an Interrupt ReQuest line and 
a DMA Request line are really similar for the HW point of view at IP level.
I'm not sure what Thierry have done for pwm, but I thing that having the 
same scheme for reg, irq and dma was what we agreed with Grant during 
Plumbers.

GPIO scheme will be probably good enough as well, but the idea was to be 
consistent in the binding for similar information.

Regards,
Benoit
