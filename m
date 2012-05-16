From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 16 May 2012 09:44:24 -0600
Message-ID: <4FB3CB58.4050107@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com> <4FA3F308.6030900@ti.com> <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com> <4FB2FEBA.1030404@ti.com> <CAJe_ZhcrMycgOWf6EiGEjz25C1ZTkB1W=33Qqp4rFpcq-5QsDg@mail.gmail.com> <4FB3A87C.1000000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:36716 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab2EPPo3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 11:44:29 -0400
In-Reply-To: <4FB3A87C.1000000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 05/16/2012 07:15 AM, Jon Hunter wrote:
> Hi Jassi,
> 
> On 05/16/2012 07:37 AM, Jassi Brar wrote:
>> Hi Jon,
>>
>> On 16 May 2012 06:41, Jon Hunter <jon-hunter@ti.com> wrote:
>>> On 05/04/2012 02:01 PM, Jassi Brar wrote:
>>>>
>>>> +       i2c1: i2c@1 {
>>>> +               ...
>>>> +               dma = <&sdma 2 1 &sdma 3 2>;
>>>> +               ...
>>>> +       };
>>>>>
>>>> I see this requires a client driver to specify a particular req_line on a
>>>> particular dma controller. I am not sure if this is most optimal.
>>>
>>> Actually, no. The phandle in the DT specifies the DMA controller to use.
>>> Then the client simply asks for a channel with a particular property,
>>> for example, DMA_MEM_TO_DEV (ie. TX) and the channel information is return.
>>>
>> See below.
>>
>>>> I think such client->req_line map should be provided to the dmac controller
>>>> driver via its dt node in some format. The dmac driver could then populate
>>>> a dma_chan, or similar, only for that req_line and not for the unused one
>>>> which otherwise could also have served the same client.
>>>>
>>>> Ideally the I2C driver should simply ask, say, a channel for TX and another
>>>> for RX, everything else should already be setup via dmac's dt nodes.
>>>
>>> Yes that is the intention here.
>>>
>> But the client is required to specify the dmac that would serve it.
>> Which is more
>> than simply asking for "some suitable channel".
> 
> No this is not the case with what I propose. The client knows nothing
> about the dmac.

I think you're both talking about slightly different things.

Jon: You're talking about the driver code.
Jassi: You're talking about the device tree.

By including a property in the DMA client's DT node that describes which
DMA controller services it, the device (the DT node) "knows" about the
DMA controllers.

By moving the information to the DMA controller and specifying which DMA
clients can be serviced, that DMA client DT node no longer contains any
information about the DMA controller that serves it, and hence it's not
bound to a single controller, and hence can select from 1 of n
controllers at run-time if applicable given the HW.

Either way, the DMA client driver is just going to call some DMA channel
request API, and hence not know anything directly about the DMA controller.
