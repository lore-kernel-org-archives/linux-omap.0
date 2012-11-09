From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V6 2/2] dmaengine: add helper function to request a slave
 DMA channel
Date: Fri, 9 Nov 2012 14:01:12 -0600
Message-ID: <509D6108.1060304@ti.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>  <1347662517-4210-3-git-send-email-jon-hunter@ti.com>  <1347852805.1943.130.camel@vkoul-udesk3> <201209171159.27359.arnd@arndb.de>  <20120917223619.GC12445@n2100.arm.linux.org.uk>  <1347938035.1943.162.camel@vkoul-udesk3> <5060DDEB.4000600@ti.com>  <1348547701.1943.190.camel@vkoul-udesk3>  <20121016024318.GF24393@S2101-09.ap.freescale.net> <1350355144.1648.5259.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36291 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab2KIUB3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 15:01:29 -0500
In-Reply-To: <1350355144.1648.5259.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Stephen Warren <swarren@nvidia.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Dan Williams <djbw@fb.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 10/15/2012 09:39 PM, Vinod Koul wrote:
> On Tue, 2012-10-16 at 10:43 +0800, Shawn Guo wrote:
>> On Tue, Sep 25, 2012 at 10:05:01AM +0530, Vinod Koul wrote:
>>> On Mon, 2012-09-24 at 17:25 -0500, Jon Hunter wrote:
>>>>> For DT bindings, I think the binding itself shouldn't change based on my
>>>>> work but I would like these same bindings to help build the DMA engine
>>>>> code mappings.
>>>>>
>>>>> Now would it make sense to NOT merge these changes for 3.7 and postpone
>>>>> to 3.8. I can host these patches on a topic branch and merge them when
>>>>> we are ready. I plan to spend some good amount of time on my work this
>>>>> week so we should be ready pretty soon.
>>>>> One these changes are merged, users can start moving to this scheme.
>>>>
>>>> I just wanted to see how things are progressing your side. Did you
>>>> create a topic branch for this? If so let me know where I can find it, I
>>>> did not find a branch on your infradead git tree.
>>>>
>>>> I wanted to pull in the latest patches for some testing. 
>>> Sorry for delay, I had everything ready, but couldn't manage to commit
>>> and push. I have pushed to topic/dmaengine_dt, it is pushing out now...
>>>
>> Vinod,
>>
>> Looks it seemed 3.7-rc1.  Does that mean we have to wait for 3.8, or
>> will it show on later -rc for 3.7?
> Yes this will be merged once we work out the common interface, otherwise
> we will end up redoing interfaces for all drivers.

Hi Vinod,

A few people have been asking me if getting device-tree support for DMA
engine is plan for record for v3.8. I know that you were working through
implementing a common interface and so I wanted to check how that is
going. Do you have any insight to when device-tree support may get added?

Cheers
Jon

