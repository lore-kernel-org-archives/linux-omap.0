From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 24 Jul 2012 14:07:43 -0500
Message-ID: <500EF27F.6050905@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>  <201207171924.33756.arnd@arndb.de> <1342756850.1726.74.camel@vkoul-udesk3>  <201207200839.24259.arnd@arndb.de> <1342777047.1726.435.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39126 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756206Ab2GXTII (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 15:08:08 -0400
In-Reply-To: <1342777047.1726.435.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>

Hi Vinod,

On 07/20/2012 04:37 AM, Vinod Koul wrote:
> On Fri, 2012-07-20 at 08:39 +0000, Arnd Bergmann wrote:
>> On Friday 20 July 2012, Vinod Koul wrote:
>>>> Required property:
>>>>     dmas: list of one or more dma specifiers, each consisting of
>>>>      - phandle pointing to dma controller node
>>>>      - flags word, a bit map that can hold these flags
>>>>        * 0x00000001 channel can be used for transfer from device
>>>>        * 0x00000002 channel can be user for transfer to device
>>>
>>> Is this for identifying which channel is for TX and RX? If not I am not
>>> sure I understood it well
>>
>> Yes, but we can potentially add more flags here.
>>
>> The argument we had when coming up with this was roughly:
>>
>> * we need to identify which specifiers are referring to the same
>>   conceptual channel and can be used as alternatives
>> * this could be done just using the dma-names property, but making
>>   dma-names mandatory adds complexity for everyone.
>> * Most devices have just one or two channels, and if they have two,
>>   there is usually one input and one output.
>>
>> => if the common dmaengine code can find out whether a channel is
>>   input or output without looking at the dmac driver specific configuration,
>>   we don't need to add dma-names in most cases, but just let the client
>>   driver ask for "give me a channel with these flags".
> No we don't export the direction of the channel and usually channel can
> be configured either way.

So yes I can see that a channel itself could be configured to support a
given direction, but when we ask for a channel via dma_request_channel()
we are going to get a channel that matches the criteria we pass using
the filter parameter. So here the thinking was that "flags" is a filter
parameter that the user could specify and one example being direction
but it could be something else too.

> But from a client POV it makes sense as with the given direction you
> would need a specific request line for a channel. So this is right.
> But direction is something I don't expect to be used for "give me a
> channel" 

Ok. The thought was that the user would have the following means of
requesting a channel ...

1. By name
2. By a filter parameter (flags)
3. By name and a filter parameter

So we would have the following APIs ...

struct dma_chan
*of_dma_request_channel(struct device_node *node, unsigned int flags);
struct dma_chan
*of_dma_request_named channel(struct device_node *node, char *name,
unsigned int flags);

In both of these the filter parameter flags is optional.

Let me know your thoughts on this.

Cheers
Jon

