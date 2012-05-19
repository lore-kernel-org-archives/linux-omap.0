From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Sat, 19 May 2012 08:44:03 +0000
Message-ID: <201205190844.03654.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201205182143.55140.arnd@arndb.de> <4FB6CB27.8020500@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59858 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817Ab2ESIo1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 May 2012 04:44:27 -0400
In-Reply-To: <4FB6CB27.8020500@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Friday 18 May 2012, Stephen Warren wrote:
> On 05/18/2012 03:43 PM, Arnd Bergmann wrote:

> > So if we do that, we might want to make the dma-names property mandatory
> > for every device, and document what the names are.
> 
> We could do that, but one more proposal: Add the client's ID/index into
> the dmas property, so:
> 
> simple 1 req:
> 
> dmas = <0 &dmac1 xxx>;
> 
> simple 2 req:
> 
> dmas = <0 &dmac1 xxx 1 &dmac1 yyy>;
> 
> multiple dmacs:
> 
> dmas = <0 &dmac1 xxx 0 &dmac2 zzz 1 &dmac1 yyy>;
> 
> (i.e. dmas = [client_dma_req_id phandle dma-specifier]*)
> 
> (where 0==TX_FIFO, 1=RX_FIFO for example, but could also have
> 2=TX_FIFO_B, 3=RX_FIFO_B, ...)
> 
> Then dma-names would map name to ID, but you'd still need to search all
> through the dmas property to find the ID match.

Again, this would probably work, but it adds complexity and inconsistency
for the common case, as nothing else requires these. I think it's much
better than putting the information into the dma controller node, but
not ideal.

> > Another option would be to encode the direction in the property in
> > a generic way and provide an API that lets you ask specifically
> > for a read, write or readwrite channel out of the ones that are
> > available, rather than assuming there is only one kind. Consequently,
> > any device that uses more than one read channel or more than one
> > write channel would still have to use names to identify them.
> 
> I'm not sure that just direction cuts it; Tegra's SPDIF has 2 TX DMAs
> ("PCM" data and control data) and same for RX. The format above is
> roughly the same as what you proposed, but with an explicit ID rather
> than direction in the dmas property.

The point with the direction was that it covers most cases and makes
them rather simple, while for the rare case where you need more than
two channels, you just use the otherwise optional named interface
rather than the numbered one. My feeling is that this also makes a
lot of sense at the driver API level: most dirvers just ask for the
read and write channels using a very simple interface, and those drivers
that have more than two will want to name them anyway.

	Arnd
