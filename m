From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
Date: Fri, 10 Jan 2014 17:46:20 +0530
Message-ID: <52CFE494.4010702@ti.com>
References: <20140102150621.GJ16456@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57641 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbaAJMQf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jan 2014 07:16:35 -0500
In-Reply-To: <20140102150621.GJ16456@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead, org@arm.linux.org.uk, linux-omap@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, sricharan.az@gmail.com

On Thursday 02 January 2014 08:36 PM, Russell King - ARM Linux wrote:
> The following patch series moves code to setup the DMA hardware and
> service interrupts from the hardware to the DMA engine driver.  This
> reduces the dependency on the legacy DMA implementation.
> 
> This series does not remove the channel allocation/freeing hooks which
> are used to manage the allocation of physical channels - this is the
> next step in the evolution.
> 
> The patches which move the interrupt handling are currently less than
> perfect since they're writing to ENABLE_L0 under a different spinlock,
> and hence RFC only at the moment.
> 
>  arch/arm/mach-omap1/dma.c |  183 +++++--------
>  arch/arm/mach-omap2/dma.c |  183 ++++++--------
>  arch/arm/plat-omap/dma.c  |   17 +-
>  drivers/dma/omap-dma.c    |  653 ++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/omap-dma.h  |   25 ++-
>  5 files changed, 774 insertions(+), 287 deletions(-)
> 

I tested this series on DRA7 with mmc peripheral dma and it looked
fine. Some how dmaengine test cases were not fine. But that may not
have anything to do with this series. I will check more on that and
will come back with that results as well.

Regards,
 Sricharan
