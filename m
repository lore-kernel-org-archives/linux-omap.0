From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Mon, 27 Feb 2012 15:22:48 +0100
Message-ID: <4F4B91B8.8000805@ti.com>
References: <4F22DEF2.5000807@ti.com> <4F44CA82.9060906@atmel.com> <4F460EF2.9010000@ti.com> <4F46609C.8080907@atmel.com> <4F4661DE.90704@ti.com> <4F4B8095.9010005@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51857 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180Ab2B0OXN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 09:23:13 -0500
In-Reply-To: <4F4B8095.9010005@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Stephen Warren <swarren@nvidia.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Thomas Abraham <thomas.abraham@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Ludovic Desroches <ludovic.desroches@atmel.com>

On 2/27/2012 2:09 PM, Nicolas Ferre wrote:
> On 02/23/2012 04:57 PM, Cousson, Benoit :
>> On 2/23/2012 4:51 PM, Nicolas Ferre wrote:
>>> On 02/23/2012 11:03 AM, Cousson, Benoit :
>>>> Salut Nico,
>>>
>>> Coucou Benoit ;-)
>>>
>>>> On 2/22/2012 11:59 AM, Nicolas Ferre wrote:
>>>>> On 01/27/2012 06:29 PM, Cousson, Benoit :
>>>>>> Add some basic helpers to retrieve a DMA controller device_node
>>>>>> and the DMA request line number.
>>>>>>
>>>>>> For legacy reason another API will export the DMA request number
>>>>>> into a Linux resource of type IORESOURCE_DMA.
>>>>>> This API is usable only on system with an unique DMA controller.
>>>>>
>>>>> Hi,
>>>>>
>>>>> I followed that discussion and I like very much the biding that Benoit
>>>>> is proposing. It will help me a lot with my current work on Atmel DMA
>>>>> controller.
>>>>>
>>>>> If I understand correctly, some rework is needed before it can be
>>>>> integrated in a stable git tree (I mean before we can base our work on
>>>>> top of it). So, in the meantime, what should I do to help and make
>>>>> things go forward? to be quite frank, I would be interested to have a
>>>>> working DMA enabled device soon ;-)
>>>>
>>>> Me too, but unfortunately, I was busy trying to add irq_domain and
>>>> fixing issues with SPARSE_IRQ on OMAP :-(
>>>
>>> Been there, loved that ;-)
>>>
>>>>> Do you think that 3.4 is out of reach?
>>>>
>>>> Maybe not, from the comments, it looks like we should add a .xlate
>>>> callback to allow any custom parsing of the DMA nodes attributes.
>>>>
>>>> I'll be more than happy, if you can finalize that patch :-)
>>>
>>> I will try to figure out what I can understand from the irq mechanism of
>>> .xlate and try to see if I can implement it on top of your patch.
>>
>> In fact that dma code is a big copy/paste of the of/gpio one and gpio
>> was already managing .xlate function.
>> I removed it because I thought it was useless for the DMA :-)
>>
>> You might just have to copy the original code...
>
> The thing is that with gpio, we can rely on the gpio_chip structure for
> having a common storage location of such .xlate callbacks.
> In our DMA case, I guess that we should not cling to dmaengine
> infrastructure because not all of us are using it right now.

Yep, that's the main issue compared to GPIO or IRQ.

> So, maybe we should provide some simple "xlate" helpers like the
> irqdomain ones. But I fear that a "callback" directly called from the
> of_get_dma_request() function is not possible (the gpio code model).

I think a well that we cannot much but a simple very abstract callback 
since we do not have any formal DMA representation?

I'm not sure to understand you concern?

> On the other hand, the "cookie" based infrastructure seems a little
> overkill to me. It seems that, in this case, we must establish a
> relation between the DMA controller code and the device tree DMA
> helpers. Please correct me if I am wrong.

Yes, and in our case the DMA controller cannot be specified with 
anything else than a Linux device for the moment.

Regards,
Benoit
