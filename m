From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 26 Jul 2012 10:53:46 -0500
Message-ID: <5011680A.6040400@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>  <500EF27F.6050905@ti.com> <1343284960.1726.8978.camel@vkoul-udesk3>  <201207260714.34540.arnd@arndb.de> <1343302083.1726.9027.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39627 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104Ab2GZPyH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 11:54:07 -0400
In-Reply-To: <1343302083.1726.9027.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org


On 07/26/2012 06:28 AM, Vinod Koul wrote:
> On Thu, 2012-07-26 at 07:14 +0000, Arnd Bergmann wrote:
>> On Thursday 26 July 2012, Vinod Koul wrote:
>>>>> But from a client POV it makes sense as with the given direction you
>>>>> would need a specific request line for a channel. So this is right.
>>>>> But direction is something I don't expect to be used for "give me a
>>>>> channel" 
>>>>
>>>> Ok. The thought was that the user would have the following means of
>>>> requesting a channel ...
>>>>
>>>> 1. By name
>>> Bare name maynot be enough. In a dmac we have many channels which one to
>>> choose?
>> The name is what is associated with the property in the client device
>> node, which describes everything the dmac driver needs to know.
>> If the dmac needs to pick a specific channel, it can find out from the
>> "dmas" property in combination with that name. If it is allowed to
>> pick any channel, it doesn't need to bother.
> dmac doesn't pick a channel. They don't come into picture till dmaengine
> and client have agreed on channel. And then channel callback in invoked,
> still it doesn't know which client.

I think what Arnd meant was that dmaengine (not the dmac) would use the
DT node and name information to extract the dma mapping information from
the device tree and provide a channel back to the client. So yes the
dmac is not involved here.

By the way, when I said "by name" above (and probably this was not
clear) but it should have been "DT node and name". So really a channel
is requested by ...

1. DT node and a name
2. DT node and a filter parameter (flags)
3. DT node, a name and a filter parameter (flags)

The DT node points us to the specific device in the DT, say an MMC node,
and the MMC node then contains the DMA mapping info. The device node may
have the mapping information have one or more DMA requests/channels and
so then the name and/or flags is used to determine which the client needs.

Sorry hope that this is a little clearer.

Cheers
Jon
