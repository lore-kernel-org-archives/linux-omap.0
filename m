From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Support for interleaved transfer
Date: Sun, 24 Jul 2016 11:15:09 +0530
Message-ID: <20160724054509.GS9681@localhost>
References: <20160712112114.8478-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160712112114.8478-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 12, 2016 at 02:21:14PM +0300, Peter Ujfalusi wrote:
> Initial support for interleaved transfer with sDMA.
> The implementation only supports DMA_MEM_TO_MEM and frame_size must be 1.
> sDMA needs to be configured for double indexing when ICG is needed.

Applied, thanks

-- 
~Vinod
