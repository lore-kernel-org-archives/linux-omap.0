From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/26] OMAP dma engine rework
Date: Thu, 13 Feb 2014 09:22:46 -0800
Message-ID: <20140213172246.GA27022@atomide.com>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48358 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbaBMRXA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 12:23:00 -0500
Content-Disposition: inline
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140210 07:58]:
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

Looks good to me and should not conflict with other patches
that I'm aware of. Please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
