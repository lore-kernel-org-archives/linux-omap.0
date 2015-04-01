From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] EDMA: TI: fixed wrongly initialized data parameter
 to the edma callback
Date: Wed, 1 Apr 2015 09:17:02 +0530
Message-ID: <20150401034701.GV7192@intel.com>
References: <1427142901-16391-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427142901-16391-1-git-send-email-petr@barix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Kulhavy <petr@barix.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, trivial@kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 23, 2015 at 09:35:01PM +0100, Petr Kulhavy wrote:
> The "data" parameter passed indirectly to the edma_callback() should be
> edma_chan and not the dma_chan.
> 
> This bug was so far harmless since the offset of struct dma_chan within struct
> edma_chan is 0. However as soon as someone changes struct edma_chan this would
> cause troubles.
Applied now, but do ensure you are using right subsystem anmes for patches.
I have fixed up now

-- 
~Vinod
