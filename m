From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 04 May 2012 12:30:23 -0600
Message-ID: <4FA4203F.3070000@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201205041556.38918.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44769 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab2EDSa1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 14:30:27 -0400
In-Reply-To: <201205041556.38918.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 05/04/2012 09:56 AM, Arnd Bergmann wrote:
> On Monday 30 April 2012, Jon Hunter wrote:
>> From: Jon Hunter <jon-hunter@ti.com>
>>
>> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
>> to add some basic helpers to retrieve a DMA controller device_node and the
>> DMA request/channel information.
...
>>   Forgetting device tree for now, some drivers use strings to represent a
>>   DMA channel instead of using an integer. I assume that these drivers then
>>   employ some sort of look-up table to convert the string into a channel
>>   number/index that the hardware understands. If this assumption is correct
>>   then when moving to a device tree implementation having such look-up tables
>>   in the driver should no longer be necessary as the device tree will provide
>>   the mapping of channel index/number to the device. Furthermore, it makes
>>   sense that device tree uses integers to represent channel as opposed to
>>   strings to save the driver having to convert the string into a integer at
>>   some later stage.
...
> I think you can actually use strings, too, as long as you use a fixed number
> of cells.
> 
> Wouldn't something like this work:?
...
> 	some-device {
> 		compatible = "something";
> 		dmas = <&dma-controller1>, "some-dma",
> 			<&dma-controller2 1 2 3>;
> 	}

The idea of mixing integer cells and strings in the same property has
come up before for other bindings, but been rejected. IIRC, there are
issues such as alignment of the integers after the string (they are not
aligned in the DTB) which can cause unaligned accesses, and perhaps
other issues I fail to recall - perhaps because it's no longer possible
to skip from the &dma-controller1 phandle to the &dma-controller2
phandle using #dma-cells, but rather you need to use strlen() and hence
involve the DMA controller driver itself (otherwise, how do you know
it's a string?) rather than just the core DMA property parsing code.
