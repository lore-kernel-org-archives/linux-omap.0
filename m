From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Tue, 9 Aug 2011 23:37:10 +0200
Message-ID: <4E41A886.30205@ti.com>
References: <4E40FC88.5090403@ti.com> <20110809162907.GA630@manju-WNB7PBC4801-0006> <4E4166F0.9050401@ti.com> <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com> <4E4172A8.3030101@ti.com> <20110809205542.GD11568@ponder.secretlab.ca> <4E41A156.3030407@ti.com> <20110809211657.GI11568@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35565 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab1HIVha (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 17:37:30 -0400
In-Reply-To: <20110809211657.GI11568@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 8/9/2011 11:16 PM, Grant Likely wrote:
> On Tue, Aug 09, 2011 at 11:06:30PM +0200, Cousson, Benoit wrote:
>> On 8/9/2011 10:55 PM, Grant Likely wrote:
>>> On Tue, Aug 09, 2011 at 07:47:20PM +0200, Cousson, Benoit wrote:
>>>> On 8/9/2011 7:23 PM, Grant Likely wrote:
>>>>> On Tue, Aug 9, 2011 at 10:57 AM, Cousson, Benoit<b-cousson@ti.com>    wrote:
>>>>>> Hi Manju,
>>>>>>
>>>>>> On 8/9/2011 6:29 PM, G, Manjunath Kondaiah wrote:
>>>>>>>
>>>>>>> Hi Benoit,
>>>>>>>
>>>>>>> On Tue, Aug 09, 2011 at 11:23:20AM +0200, Cousson, Benoit wrote:
>>>>>>>>
>>>>>>>> Hi Grant,
>>>>>>>>
>>>>>>>> Trying to bind hwmod informations with DT, I'm facing a little
>>>>>>>> limitation.
>>>>>>>> A bunch of drivers are using the platform_get_resource_byname, so
>>>>>>>> the name for the resource is needed.
>>>>>>>>
>>>>>>>> The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and
>>>>>>>> IORESOURCE_DMA types of resources.
>>>>>>>
>>>>>>> IORESOURCE_MEM and IORESOURCE_IRQ's are fetched from dt blob and
>>>>>>> it will be part of pdev.
>>>>>>
>>>>>> Yes, but without the proper name in the resource structure. It will be then
>>>>>> impossible to use the platform_get_resource_byname function that is
>>>>>> currently used by a bunch of drivers.
>>>>>
>>>>> There is no analogous mechanism for _byname in the device tree.  The
>>>>> DT binding for a device must explicitly state what order the register
>>>>> ranges are in.  The driver will need to be adapted.
>>>>
>>>> That seems to be a small regression for my point of view. Relying on
>>>> the order is not super safe. This is not very readable either.
>>>> That's for that exact reason that we changed our drivers to use
>>>> platform_get_resource_byname. That's probably the reason why that
>>>> API is there as well.
>>>> For the same IP, the number of entries can vary depending of the SoC
>>>> revision.
>>>> By using the _byname, we can check if the resource is there or not
>>>> without having to care about the position.
>>>
>>> We've done it that way for a very long time with the device tree.  If
>>> you want to do something by name, then propose a binding that will
>>> make it work alongside the existing scheme.
>>>
>>>>
>>>>>>> For IORESOURCE_DMA, you can have property
>>>>>>> "dma-channel" in dtsi file and fetch dma-channel in driver probe
>>>>>>> through "of_property_read_u32()" api.
>>>>>>
>>>>>> That will not be enough to get the name. So maybe something like:
>>>>>>         dmas =<12>, "rx_req",<13>, "tx_req";
>>>>>> will be doable.
>>>>>> The issue is that the name is optional so managing the multiple entries
>>>>>> might be tricky.
>>>>>
>>>>> DMA channels will never show up in the resource structure anyway.
>>>>
>>>> Can you elaborate on that point? AFAIK, IORESOURCE_DMA is already
>>>> used today.
>>>
>>> IORESOURCE_DMA is a Linux construct, as is IORESOURCE_IRQ and
>>> IORESOURCE_MEM.  However, IRQ and MEM can be directly mapped from the
>>> common 'reg' and 'interrupts' bindings used by pretty much all device
>>> tree nodes.  Therefore common code can be written to translate MEM and
>>> IRQ that will always work.  There is no such common binding in place
>>> for DMA regions, so common setup code cannot do it transparently for
>>> the device driver.
>>
>> OK, sure, I get your point now. I was thinking about a "potential"
>> dma support from the core DT, since this is very similar to IRQ.
>>
>> Otherwise, we can do it OMAP specific if nobody else care about
>> that. But I still think it should be useful for other platforms.
>
> I think people care, and it will be a net win, but it does mean you
> need do the work of crafting a binding that will work for a large
> proportion of SoCs.

The devil is in the details, but the way the DMA lines are connected in 
OMAP is similar to IRQ lines, and maybe a little bit simpler.

So starting with a copy/paste of the of_irq file should be a good start.
And then the issues will start:-)

Benoit


>
> g.
>

