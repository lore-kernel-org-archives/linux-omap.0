From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] dmaengine: omap-dma: Fix dynamic lch_map alocation
Date: Mon, 2 Jan 2017 21:13:28 +0200
Message-ID: <20170102191328.pssv24pzxhguyeby@raspberrypi-2.musicnaut.iki.fi>
References: <20170102100737.11927-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170102100737.11927-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Jan 02, 2017 at 12:07:37PM +0200, Peter Ujfalusi wrote:
> The original patch did not done what it was supposed to be doing and even
> worst it broke legacy boot (OMAP1).
> 
> The lch_map size should be the number of available logical channels in sDMA
> and the od->dma_requests should store the number of available DMA request
> lines usable in sDMA.
> 
> In legacy mode we do not have a way to get the DMA request count, in that
> case we use OMAP_SDMA_REQUESTS (127), despite the fact that OMAP1510 have
> only 31 DMA request line.
> 
> Fixes: 2d1a9a946fae ("dmaengine: omap-dma: Dynamically allocate memory for lch_map")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: stable@vger.kernel.org   # v4.9
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.
