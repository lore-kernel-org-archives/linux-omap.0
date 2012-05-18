From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 18 May 2012 16:20:23 -0600
Message-ID: <4FB6CB27.8020500@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201205182050.00095.arnd@arndb.de> <4FB6BA29.6070400@wwwdotorg.org> <201205182143.55140.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34901 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296Ab2ERWU2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 18:20:28 -0400
In-Reply-To: <201205182143.55140.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 05/18/2012 03:43 PM, Arnd Bergmann wrote:
> On Friday 18 May 2012, Stephen Warren wrote:
>>> The driver can still request the dma line by name "tx" and the subsystem
>>> would pick one out of those with the same name.
>>>
>>> For the majority of cases, we would only need a single dma request line
>>
>> Hmm. Many devices have multiple different FIFOs, and hence multiple DMA
>> request signals (e.g. Tegra I2S has separate RX and TX FIFO, Tegra
>> S/PDIF has 2 FIFOs in each direction). That would require the driver to
>> always use get_by_name() to differentiate between 2/4 options for the
>> same DMA req or 2/4 different DMA requests. Most other bindings allow
>> use of get_by_id() or get_by_name() interchangeably.
> 
> Ok, good point. So we could make the common case that they are numbered
> but not named and require all drivers to use named properties when
> there is the possibility that the device might be connected to multiple
> controllers, but that seems tricky because a driver can start being
> used on a platform that has only one controller and have no dma-name
> property in the device tree but then get used on a different soc
> that actually has multiple controllers.

Indeed.

> So if we do that, we might want to make the dma-names property mandatory
> for every device, and document what the names are.

We could do that, but one more proposal: Add the client's ID/index into
the dmas property, so:

simple 1 req:

dmas = <0 &dmac1 xxx>;

simple 2 req:

dmas = <0 &dmac1 xxx 1 &dmac1 yyy>;

multiple dmacs:

dmas = <0 &dmac1 xxx 0 &dmac2 zzz 1 &dmac1 yyy>;

(i.e. dmas = [client_dma_req_id phandle dma-specifier]*)

(where 0==TX_FIFO, 1=RX_FIFO for example, but could also have
2=TX_FIFO_B, 3=RX_FIFO_B, ...)

Then dma-names would map name to ID, but you'd still need to search all
through the dmas property to find the ID match.

> Another option would be to encode the direction in the property in
> a generic way and provide an API that lets you ask specifically
> for a read, write or readwrite channel out of the ones that are
> available, rather than assuming there is only one kind. Consequently,
> any device that uses more than one read channel or more than one
> write channel would still have to use names to identify them.

I'm not sure that /just/ direction cuts it; Tegra's SPDIF has 2 TX DMAs
("PCM" data and control data) and same for RX. The format above is
roughly the same as what you proposed, but with an explicit ID rather
than direction in the dmas property.
