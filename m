From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V6 2/2] dmaengine: add helper function to request a slave
 DMA channel
Date: Mon, 24 Sep 2012 17:25:47 -0500
Message-ID: <5060DDEB.4000600@ti.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>  <1347662517-4210-3-git-send-email-jon-hunter@ti.com>  <1347852805.1943.130.camel@vkoul-udesk3> <201209171159.27359.arnd@arndb.de>  <20120917223619.GC12445@n2100.arm.linux.org.uk> <1347938035.1943.162.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53872 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab2IXW0W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 18:26:22 -0400
In-Reply-To: <1347938035.1943.162.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Dan Williams <djbw@fb.com>

Hi Vinod,

On 09/17/2012 10:13 PM, Vinod Koul wrote:
> On Mon, 2012-09-17 at 23:36 +0100, Russell King - ARM Linux wrote:
>>>
>>> I believe that Jon is on vacation this week, so if this is the only issue
>>> holding up the merge, maybe you can change this in his patch directly, or
>>> I can send an updated version if you prefer.
>>
>> I worry that too much is going on here too quickly.  We have some people
>> working on changing the way DMA engine selects channels.  Meanwhile we
>> have other people trying to create an OF DMA engine API.
>>
>> It seems that Vinod's working on a way for platforms to specify bindings
>> to the DMA engine code, and the DMA engine code itself selects the
>> appropriate channel.  This patch, on the other hand, introduces a set of
>> translation functions which need to be provided by platform code,
>> which returns the dma_chan pointer.
>>
>> This sounds like a recipe for a total abortion of interfaces.  Only one
>> of those two activities should be going on at any one time, or if they
>> have to occur, they need coordination so that the we don't end up with
>> two totally different schemes.
>>
>> In the mad rush to DTify everything, don't make hasty decisions, because
>> it is very difficult to change it later - especially something like this
>> which defines how DT encodes this information.
> We discussed this in KS and IMHO we need to merge these two approaches.
> 
> For DT bindings, I think the binding itself shouldn't change based on my
> work but I would like these same bindings to help build the DMA engine
> code mappings.
> 
> Now would it make sense to NOT merge these changes for 3.7 and postpone
> to 3.8. I can host these patches on a topic branch and merge them when
> we are ready. I plan to spend some good amount of time on my work this
> week so we should be ready pretty soon.
> One these changes are merged, users can start moving to this scheme.

I just wanted to see how things are progressing your side. Did you
create a topic branch for this? If so let me know where I can find it, I
did not find a branch on your infradead git tree.

I wanted to pull in the latest patches for some testing.

Cheers
Jon
