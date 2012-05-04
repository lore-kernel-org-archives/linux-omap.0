From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 4 May 2012 10:22:01 -0500
Message-ID: <4FA3F419.5050707@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53740 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab2EDPW0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 11:22:26 -0400
In-Reply-To: <CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jassi,

On 05/04/2012 01:56 AM, Jassi Brar wrote:
> On 1 May 2012 02:47, Jon Hunter <jon-hunter@ti.com> wrote:
>> From: Jon Hunter <jon-hunter@ti.com>
>>
>> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
>> to add some basic helpers to retrieve a DMA controller device_node and the
>> DMA request/channel information.
>>
>> Aim of DMA helpers
>> - The purpose of device-tree (as far as I understand), is to describe the
>>  capabilites of the hardware. Thinking about DMA controllers purely from the
>>  context of the hardware to begin with, we can describe a device in terms of
>>  a DMA controller as follows ...
>>        1. Number of DMA controllers
>>        2. Number of channels (maybe physical or logical)
>>        3. Mapping of DMA requests signals to DMA controller
>>        4. Number of DMA interrupts
>>        5. Mapping of DMA interrupts to channels
>> - With the above in mind the aim of the DT DMA helper functions is to extract
>>  the above information from the DT and provide to the appropriate driver.
>>  However, due to the vast number of DMA controllers and not all are using a
>>  common driver (such as DMA Engine) it has been seen that this is not a
>>  trivial task.
>>
> Sorry for being slow, but so far I thought DT is only to provide _h/w_
> specific info
> to the _controller_ drivers. It was not supposed to provide any info
> pertaining to
> some API (dmaengine in this case).
> 
> And I believe this is one of few situations where we are better off
> not generalizing
> the interface - pass controller specific info in the controller
> driver's specified format.
> Generalizing only seems to complicate things here, when we anyway have machine
> specific dtb, which could always have clients requesting and the
> controllers given
> dma's info in controller driver's specific format.
> 
> Perhaps I am overlooking the need to generalize. If you think so, please help me
> understand by pointing out some use case for it.

No not really, your points are valid. From reading the previous
discussions one of the items that was clearly lacking was the ability to
represent and identify a device having more than one DMA controller. In
other words, when you request the DMA resource, how do you identify
which DMA controller in the system that resource belongs too. With DMA
engine there are ways we can do this.

However, thinking about this now. Instead of passing specific DMA engine
parameters to the register function may be we can pass a generic void *
pointer with the information and completely abstract the binding from
DMA engine. This is probably a better approach.

Cheers
Jon
