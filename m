From: Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCH V6 1/2] of: Add generic device tree DMA helpers
Date: Wed, 19 Sep 2012 06:19:06 +0800
Message-ID: <5058F35A.8040702@firmworks.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com> <1347662517-4210-2-git-send-email-jon-hunter@ti.com> <20120915001431.GB12445@n2100.arm.linux.org.uk> <201209172042.11860.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rs130.luxsci.com ([72.32.115.17]:43341 "EHLO rs130.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351Ab2IRWUQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Sep 2012 18:20:16 -0400
In-Reply-To: <201209172042.11860.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Vinod Koul <vinod.koul@intel.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Dan Williams <djbw@fb.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, linux-omap <linux-omap@vger.kernel.org>

On 9/18/2012 4:42 AM, Arnd Bergmann wrote:
> On Saturday 15 September 2012, Russell King - ARM Linux wrote:
>>
>> On Fri, Sep 14, 2012 at 05:41:56PM -0500, Jon Hunter wrote:
>>> 3. Supporting legacy devices not using DMA Engine
>>>
>>>    These devices present a problem, as there may not be a uniform way to easily
>>>    support them with regard to device tree. Ideally, these should be migrated
>>>    to DMA engine. However, if this is not possible, then they should still be
>>>    able to use this binding, the only constaint imposed by this implementation
>>>    is that when requesting a DMA channel via of_dma_request_slave_channel(), it
>>>    will return a type of dma_chan.
>>
>> As far as devices not using DMA engine, the answer is we don't support
>> their specification in the DT model.  Note that the legacy OMAP DMA
>> API is scheduled for removal next year, so it's not going to be around
>> that much longer.
> 
> There are a few platforms using the ISA DMA API (rpc, h720x, shark, footbridge),
> and I agree that they are unlikely to see OF support,

(Warning - historical rambling follows)

There is a delicious irony here with respect to Shark.  Shark has real
Open Firmware.  It's the platform that I used for the first OFW port to
ARM.  We (the Shark design team) had a version of NetBSD that would run
on Shark without any native drivers, calling into the Open Firmware
drivers.  It was very useful for bringup.

I wonder when was the last time anyone turned on a Shark?  I ran my mail
server on one until 8 years ago, when the incoming spam load began to
saturate the 10 Mbit Ethernet.  Shark had decent computational power,
but the I/O system, built around a low cost PC I/O chip, didn't have
much bandwidth.

Also in that time frame (early 2000s), some of us Shark designers
managed to grab a pile of Sharks that HP was going to scrap.  (HP had
inherited them as part of Compaq, who had acquired them as part of
Digital.)  We used them as production unit testers for a consumer gadget
that we were building.  But, alas, even that usage fell to the wayside.
 I redesigned the tester around an ATSAM7 chip and put the entire test
setup into a tiny box.  I still have a couple of Sharks, but they
haven't been turned on for at least 6 years.

Is there ever a point when old architectures leave the Linux tree, or
will people have to see grep hits from them until the end of time?


 although if they did, it
> wouldn't be unreasonable to encode their DMA channels using the same binding.
> 
> The other ones that are currently around with their own DMA implementation are
> 
> bcmring --> platform is going away
> samsung --> gradually getting moved to dmaengine, already has its own binding
>             that needs to be replaced with this one, so best do it at the same
>             time.
> tegra   --> old dma code gone in 3.7
> pxa/mmp --> dmaengine implementation being worked on, should wait for that.
> msm     --> dma implementation only used by two drivers (serial and mmc). 
> 
> Outside of arch/arm, at least sh, cris, unicore32 and blackfin have their
> own dma APIs based on the ISA interfaces. I don't currently see any of them
> moving towards DT, but it's definitely possible. 
> 
> Among the above MSM seems to be the most likely candidate to use the binding
> before moving to DT. The msm_sdcc driver is (like much of the msm platform
> code) lagging far behind the internel version that qualcomm have, and the
> device tree binding they are using is incompatible with the common MMC
> binding (and of course the DMA binding here) as well. For getting MSM up
> to speed compared with the other platforms, they have to use proper DT
> bindings as well as proper DMA engine support. Between those two, I'd prefer
> fixing the DT binding first, in order to limit the amount of changes that
> have to be done to external device tree files.
> 
> 	Arnd
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
