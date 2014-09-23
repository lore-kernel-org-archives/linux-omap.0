From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/2] dmaengine: omap-dma: Fix cyclic suspend/resume
Date: Tue, 23 Sep 2014 18:23:27 +0530
Message-ID: <20140923125327.GK24663@intel.com>
References: <1410896757-3848-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410896757-3848-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 16, 2014 at 10:45:55PM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v2:
> - fix typo in patch two
> - Acked-by added from Russell
> 
> When the audio is paused/resumed (application paused the sream or board suspend)
> the audio was only playing back one period worth of data and then stops because
> the omap_dam_stop() clears the link configuration and it is not restored in
> start.
> 
> Also add memory barrier call to resume path since this could happen right after
> coming out from suspend.

Applied, thanks

-- 
~Vinod
