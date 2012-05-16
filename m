From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 16 May 2012 11:01:08 -0500
Message-ID: <4FB3CF44.4040603@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com> <4FA3F308.6030900@ti.com> <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com> <4FB2FEBA.1030404@ti.com> <CAJe_ZhcrMycgOWf6EiGEjz25C1ZTkB1W=33Qqp4rFpcq-5QsDg@mail.gmail.com> <4FB3A87C.1000000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46268 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756540Ab2EPQB2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 12:01:28 -0400
In-Reply-To: <4FB3A87C.1000000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 05/16/2012 08:15 AM, Jon Hunter wrote:
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

By the way, I do see your point. You wish to describe the all the
mappings available to all dma controllers and then set a mapping in the
device tree. Where as I am simply setting a mapping and do not list all
other possibilities (assuming that there some).

What is still unclear to me, is if you use this token approach how
readable is the device-tree? For example, if you have a client that can
use one of two dmac and for each dmac the request/channel number is
different, then by using a global token how can I determine what the
options available for this client are?

Take your example ...

mmc1: mmc@13002000 {
        ...
        dma_tx = <891>   //some platform-wide unique value
        dma_rx = <927>   //some platform-wide unique value
        ...
};

DMAC's Node:-

pdma2: pdma@10800000 {
         .......
	dma_map = <891, 7>,       // Map mmc1_tx onto i/f 7
		  <927, 8>,       // Map mmc1_rx onto i/f 8
	.......
};

But now I have another dmac which has the following options ...

pdma1: pdma@10000000 {
         .......
	dma_map = <598, 2>,       // Map mmc1_tx onto i/f 2
		  <230, 3>,       // Map mmc1_rx onto i/f 3
	.......
};

Other than using a comment or yet another token to represent the client,
it is not clear from the arbitrary token value itself what my options are.

One way around this would be to have an enable/disable flag along with
the token such as ...

mmc1: mmc@13002000 {
        ...
        dma_tx = <891, 1>   // default tx channel
        dma_rx = <927, 1>   // default rx channel
        dma_tx = <598, 0>   // other available tx channel
        dma_rx = <230, 0>   // other available rx channel
        ...
};

That being said, we could take the same approach with using the dmac
phandle instead of the token. So you would have ...


mmc1: mmc@13002000 {
        ...
		// phandle + channel + enable/disable
        dma_tx = <pdma0, 7, 1>   // default tx channel
        dma_rx = <pdma0, 8, 1>   // default rx channel
        dma_tx = <pdma1, 2, 0>   // other available tx channel
        dma_rx = <pdma1, 3, 0>   // other available rx channel
        ...
};

Then you could eliminate the random token and dma map from the dmac.
Seems easier to read too.

Cheers
Jon
