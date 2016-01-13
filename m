From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: edma: Fix paRAM slot allocation for entry
 channel 0
Date: Wed, 13 Jan 2016 19:09:51 +0530
Message-ID: <20160113133951.GG11130@localhost>
References: <1452501481-5543-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452501481-5543-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 11, 2016 at 10:38:01AM +0200, Peter Ujfalusi wrote:
> edma_alloc_slot was not checking the channel mapping support existence when
> slot 0 has been requested (used as entry slot for channel/event 0).

Applied, thanks

-- 
~Vinod
