From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Tue, 9 Aug 2011 19:47:20 +0200
Message-ID: <4E4172A8.3030101@ti.com>
References: <4E40FC88.5090403@ti.com> <20110809162907.GA630@manju-WNB7PBC4801-0006> <4E4166F0.9050401@ti.com> <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60772 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754286Ab1HIRrg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Aug 2011 13:47:36 -0400
In-Reply-To: <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 8/9/2011 7:23 PM, Grant Likely wrote:
> On Tue, Aug 9, 2011 at 10:57 AM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Hi Manju,
>>
>> On 8/9/2011 6:29 PM, G, Manjunath Kondaiah wrote:
>>>
>>> Hi Benoit,
>>>
>>> On Tue, Aug 09, 2011 at 11:23:20AM +0200, Cousson, Benoit wrote:
>>>>
>>>> Hi Grant,
>>>>
>>>> Trying to bind hwmod informations with DT, I'm facing a little
>>>> limitation.
>>>> A bunch of drivers are using the platform_get_resource_byname, so
>>>> the name for the resource is needed.
>>>>
>>>> The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and
>>>> IORESOURCE_DMA types of resources.
>>>
>>> IORESOURCE_MEM and IORESOURCE_IRQ's are fetched from dt blob and
>>> it will be part of pdev.
>>
>> Yes, but without the proper name in the resource structure. It will be then
>> impossible to use the platform_get_resource_byname function that is
>> currently used by a bunch of drivers.
>
> There is no analogous mechanism for _byname in the device tree.  The
> DT binding for a device must explicitly state what order the register
> ranges are in.  The driver will need to be adapted.

That seems to be a small regression for my point of view. Relying on the 
order is not super safe. This is not very readable either. That's for 
that exact reason that we changed our drivers to use 
platform_get_resource_byname. That's probably the reason why that API is 
there as well.
For the same IP, the number of entries can vary depending of the SoC 
revision.
By using the _byname, we can check if the resource is there or not 
without having to care about the position.

>>> For IORESOURCE_DMA, you can have property
>>> "dma-channel" in dtsi file and fetch dma-channel in driver probe
>>> through "of_property_read_u32()" api.
>>
>> That will not be enough to get the name. So maybe something like:
>>         dmas =<12>, "rx_req",<13>, "tx_req";
>> will be doable.
>> The issue is that the name is optional so managing the multiple entries
>> might be tricky.
>
> DMA channels will never show up in the resource structure anyway.

Can you elaborate on that point? AFAIK, IORESOURCE_DMA is already used 
today.

> The
> common code only takes care of translating IRQ and register ranges.
> For DMA you'll need a binding for the dma channels.  You can either
> make them explicitly ordered, or use different property names for each
> of the dma channels.

FWIW, DMA channel != DMA request. The DMA request is a physical line 
that is connected to a DMA controller. It is similar to an IRQ connected 
to an interrupt controller. It is a HW resource like an IRQ.
The DMA channel is a logical entry in the DMA controller that will be 
used by the driver.

>> BTW, it's strange that a default support does not exist for dma request (and
>> not channel).
>> The mechanism is similar to irq line, and quite standard to many SoC AFAIK.
>> Or maybe I missed it.
>
> DMA channels haven't historically had the same global scope that irq
> numbers have.  There hasn't been a pressing need up to now to have
> common infrastructure, though it is probably a good idea to define a
> common binding.

Cool, I think so as well.

Regards,
Benoit
