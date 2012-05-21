From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Mon, 21 May 2012 11:33:52 -0600
Message-ID: <4FBA7C80.4080801@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201205182143.55140.arnd@arndb.de> <4FB6CB27.8020500@wwwdotorg.org> <201205190844.03654.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34295 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808Ab2EURd4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 13:33:56 -0400
In-Reply-To: <201205190844.03654.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 05/19/2012 02:44 AM, Arnd Bergmann wrote:
> On Friday 18 May 2012, Stephen Warren wrote:
>> On 05/18/2012 03:43 PM, Arnd Bergmann wrote:
> 
>>> So if we do that, we might want to make the dma-names property mandatory
>>> for every device, and document what the names are.
>>
>> We could do that, but one more proposal: Add the client's ID/index into
>> the dmas property, so:
>>
>> simple 1 req:
>>
>> dmas = <0 &dmac1 xxx>;
>>
>> simple 2 req:
>>
>> dmas = <0 &dmac1 xxx 1 &dmac1 yyy>;
>>
>> multiple dmacs:
>>
>> dmas = <0 &dmac1 xxx 0 &dmac2 zzz 1 &dmac1 yyy>;
>>
>> (i.e. dmas = [client_dma_req_id phandle dma-specifier]*)
>>
>> (where 0==TX_FIFO, 1=RX_FIFO for example, but could also have
>> 2=TX_FIFO_B, 3=RX_FIFO_B, ...)
>>
>> Then dma-names would map name to ID, but you'd still need to search all
>> through the dmas property to find the ID match.
> 
> Again, this would probably work, but it adds complexity and inconsistency
> for the common case, as nothing else requires these. I think it's much
> better than putting the information into the dma controller node, but
> not ideal.
> 
>>> Another option would be to encode the direction in the property in
>>> a generic way and provide an API that lets you ask specifically
>>> for a read, write or readwrite channel out of the ones that are
>>> available, rather than assuming there is only one kind. Consequently,
>>> any device that uses more than one read channel or more than one
>>> write channel would still have to use names to identify them.
>>
>> I'm not sure that just direction cuts it; Tegra's SPDIF has 2 TX DMAs
>> ("PCM" data and control data) and same for RX. The format above is
>> roughly the same as what you proposed, but with an explicit ID rather
>> than direction in the dmas property.
> 
> The point with the direction was that it covers most cases and makes
> them rather simple, while for the rare case where you need more than
> two channels, you just use the otherwise optional named interface
> rather than the numbered one. My feeling is that this also makes a
> lot of sense at the driver API level: most dirvers just ask for the
> read and write channels using a very simple interface, and those drivers
> that have more than two will want to name them anyway.

How are you thinking of representing the direction in DT - as part of
the DMA request specifier, so in a DMAC-specific way?

If so, that seems a little odd; you have to request a DMA channel for
"TX", but then end up having the common code check all the entries in
the dmas property since it can't know which are TX, and then have the
wrong ones almost accidentally fail, since the DMAC will then determine
that it can't support TX on the RX DMA request IDs.

If not, then presumably there's going to be a cell for "direction", so
it may as well just be a cell for "outgoing DMA request ID" - the two
are equivalent in the simple case.
