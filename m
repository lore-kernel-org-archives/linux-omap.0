From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 17:31:32 +0100
Message-ID: <4F675F64.6070306@atmel.com>
References: <4F22DEF2.5000807@ti.com> <20120317094059.7C2333E08E2@localhost> <4F6734DD.3020203@atmel.com> <201203191406.35064.arnd@arndb.de> <20120319153334.GF16389@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:10105 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161769Ab2CSQcF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 12:32:05 -0400
In-Reply-To: <20120319153334.GF16389@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>
Cc: rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org

On 03/19/2012 04:33 PM, Russell King - ARM Linux :
> On Mon, Mar 19, 2012 at 02:06:34PM +0000, Arnd Bergmann wrote:
>> ==== mmci ====
>> /* in drivers/dma/ste_dma40.c, others in pl330.c, coh901318.c, ... */
>> bool stedma40_filter(struct dma_chan *chan, void *data)
>> {               
>>         struct stedma40_chan_cfg *info = data;
>>         struct d40_chan *d40c = container_of(chan, struct d40_chan, chan);
>>         int err;                
>>         
>>         err = d40_validate_conf(d40c, info);
>>         if (!err)
>>                 d40c->dma_cfg = *info;
>>         d40c->configured = true;
>>         
>>         return err == 0;
>> }
>> EXPORT_SYMBOL(stedma40_filter);
>>
>> /* in mmci.h */
>> struct mmci_platform_data {
>> 	...
>>         bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
>>         void *dma_rx_param;
>>         void *dma_tx_param;
>> };
>>
>> /* in mmci.c */
>> static void __devinit mmci_dma_setup(struct mmci_host *host)
>> {
>> 	...
>>         host->dma_rx_channel = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
>> 	...
>> }
>>
>> ====
>>
>> Whatever we come up with obviously needs to work with both drivers.
>> I think we will end up with something closer to the second one, except
>> that the dma parameters do not come from platform_data but from the
>> #dma-request property, which also identifies the controller and channel.
> 
> Firstly, define what you mean by "the DMA parameters".  Things like burst
> size, register width, register address?  That should all be known by the
> peripheral driver and _not_ be encoded into DT in any way - and this
> information should be passed to the DMA engine driver for the well defined
> API for that purpose.
> 
> Secondly, there are platforms (Samsung) where peripherals are connected
> to more than one DMA controller, and either DMA controller can be used -
> I'm told by Jassi that there's reasons why you'd want to select one or
> other as the target at runtime.
> 
> Whether it's appropriate for DT to know that or not, I'm not certain at
> the moment - I suspect the _right_ solution would be a radical DMA engine
> redesign which moves _all_ slave DMA to a virtual channel representation,
> and for the virtual channels to be scheduled onto a set of physical DMA
> channels over a range of DMA devices.  Obviously, there's restrictions on
> which virtual channels could be scheduled onto which physical channels of
> which DMA devices.

OMG! the dmaengine drivers are already not so obvious to understand. I
fear that trying to mimic some special behaviors within relatively
simple dmaengine drivers will bring confusion and prevent people to
read/contribute and fix those simple ones...

> It seems to me, therefore, that any attempt to come up with some kind of
> DT based representation of the current scheme is doomed to fail, and will
> at some point become obsolete.
> 
> I think instead, rather than trying to fix this now, we persist with what
> we have, but organize an effort to clean up and restructure the DMA engine
> code so that:
> 
> (a) things like the Samsung, and ARM board oddities can be easily dealt
>  with in a driver independent manner.
> (b) get rid of all the duplicated functionality between each different
>  DMA engine implementation, separating this out into core code, and
>  simplifying the drivers.
> 
> The _big_ problem I see is that if we try to represent the existing
> solution in DT, we're going to get locked into that way of doing things
> and then any major restructuring of the DMA engine stuff will become an
> impossibility - especially if we start specifying things by DMA request
> signal numbers on DMA engines.

Even if I understand your point, I wonder what is the solution for us
that have a pretty simple representation of *hardware* to code into DT:
should we wait for a big rework? Should we go for a private DMA binding
for each of us that have just the need for a quite simple representation?

I must say that I am puzzled by recent discussion on the topic (mix of
"channel" and "request" notions, plan for a complete rework of dmaengine
that can delay DT representation of DMA slave-controller relationship,
even my own doubts on the "void *" output parameter, etc.). It seems
that I am not familiar with all those cases and that I cannot go further
with a generic DT representation...

Best regards,
-- 
Nicolas Ferre
