From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 00/26] OMAP dma engine rework
Date: Fri, 14 Feb 2014 18:24:56 +0530
Message-ID: <52FE1220.6090502@ti.com>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34234 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbaBNMzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Feb 2014 07:55:48 -0500
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>

On Monday 10 February 2014 09:25 PM, Russell King - ARM Linux wrote:
> This is the current set of patches for the OMAP DMA engine rework,
> which should now work correctly on OMAP1 platforms thanks to Tony's
> testing.
> 
> It would be good to get this validated by others across a range of
> OMAP platforms, and queued up for the next merge window, so it can
> be built upon.
> 
> Acks appreciated, and once sufficient have been added, I'll send a
> pull request for this to Vinod.
> 
>  arch/arm/mach-omap1/dma.c | 191 ++++++--------
>  arch/arm/mach-omap2/dma.c | 183 ++++++-------
>  arch/arm/plat-omap/dma.c  |  17 +-
>  drivers/dma/omap-dma.c    | 659 +++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/omap-dma.h  |  25 +-
>  5 files changed, 784 insertions(+), 291 deletions(-)
> 
Tested this on DRA7XX with MMC peripheral DMA

Regards,
 Sricharan
