From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH RFC 08/26] dmaengine: omap-dma: consolidate setup of CCR
Date: Wed, 22 Jan 2014 09:39:26 -0500
Message-ID: <52DFD81E.1070103@ti.com>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk> <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk> <52DFBFDD.8040506@ti.com> <20140122141905.GQ27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49496 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755299AbaAVOj4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jan 2014 09:39:56 -0500
In-Reply-To: <20140122141905.GQ27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sricharan R <r.sricharan@ti.com>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Wednesday 22 January 2014 09:19 AM, Russell King - ARM Linux wrote:
> On Wed, Jan 22, 2014 at 06:25:57PM +0530, Sricharan R wrote:
>> Setting up of DMA_DST_SYNC_PREFETCH is missing after this ?
> 
> I'm not looking for the DMA engine driver to be a 100% reimplementation
> of the legacy driver.  Rather than supporting the entire set of features
> which the legacy driver did, and have many of them simply not used, the
> approach I'm taking here is to only support what is necessary for the
> drivers we have in mainline - and what fits the DMA engine interfaces.
> 
+1 on the approach.

> There is no point inventing new DMA engine interfaces for features for
> which we have no users in mainline kernel - to try to do that will be
> quite rightfully thrown out by the DMA engine maintainers.
> 
> Here's the total number of references/definitions of DMA_DST_SYNC_PREFETCH
> in the mainline kernel:
> 
> arch/arm/plat-omap/dma.c:               if (src_or_dst_synch == OMAP_DMA_DST_SYNC_PREFETCH) {
> include/linux/omap-dma.h:#define OMAP_DMA_DST_SYNC_PREFETCH     0x02
> 
> Hence, this feature is unused at present.
> 
I thought the crypto was using the prefetch feature but it isn't. 

Regards,
Santosh
