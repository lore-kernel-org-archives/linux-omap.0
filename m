From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Thu, 23 Feb 2012 16:57:18 +0100
Message-ID: <4F4661DE.90704@ti.com>
References: <4F22DEF2.5000807@ti.com> <4F44CA82.9060906@atmel.com> <4F460EF2.9010000@ti.com> <4F46609C.8080907@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51221 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab2BWP5g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 10:57:36 -0500
In-Reply-To: <4F46609C.8080907@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Stephen Warren <swarren@nvidia.com>, Thomas Abraham <thomas.abraham@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Ludovic Desroches <ludovic.desroches@atmel.com>

On 2/23/2012 4:51 PM, Nicolas Ferre wrote:
> On 02/23/2012 11:03 AM, Cousson, Benoit :
>> Salut Nico,
>
> Coucou Benoit ;-)
>
>> On 2/22/2012 11:59 AM, Nicolas Ferre wrote:
>>> On 01/27/2012 06:29 PM, Cousson, Benoit :
>>>> Add some basic helpers to retrieve a DMA controller device_node
>>>> and the DMA request line number.
>>>>
>>>> For legacy reason another API will export the DMA request number
>>>> into a Linux resource of type IORESOURCE_DMA.
>>>> This API is usable only on system with an unique DMA controller.
>>>
>>> Hi,
>>>
>>> I followed that discussion and I like very much the biding that Benoit
>>> is proposing. It will help me a lot with my current work on Atmel DMA
>>> controller.
>>>
>>> If I understand correctly, some rework is needed before it can be
>>> integrated in a stable git tree (I mean before we can base our work on
>>> top of it). So, in the meantime, what should I do to help and make
>>> things go forward? to be quite frank, I would be interested to have a
>>> working DMA enabled device soon ;-)
>>
>> Me too, but unfortunately, I was busy trying to add irq_domain and
>> fixing issues with SPARSE_IRQ on OMAP :-(
>
> Been there, loved that ;-)
>
>>> Do you think that 3.4 is out of reach?
>>
>> Maybe not, from the comments, it looks like we should add a .xlate
>> callback to allow any custom parsing of the DMA nodes attributes.
>>
>> I'll be more than happy, if you can finalize that patch :-)
>
> I will try to figure out what I can understand from the irq mechanism of
> .xlate and try to see if I can implement it on top of your patch.

In fact that dma code is a big copy/paste of the of/gpio one and gpio 
was already managing .xlate function.
I removed it because I thought it was useless for the DMA :-)

You might just have to copy the original code...

> I will keep you informed...

Thanks for the help,
Benoit
