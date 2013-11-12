From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: cppi41: pending patches
Date: Tue, 12 Nov 2013 14:29:07 +0530
Message-ID: <20131112085907.GL8834@intel.com>
References: <1382436846-9057-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1382436846-9057-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 22, 2013 at 12:14:02PM +0200, Sebastian Andrzej Siewior wrote:
> Hi Vinod,
> 
> this series contains patches which are floating on the mainling list so
> I hope it is easier to collect them. It contains two of Daniel's which
> were not yet applied and two of mine.
> The patch "redo descriptor collection in abort case" was posted earlier
> and tested by Daniel, in this version here I removed an unused variable.
> 
> The patches are also available in a git tree based on your next tree prior
> the the "dma_complete" merge because DMA_COMPLETE & DMA_SUCCESS contain a
> diferent value.
Applied, thanks

--
~Vinod
> 
> The following changes since commit cc94dac27e15df9211394467e13fdfa2366e3593:
> 
>   Merge branch 'for-linus' into next (2013-10-21 12:57:31 +0530)
> 
> are available in the git repository at:
> 
> 
>   git://breakpoint.cc/bigeasy/linux tags/cppi41-next
> 
> for you to fetch changes up to e389973c52dbea967a9254798600c35c8f94b2c3:
> 
>   dma: cppi41: return code > 0 of pm_runtime_get_sync() is not an error (2013-10-22 12:00:45 +0200)
> 
> ----------------------------------------------------------------
> A handfull of cppi41 patches including pm support by Daniel Mack.
> 
> ----------------------------------------------------------------
> Daniel Mack (2):
>       dma: cppi41: restore more registers
>       dma: cppi41: use cppi41_pop_desc() where possible
> 
> Sebastian Andrzej Siewior (2):
>       dma: cppi41: redo descriptor collection in abort case
>       dma: cppi41: return code > 0 of pm_runtime_get_sync() is not an error
> 
>  drivers/dma/cppi41.c | 82 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 43 insertions(+), 39 deletions(-)
> 
> Sebastian

-- 
