From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/3] ARM/dma: edma: Serve cyclic clients via high
 priority queue
Date: Mon, 28 Jul 2014 17:04:46 +0530
Message-ID: <20140728113446.GB8181@intel.com>
References: <1404816398-12338-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404816398-12338-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nsekhar@ti.com, joelf@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 08, 2014 at 01:46:35PM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> It is preferred that audio is served with the highest priority queue in order to
> avoid delays in data transfer between memory and audio IP.
> 
> The following series will add an API to arch code to assign a channel to a given
> queue.
> The default queue is changed from 0 (highest priority) to lowest priority.
> In the dmaengine driver we move the cyclic channel to queue0 (highest priority)
> and move it back to default queue when the channel is terminated.

Applied, thanks

-- 
~Vinod

> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   ARM: edma: Set default queue to lowest priority
>   ARM: edma: Add edma_assign_channel_eventq() to move channel to a give
>     queue
>   dma: edma: Serve cyclic (audio) channels with high priority queue
> 
>  arch/arm/common/edma.c             | 31 ++++++++++++++++++++++++++++++-
>  drivers/dma/edma.c                 |  8 ++++++++
>  include/linux/platform_data/edma.h |  2 ++
>  3 files changed, 40 insertions(+), 1 deletion(-)
> 
> -- 
> 2.0.0
> 

-- 
