From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] dma: edma: Add support for Cyclic DMA
Date: Tue, 12 Nov 2013 09:18:08 +0530
Message-ID: <20131112034808.GB8834@intel.com>
References: <1383255083-31186-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18970 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab3KLEnm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Nov 2013 23:43:42 -0500
Content-Disposition: inline
In-Reply-To: <1383255083-31186-1-git-send-email-joelf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, matt.porter@linaro.org, Dan Williams <dan.j.williams@intel.com>, "open list:DMA GENERIC OFFLO..." <dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Oct 31, 2013 at 04:31:23PM -0500, Joel Fernandes wrote:
> Using the PaRAM configuration function that we split for reuse by the
> different DMA types, we implement Cyclic DMA support.
> For the cyclic case, we pass different configuration parameters to this
> function, and handle all the Cyclic-specific functionality separately.
> 
> Callbacks to the DMA users are handled using vchan_cyclic_callback in
> the virt-dma layer. Linking is handled the same way as the slave SG case
> except for the last slot where we link it back to the first one in a
> cyclic fashion.
> 
> For continuity, we check for cases where no.of periods is great than the
> MAX number of slots the driver can allocate for a particular descriptor
> and error out on such cases.
Applied, thanks

~Vinod
