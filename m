From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 00/26] OMAP dma engine rework
Date: Tue, 18 Mar 2014 21:18:45 +0530
Message-ID: <20140318154845.GE1976@intel.com>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26843 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755380AbaCRPyu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 11:54:50 -0400
Content-Disposition: inline
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, Tony Lindgren <tony@atomide.com>

On Mon, Feb 10, 2014 at 09:25:31PM +0530, Russell King - ARM Linux wrote:
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
So is this series finalized. I havent seen the pull request for this or did i
miss it!

-- 
~Vinod
> 
>  arch/arm/mach-omap1/dma.c | 191 ++++++--------
>  arch/arm/mach-omap2/dma.c | 183 ++++++-------
>  arch/arm/plat-omap/dma.c  |  17 +-
>  drivers/dma/omap-dma.c    | 659 +++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/omap-dma.h  |  25 +-
>  5 files changed, 784 insertions(+), 291 deletions(-)
> 
> -- 
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".

-- 
