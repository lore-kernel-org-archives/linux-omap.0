From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/1] dma: edma: fix incorrect SG list handling
Date: Mon, 14 Apr 2014 14:27:46 +0530
Message-ID: <20140414085746.GG32284@intel.com>
References: <1395208550-1603-1-git-send-email-nsekhar@ti.com>
 <534B9CCF.1070904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28594 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbaDNJHh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Apr 2014 05:07:37 -0400
Content-Disposition: inline
In-Reply-To: <534B9CCF.1070904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Dan Williams <dan.j.williams@intel.com>, DMA Engine Mailing List <dmaengine@vger.kernel.org>, Linux DaVinci Mailing List <davinci-linux-open-source@linux.davincidsp.com>, Jon Ringle <jringle@gridpoint.com>, Alexander Holler <holler@ahsoftware.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Joel Fernandes <joelf@ti.com>

On Mon, Apr 14, 2014 at 02:01:11PM +0530, Sekhar Nori wrote:
> Vinod,
> 
> On Wednesday 19 March 2014 11:25 AM, Sekhar Nori wrote:
> > The code to handle any length SG lists calls edma_resume()
> > even before edma_start() is called. This is incorrect
> > because edma_resume() enables edma events on the channel
> > after which CPU (in edma_start) cannot clear posted
> > events by writing to ECR (per the EDMA user's guide).
> > 
> > Because of this EDMA transfers fail to start if due
> > to some reason there is a pending EDMA event registered
> > even before EDMA transfers are started. This can happen if
> > an EDMA event is a byproduct of device initialization.
> > 
> > Fix this by calling edma_resume() only if it is not the
> > first batch of MAX_NR_SG elements.
> > 
> > Without this patch, MMC/SD fails to function on DA850 EVM
> > with DMA. The behaviour is triggered by specific IP and
> > this can explain why the issue was not reported before
> > (example with MMC/SD on AM335x).
> > 
> > Tested on DA850 EVM and AM335x EVM-SK using MMC/SD card.
> > 
> > Cc: stable@vger.kernel.org # v3.12.x+
> > Cc: Joel Fernandes <joelf@ti.com>
> > Acked-by: Joel Fernandes <joelf@ti.com>
> > Tested-by: Jon Ringle <jringle@gridpoint.com>
> > Tested-by: Alexander Holler <holler@ahsoftware.de>
> > Reported-by: Jon Ringle <jringle@gridpoint.com>
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Looks like this patch is not in mainline still?

Sorry looks like I have missed sending the email. I had applied it last week and
today rebased after rc1. It would be part of rc2...

-- 
~Vinod
> 
> Thanks,
> Sekhar

-- 
